
// Primary Include
#include "Renderer.h"

// External Include
#include <GLFW/glfw3.h>
#include <cstring>
#include <cassert>
#include <algorithm>
#include <array>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

// Internal Include
#include "Core/Application.h"
#include "Core/Logger.h"
#include "Core/Helper.h"
#include "Renderer/VkHelper.h"
#include "Renderer/Resources/Vertex.h"
#include "Renderer/Resources/UniformBuffer.h"
#include "Renderer/Resources/VertexBuffer.h"
#include "Renderer/Resources/IndexBuffer.h"


const uint32_t Renderer::MAX_FRAME_IN_FLIGHT = 3;

Renderer::Renderer(class Application* inApp)
    : Module(inApp)
    , mRenderDevice(nullptr)
    , mGraphicsQueue(VK_NULL_HANDLE)
    , mPresentQueue(VK_NULL_HANDLE)
    , mTransferQueue(VK_NULL_HANDLE)
    , mSwapChain(VK_NULL_HANDLE)
    , mRenderPass(VK_NULL_HANDLE)
    , mPipelineLayout(VK_NULL_HANDLE)
    , mGraphicPipeline(VK_NULL_HANDLE)
    , mGraphicsCommandPool(VK_NULL_HANDLE)
    , mTransferCommandPool(VK_NULL_HANDLE)
    , mDescriptorPool(VK_NULL_HANDLE)
    , mCurrentFrame(0)
    , mSwapChainExtent{ 0, }
    , mSwapChainImageFormat(VK_FORMAT_UNDEFINED)
    , mbFrameBufferResized(false)
    , mbCanRender(true)
{
    mRenderDevice = std::make_unique<RenderDevice>();

    // register all render objects;
    mAllRenderObjects.push_back(mRenderDevice.get());
}

Renderer::~Renderer()
{
}

bool Renderer::Initialize()
{
    RAD_LOG(ELogType::Renderer, ELogClass::Log, "Start renderer module initialization.");
    bool bResult = true;

    bResult = mRenderDevice->Create(nullptr);
    if (!bResult)
    {
        return bResult;
    }

    // RenderDevice에서 생성한 VkQueue를 가져옴
    mGraphicsQueue = mRenderDevice->GetGraphicsQueue();
    mPresentQueue = mRenderDevice->GetPresentQueue();
    mTransferQueue = mRenderDevice->GetTransferQueue();

    bResult = CreateSwapChain();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateRenderPass();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateDescriptorSetLayout();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateGraphicsPipeline();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateFrameBuffers();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateCommandPools();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateVertexBuffer();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateIndexBuffer();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateUniformBuffer();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateDescriptorPool();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateDescriptorSets();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateCommandBuffers();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateSyncObjects();
    if (!bResult)
    {
        return bResult;
    }

    RAD_LOG(ELogType::Renderer, ELogClass::Log, "Complete renderer module initialization.");
    return bResult;
}

void Renderer::Loop()
{
    if (!mbCanRender)
    {
        return;
    }

    VK_ASSERT(vkWaitForFences(*mRenderDevice, 1, &mInFlightFence[mCurrentFrame], VK_TRUE, UINT64_MAX));

    uint32_t imageIndex;
    VkResult result = vkAcquireNextImageKHR(*mRenderDevice, mSwapChain, UINT64_MAX, mImageAvailableSemaphores[mCurrentFrame], VK_NULL_HANDLE, &imageIndex);
    if (result == VK_ERROR_OUT_OF_DATE_KHR)
    {
        RecreateDependSwapChainObjects();
        return;
    }
    else if (result == VK_SUBOPTIMAL_KHR) // 이미지를 얻는 것에는 성공. 하지만 스왑체인 재생성 필요.
    {
        FrameBufferResized();
    }
    else if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to aquire swap chain image.");
        return;
    }

    if (mImageInFlightFence[imageIndex] != VK_NULL_HANDLE)
    {
        VK_ASSERT(vkWaitForFences(*mRenderDevice, 1, &mImageInFlightFence[imageIndex], VK_TRUE, UINT64_MAX));
    }

    mImageInFlightFence[imageIndex] = mInFlightFence[mCurrentFrame];
    VK_ASSERT(vkResetFences(*mRenderDevice, 1, &mInFlightFence[mCurrentFrame]));

    // temp transform function
    UpdateUniformBuffer(imageIndex);

    VkSubmitInfo submitInfo = {};
    submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;

    VkSemaphore waitSemaphores[] = { mImageAvailableSemaphores[mCurrentFrame] };
    VkPipelineStageFlags waitStages[] = { VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT };
    submitInfo.waitSemaphoreCount = static_cast<uint32_t>(ArraySize(waitSemaphores));
    submitInfo.pWaitSemaphores = waitSemaphores;
    submitInfo.pWaitDstStageMask = waitStages;

    submitInfo.commandBufferCount = 1;
    submitInfo.pCommandBuffers = &mCommandBuffers[imageIndex];

    VkSemaphore signalSemaphores[] = { mRenderFinishedSemaphores[mCurrentFrame] };
    submitInfo.signalSemaphoreCount = static_cast<uint32_t>(ArraySize(signalSemaphores));
    submitInfo.pSignalSemaphores = signalSemaphores;

    result = vkQueueSubmit(mGraphicsQueue, 1, &submitInfo, mInFlightFence[mCurrentFrame]);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Warning, "Failed to submit draw command buffer.");
        return;
    }

    VkPresentInfoKHR presentInfo = {};
    presentInfo.sType = VK_STRUCTURE_TYPE_PRESENT_INFO_KHR;
    presentInfo.waitSemaphoreCount = static_cast<uint32_t>(ArraySize(waitSemaphores));
    presentInfo.pWaitSemaphores = signalSemaphores;

    VkSwapchainKHR swapChains[] = { mSwapChain };
    presentInfo.swapchainCount = static_cast<uint32_t>(ArraySize(swapChains));
    presentInfo.pSwapchains = swapChains;
    presentInfo.pImageIndices = &imageIndex;
    presentInfo.pResults = nullptr;

    result = vkQueuePresentKHR(mPresentQueue, &presentInfo);
    if (result == VK_ERROR_OUT_OF_DATE_KHR || result == VK_SUBOPTIMAL_KHR || mbFrameBufferResized)
    {
        RecreateDependSwapChainObjects();
    }

    mCurrentFrame = (mCurrentFrame + 1) % MAX_FRAME_IN_FLIGHT;
}

void Renderer::Deinitialize()
{
    RAD_LOG(ELogType::Renderer, ELogClass::Log, "Start renderer module deinitialization.");

    VK_ASSERT(vkDeviceWaitIdle(*mRenderDevice));

    assert(mInFlightFence.size() == mRenderFinishedSemaphores.size()
        && mRenderFinishedSemaphores.size() == mImageAvailableSemaphores.size());
    for (uint32_t i = 0; i < mInFlightFence.size(); ++i)
    {
        vkDestroyFence(*mRenderDevice, mInFlightFence[i], nullptr);
        vkDestroySemaphore(*mRenderDevice, mRenderFinishedSemaphores[i], nullptr);
        vkDestroySemaphore(*mRenderDevice, mImageAvailableSemaphores[i], nullptr);
    }

    vkDestroyCommandPool(*mRenderDevice, mTransferCommandPool, nullptr);
    vkDestroyCommandPool(*mRenderDevice, mGraphicsCommandPool, nullptr);

    mVertexBuffer = nullptr;
    mIndexBuffer = nullptr;

    vkDestroyDescriptorSetLayout(*mRenderDevice, mDescriptorSetLayout, nullptr);

    DestroyDependSwapChainObjects();

    mRenderDevice = nullptr;

    RAD_LOG(ELogType::Renderer, ELogClass::Log, "Complete renderer module deinitialization.");
}

bool Renderer::RecreateDependSwapChainObjects()
{
    VK_ASSERT(vkDeviceWaitIdle(*mRenderDevice));

    int width = 0;
    int height = 0;
    glfwGetFramebufferSize(mApp->GetWindowObject(), &width, &height);
    if (width == 0 || height == 0)
    {
        return false;
    }

    vkFreeCommandBuffers(*mRenderDevice, mGraphicsCommandPool, static_cast<uint32_t>(mCommandBuffers.size()), mCommandBuffers.data());
    DestroyDependSwapChainObjects();

    bool bResult = CreateSwapChain();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateRenderPass();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateGraphicsPipeline();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateFrameBuffers();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateUniformBuffer();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateDescriptorPool();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateDescriptorSets();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateCommandBuffers();
    if (!bResult)
    {
        return bResult;
    }

    RAD_LOG(ELogType::Renderer, ELogClass::Log, "Recreate to objects depend on swap chain.");
    mbFrameBufferResized = false;

    return bResult;
}

void Renderer::DestroyDependSwapChainObjects()
{
    for (VkFramebuffer frameBuffer : mSwapChainFrameBuffers)
    {
        vkDestroyFramebuffer(*mRenderDevice, frameBuffer, nullptr);
    }

    for (size_t i = 0; i < mUniformBuffers.size(); ++i)
    {
        mUniformBuffers[i] = nullptr;
    }

    vkDestroyDescriptorPool(*mRenderDevice, mDescriptorPool, nullptr);

    vkDestroyPipeline(*mRenderDevice, mGraphicPipeline, nullptr);
    vkDestroyPipelineLayout(*mRenderDevice, mPipelineLayout, nullptr);
    vkDestroyRenderPass(*mRenderDevice, mRenderPass, nullptr);

    for (VkImageView imageView : mSwapChainImageViews)
    {
        vkDestroyImageView(*mRenderDevice, imageView, nullptr);
    }

    vkDestroySwapchainKHR(*mRenderDevice, mSwapChain, nullptr);
}

bool Renderer::CreateSwapChain()
{
    const SwapChainSupportDetails details = mRenderDevice->QuerySwapCahinSupport();
    const VkSurfaceFormatKHR surfaceFormat = ChooseSwapSurfaceFormat(details.Formats);
    const VkPresentModeKHR presentMode = ChooseSwapPresentMode(details.PresentModes);
    const VkExtent2D extent = ChooseSwapExtent(details.Capabilities);

    uint32_t imageCount = details.Capabilities.minImageCount + 1;
    if (details.Capabilities.maxImageCount > 0 && details.Capabilities.maxImageCount < imageCount)
    {
        imageCount = details.Capabilities.maxImageCount;
    }

    VkSwapchainCreateInfoKHR swapChainCreateInfo = {};
    swapChainCreateInfo.sType = VK_STRUCTURE_TYPE_SWAPCHAIN_CREATE_INFO_KHR;
    swapChainCreateInfo.surface = mRenderDevice->GetSurface();
    swapChainCreateInfo.minImageCount = imageCount;
    swapChainCreateInfo.imageFormat = surfaceFormat.format;
    swapChainCreateInfo.imageColorSpace = surfaceFormat.colorSpace;
    swapChainCreateInfo.imageExtent = extent;
    swapChainCreateInfo.imageArrayLayers = 1;
    swapChainCreateInfo.imageUsage = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT;

    const QueueFamilyIndices indices = mRenderDevice->FindQueueFamilies();
    assert(QueueFamilyIndices::IsValidQueueFamilyIndices(indices) == true);
    std::vector<uint32_t> uniqueQueueFamilies = QueueFamilyIndices::GetUniqueFamilies(indices);

    // Graphics queue와 Transfer queue가 다르도록 강제하기에 CONCURRENT 모드 사용.
    // CONCURRENT 모드 사용 시에는 QueueFamilyIndex가 Unique 해야함.
    swapChainCreateInfo.imageSharingMode = VK_SHARING_MODE_CONCURRENT;
    swapChainCreateInfo.queueFamilyIndexCount = static_cast<uint32_t>(uniqueQueueFamilies.size());
    swapChainCreateInfo.pQueueFamilyIndices = uniqueQueueFamilies.data();

    swapChainCreateInfo.preTransform = details.Capabilities.currentTransform;
    swapChainCreateInfo.compositeAlpha = VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR;
    swapChainCreateInfo.presentMode = presentMode;
    swapChainCreateInfo.clipped = VK_TRUE;
    swapChainCreateInfo.oldSwapchain = VK_NULL_HANDLE;

    VkResult result = vkCreateSwapchainKHR(*mRenderDevice, &swapChainCreateInfo, nullptr, &mSwapChain);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create Vulkan swap chain.");
        return false;
    }

    mSwapChainExtent = extent;
    mSwapChainImageFormat = surfaceFormat.format;

    uint32_t swapImageCount = 0;
    VK_ASSERT(vkGetSwapchainImagesKHR(*mRenderDevice, mSwapChain, &swapImageCount, nullptr));
    mSwapChainImages.resize(swapImageCount);
    VK_ASSERT(vkGetSwapchainImagesKHR(*mRenderDevice, mSwapChain, &swapImageCount, mSwapChainImages.data()));

    // Begin create swap chain image views
    mSwapChainImageViews.resize(mSwapChainImages.size());
    for (size_t i = 0; i < mSwapChainImages.size(); ++i)
    {
        VkImageViewCreateInfo imageViewCreateInfo = {};
        imageViewCreateInfo.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
        imageViewCreateInfo.image = mSwapChainImages[i];
        imageViewCreateInfo.viewType = VK_IMAGE_VIEW_TYPE_2D;
        imageViewCreateInfo.format = mSwapChainImageFormat;
        imageViewCreateInfo.components.r = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.components.g = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.components.b = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.components.a = VK_COMPONENT_SWIZZLE_IDENTITY;
        imageViewCreateInfo.subresourceRange.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
        imageViewCreateInfo.subresourceRange.baseMipLevel = 0;
        imageViewCreateInfo.subresourceRange.levelCount = 1;
        imageViewCreateInfo.subresourceRange.baseArrayLayer = 0;
        imageViewCreateInfo.subresourceRange.layerCount = 1;

        result = vkCreateImageView(*mRenderDevice, &imageViewCreateInfo, nullptr, &mSwapChainImageViews[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create swap chain image view.");
            return false;
        }
    }

    return true;
}

bool Renderer::CreateRenderPass()
{
    VkAttachmentDescription colorAttachment = {};
    colorAttachment.format = mSwapChainImageFormat;
    colorAttachment.samples = VK_SAMPLE_COUNT_1_BIT;
    colorAttachment.loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR;
    colorAttachment.storeOp = VK_ATTACHMENT_STORE_OP_STORE;
    colorAttachment.stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE;
    colorAttachment.stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE;
    colorAttachment.initialLayout = VK_IMAGE_LAYOUT_UNDEFINED;
    colorAttachment.finalLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR;

    VkAttachmentReference colorAttachmentRef = {};
    colorAttachmentRef.attachment = 0;
    colorAttachmentRef.layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL;

    VkSubpassDescription subPass = {};
    subPass.pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS;
    subPass.colorAttachmentCount = 1;
    subPass.pColorAttachments = &colorAttachmentRef;

    VkSubpassDependency dependency = {};
    dependency.srcSubpass = VK_SUBPASS_EXTERNAL;
    dependency.dstSubpass = VK_SUBPASS_CONTENTS_INLINE;
    dependency.srcStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT;
    dependency.srcAccessMask = VK_ACCESS_NONE_KHR;
    dependency.dstStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT;
    dependency.dstAccessMask = VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT;

    VkRenderPassCreateInfo renderPassCreateInfo = {};
    renderPassCreateInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO;
    renderPassCreateInfo.attachmentCount = 1;
    renderPassCreateInfo.pAttachments = &colorAttachment;
    renderPassCreateInfo.subpassCount = 1;
    renderPassCreateInfo.pSubpasses = &subPass;
    renderPassCreateInfo.dependencyCount = 1;
    renderPassCreateInfo.pDependencies = &dependency;

    VkResult result = vkCreateRenderPass(*mRenderDevice, &renderPassCreateInfo, nullptr, &mRenderPass);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create render pass.");
        return false;
    }

    return true;
}

bool Renderer::CreateGraphicsPipeline()
{
    static constexpr char* VERT_SHADER_PATH = "../Shader/Default.vert.spv";
    static constexpr char* FRAG_SHADER_PATH = "../Shader/Default.frag.spv";
    static constexpr char* SHADER_ENTRY_POINT_NAME = "main";

    std::vector<uint8_t> vertShaderBinary;
    std::vector<uint8_t> fragShaderBinary;
    bool bResult = VkHelper::TryReadShaderFile(&vertShaderBinary, VERT_SHADER_PATH);
    if (!bResult)
    {
        return bResult;
    }

    bResult = VkHelper::TryReadShaderFile(&fragShaderBinary, FRAG_SHADER_PATH);
    if (!bResult)
    {
        return bResult;
    }

    VkShaderModule vertShaderModule;
    bResult = CreateShaderModule(&vertShaderModule, vertShaderBinary);
    if (!bResult)
    {
        return bResult;
    }

    VkShaderModule fragShaderModule;
    bResult = CreateShaderModule(&fragShaderModule, fragShaderBinary);
    if (!bResult)
    {
        goto EXIT_SHADER_VERT;
    }

    // goto로 인한 C4533에러 방지 용 Brace
    {
        // Begin shader stage
        VkPipelineShaderStageCreateInfo vertShaderStageCreateInfo = {};
        vertShaderStageCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
        vertShaderStageCreateInfo.stage = VK_SHADER_STAGE_VERTEX_BIT;
        vertShaderStageCreateInfo.module = vertShaderModule;
        vertShaderStageCreateInfo.pName = SHADER_ENTRY_POINT_NAME;

        VkPipelineShaderStageCreateInfo fragShaderStageCreateInfo = {};
        fragShaderStageCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO;
        fragShaderStageCreateInfo.stage = VK_SHADER_STAGE_FRAGMENT_BIT;
        fragShaderStageCreateInfo.module = fragShaderModule;
        fragShaderStageCreateInfo.pName = SHADER_ENTRY_POINT_NAME;

        VkPipelineShaderStageCreateInfo shaderStageCreateInfos[2] = { vertShaderStageCreateInfo, fragShaderStageCreateInfo };
        // End shader stage

        // Begin vertex input state
        const VkVertexInputBindingDescription bindingDesc = Vertex::GetVkBindingDescription();
        const std::array<VkVertexInputAttributeDescription, 2> attributeDesc = Vertex::GetVkAttributeDescriptions();

        VkPipelineVertexInputStateCreateInfo vertexInputCreateInfo = {};
        vertexInputCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO;
        vertexInputCreateInfo.vertexBindingDescriptionCount = 1;
        vertexInputCreateInfo.pVertexBindingDescriptions = &bindingDesc;
        vertexInputCreateInfo.vertexAttributeDescriptionCount = static_cast<uint32_t>(attributeDesc.size());
        vertexInputCreateInfo.pVertexAttributeDescriptions = attributeDesc.data();
        // End verte input state

        // Begin input assembly state
        VkPipelineInputAssemblyStateCreateInfo inputAssemblyCreateInfo = {};
        inputAssemblyCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO;
        inputAssemblyCreateInfo.topology = VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST;
        inputAssemblyCreateInfo.primitiveRestartEnable = VK_FALSE;
        // End inptu assembly state

        // Begin viewport and scissor
        VkViewport viewport = {};
        viewport.x = 0.f;
        viewport.y = static_cast<float>(mSwapChainExtent.height);
        viewport.width = static_cast<float>(mSwapChainExtent.width);
        viewport.height = -static_cast<float>(mSwapChainExtent.height);
        viewport.minDepth = 0.f;
        viewport.maxDepth = 1.f;

        VkRect2D scissor = {};
        scissor.offset = { 0, 0 };
        scissor.extent = mSwapChainExtent;

        VkPipelineViewportStateCreateInfo viewportCreateInfo = {};
        viewportCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO;
        viewportCreateInfo.viewportCount = 1;
        viewportCreateInfo.pViewports = &viewport;
        viewportCreateInfo.scissorCount = 1;
        viewportCreateInfo.pScissors = &scissor;
        // End viweport and scissor

        // Begin rasterizer
        VkPipelineRasterizationStateCreateInfo rasterizerCreateInfo = {};
        rasterizerCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO;
        rasterizerCreateInfo.depthClampEnable = VK_FALSE;
        rasterizerCreateInfo.rasterizerDiscardEnable = VK_FALSE;
        rasterizerCreateInfo.polygonMode = VK_POLYGON_MODE_FILL;
        rasterizerCreateInfo.lineWidth = 1.f;
        rasterizerCreateInfo.cullMode = VK_CULL_MODE_BACK_BIT;
        rasterizerCreateInfo.frontFace = VK_FRONT_FACE_CLOCKWISE;
        rasterizerCreateInfo.depthBiasEnable = VK_FALSE;
        rasterizerCreateInfo.depthBiasConstantFactor = 0.f;
        rasterizerCreateInfo.depthBiasClamp = 0.f;
        rasterizerCreateInfo.depthBiasSlopeFactor = 0.f;
        // End rasterizer

        // Begin multisampling
        VkPipelineMultisampleStateCreateInfo multisampleCreateInfo = {};
        multisampleCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO;
        multisampleCreateInfo.sampleShadingEnable = VK_FALSE;
        multisampleCreateInfo.rasterizationSamples = VK_SAMPLE_COUNT_1_BIT;
        multisampleCreateInfo.minSampleShading = 1.f;
        multisampleCreateInfo.pSampleMask = nullptr;
        multisampleCreateInfo.alphaToCoverageEnable = VK_FALSE;
        multisampleCreateInfo.alphaToOneEnable = VK_FALSE;
        // End multisampling

        // Begin color blend
        VkPipelineColorBlendAttachmentState colorBlendAttachment = {};
        colorBlendAttachment.colorWriteMask = VK_COLOR_COMPONENT_R_BIT | VK_COLOR_COMPONENT_G_BIT | VK_COLOR_COMPONENT_B_BIT | VK_COLOR_COMPONENT_A_BIT;
        colorBlendAttachment.blendEnable = VK_FALSE;
        colorBlendAttachment.srcColorBlendFactor = VK_BLEND_FACTOR_ONE;
        colorBlendAttachment.dstColorBlendFactor = VK_BLEND_FACTOR_ZERO;
        colorBlendAttachment.colorBlendOp = VK_BLEND_OP_ADD;
        colorBlendAttachment.srcAlphaBlendFactor = VK_BLEND_FACTOR_ONE;
        colorBlendAttachment.dstAlphaBlendFactor = VK_BLEND_FACTOR_ZERO;
        colorBlendAttachment.alphaBlendOp = VK_BLEND_OP_ADD;

        VkPipelineColorBlendStateCreateInfo colorBlendCreateInfo = {};
        colorBlendCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO;
        colorBlendCreateInfo.logicOpEnable = VK_FALSE;
        colorBlendCreateInfo.logicOp = VK_LOGIC_OP_COPY;
        colorBlendCreateInfo.attachmentCount = 1;
        colorBlendCreateInfo.pAttachments = &colorBlendAttachment;
        colorBlendCreateInfo.blendConstants[0] = 0.f;
        colorBlendCreateInfo.blendConstants[1] = 0.f;
        colorBlendCreateInfo.blendConstants[2] = 0.f;
        colorBlendCreateInfo.blendConstants[3] = 0.f;
        // End color blend

        // Begin dynamic state
        VkDynamicState dynamicStates[2] = {
            VK_DYNAMIC_STATE_VIEWPORT,
            VK_DYNAMIC_STATE_LINE_WIDTH
        };

        VkPipelineDynamicStateCreateInfo dynamicCreateInfo = {};
        dynamicCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_DYNAMIC_STATE_CREATE_INFO;
        dynamicCreateInfo.dynamicStateCount = static_cast<uint32_t>(ArraySize(dynamicStates));
        dynamicCreateInfo.pDynamicStates = dynamicStates;
        // End dynamic state

        // Begin pipeline layout
        VkPipelineLayoutCreateInfo pipelineLayoutCreateInfo = {};
        pipelineLayoutCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO;
        pipelineLayoutCreateInfo.setLayoutCount = 1;
        pipelineLayoutCreateInfo.pSetLayouts = &mDescriptorSetLayout;
        pipelineLayoutCreateInfo.pushConstantRangeCount = 0;
        pipelineLayoutCreateInfo.pPushConstantRanges = nullptr;

        VkResult result = vkCreatePipelineLayout(*mRenderDevice, &pipelineLayoutCreateInfo, nullptr, &mPipelineLayout);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create pipeline layout.");
            bResult = false;
            goto EXIT_SHADER_ALL;
        }
        // End pipeline layout

        // Begin graphics pipeline
        VkGraphicsPipelineCreateInfo pipelineCreateInfo = {};
        pipelineCreateInfo.sType = VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO;
        pipelineCreateInfo.stageCount = static_cast<uint32_t>(ArraySize(shaderStageCreateInfos));
        pipelineCreateInfo.pStages = shaderStageCreateInfos;
        pipelineCreateInfo.pVertexInputState = &vertexInputCreateInfo;
        pipelineCreateInfo.pInputAssemblyState = &inputAssemblyCreateInfo;
        pipelineCreateInfo.pViewportState = &viewportCreateInfo;
        pipelineCreateInfo.pRasterizationState = &rasterizerCreateInfo;
        pipelineCreateInfo.pMultisampleState = &multisampleCreateInfo;
        pipelineCreateInfo.pDepthStencilState = nullptr;
        pipelineCreateInfo.pColorBlendState = &colorBlendCreateInfo;
        pipelineCreateInfo.pDynamicState = nullptr;
        pipelineCreateInfo.layout = mPipelineLayout;
        pipelineCreateInfo.renderPass = mRenderPass;
        pipelineCreateInfo.subpass = 0;
        pipelineCreateInfo.basePipelineHandle = VK_NULL_HANDLE;
        pipelineCreateInfo.basePipelineIndex = -1;

        result = vkCreateGraphicsPipelines(*mRenderDevice, VK_NULL_HANDLE, 1, &pipelineCreateInfo, nullptr, &mGraphicPipeline);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create graphics pipeline.");
            bResult = false;
            goto EXIT_SHADER_ALL;
        }
        // End graphics pipeline
    }


EXIT_SHADER_ALL:
    vkDestroyShaderModule(*mRenderDevice, vertShaderModule, nullptr);
EXIT_SHADER_VERT:
    vkDestroyShaderModule(*mRenderDevice, fragShaderModule, nullptr);

    return bResult;
}

bool Renderer::CreateFrameBuffers()
{
    mSwapChainFrameBuffers.resize(mSwapChainImageViews.size());

    for (size_t i = 0; i < mSwapChainImageViews.size(); ++i)
    {
        VkImageView attachments[] = {
            mSwapChainImageViews[i]
        };

        VkFramebufferCreateInfo frameBufferCreateInfo = {};
        frameBufferCreateInfo.sType = VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO;
        frameBufferCreateInfo.renderPass = mRenderPass;
        frameBufferCreateInfo.attachmentCount = static_cast<uint32_t>(ArraySize(attachments));
        frameBufferCreateInfo.pAttachments = attachments;
        frameBufferCreateInfo.width = mSwapChainExtent.width;
        frameBufferCreateInfo.height = mSwapChainExtent.height;
        frameBufferCreateInfo.layers = 1;

        const VkResult result = vkCreateFramebuffer(*mRenderDevice, &frameBufferCreateInfo, nullptr, &mSwapChainFrameBuffers[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create frame buffer.");
            return false;
        }
    }

    return true;
}

bool Renderer::CreateDescriptorSetLayout()
{
    VkDescriptorSetLayoutBinding uboLayoutBinding = {};
    uboLayoutBinding.binding = 0;
    uboLayoutBinding.descriptorType = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER;
    uboLayoutBinding.descriptorCount = 1;
    uboLayoutBinding.stageFlags = VK_SHADER_STAGE_VERTEX_BIT;
    uboLayoutBinding.pImmutableSamplers = nullptr;

    VkDescriptorSetLayoutCreateInfo layoutCreateInfo = {};
    layoutCreateInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO;
    layoutCreateInfo.bindingCount = 1;
    layoutCreateInfo.pBindings = &uboLayoutBinding;

    const VkResult result = vkCreateDescriptorSetLayout(*mRenderDevice, &layoutCreateInfo, nullptr, &mDescriptorSetLayout);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create descriptor set layout.");
        return false;
    }

    return true;
}

bool Renderer::CreateCommandPools()
{
    const QueueFamilyIndices queueFamilyIndices = mRenderDevice->FindQueueFamilies();

    VkCommandPoolCreateInfo commandPoolCreateInfo = {};
    commandPoolCreateInfo.sType = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
    commandPoolCreateInfo.queueFamilyIndex = queueFamilyIndices.GraphicsFamily.value();
    commandPoolCreateInfo.flags = 0;

    VkResult result = vkCreateCommandPool(*mRenderDevice, &commandPoolCreateInfo, nullptr, &mGraphicsCommandPool);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create graphics command pool.");
        return false;
    }

    commandPoolCreateInfo.queueFamilyIndex = queueFamilyIndices.TransferFamily.value();
    commandPoolCreateInfo.flags = VK_COMMAND_POOL_CREATE_TRANSIENT_BIT; // CommandBuffer의 수명이 짧다는 힌트 플래그.
    result = vkCreateCommandPool(*mRenderDevice, &commandPoolCreateInfo, nullptr, &mTransferCommandPool);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create transfer command pool.");
        return false;
    }

    return true;
}

bool Renderer::CreateVertexBuffer()
{
    const VkDeviceSize bufferSize = sizeof(Vertex) * Vertex::Vertices.size();

    mVertexBuffer = std::make_unique<VertexBuffer>(mRenderDevice.get(), bufferSize);
    const bool bCreateResult = mVertexBuffer->CreateBuffer();
    if (!bCreateResult)
    {
        return false;
    }

    mVertexBuffer->MapStagingBuffer((void*)Vertex::Vertices.data(), bufferSize);
    mVertexBuffer->TransferBuffer(mTransferCommandPool, mTransferQueue);

    return true;
}

bool Renderer::CreateIndexBuffer()
{
    const VkDeviceSize bufferSize = sizeof(uint16_t) * Vertex::Indices.size();

    mIndexBuffer = std::make_unique<IndexBuffer>(mRenderDevice.get(), bufferSize);

    const bool bCreateResult = mIndexBuffer->CreateBuffer();
    if (!bCreateResult)
    {
        return false;
    }

    mIndexBuffer->MapStagingBuffer((void*)Vertex::Indices.data(), bufferSize);
    mIndexBuffer->TransferBuffer(mTransferCommandPool, mTransferQueue);

    return true;
}

bool Renderer::CreateUniformBuffer()
{
    VkDeviceSize bufferSize = sizeof(UniformBufferObject);

    // In-Flight 방식이기에 Image마다 UniformBuffer 필요.
    mUniformBuffers.resize(mSwapChainImages.size());

    for (size_t i = 0; i < mSwapChainImages.size(); ++i)
    {
        std::unique_ptr<UniformBuffer> uniformBuffer = std::make_unique<UniformBuffer>(mRenderDevice.get(), bufferSize);
        const bool bCreateResult = uniformBuffer->CreateBuffer();
        if (!bCreateResult)
        {
            return false;
        }

        mUniformBuffers[i] = std::move(uniformBuffer);
    }

    return true;
}

bool Renderer::CreateDescriptorPool()
{
    VkDescriptorPoolSize poolSize = {};
    poolSize.type = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER;
    poolSize.descriptorCount = static_cast<uint32_t>(mSwapChainImages.size());

    VkDescriptorPoolCreateInfo poolCreateInfo = {};
    poolCreateInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO;
    poolCreateInfo.poolSizeCount = 1;
    poolCreateInfo.pPoolSizes = &poolSize;
    poolCreateInfo.maxSets = static_cast<uint32_t>(mSwapChainImages.size());

    const VkResult result = vkCreateDescriptorPool(*mRenderDevice, &poolCreateInfo, nullptr, &mDescriptorPool);
    if (result != VK_SUCCESS)
    {
        return false;
    }

    return true;
}

bool Renderer::CreateDescriptorSets()
{
    std::vector<VkDescriptorSetLayout> layouts(mSwapChainImages.size(), mDescriptorSetLayout);

    VkDescriptorSetAllocateInfo allocInfo = {};
    allocInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO;
    allocInfo.descriptorPool = mDescriptorPool;
    allocInfo.descriptorSetCount = static_cast<uint32_t>(layouts.size());
    allocInfo.pSetLayouts = layouts.data();

    mDescriptorSets.resize(layouts.size());
    const VkResult result = vkAllocateDescriptorSets(*mRenderDevice, &allocInfo, mDescriptorSets.data());
    if (result != VK_SUCCESS)
    {
        return false;
    }

    assert(mDescriptorSets.size() == mUniformBuffers.size());
    for (size_t i = 0; i < mDescriptorSets.size(); ++i)
    {
        VkDescriptorBufferInfo bufferInfo = {};
        bufferInfo.buffer = mUniformBuffers[i]->GetVkBuffer();
        bufferInfo.offset = 0;
        bufferInfo.range = VK_WHOLE_SIZE;

        VkWriteDescriptorSet writeDesc = {};
        writeDesc.sType = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
        writeDesc.dstSet = mDescriptorSets[i];
        writeDesc.dstBinding = 0;
        writeDesc.dstArrayElement = 0;
        writeDesc.descriptorType = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER;
        writeDesc.descriptorCount = 1;
        writeDesc.pBufferInfo = &bufferInfo;
        writeDesc.pImageInfo = nullptr;
        writeDesc.pTexelBufferView = nullptr;

        vkUpdateDescriptorSets(*mRenderDevice, 1, &writeDesc, 0, nullptr);
    }

    return true;
}

bool Renderer::CreateCommandBuffers()
{
    mCommandBuffers.resize(mSwapChainFrameBuffers.size());

    VkCommandBufferAllocateInfo allocInfo = {};
    allocInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
    allocInfo.commandPool = mGraphicsCommandPool;
    allocInfo.level = VK_COMMAND_BUFFER_LEVEL_PRIMARY;
    allocInfo.commandBufferCount = static_cast<uint32_t>(mCommandBuffers.size());

    const VkResult result = vkAllocateCommandBuffers(*mRenderDevice, &allocInfo, mCommandBuffers.data());
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to allocate command buffers.");
        return false;
    }

    for (size_t i = 0; i < mCommandBuffers.size(); ++i)
    {
        VkCommandBufferBeginInfo commandBufferBeginInfo = {};
        commandBufferBeginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
        commandBufferBeginInfo.flags = 0;
        commandBufferBeginInfo.pInheritanceInfo = nullptr;

        VkResult passResult = vkBeginCommandBuffer(mCommandBuffers[i], &commandBufferBeginInfo);
        if (passResult != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to begin recording command buffer.");
            return false;
        }

        assert(mCommandBuffers.size() == mSwapChainFrameBuffers.size());
        VkRenderPassBeginInfo renderPassBeginInfo = {};
        renderPassBeginInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
        renderPassBeginInfo.renderPass = mRenderPass;
        renderPassBeginInfo.framebuffer = mSwapChainFrameBuffers[i];
        renderPassBeginInfo.renderArea.offset = { 0, 0 };
        renderPassBeginInfo.renderArea.extent = mSwapChainExtent;

        VkClearValue clearColor = {};
        clearColor.color = { 0.f, 0.f, 0.f, 1.f };

        renderPassBeginInfo.clearValueCount = 1;
        renderPassBeginInfo.pClearValues = &clearColor;

        // Begin render command
        vkCmdBeginRenderPass(mCommandBuffers[i], &renderPassBeginInfo, VK_SUBPASS_CONTENTS_INLINE);

        vkCmdBindPipeline(mCommandBuffers[i], VK_PIPELINE_BIND_POINT_GRAPHICS, mGraphicPipeline);

        VkBuffer vertexBuffers[] = { mVertexBuffer->GetVkBuffer()};
        VkDeviceSize offsets[] = { 0 };
        vkCmdBindVertexBuffers(mCommandBuffers[i], 0, 1, vertexBuffers, offsets);
        vkCmdBindIndexBuffer(mCommandBuffers[i], mIndexBuffer->GetVkBuffer(), 0, VK_INDEX_TYPE_UINT16);

        assert(mDescriptorSets.size() == mCommandBuffers.size());
        vkCmdBindDescriptorSets(mCommandBuffers[i], VK_PIPELINE_BIND_POINT_GRAPHICS, mPipelineLayout, 0, 1, &mDescriptorSets[i], 0, nullptr);

        vkCmdDrawIndexed(mCommandBuffers[i], static_cast<uint32_t>(Vertex::Indices.size()), 1, 0, 0, 0);

        vkCmdEndRenderPass(mCommandBuffers[i]);
        // End render command

        passResult = vkEndCommandBuffer(mCommandBuffers[i]);
        if (passResult != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to end recording command buffer.");
            return false;
        }
    }

    return true;
}

bool Renderer::CreateSyncObjects()
{
    mImageAvailableSemaphores.resize(MAX_FRAME_IN_FLIGHT);
    mRenderFinishedSemaphores.resize(MAX_FRAME_IN_FLIGHT);
    mInFlightFence.resize(MAX_FRAME_IN_FLIGHT);
    mImageInFlightFence.resize(mSwapChainImages.size(), VK_NULL_HANDLE);

    VkSemaphoreCreateInfo semaphoreCreateInfo = {};
    semaphoreCreateInfo.sType = VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO;

    VkFenceCreateInfo fenceCreateInfo = {};
    fenceCreateInfo.sType = VK_STRUCTURE_TYPE_FENCE_CREATE_INFO;
    fenceCreateInfo.flags = VK_FENCE_CREATE_SIGNALED_BIT;

    for (uint32_t i = 0; i < MAX_FRAME_IN_FLIGHT; ++i)
    {
        VkResult result = vkCreateSemaphore(*mRenderDevice, &semaphoreCreateInfo, nullptr, &mImageAvailableSemaphores[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create image available semaphore.");
            return false;
        }

        result = vkCreateSemaphore(*mRenderDevice, &semaphoreCreateInfo, nullptr, &mRenderFinishedSemaphores[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create render finished semaphore.");
            return false;
        }

        result = vkCreateFence(*mRenderDevice, &fenceCreateInfo, nullptr, &mInFlightFence[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create in-flight fence.");
            return false;
        }
    }

    return true;
}

bool Renderer::CreateShaderModule(VkShaderModule* outShaderModule, const std::vector<uint8_t>& shaderBinary)
{
    VkShaderModuleCreateInfo shaderCreateInfo = {};
    shaderCreateInfo.sType = VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
    shaderCreateInfo.codeSize = shaderBinary.size();
    shaderCreateInfo.pCode = reinterpret_cast<const uint32_t*>(shaderBinary.data());

    VkResult result = vkCreateShaderModule(*mRenderDevice, &shaderCreateInfo, nullptr, outShaderModule);
    if (result != VK_SUCCESS)
    {
        return false;
    }

    return true;
}

VkSurfaceFormatKHR Renderer::ChooseSwapSurfaceFormat(const std::vector<VkSurfaceFormatKHR>& avaliableFormats) const
{
    for (const VkSurfaceFormatKHR avaliableFormat : avaliableFormats)
    {
        if (avaliableFormat.format == VK_FORMAT_B8G8R8A8_SRGB
            && avaliableFormat.colorSpace == VK_COLORSPACE_SRGB_NONLINEAR_KHR)
        {
            return avaliableFormat;
        }
    }

    return avaliableFormats.front();
}

VkPresentModeKHR Renderer::ChooseSwapPresentMode(const std::vector<VkPresentModeKHR>& avaliablePresentModes) const
{
    for (const VkPresentModeKHR& avaliablePresentMode : avaliablePresentModes)
    {
        if (avaliablePresentMode == VK_PRESENT_MODE_MAILBOX_KHR)
        {
            return avaliablePresentMode;
        }
    }

    return VK_PRESENT_MODE_FIFO_KHR; // Guaranteed to be always avaliable.
}

VkExtent2D Renderer::ChooseSwapExtent(const VkSurfaceCapabilitiesKHR& capabilities) const
{
    VkExtent2D actualExtent = capabilities.currentExtent;
    if (capabilities.currentExtent.width == UINT32_MAX)
    {
        int width = 0;
        int height = 0;

        GLFWwindow* windowObject = mApp->GetWindowObject();
        glfwGetFramebufferSize(windowObject, &width, &height);

        actualExtent.width = static_cast<uint32_t>(width);
        actualExtent.height = static_cast<uint32_t>(height);
        actualExtent.width = std::clamp(actualExtent.width, capabilities.minImageExtent.width, capabilities.maxImageExtent.width);
        actualExtent.height = std::clamp(actualExtent.height, capabilities.minImageExtent.height, capabilities.maxImageExtent.height);
    }

    return actualExtent;
}

// temp include
#include <chrono>
void Renderer::UpdateUniformBuffer(uint32_t currentImage)
{
    static auto startTime = std::chrono::high_resolution_clock::now();
    auto currentTime = std::chrono::high_resolution_clock::now();

    const float time = std::chrono::duration<float, std::chrono::seconds::period>(currentTime - startTime).count();

    UniformBufferObject ubo = {};
    ubo.ModelMatrix = glm::rotate(glm::mat4(1.f), time * glm::radians(90.f), glm::vec3(0.f, 0.f, 1.f));
    ubo.ViewMatrix = glm::lookAt(glm::vec3(2.f, 2.f, 2.f), glm::vec3(0.f, 0.f, 0.f), glm::vec3(0.f, 0.f, 1.f));

    const float aspect = static_cast<float>(mSwapChainExtent.width) / static_cast<float>(mSwapChainExtent.height);
    ubo.ProjMatrix = glm::perspective(glm::radians(45.f), aspect, 0.1f, 100.f);

    UniformBuffer* CurrentBuffer = mUniformBuffers[currentImage].get();
    CurrentBuffer->MapStagingBuffer(&ubo, sizeof(ubo));
    CurrentBuffer->TransferBuffer(mTransferCommandPool, mTransferQueue);
}
