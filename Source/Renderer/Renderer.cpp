
// Primary Include
#include "Renderer.h"

// External Include
#include <GLFW/glfw3.h>
#include <cstring>
#include <cassert>
#include <unordered_set>
#include <algorithm>
#include <array>
#include <iterator>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

// Internal Include
#include "Core/Application.h"
#include "Core/Logger.h"
#include "Core/Helper.h"
#include "Renderer/Vertex.h"
#include "Renderer/VkHelper.h"
#include "Renderer/UniformBuffer.h"


constexpr char* DEFAULT_VALIDATION_LAYER_NAME = "VK_LAYER_KHRONOS_validation";

bool QueueFamilyIndices::IsValidQueueFamilyIndices(const QueueFamilyIndices& indices)
{
    const bool bIsValidGraphicQueue = indices.GraphicFamily.has_value();
    const bool bIsValidPresentQueue = indices.PresentFamily.has_value();
    const bool bIsValidTransferQueue = indices.TransferFamily.has_value();

    return bIsValidGraphicQueue && bIsValidPresentQueue && bIsValidTransferQueue;
}

std::vector<uint32_t> QueueFamilyIndices::GetUniqueFamilies(const QueueFamilyIndices& indices)
{
    std::unordered_set<uint32_t> uniqueQueueFamilies;
    uniqueQueueFamilies.insert(indices.GraphicFamily.value());
    uniqueQueueFamilies.insert(indices.PresentFamily.value());
    uniqueQueueFamilies.insert(indices.TransferFamily.value());

    std::vector<uint32_t> outVector;
    copy(uniqueQueueFamilies.begin(), uniqueQueueFamilies.end(), std::back_inserter(outVector));

    return outVector;
}

const uint32_t Renderer::MAX_FRAME_IN_FLIGHT = 3;

Renderer::Renderer(class Application* inApp)
    : Module(inApp)
    , mInstance(VK_NULL_HANDLE)
    , mDebugMessenger(VK_NULL_HANDLE)
    , mPhysicalDevice(VK_NULL_HANDLE)
    , mDevice(VK_NULL_HANDLE)
    , mGraphicsQueue(VK_NULL_HANDLE)
    , mPresentQueue(VK_NULL_HANDLE)
    , mTransferQueue(VK_NULL_HANDLE)
    , mSurface(VK_NULL_HANDLE)
    , mSwapChain(VK_NULL_HANDLE)
    , mRenderPass(VK_NULL_HANDLE)
    , mPipelineLayout(VK_NULL_HANDLE)
    , mGraphicPipeline(VK_NULL_HANDLE)
    , mGraphicsCommandPool(VK_NULL_HANDLE)
    , mTransferCommandPool(VK_NULL_HANDLE)
    , mDescriptorPool(VK_NULL_HANDLE)
    , mVertexBuffer(VK_NULL_HANDLE)
    , mVertexBufferMemory(VK_NULL_HANDLE)
    , mIndexBuffer(VK_NULL_HANDLE)
    , mIndexBufferMemory(VK_NULL_HANDLE)
    , mCurrentFrame(0)
    , mSwapChainExtent{ 0, }
    , mSwapChainImageFormat(VK_FORMAT_UNDEFINED)
    , mbEnableValidationLayer(true)
    , mbFrameBufferResized(false)
    , mbCanRender(true)
{
    // required extension
    mDeviceExtensions.push_back(VK_KHR_SWAPCHAIN_EXTENSION_NAME);
    mDeviceExtensions.push_back(VK_KHR_MAINTENANCE1_EXTENSION_NAME);

    // required layer
    mValidationLayers.push_back(DEFAULT_VALIDATION_LAYER_NAME);
}

Renderer::~Renderer()
{
}

bool Renderer::Initialize()
{
    RAD_LOG(ELogType::Renderer, ELogClass::Log, "Start renderer module initialization.");
    bool bResult = true;

    bResult = CreateInstance();
    if (!bResult)
    {
        return bResult;
    }

#if !defined NDEBUG
    bResult = CreateDebugMessenger();
    if (!bResult)
    {
        return bResult;
    }
#endif

    bResult = CreateSurface();
    if (!bResult)
    {
        return bResult;
    }

    bResult = PickPhysicalDevice();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateLogicalDevice();
    if (!bResult)
    {
        return bResult;
    }

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

    VK_ASSERT(vkWaitForFences(mDevice, 1, &mInFlightFence[mCurrentFrame], VK_TRUE, UINT64_MAX));

    uint32_t imageIndex;
    VkResult result = vkAcquireNextImageKHR(mDevice, mSwapChain, UINT64_MAX, mImageAvailableSemaphores[mCurrentFrame], VK_NULL_HANDLE, &imageIndex);
    if (result == VK_ERROR_OUT_OF_DATE_KHR)
    {
        RecreateDependSwapChainObjects();
        return;
    }
    else if (result == VK_SUBOPTIMAL_KHR) // ???????? ???? ?????? ????. ?????? ???????? ?????? ????.
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
        VK_ASSERT(vkWaitForFences(mDevice, 1, &mImageInFlightFence[imageIndex], VK_TRUE, UINT64_MAX));
    }

    mImageInFlightFence[imageIndex] = mInFlightFence[mCurrentFrame];
    VK_ASSERT(vkResetFences(mDevice, 1, &mInFlightFence[mCurrentFrame]));

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

    VK_ASSERT(vkDeviceWaitIdle(mDevice));

    assert(mInFlightFence.size() == mRenderFinishedSemaphores.size()
        && mRenderFinishedSemaphores.size() == mImageAvailableSemaphores.size());
    for (uint32_t i = 0; i < mInFlightFence.size(); ++i)
    {
        vkDestroyFence(mDevice, mInFlightFence[i], nullptr);
        vkDestroySemaphore(mDevice, mRenderFinishedSemaphores[i], nullptr);
        vkDestroySemaphore(mDevice, mImageAvailableSemaphores[i], nullptr);
    }

    vkDestroyCommandPool(mDevice, mTransferCommandPool, nullptr);
    vkDestroyCommandPool(mDevice, mGraphicsCommandPool, nullptr);

    vkDestroyBuffer(mDevice, mIndexBuffer, nullptr);
    vkFreeMemory(mDevice, mIndexBufferMemory, nullptr);

    vkDestroyBuffer(mDevice, mVertexBuffer, nullptr);
    vkFreeMemory(mDevice, mVertexBufferMemory, nullptr);

    vkDestroyDescriptorSetLayout(mDevice, mDescriptorSetLayout, nullptr);

    DestroyDependSwapChainObjects();

    vkDestroyDevice(mDevice, nullptr);
    vkDestroySurfaceKHR(mInstance, mSurface, nullptr);
#if !defined NDEBUG
    if (mbEnableValidationLayer)
    {
        DestroyDebugUtilsMessengerEXT(mInstance, mDebugMessenger, nullptr);
    }
#endif
    vkDestroyInstance(mInstance, nullptr);

    RAD_LOG(ELogType::Renderer, ELogClass::Log, "Complete renderer module deinitialization.");
}

bool Renderer::RecreateDependSwapChainObjects()
{
    VK_ASSERT(vkDeviceWaitIdle(mDevice));

    int width = 0;
    int height = 0;
    glfwGetFramebufferSize(mApp->GetWindowObject(), &width, &height);
    if (width == 0 || height == 0)
    {
        return false;
    }

    vkFreeCommandBuffers(mDevice, mGraphicsCommandPool, static_cast<uint32_t>(mCommandBuffers.size()), mCommandBuffers.data());
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
        vkDestroyFramebuffer(mDevice, frameBuffer, nullptr);
    }

    assert(mUniformBuffers.size() == mUniformBufferMemories.size());
    for (size_t i = 0; i < mUniformBuffers.size(); ++i)
    {
        vkDestroyBuffer(mDevice, mUniformBuffers[i], nullptr);
        vkFreeMemory(mDevice, mUniformBufferMemories[i], nullptr);
    }

    vkDestroyDescriptorPool(mDevice, mDescriptorPool, nullptr);

    vkDestroyPipeline(mDevice, mGraphicPipeline, nullptr);
    vkDestroyPipelineLayout(mDevice, mPipelineLayout, nullptr);
    vkDestroyRenderPass(mDevice, mRenderPass, nullptr);

    for (VkImageView imageView : mSwapChainImageViews)
    {
        vkDestroyImageView(mDevice, imageView, nullptr);
    }

    vkDestroySwapchainKHR(mDevice, mSwapChain, nullptr);
}

bool Renderer::CreateInstance()
{
    // create vkapp info
    VkApplicationInfo vkAppInfo = {};
    vkAppInfo.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
    vkAppInfo.pApplicationName = Application::GetApplicationOrNull()->GetAppTitle().c_str();
    vkAppInfo.applicationVersion = VK_MAKE_VERSION(0, 0, 1);
    vkAppInfo.pEngineName = nullptr;
    vkAppInfo.engineVersion = VK_MAKE_VERSION(0, 0, 0);
    vkAppInfo.apiVersion = VK_API_VERSION_1_0;

    // create vkinstancecreate info
    VkInstanceCreateInfo instanceCreateInfo = {};
    instanceCreateInfo.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
    instanceCreateInfo.pApplicationInfo = &vkAppInfo;

    std::vector<const char*> requiredExtensions;
    GetRequiredExtensions(&requiredExtensions);
    instanceCreateInfo.enabledExtensionCount = static_cast<uint32_t>(requiredExtensions.size());
    instanceCreateInfo.ppEnabledExtensionNames = requiredExtensions.data();
#if defined NDEBUG 
    vkInstanceCreateInfo.enabledLayerCount = 0;
#else
    VkDebugUtilsMessengerCreateInfoEXT debugMessengerCreateInfo = {};
    if (mbEnableValidationLayer)
    {
        instanceCreateInfo.enabledLayerCount = static_cast<uint32_t>(mValidationLayers.size());
        instanceCreateInfo.ppEnabledLayerNames = mValidationLayers.data();

        PopulateDebugMessengerCreateInfo(debugMessengerCreateInfo);
        instanceCreateInfo.pNext = reinterpret_cast<VkDebugUtilsMessengerCreateInfoEXT*>(&debugMessengerCreateInfo);
    }
    else
    {
        instanceCreateInfo.enabledLayerCount = 0;
    }
#endif

    VkResult result = vkCreateInstance(&instanceCreateInfo, nullptr, &mInstance);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create Vulkan instance.");
        return false;
    }

    uint32_t vkExtensionCount = 0;
    VK_ASSERT(vkEnumerateInstanceExtensionProperties(nullptr, &vkExtensionCount, nullptr));
    mVkExtensions.resize(vkExtensionCount);
    VK_ASSERT(vkEnumerateInstanceExtensionProperties(nullptr, &vkExtensionCount, mVkExtensions.data()));
    for (size_t i = 0; i < requiredExtensions.size(); ++i)
    {
        const char* requireExtension = requiredExtensions[i];
        auto iterator = std::find_if(mVkExtensions.begin(), mVkExtensions.end(), [requireExtension](const VkExtensionProperties& extension)
            {
                return std::strcmp(requireExtension, extension.extensionName) == 0;
            });
        if (iterator == mVkExtensions.end())
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Required Vulkan extension does not exist");
            return false;
        }
    }

    uint32_t vkLayerCount = 0;
    VK_ASSERT(vkEnumerateInstanceLayerProperties(&vkLayerCount, nullptr));
    mVkLayers.resize(vkLayerCount);
    VK_ASSERT(vkEnumerateInstanceLayerProperties(&vkLayerCount, mVkLayers.data()));
#if !defined NDEBUG 
    if (mbEnableValidationLayer && !CheckValidationLayerSupport())
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Tried to use the validation layer, but does not exist.");
        return false;
    }
#endif

    return true;
}

#if !defined NDEBUG 
bool Renderer::CreateDebugMessenger()
{
    VkDebugUtilsMessengerCreateInfoEXT createInfo = {};
    PopulateDebugMessengerCreateInfo(createInfo);

    VkResult result = CreateDebugUtilsMessengerEXT(mInstance, &createInfo, nullptr, &mDebugMessenger);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create Vulkan debug messenger.");
        return false;
    }

    return true;
}
#endif

bool Renderer::CreateSurface()
{
    GLFWwindow* windowObject = mApp->GetWindowObject();
    VkResult vkResult = glfwCreateWindowSurface(mInstance, windowObject, nullptr, &mSurface);
    if (vkResult != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create window surface.");
        return false;
    }

    return true;
}

bool Renderer::PickPhysicalDevice()
{
    uint32_t deviceCount = 0;;
    VK_ASSERT(vkEnumeratePhysicalDevices(mInstance, &deviceCount, nullptr));
    if (deviceCount == 0)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "There are no graphics devices that support Vulkan.");
        return false;
    }

    std::vector<VkPhysicalDevice> vkDevices(deviceCount);
    VK_ASSERT(vkEnumeratePhysicalDevices(mInstance, &deviceCount, vkDevices.data()));
    for (VkPhysicalDevice device : vkDevices)
    {
        if (IsDeviceSuitable(device))
        {
            mPhysicalDevice = device; // get first suitable device.
            break;
        }
    }

    if (mPhysicalDevice == VK_NULL_HANDLE)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Falied to find a suitable GPU.");
        return false;
    }

    return true;
}

bool Renderer::CreateLogicalDevice()
{
    QueueFamilyIndices indices = FindQueueFamilies(mPhysicalDevice);
    if (QueueFamilyIndices::IsValidQueueFamilyIndices(indices) == false)
    {
        return false;
    }

    std::vector<VkDeviceQueueCreateInfo> queueCreateInfos;
    std::vector<uint32_t> uniqueQueueFamilies = QueueFamilyIndices::GetUniqueFamilies(indices);

    float queuePriority = 1.f;
    for (uint32_t queueFamily : uniqueQueueFamilies)
    {
        VkDeviceQueueCreateInfo queueCreateInfo = {};
        queueCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO;
        queueCreateInfo.queueFamilyIndex = queueFamily;
        queueCreateInfo.queueCount = 1;
        queueCreateInfo.pQueuePriorities = &queuePriority;

        queueCreateInfos.push_back(queueCreateInfo);
    }

    VkPhysicalDeviceFeatures deviceFeatures = {};

    VkDeviceCreateInfo deviceCreateInfo = {};
    deviceCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO;
    deviceCreateInfo.pQueueCreateInfos = queueCreateInfos.data();
    deviceCreateInfo.queueCreateInfoCount = static_cast<uint32_t>(queueCreateInfos.size());
    deviceCreateInfo.pEnabledFeatures = &deviceFeatures;
    deviceCreateInfo.enabledExtensionCount = static_cast<uint32_t>(mDeviceExtensions.size());
    deviceCreateInfo.ppEnabledExtensionNames = mDeviceExtensions.data();
#if !defined NDEBUG
    if (mbEnableValidationLayer)
    {
        deviceCreateInfo.enabledLayerCount = static_cast<uint32_t>(mValidationLayers.size());
        deviceCreateInfo.ppEnabledLayerNames = mValidationLayers.data();
    }
    else
    {
        deviceCreateInfo.enabledLayerCount = 0;
    }
#else
    deviceCreateInfo.enabledLayerCount = 0;
#endif

    VkResult result = vkCreateDevice(mPhysicalDevice, &deviceCreateInfo, nullptr, &mDevice);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create Vulkan logical device.");
        return false;
    }

    vkGetDeviceQueue(mDevice, indices.GraphicFamily.value(), 0, &mGraphicsQueue);
    vkGetDeviceQueue(mDevice, indices.PresentFamily.value(), 0, &mPresentQueue);
    vkGetDeviceQueue(mDevice, indices.TransferFamily.value(), 0, &mTransferQueue);

    return true;
}

bool Renderer::CreateSwapChain()
{
    const SwapChainSupportDetails details = QuerySwapCahinSupport(mPhysicalDevice);

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
    swapChainCreateInfo.surface = mSurface;
    swapChainCreateInfo.minImageCount = imageCount;
    swapChainCreateInfo.imageFormat = surfaceFormat.format;
    swapChainCreateInfo.imageColorSpace = surfaceFormat.colorSpace;
    swapChainCreateInfo.imageExtent = extent;
    swapChainCreateInfo.imageArrayLayers = 1;
    swapChainCreateInfo.imageUsage = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT;

    QueueFamilyIndices indices = FindQueueFamilies(mPhysicalDevice);
    assert(QueueFamilyIndices::IsValidQueueFamilyIndices(indices) == true);
    std::vector<uint32_t> uniqueQueueFamilies = QueueFamilyIndices::GetUniqueFamilies(indices);

    // Graphics queue?? Transfer queue?? ???????? ?????????? CONCURRENT ???? ????.
    // CONCURRENT ???? ???? ?????? QueueFamilyIndex?? Unique ??????.
    swapChainCreateInfo.imageSharingMode = VK_SHARING_MODE_CONCURRENT;
    swapChainCreateInfo.queueFamilyIndexCount = static_cast<uint32_t>(uniqueQueueFamilies.size());
    swapChainCreateInfo.pQueueFamilyIndices = uniqueQueueFamilies.data();

    swapChainCreateInfo.preTransform = details.Capabilities.currentTransform;
    swapChainCreateInfo.compositeAlpha = VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR;
    swapChainCreateInfo.presentMode = presentMode;
    swapChainCreateInfo.clipped = VK_TRUE;
    swapChainCreateInfo.oldSwapchain = VK_NULL_HANDLE;

    VkResult result = vkCreateSwapchainKHR(mDevice, &swapChainCreateInfo, nullptr, &mSwapChain);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create Vulkan swap chain.");
        return false;
    }

    mSwapChainExtent = extent;
    mSwapChainImageFormat = surfaceFormat.format;

    uint32_t swapImageCount = 0;
    VK_ASSERT(vkGetSwapchainImagesKHR(mDevice, mSwapChain, &swapImageCount, nullptr));
    mSwapChainImages.resize(swapImageCount);
    VK_ASSERT(vkGetSwapchainImagesKHR(mDevice, mSwapChain, &swapImageCount, mSwapChainImages.data()));

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

        result = vkCreateImageView(mDevice, &imageViewCreateInfo, nullptr, &mSwapChainImageViews[i]);
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

    VkResult result = vkCreateRenderPass(mDevice, &renderPassCreateInfo, nullptr, &mRenderPass);
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
    bool bResult = TryReadShaderFile(&vertShaderBinary, VERT_SHADER_PATH);
    if (!bResult)
    {
        return bResult;
    }

    bResult = TryReadShaderFile(&fragShaderBinary, FRAG_SHADER_PATH);
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

    // goto?? ???? C4533???? ???? ?? Brace
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

        VkResult result = vkCreatePipelineLayout(mDevice, &pipelineLayoutCreateInfo, nullptr, &mPipelineLayout);
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

        result = vkCreateGraphicsPipelines(mDevice, VK_NULL_HANDLE, 1, &pipelineCreateInfo, nullptr, &mGraphicPipeline);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create graphics pipeline.");
            bResult = false;
            goto EXIT_SHADER_ALL;
        }
        // End graphics pipeline
    }


EXIT_SHADER_ALL:
    vkDestroyShaderModule(mDevice, vertShaderModule, nullptr);
EXIT_SHADER_VERT:
    vkDestroyShaderModule(mDevice, fragShaderModule, nullptr);

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

        const VkResult result = vkCreateFramebuffer(mDevice, &frameBufferCreateInfo, nullptr, &mSwapChainFrameBuffers[i]);
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

    const VkResult result = vkCreateDescriptorSetLayout(mDevice, &layoutCreateInfo, nullptr, &mDescriptorSetLayout);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create descriptor set layout.");
        return false;
    }

    return true;
}

bool Renderer::CreateCommandPools()
{
    QueueFamilyIndices queueFamilyIndices = FindQueueFamilies(mPhysicalDevice);

    VkCommandPoolCreateInfo commandPoolCreateInfo = {};
    commandPoolCreateInfo.sType = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
    commandPoolCreateInfo.queueFamilyIndex = queueFamilyIndices.GraphicFamily.value();
    commandPoolCreateInfo.flags = 0;

    VkResult result = vkCreateCommandPool(mDevice, &commandPoolCreateInfo, nullptr, &mGraphicsCommandPool);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create graphics command pool.");
        return false;
    }

    commandPoolCreateInfo.queueFamilyIndex = queueFamilyIndices.TransferFamily.value();
    commandPoolCreateInfo.flags = VK_COMMAND_POOL_CREATE_TRANSIENT_BIT; // CommandBuffer?? ?????? ?????? ???? ??????.
    result = vkCreateCommandPool(mDevice, &commandPoolCreateInfo, nullptr, &mTransferCommandPool);
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

    // ???????? ???? ???? ????
    VkBuffer stagingBuffer;
    VkDeviceMemory stagingBufferMemory;
    bool bResult = CreateBuffer(
        &stagingBuffer,
        &stagingBufferMemory,
        bufferSize,
        VK_BUFFER_USAGE_TRANSFER_SRC_BIT,
        VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT);
    if (!bResult)
    {
        return bResult;
    }

    void* data;
    VK_ASSERT(vkMapMemory(mDevice, stagingBufferMemory, 0, VK_WHOLE_SIZE, 0, &data));
    memcpy(data, Vertex::Vertices.data(), bufferSize);
    vkUnmapMemory(mDevice, stagingBufferMemory);

    // ???????? ???????????? ???? ????
    bResult = CreateBuffer(
        &mVertexBuffer,
        &mVertexBufferMemory,
        bufferSize,
        VK_BUFFER_USAGE_TRANSFER_DST_BIT | VK_BUFFER_USAGE_VERTEX_BUFFER_BIT,
        VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT);
    if (!bResult)
    {
        goto EXIT_CLEAR_BUFFER;
    }

    // ???????? TransferQueue?? ?????? ?? ???? Wait ??.
    CopyBuffer(stagingBuffer, mVertexBuffer, bufferSize);

EXIT_CLEAR_BUFFER:
    vkDestroyBuffer(mDevice, stagingBuffer, nullptr);
    vkFreeMemory(mDevice, stagingBufferMemory, nullptr);

    return bResult;
}

bool Renderer::CreateIndexBuffer()
{
    const VkDeviceSize bufferSize = sizeof(uint16_t) * Vertex::Indices.size();

    // ???????? ???? ???? ????
    VkBuffer stagingBuffer;
    VkDeviceMemory stagingBufferMemory;
    bool bResult = CreateBuffer(
        &stagingBuffer,
        &stagingBufferMemory,
        bufferSize,
        VK_BUFFER_USAGE_TRANSFER_SRC_BIT,
        VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT);
    if (!bResult)
    {
        return false;
    }

    void* data;
    VK_ASSERT(vkMapMemory(mDevice, stagingBufferMemory, 0, VK_WHOLE_SIZE, 0, &data));
    memcpy(data, Vertex::Indices.data(), bufferSize);
    vkUnmapMemory(mDevice, stagingBufferMemory);

    // ???????? ???????????? ???? ????
    bResult = CreateBuffer(
        &mIndexBuffer,
        &mIndexBufferMemory,
        bufferSize,
        VK_BUFFER_USAGE_TRANSFER_DST_BIT | VK_BUFFER_USAGE_INDEX_BUFFER_BIT,
        VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT);
    if (!bResult)
    {
        return false;
    }

    // ???????? TransferQueue?? ?????? ?? ???? Wait ??.
    CopyBuffer(stagingBuffer, mIndexBuffer, bufferSize);

    vkDestroyBuffer(mDevice, stagingBuffer, nullptr);
    vkFreeMemory(mDevice, stagingBufferMemory, nullptr);

    return true;
}

bool Renderer::CreateUniformBuffer()
{
    VkDeviceSize bufferSize = sizeof(UniformBufferObject);

    // In-Flight ?????????? Image???? UniformBuffer ????.
    mUniformBuffers.resize(mSwapChainImages.size());
    mUniformBufferMemories.resize(mSwapChainImages.size());

    for (size_t i = 0; i < mSwapChainImages.size(); ++i)
    {
        const bool bResult = CreateBuffer(
            &mUniformBuffers[i],
            &mUniformBufferMemories[i],
            bufferSize,
            VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT,
            VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT);
        if (!bResult)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create uniform buffer.");
            return false;
        }
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

    const VkResult result = vkCreateDescriptorPool(mDevice, &poolCreateInfo, nullptr, &mDescriptorPool);
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
    const VkResult result = vkAllocateDescriptorSets(mDevice, &allocInfo, mDescriptorSets.data());
    if (result != VK_SUCCESS)
    {
        return false;
    }

    assert(mDescriptorSets.size() == mUniformBuffers.size());
    for (size_t i = 0; i < mDescriptorSets.size(); ++i)
    {
        VkDescriptorBufferInfo bufferInfo = {};
        bufferInfo.buffer = mUniformBuffers[i];
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

        vkUpdateDescriptorSets(mDevice, 1, &writeDesc, 0, nullptr);
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

    const VkResult result = vkAllocateCommandBuffers(mDevice, &allocInfo, mCommandBuffers.data());
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

        VkBuffer vertexBuffers[] = { mVertexBuffer };
        VkDeviceSize offsets[] = { 0 };
        vkCmdBindVertexBuffers(mCommandBuffers[i], 0, 1, vertexBuffers, offsets);
        vkCmdBindIndexBuffer(mCommandBuffers[i], mIndexBuffer, 0, VK_INDEX_TYPE_UINT16);

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
        VkResult result = vkCreateSemaphore(mDevice, &semaphoreCreateInfo, nullptr, &mImageAvailableSemaphores[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create image available semaphore.");
            return false;
        }

        result = vkCreateSemaphore(mDevice, &semaphoreCreateInfo, nullptr, &mRenderFinishedSemaphores[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create render finished semaphore.");
            return false;
        }

        result = vkCreateFence(mDevice, &fenceCreateInfo, nullptr, &mInFlightFence[i]);
        if (result != VK_SUCCESS)
        {
            RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create in-flight fence.");
            return false;
        }
    }

    return true;
}

bool Renderer::CheckValidationLayerSupport() const
{
    auto iterator = std::find_if(mVkLayers.begin(), mVkLayers.end(), [](const VkLayerProperties& layer)
        {
            return strcmp(DEFAULT_VALIDATION_LAYER_NAME, layer.layerName) == 0;
        });

    if (iterator == mVkLayers.end())
    {
        return false;
    }

    return true;
}

void Renderer::GetRequiredExtensions(std::vector<const char*>* outExtensions) const
{
    uint32_t glfwExtensionCount = 0;
    const char** glfwExtensions = nullptr;
    glfwExtensions = glfwGetRequiredInstanceExtensions(&glfwExtensionCount);

    for (uint32_t i = 0; i < glfwExtensionCount; ++i)
    {
        outExtensions->push_back(glfwExtensions[i]);
    }

#if !defined NDEBUG 
    if (mbEnableValidationLayer)
    {
        outExtensions->push_back(VK_EXT_DEBUG_UTILS_EXTENSION_NAME);
    }
#endif
}

void Renderer::PopulateDebugMessengerCreateInfo(VkDebugUtilsMessengerCreateInfoEXT& createInfo) const
{
    createInfo.sType = VK_STRUCTURE_TYPE_DEBUG_UTILS_MESSENGER_CALLBACK_DATA_EXT;
    createInfo.messageSeverity =
        VK_DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_SEVERITY_INFO_BIT_EXT
        | VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT;
    createInfo.messageType =
        VK_DEBUG_UTILS_MESSAGE_TYPE_GENERAL_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_TYPE_VALIDATION_BIT_EXT
        | VK_DEBUG_UTILS_MESSAGE_TYPE_PERFORMANCE_BIT_EXT;
    createInfo.pfnUserCallback = &OnVkDebugLog;
    createInfo.pUserData = nullptr;
}

bool Renderer::IsDeviceSuitable(VkPhysicalDevice physicalDevice) const
{
    VkPhysicalDeviceProperties deviceProperties;
    vkGetPhysicalDeviceProperties(physicalDevice, &deviceProperties);

    VkPhysicalDeviceFeatures deviceFeatures;
    vkGetPhysicalDeviceFeatures(physicalDevice, &deviceFeatures);

    QueueFamilyIndices indices = FindQueueFamilies(physicalDevice);

    const bool bIsValidQueueFamilies = QueueFamilyIndices::IsValidQueueFamilyIndices(indices);
    const bool bExtensionSupported = CheckDeviceExtensionSupport(physicalDevice);
    bool bSwapChainSupported = false;
    if (bExtensionSupported)
    {
        const SwapChainSupportDetails details = QuerySwapCahinSupport(physicalDevice);
        bSwapChainSupported = !details.Formats.empty() && !details.PresentModes.empty();
    }

    const bool bDiscreteGPU = deviceProperties.deviceType == VK_PHYSICAL_DEVICE_TYPE_DISCRETE_GPU;
    const bool bSupportGeometryShader = deviceFeatures.geometryShader;

    return bIsValidQueueFamilies && bExtensionSupported && bSwapChainSupported
        && bDiscreteGPU && bSupportGeometryShader;
}

bool Renderer::CheckDeviceExtensionSupport(VkPhysicalDevice physicalDevice) const
{
    uint32_t extensionCount = 0;
    VK_ASSERT(vkEnumerateDeviceExtensionProperties(physicalDevice, nullptr, &extensionCount, nullptr));

    std::vector<VkExtensionProperties> extensions(extensionCount);
    VK_ASSERT(vkEnumerateDeviceExtensionProperties(physicalDevice, nullptr, &extensionCount, extensions.data()));

    for (const char* extensionName : mDeviceExtensions)
    {
        auto iterator = std::find_if(extensions.begin(), extensions.end(), [extensionName](const VkExtensionProperties& properties)
            {
                return strcmp(properties.extensionName, extensionName) == 0;
            });
        if (iterator == extensions.end())
        {
            return false;
        }
    }

    return true;
}

QueueFamilyIndices Renderer::FindQueueFamilies(VkPhysicalDevice physicalDevice) const
{
    QueueFamilyIndices indices;
    uint32_t queueFamilyCount = 0;
    vkGetPhysicalDeviceQueueFamilyProperties(physicalDevice, &queueFamilyCount, nullptr);

    std::vector<VkQueueFamilyProperties> queueFamilies(queueFamilyCount);
    vkGetPhysicalDeviceQueueFamilyProperties(physicalDevice, &queueFamilyCount, queueFamilies.data());

    for (size_t i = 0; i < queueFamilies.size(); ++i)
    {
        const uint32_t index = static_cast<uint32_t>(i);
        if (QueueFamilyIndices::IsValidQueueFamilyIndices(indices) == true)
        {
            break;
        }

        const VkQueueFamilyProperties& queueFamily = queueFamilies[i];
        const bool bMatchGraphicsBit = (queueFamily.queueFlags & VK_QUEUE_GRAPHICS_BIT) != 0;
        const bool bMatchTransferBit = (queueFamily.queueFlags & VK_QUEUE_TRANSFER_BIT) != 0;

        if (indices.GraphicFamily.has_value() == false)
        {
            if (bMatchGraphicsBit)
            {
                indices.GraphicFamily = index;
            }
        }

        if (indices.PresentFamily.has_value() == false)
        {
            VkBool32 bSupportPresent = false;
            VK_ASSERT(vkGetPhysicalDeviceSurfaceSupportKHR(physicalDevice, index, mSurface, &bSupportPresent));
            if (bSupportPresent)
            {
                indices.PresentFamily = index;
            }
        }

        if (indices.TransferFamily.has_value() == false)
        {
            // Graphics bit?? set ?? Queue?? ?????????? Transfer bit?? set ??.
            if (!bMatchGraphicsBit && bMatchTransferBit)
            {
                indices.TransferFamily = index;
            }
        }
    }

    return indices;
}

SwapChainSupportDetails Renderer::QuerySwapCahinSupport(VkPhysicalDevice physicalDevice) const
{
    SwapChainSupportDetails details;

    VK_ASSERT(vkGetPhysicalDeviceSurfaceCapabilitiesKHR(physicalDevice, mSurface, &details.Capabilities));

    uint32_t formatCount = 0;
    VK_ASSERT(vkGetPhysicalDeviceSurfaceFormatsKHR(physicalDevice, mSurface, &formatCount, nullptr));
    details.Formats.resize(formatCount);
    VK_ASSERT(vkGetPhysicalDeviceSurfaceFormatsKHR(physicalDevice, mSurface, &formatCount, details.Formats.data()));

    uint32_t presentModeCount = 0;
    VK_ASSERT(vkGetPhysicalDeviceSurfacePresentModesKHR(physicalDevice, mSurface, &presentModeCount, nullptr));
    details.PresentModes.resize(presentModeCount);
    VK_ASSERT(vkGetPhysicalDeviceSurfacePresentModesKHR(physicalDevice, mSurface, &presentModeCount, details.PresentModes.data()));

    return details;
}

bool Renderer::CreateShaderModule(VkShaderModule* outShaderModule, const std::vector<uint8_t>& shaderBinary)
{
    VkShaderModuleCreateInfo shaderCreateInfo = {};
    shaderCreateInfo.sType = VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO;
    shaderCreateInfo.codeSize = shaderBinary.size();
    shaderCreateInfo.pCode = reinterpret_cast<const uint32_t*>(shaderBinary.data());

    VkResult result = vkCreateShaderModule(mDevice, &shaderCreateInfo, nullptr, outShaderModule);
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

uint32_t Renderer::FindPhysicalMemoryType(uint32_t typeFilter, VkMemoryPropertyFlags properties) const
{
    VkPhysicalDeviceMemoryProperties memProperties;
    vkGetPhysicalDeviceMemoryProperties(mPhysicalDevice, &memProperties);

    for (uint32_t i = 0; i < memProperties.memoryTypeCount; ++i)
    {
        const bool bCorrectType = (typeFilter & (1 << i)) != 0;
        const bool bCorrectProperty = (memProperties.memoryTypes[i].propertyFlags & properties) == properties;
        if (bCorrectType && bCorrectProperty)
        {
            return i;
        }
    }

    RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to find suitable physical device memory type.");
    return UINT32_MAX;
}

bool Renderer::CreateBuffer(VkBuffer* outBuffer, VkDeviceMemory* outBufferMemory, VkDeviceSize size, VkBufferUsageFlags usage, VkMemoryPropertyFlags properties) const
{
    VkBufferCreateInfo bufferCreateInfo = {};
    bufferCreateInfo.sType = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
    bufferCreateInfo.size = size;
    bufferCreateInfo.usage = usage;
    bufferCreateInfo.sharingMode = VK_SHARING_MODE_EXCLUSIVE;

    VkResult result = vkCreateBuffer(mDevice, &bufferCreateInfo, nullptr, outBuffer);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create buffer.");
        return false;
    }

    VkMemoryRequirements memRequirements;
    vkGetBufferMemoryRequirements(mDevice, *outBuffer, &memRequirements);

    VkMemoryAllocateInfo allocInfo = {};
    allocInfo.sType = VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
    allocInfo.allocationSize = memRequirements.size;
    const VkMemoryPropertyFlags memFlag = VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT;
    allocInfo.memoryTypeIndex = FindPhysicalMemoryType(memRequirements.memoryTypeBits, memFlag);

    result = vkAllocateMemory(mDevice, &allocInfo, nullptr, outBufferMemory);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to allocate buffer memory.");
        return false;
    }

    vkBindBufferMemory(mDevice, *outBuffer, *outBufferMemory, 0);

    return true;
}

void Renderer::CopyBuffer(VkBuffer srcBuffer, VkBuffer dstBuffer, VkDeviceSize size)
{
    VkCommandBufferAllocateInfo allocInfo = {};
    allocInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
    allocInfo.level = VK_COMMAND_BUFFER_LEVEL_PRIMARY;
    allocInfo.commandPool = mTransferCommandPool;
    allocInfo.commandBufferCount = 1;

    VkCommandBuffer commandBuffer;
    VK_ASSERT(vkAllocateCommandBuffers(mDevice, &allocInfo, &commandBuffer));

    VkCommandBufferBeginInfo beginInfo = {};
    beginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
    beginInfo.flags = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT;

    VK_ASSERT(vkBeginCommandBuffer(commandBuffer, &beginInfo));

    VkBufferCopy copyRegion = {};
    copyRegion.srcOffset = 0;
    copyRegion.dstOffset = 0;
    copyRegion.size = size;

    vkCmdCopyBuffer(commandBuffer, srcBuffer, dstBuffer, 1, &copyRegion);

    VK_ASSERT(vkEndCommandBuffer(commandBuffer));

    VkSubmitInfo submitInfo = {};
    submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;
    submitInfo.commandBufferCount = 1;
    submitInfo.pCommandBuffers = &commandBuffer;

    VK_ASSERT(vkQueueSubmit(mTransferQueue, 1, &submitInfo, VK_NULL_HANDLE));
    VK_ASSERT(vkQueueWaitIdle(mTransferQueue));

    vkFreeCommandBuffers(mDevice, mTransferCommandPool, 1, &commandBuffer);
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

    void* data;
    vkMapMemory(mDevice, mUniformBufferMemories[currentImage], 0, sizeof(ubo), 0, &data);
    memcpy(data, &ubo, sizeof(ubo));
    vkUnmapMemory(mDevice, mUniformBufferMemories[currentImage]);
}

VKAPI_ATTR VkBool32 VKAPI_CALL Renderer::OnVkDebugLog(
    VkDebugUtilsMessageSeverityFlagBitsEXT messageServerity,
    VkDebugUtilsMessageTypeFlagsEXT messageType,
    const VkDebugUtilsMessengerCallbackDataEXT* pCallBackData,
    void* pUserData)
{
    ELogClass logClass = ELogClass::Log;
    if (messageServerity == VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT)
    {
        logClass = ELogClass::Warning;
    }
    else if (messageServerity == VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT)
    {
        logClass = ELogClass::Error;
    }

    RAD_LOG(ELogType::Renderer, logClass, pCallBackData->pMessage);

    return VK_FALSE;
}
