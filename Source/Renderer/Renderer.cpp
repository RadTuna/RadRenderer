
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
#include <imgui.h>
#include <imgui_impl_glfw.h>
#include <imgui_impl_vulkan.h>

// Internal Include
#include "Core/Application.h"
#include "Core/Logger.h"
#include "Core/Helper.h"
#include "Renderer/VkHelper.h"
#include "Renderer/RenderPass.h"
#include "Renderer/Resources/Vertex.h"
#include "Renderer/Resources/UniformBuffer.h"
#include "Renderer/Resources/VertexBuffer.h"
#include "Renderer/Resources/IndexBuffer.h"


Renderer::Renderer(class Application* inApp)
    : Module(inApp)
    , mRenderDevice(nullptr)
    , mSwapChain(nullptr)
    , mRenderPass(nullptr)
    , mGraphicsQueue(VK_NULL_HANDLE)
    , mPresentQueue(VK_NULL_HANDLE)
    , mTransferQueue(VK_NULL_HANDLE)
    , mDescriptorSetLayout(VK_NULL_HANDLE)
    , mPipelineLayout(VK_NULL_HANDLE)
    , mGraphicsPipeline(VK_NULL_HANDLE)
    , mGraphicsCommandPool(VK_NULL_HANDLE)
    , mTransferCommandPool(VK_NULL_HANDLE)
    , mDescriptorPool(VK_NULL_HANDLE)
    , mCurrentFrame(0)
    , mbFrameBufferResized(false)
    , mbCanRender(true)
{
}

Renderer::~Renderer()
{
}

bool Renderer::Initialize()
{
    RAD_LOG(Renderer, Log, "Start renderer module initialization.");
    bool bResult = true;

    mRenderDevice = MakeRenderObject<RenderDevice>();
    if (mRenderDevice == nullptr)
    {
        return false;
    }

    // RenderDevice에서 생성한 VkQueue를 가져옴
    mGraphicsQueue = mRenderDevice->GetGraphicsQueue();
    mPresentQueue = mRenderDevice->GetPresentQueue();
    mTransferQueue = mRenderDevice->GetTransferQueue();

    mSwapChain = MakeRenderObject<RenderSwapChain>(mRenderDevice);
    if (mSwapChain == nullptr)
    {
        return false;
    }

    mRenderPass = MakeRenderObject<RenderPass>(mRenderDevice, mSwapChain);
    if (mRenderPass == nullptr)
    {
        return false;
    }

    bResult = CreateDescriptorSetLayout();
    if (bResult == false)
    {
        return bResult;
    }

    bResult = CreateGraphicsPipeline();
    if (bResult == false)
    {
        return bResult;
    }

    bResult = CreateCommandPools();
    if (bResult == false)
    {
        return bResult;
    }

    bResult = CreateBuffers();
    if (bResult == false)
    {
        return bResult;
    }

    bResult = CreateDescriptorPool();
    if (bResult == false)
    {
        return bResult;
    }

    bResult = CreateDescriptorSets();
    if (bResult == false)
    {
        return bResult;
    }

    bResult = CreateCommandBuffers();
    if (bResult == false)
    {
        return bResult;
    }

    bResult = CreateSyncObjects();
    if (bResult == false)
    {
        return bResult;
    }

    bResult = CreateImGuiBackend();
    if (bResult == false)
    {
        return bResult;
    }

    RAD_LOG(Renderer, Log, "Complete renderer module initialization.");
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
    VkResult result = vkAcquireNextImageKHR(*mRenderDevice, *mSwapChain, UINT64_MAX, mImageAvailableSemaphores[mCurrentFrame], VK_NULL_HANDLE, &imageIndex);
    if (result == VK_ERROR_OUT_OF_DATE_KHR)
    {
        RecreateDependSwapChainObjects();
        return;
    }
    else if (result == VK_SUBOPTIMAL_KHR)
    {
        FrameBufferResized();
    }
    else if (result != VK_SUCCESS)
    {
        RAD_LOG(Renderer, Error, "Failed to aquire swap chain image.");
        return;
    }

    VK_ASSERT(vkResetFences(*mRenderDevice, 1, &mInFlightFence[mCurrentFrame]));

    {
        RecordRenderCommands(imageIndex);

        // temp transform function
        UpdateUniformBuffer(mCurrentFrame);
    }

    VkSubmitInfo submitInfo = {};
    submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;

    VkSemaphore waitSemaphores[] = { mImageAvailableSemaphores[mCurrentFrame] };
    VkPipelineStageFlags waitStages[] = { VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT };
    submitInfo.waitSemaphoreCount = static_cast<uint32_t>(ArraySize(waitSemaphores));
    submitInfo.pWaitSemaphores = waitSemaphores;
    submitInfo.pWaitDstStageMask = waitStages;

    submitInfo.commandBufferCount = 1;
    submitInfo.pCommandBuffers = &mCommandBuffers[mCurrentFrame];

    VkSemaphore signalSemaphores[] = { mRenderFinishedSemaphores[mCurrentFrame] };
    submitInfo.signalSemaphoreCount = static_cast<uint32_t>(ArraySize(signalSemaphores));
    submitInfo.pSignalSemaphores = signalSemaphores;

    result = vkQueueSubmit(mGraphicsQueue, 1, &submitInfo, mInFlightFence[mCurrentFrame]);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(Renderer, Warning, "Failed to submit draw command buffer.");
        return;
    }

    VkPresentInfoKHR presentInfo = {};
    presentInfo.sType = VK_STRUCTURE_TYPE_PRESENT_INFO_KHR;
    presentInfo.waitSemaphoreCount = static_cast<uint32_t>(ArraySize(signalSemaphores));
    presentInfo.pWaitSemaphores = signalSemaphores;

    VkSwapchainKHR swapChains[] = { *mSwapChain };
    presentInfo.swapchainCount = static_cast<uint32_t>(ArraySize(swapChains));
    presentInfo.pSwapchains = swapChains;
    presentInfo.pImageIndices = &imageIndex;
    presentInfo.pResults = nullptr;

    result = vkQueuePresentKHR(mPresentQueue, &presentInfo);
    if (result == VK_ERROR_OUT_OF_DATE_KHR || result == VK_SUBOPTIMAL_KHR || mbFrameBufferResized)
    {
        RecreateDependSwapChainObjects();
    }

    mCurrentFrame = (mCurrentFrame + 1) % mSwapChain->GetImageCount();
}

void Renderer::Deinitialize()
{
    RAD_LOG(Renderer, Log, "Start renderer module deinitialization.");

    VK_ASSERT(vkDeviceWaitIdle(*mRenderDevice));

    // release imgui vk resource
    {
        vkDestroyDescriptorPool(*mRenderDevice, mImGuiVkResource.DescriptorPool, nullptr);
    }

    ASSERT(mInFlightFence.size() == mRenderFinishedSemaphores.size()
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
    vkDestroyDescriptorPool(*mRenderDevice, mDescriptorPool, nullptr);

    DestroyDependSwapChainObjects();

    ImGui_ImplVulkan_Shutdown();
    ImGui_ImplGlfw_Shutdown();

    for (int32_t idx = mAllRenderObjects.size() - 1; idx >= 0; --idx)
    {
        mAllRenderObjects[idx] = nullptr;
    }

    RAD_LOG(Renderer, Log, "Complete renderer module deinitialization.");
}

void Renderer::StartFrame()
{
    ImGui_ImplVulkan_NewFrame();
    ImGui_ImplGlfw_NewFrame();
    ImGui::NewFrame();
}

void Renderer::EndFrame()
{
    ImGuiIO& io = ImGui::GetIO();

    // Update and Render additional Platform Windows
    if (io.ConfigFlags & ImGuiConfigFlags_ViewportsEnable)
    {
        ImGui::UpdatePlatformWindows();
        ImGui::RenderPlatformWindowsDefault();
    }

    ImGui::EndFrame();
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

    DestroyDependSwapChainObjects();

    bool bResult = mSwapChain = MakeRenderObject<RenderSwapChain>(mRenderDevice);
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateGraphicsPipeline();
    if (!bResult)
    {
        return bResult;
    }

    vkFreeDescriptorSets(*mRenderDevice, mDescriptorPool, static_cast<uint32_t>(mDescriptorSets.size()), mDescriptorSets.data());
    bResult = CreateDescriptorSets();
    if (!bResult)
    {
        return bResult;
    }

    vkFreeCommandBuffers(*mRenderDevice, mGraphicsCommandPool, static_cast<uint32_t>(mCommandBuffers.size()), mCommandBuffers.data());
    bResult = CreateCommandBuffers();
    if (!bResult)
    {
        return bResult;
    }

    RAD_LOG(Renderer, Log, "Recreate to objects depend on swap chain.");
    mbFrameBufferResized = false;

    return bResult;
}

void Renderer::DestroyDependSwapChainObjects()
{
    for (size_t i = 0; i < mUniformBuffers.size(); ++i)
    {
        mUniformBuffers[i] = nullptr;
    }

    vkDestroyPipeline(*mRenderDevice, mGraphicsPipeline, nullptr);
    vkDestroyPipelineLayout(*mRenderDevice, mPipelineLayout, nullptr);

    mRenderPass = nullptr;
    mSwapChain = nullptr;
}

bool Renderer::CreateDescriptorSetLayout()
{
    VkDescriptorSetLayoutBinding uboLayoutBinding = {};
    uboLayoutBinding.binding = 0;
    uboLayoutBinding.descriptorType = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER;
    uboLayoutBinding.descriptorCount = 1;
    uboLayoutBinding.stageFlags = VK_SHADER_STAGE_VERTEX_BIT;
    uboLayoutBinding.pImmutableSamplers = nullptr;

    VkDescriptorSetLayoutBinding samplerLayoutBinding = {};
    samplerLayoutBinding.binding = 1;
    samplerLayoutBinding.descriptorType = VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER;
    samplerLayoutBinding.descriptorCount = 1;
    samplerLayoutBinding.stageFlags = VK_SHADER_STAGE_FRAGMENT_BIT;
    samplerLayoutBinding.pImmutableSamplers = nullptr;

    VkDescriptorSetLayoutBinding layoutBindings[] = { uboLayoutBinding, samplerLayoutBinding };

    VkDescriptorSetLayoutCreateInfo layoutCreateInfo = {};
    layoutCreateInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO;
    layoutCreateInfo.bindingCount = static_cast<uint32_t>(ArraySize(layoutBindings));
    layoutCreateInfo.pBindings = layoutBindings;

    VkResult result = vkCreateDescriptorSetLayout(*mRenderDevice, &layoutCreateInfo, nullptr, &mDescriptorSetLayout);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(Renderer, Error, "Failed to create descriptor set layout.");
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

    // goto handling brace
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
        const VkExtent2D& swapChainExtent = mSwapChain->GetExtent();

        VkViewport viewport = {};
        viewport.x = 0.f;
        viewport.y = static_cast<float>(swapChainExtent.height);
        viewport.width = static_cast<float>(swapChainExtent.width);
        viewport.height = -static_cast<float>(swapChainExtent.height);
        viewport.minDepth = 0.f;
        viewport.maxDepth = 1.f;

        VkRect2D scissor = {};
        scissor.offset = { 0, 0 };
        scissor.extent = swapChainExtent;

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
            RAD_LOG(Renderer, Error, "Failed to create pipeline layout.");
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
        pipelineCreateInfo.renderPass = *mRenderPass;
        pipelineCreateInfo.subpass = 0;
        pipelineCreateInfo.basePipelineHandle = VK_NULL_HANDLE;
        pipelineCreateInfo.basePipelineIndex = -1;

        result = vkCreateGraphicsPipelines(*mRenderDevice, VK_NULL_HANDLE, 1, &pipelineCreateInfo, nullptr, &mGraphicsPipeline);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(Renderer, Error, "Failed to create graphics pipeline.");
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

bool Renderer::CreateCommandPools()
{
    const QueueFamilyIndices queueFamilyIndices = mRenderDevice->FindQueueFamilies();

    VkCommandPoolCreateInfo commandPoolCreateInfo = {};
    commandPoolCreateInfo.sType = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
    commandPoolCreateInfo.queueFamilyIndex = queueFamilyIndices.GraphicsFamily.value();
    commandPoolCreateInfo.flags = VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT;

    VkResult result = vkCreateCommandPool(*mRenderDevice, &commandPoolCreateInfo, nullptr, &mGraphicsCommandPool);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(Renderer, Error, "Failed to create graphics command pool.");
        return false;
    }

    commandPoolCreateInfo.queueFamilyIndex = queueFamilyIndices.TransferFamily.value();
    commandPoolCreateInfo.flags = VK_COMMAND_POOL_CREATE_TRANSIENT_BIT; // CommandBuffer의 수명이 짧다는 힌트 플래그.
    result = vkCreateCommandPool(*mRenderDevice, &commandPoolCreateInfo, nullptr, &mTransferCommandPool);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(Renderer, Error, "Failed to create transfer command pool.");
        return false;
    }

    return true;
}

bool Renderer::CreateBuffers()
{
    // Create vertex buffer
    {
        const VkDeviceSize bufferSize = sizeof(Vertex) * Vertex::Vertices.size();
        mVertexBuffer = std::make_unique<VertexBuffer>(mRenderDevice, bufferSize);

        const bool bCreateResult = mVertexBuffer->CreateBuffer();
        if (!bCreateResult)
        {
            return false;
        }

        mVertexBuffer->MapStagingBuffer((void*)Vertex::Vertices.data(), bufferSize);
        mVertexBuffer->TransferBuffer(mTransferCommandPool);
    }

    // Create index buffer
    {
        const VkDeviceSize bufferSize = sizeof(uint16_t) * Vertex::Indices.size();
        mIndexBuffer = std::make_unique<IndexBuffer>(mRenderDevice, bufferSize);

        const bool bCreateResult = mIndexBuffer->CreateBuffer();
        if (!bCreateResult)
        {
            return false;
        }

        mIndexBuffer->MapStagingBuffer((void*)Vertex::Indices.data(), bufferSize);
        mIndexBuffer->TransferBuffer(mTransferCommandPool);
    }

    // Create uniform buffer
    {
        VkDeviceSize bufferSize = sizeof(UniformBufferObject);

        // In-Flight 방식이기에 Image마다 UniformBuffer 필요.
        const size_t swapChainImageCount = mSwapChain->GetImageCount();
        mUniformBuffers.resize(swapChainImageCount);
        for (size_t i = 0; i < swapChainImageCount; ++i)
        {
            std::unique_ptr<UniformBuffer> uniformBuffer = std::make_unique<UniformBuffer>(mRenderDevice, bufferSize);
            const bool bCreateResult = uniformBuffer->CreateBuffer();
            if (!bCreateResult)
            {
                return false;
            }

            mUniformBuffers[i] = std::move(uniformBuffer);
        }
    }

    return true;
}

bool Renderer::CreateDescriptorPool()
{
    VkDescriptorPoolSize uniformPoolSize = {};
    uniformPoolSize.type = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER;
    uniformPoolSize.descriptorCount = MAX_FRAME_IN_FLIGHT;

    VkDescriptorPoolSize poolSizes[] = { uniformPoolSize };

    VkDescriptorPoolCreateInfo poolCreateInfo = {};
    poolCreateInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO;
    poolCreateInfo.flags = VK_DESCRIPTOR_POOL_CREATE_FREE_DESCRIPTOR_SET_BIT;
    poolCreateInfo.poolSizeCount = ArraySize(poolSizes);
    poolCreateInfo.pPoolSizes = poolSizes;
    poolCreateInfo.maxSets = MAX_FRAME_IN_FLIGHT;

    const VkResult result = vkCreateDescriptorPool(*mRenderDevice, &poolCreateInfo, nullptr, &mDescriptorPool);
    if (result != VK_SUCCESS)
    {
        return false;
    }

    return true;
}

bool Renderer::CreateDescriptorSets()
{
    const size_t swapChainImageCount = mSwapChain->GetImageCount();
    std::vector<VkDescriptorSetLayout> layouts(swapChainImageCount, mDescriptorSetLayout);

    VkDescriptorSetAllocateInfo allocInfo = {};
    allocInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO;
    allocInfo.descriptorPool = mDescriptorPool;
    allocInfo.descriptorSetCount = static_cast<uint32_t>(layouts.size());
    allocInfo.pSetLayouts = layouts.data();

    mDescriptorSets.resize(layouts.size());
    VkResult result = vkAllocateDescriptorSets(*mRenderDevice, &allocInfo, mDescriptorSets.data());
    if (result != VK_SUCCESS)
    {
        return false;
    }

    ASSERT(mDescriptorSets.size() == mUniformBuffers.size());
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
    const size_t swapChainImageCount = mSwapChain->GetImageCount();
    mCommandBuffers.resize(swapChainImageCount);

    VkCommandBufferAllocateInfo allocInfo = {};
    allocInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
    allocInfo.commandPool = mGraphicsCommandPool;
    allocInfo.level = VK_COMMAND_BUFFER_LEVEL_PRIMARY;
    allocInfo.commandBufferCount = static_cast<uint32_t>(mCommandBuffers.size());

    const VkResult result = vkAllocateCommandBuffers(*mRenderDevice, &allocInfo, mCommandBuffers.data());
    if (result != VK_SUCCESS)
    {
        RAD_LOG(Renderer, Error, "Failed to allocate command buffers.");
        return false;
    }

    return true;
}

bool Renderer::CreateSyncObjects()
{
    const size_t swapChainImageCount = mSwapChain->GetImageCount();
    mImageAvailableSemaphores.resize(MAX_FRAME_IN_FLIGHT);
    mRenderFinishedSemaphores.resize(MAX_FRAME_IN_FLIGHT);
    mInFlightFence.resize(MAX_FRAME_IN_FLIGHT);

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
            RAD_LOG(Renderer, Error, "Failed to create image available semaphore.");
            return false;
        }

        result = vkCreateSemaphore(*mRenderDevice, &semaphoreCreateInfo, nullptr, &mRenderFinishedSemaphores[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(Renderer, Error, "Failed to create render finished semaphore.");
            return false;
        }

        result = vkCreateFence(*mRenderDevice, &fenceCreateInfo, nullptr, &mInFlightFence[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(Renderer, Error, "Failed to create in-flight fence.");
            return false;
        }
    }

    return true;
}

bool Renderer::CreateImGuiBackend()
{
    // Create ImGui render pass
    {
        ASSERT(mSwapChain != nullptr);

        VkAttachmentDescription colorAttachment = {};
        colorAttachment.format = mSwapChain->GetImageFormat();
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

        VkResult result = vkCreateRenderPass(*mRenderDevice, &renderPassCreateInfo, nullptr, &mImGuiVkResource.RenderPass);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(Renderer, Error, "Failed to create main render pass.");
            return false;
        }

        const bool bResult = mSwapChain->CreateFrameBuffers(mImGuiVkResource.RenderPass);
        if (bResult == false)
        {
            RAD_LOG(Renderer, Error, "Failed to create main frame buffers.");
            return false;
        }
    }

    // Create ImGui decriptor pool
    {
        VkDescriptorPoolSize poolSize = {};
        poolSize.type = VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER;
        poolSize.descriptorCount = MAX_FRAME_IN_FLIGHT + 1;

        VkDescriptorPoolCreateInfo poolCreateInfo = {};
        poolCreateInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO;
        poolCreateInfo.flags = VK_DESCRIPTOR_POOL_CREATE_FREE_DESCRIPTOR_SET_BIT;
        poolCreateInfo.poolSizeCount = 1;
        poolCreateInfo.pPoolSizes = &poolSize;
        poolCreateInfo.maxSets = poolSize.descriptorCount;

        const VkResult result = vkCreateDescriptorPool(*mRenderDevice, &poolCreateInfo, nullptr, &mImGuiVkResource.DescriptorPool);
        if (result != VK_SUCCESS)
        {
            return false;
        }
    }

    // Setup Dear ImGui
    {
        const QueueFamilyIndices queueFamilyIndices = mRenderDevice->FindQueueFamilies();

        ImGui_ImplGlfw_InitForVulkan(mApp->GetWindowObject(), true);
        ImGui_ImplVulkan_InitInfo initInfo = { 0, };
        initInfo.Instance = mRenderDevice->GetInstance();
        initInfo.PhysicalDevice = mRenderDevice->GetPhysicalDevice();
        initInfo.Device = *mRenderDevice;
        initInfo.QueueFamily = queueFamilyIndices.GraphicsFamily.value();
        initInfo.Queue = mRenderDevice->GetGraphicsQueue();
        initInfo.PipelineCache = VK_NULL_HANDLE;
        initInfo.DescriptorPool = mImGuiVkResource.DescriptorPool;
        initInfo.Subpass = 0;
        initInfo.MinImageCount = mSwapChain->GetImageCount();
        initInfo.ImageCount = mSwapChain->GetImageCount();
        initInfo.MSAASamples = VK_SAMPLE_COUNT_1_BIT;
        initInfo.Allocator = nullptr;
        initInfo.CheckVkResultFn = nullptr;

        // ImGui는 별도의 GraphicsPipeline를 생성한다
        ImGui_ImplVulkan_Init(&initInfo, mImGuiVkResource.RenderPass);
    }

    // Upload Fonts
    {
        VkCommandBufferAllocateInfo allocInfo = {};
        allocInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
        allocInfo.level = VK_COMMAND_BUFFER_LEVEL_PRIMARY;
        allocInfo.commandPool = mTransferCommandPool;
        allocInfo.commandBufferCount = 1;

        VkCommandBuffer commandBuffer = VK_NULL_HANDLE;
        VK_ASSERT(vkAllocateCommandBuffers(*mRenderDevice, &allocInfo, &commandBuffer));

        VkCommandBufferBeginInfo beginInfo = {};
        beginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
        beginInfo.flags = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT;

        VK_ASSERT(vkBeginCommandBuffer(commandBuffer, &beginInfo));

        ImGui_ImplVulkan_CreateFontsTexture(commandBuffer);

        VK_ASSERT(vkEndCommandBuffer(commandBuffer));

        VkSubmitInfo submitInfo = {};
        submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;
        submitInfo.commandBufferCount = 1;
        submitInfo.pCommandBuffers = &commandBuffer;

        VK_ASSERT(vkQueueSubmit(mRenderDevice->GetTransferQueue(), 1, &submitInfo, VK_NULL_HANDLE));
        VK_ASSERT(vkQueueWaitIdle(mRenderDevice->GetTransferQueue()));

        vkFreeCommandBuffers(*mRenderDevice, mTransferCommandPool, 1, &commandBuffer);
        ImGui_ImplVulkan_DestroyFontUploadObjects();
    }

    mInFlightDescriptorSets.resize(MAX_FRAME_IN_FLIGHT);

    return true;
}

void Renderer::RecordRenderCommands(uint32_t imageIndex)
{
    VkDescriptorSet prevDescriptorSet = mInFlightDescriptorSets[mCurrentFrame];
    if (prevDescriptorSet != VK_NULL_HANDLE)
    {
        ImGui_ImplVulkan_RemoveTexture(prevDescriptorSet);
        mInFlightDescriptorSets[mCurrentFrame] = VK_NULL_HANDLE;
    }

    VkSampler currentSampler = mRenderPass->GetBufferSampler(mCurrentFrame);
    VkImageView currentImageView = mRenderPass->GetBufferImageView(mCurrentFrame);
    VkDescriptorSet currentDescriptorSet = ImGui_ImplVulkan_AddTexture(currentSampler, currentImageView, VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL);
    mInFlightDescriptorSets[mCurrentFrame] = currentDescriptorSet;

    ImTextureID textureID = static_cast<ImTextureID>(currentDescriptorSet);
    {
        static bool bLogOpen = true;
        ImGui::Begin("Viewport", &bLogOpen);
        ImGui::Image(textureID, ImVec2(256, 256));
        ImGui::End();
    }

    VkCommandBuffer commandBuffer = GetCurrrentCommandBuffer();
    vkResetCommandBuffer(commandBuffer, 0);

    VkClearValue clearColor = {};
    clearColor.color = { 0.f, 0.f, 0.f, 1.f };

    {
        SCOPED_VK_COMMAND(commandBuffer);

        VkRenderPassBeginInfo mainRenderPassBeginInfo = {};
        mainRenderPassBeginInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
        mainRenderPassBeginInfo.renderPass = *mRenderPass;
        mainRenderPassBeginInfo.framebuffer = mRenderPass->GetFrameBuffer(mCurrentFrame);
        mainRenderPassBeginInfo.renderArea.offset = { 0, 0 };
        mainRenderPassBeginInfo.renderArea.extent = mSwapChain->GetExtent();
        mainRenderPassBeginInfo.clearValueCount = 1;
        mainRenderPassBeginInfo.pClearValues = &clearColor;

        vkCmdBeginRenderPass(commandBuffer, &mainRenderPassBeginInfo, VK_SUBPASS_CONTENTS_INLINE);

        vkCmdBindPipeline(commandBuffer, VK_PIPELINE_BIND_POINT_GRAPHICS, mGraphicsPipeline);

        VkBuffer vertexBuffers[] = { mVertexBuffer->GetVkBuffer() };
        VkDeviceSize offsets[] = { 0 };
        vkCmdBindVertexBuffers(commandBuffer, 0, 1, vertexBuffers, offsets);
        vkCmdBindIndexBuffer(commandBuffer, mIndexBuffer->GetVkBuffer(), 0, VK_INDEX_TYPE_UINT16);

        ASSERT(mDescriptorSets.size() == mCommandBuffers.size());
        vkCmdBindDescriptorSets(commandBuffer, VK_PIPELINE_BIND_POINT_GRAPHICS, mPipelineLayout, 0, 1, &mDescriptorSets[mCurrentFrame], 0, nullptr);

        vkCmdDrawIndexed(commandBuffer, static_cast<uint32_t>(Vertex::Indices.size()), 1, 0, 0, 0);

        vkCmdEndRenderPass(commandBuffer);

        VkRenderPassBeginInfo imGuiRenderPassBeginInfo = {};
        imGuiRenderPassBeginInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
        imGuiRenderPassBeginInfo.renderPass = mImGuiVkResource.RenderPass;
        imGuiRenderPassBeginInfo.framebuffer = mSwapChain->GetFrameBuffer(imageIndex);
        imGuiRenderPassBeginInfo.renderArea.offset = { 0, 0 };
        imGuiRenderPassBeginInfo.renderArea.extent = mSwapChain->GetExtent();
        imGuiRenderPassBeginInfo.clearValueCount = 1;
        imGuiRenderPassBeginInfo.pClearValues = &clearColor;

        vkCmdBeginRenderPass(commandBuffer, &imGuiRenderPassBeginInfo, VK_SUBPASS_CONTENTS_INLINE);

        ImGui::Render();
        ImGui_ImplVulkan_RenderDrawData(ImGui::GetDrawData(), commandBuffer);

        vkCmdEndRenderPass(commandBuffer);
    }
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

    const VkExtent2D& swapChainExtent = mSwapChain->GetExtent();
    const float aspect = static_cast<float>(swapChainExtent.width) / static_cast<float>(swapChainExtent.height);
    ubo.ProjMatrix = glm::perspective(glm::radians(45.f), aspect, 0.1f, 100.f);

    UniformBuffer* CurrentBuffer = mUniformBuffers[currentImage].get();
    CurrentBuffer->MapStagingBuffer(&ubo, sizeof(ubo));
    CurrentBuffer->TransferBuffer(mTransferCommandPool);
}
