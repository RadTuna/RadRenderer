
// Primary Include
#include "Renderer.h"

// External Include
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
#include <cstring>
#include <cassert>
#include <unordered_set>
#include <algorithm>
#include <fstream>

// Internal Include
#include "Core/Application.h"
#include "Core/Logger.h"
#include "Core/Helper.h"


constexpr char* DEFAULT_VALIDATION_LAYER_NAME = "VK_LAYER_KHRONOS_validation";

// vulkan proxy function.
VkResult CreateDebugUtilsMessengerEXT(
    VkInstance instance,
    const VkDebugUtilsMessengerCreateInfoEXT* createInfo,
    const VkAllocationCallbacks* allocator, VkDebugUtilsMessengerEXT* debugMessenger)
{
    static constexpr char* VK_CREATE_DEBUG_UTILS_MESSENGER_FUNC_NAME = "vkCreateDebugUtilsMessengerEXT";
    auto func = reinterpret_cast<PFN_vkCreateDebugUtilsMessengerEXT>(vkGetInstanceProcAddr(instance, VK_CREATE_DEBUG_UTILS_MESSENGER_FUNC_NAME));
    if (func != nullptr)
    {
        return func(instance, createInfo, allocator, debugMessenger);
    }

    return VK_ERROR_EXTENSION_NOT_PRESENT;
}

void DestroyDebugUtilsMessengerEXT(
    VkInstance instance, 
    VkDebugUtilsMessengerEXT debugMessenger, 
    const VkAllocationCallbacks* allocator)
{
    static constexpr char* VK_DESTROY_DEBUG_UTILS_MESSENGER_FUNC_NAME = "vkDestroyDebugUtilsMessengerEXT";
    auto func = reinterpret_cast<PFN_vkDestroyDebugUtilsMessengerEXT>(vkGetInstanceProcAddr(instance, VK_DESTROY_DEBUG_UTILS_MESSENGER_FUNC_NAME));
    if (func != nullptr)
    {
        func(instance, debugMessenger, allocator);
    }
}

// QueueFamilyIndices helper function.
bool IsValidQueueFamilyIndices(const QueueFamilyIndices& indices)
{
    const bool bIsValidGraphicQueue = indices.GraphicFamily.has_value();
    const bool bIsValidPresentQueue = indices.PresentFamily.has_value();

    return bIsValidGraphicQueue && bIsValidPresentQueue;
}

Renderer::Renderer()
    : mInstance(VK_NULL_HANDLE)
    , mDebugMessenger(VK_NULL_HANDLE)
    , mPhysicalDevice(VK_NULL_HANDLE)
    , mDevice(VK_NULL_HANDLE)
    , mGraphicsQueue(VK_NULL_HANDLE)
    , mPresentQueue(VK_NULL_HANDLE)
    , mSurface(VK_NULL_HANDLE)
    , mSwapChain(VK_NULL_HANDLE)
    , mRenderPass(VK_NULL_HANDLE)
    , mPipelineLayout(VK_NULL_HANDLE)
    , mGraphicPipeline(VK_NULL_HANDLE)
    , mSwapChainExtent{0,}
    , mSwapChainImageFormat(VK_FORMAT_UNDEFINED)
    , mbEnableValidationLayer(true)
    , mbIsInitialized(false)
{
    // required extension
    mDeviceExtensions.push_back(VK_KHR_SWAPCHAIN_EXTENSION_NAME);

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
        return false;
    }

#if !defined NDEBUG
    bResult = CreateDebugMessenger();
    if (!bResult)
    {
        return false;
    }
#endif

    bResult = CreateSurface();
    if (!bResult)
    {
        return false;
    }

    bResult = PickPhysicalDevice();
    if (!bResult)
    {
        return false;
    }

    bResult = CreateLogicalDevice();
    if (!bResult)
    {
        return false;
    }

    bResult = CreateSwapChain();
    if (!bResult)
    {
        return false;
    }

    bResult = CreateRenderPass();
    if (!bResult)
    {
        return false;
    }

    bResult = CreateGraphicsPipeline();
    if (!bResult)
    {
        return false;
    }

    mbIsInitialized = bResult;

    RAD_LOG(ELogType::Renderer, ELogClass::Log, "Complete renderer module initialization.");
    return true;
}

void Renderer::Loop()
{
}

void Renderer::Deinitialize()
{
    RAD_LOG(ELogType::Renderer, ELogClass::Log, "Start renderer module deinitialization.");

#if !defined NDEBUG
    if (mbEnableValidationLayer)
    {
        DestroyDebugUtilsMessengerEXT(mInstance, mDebugMessenger, nullptr);
    }
#endif

    vkDestroyPipeline(mDevice, mGraphicPipeline, nullptr);
    vkDestroyPipelineLayout(mDevice, mPipelineLayout, nullptr);
    vkDestroyRenderPass(mDevice, mRenderPass, nullptr);

    for (VkImageView imageView : mSwapChainImageViews)
    {
        vkDestroyImageView(mDevice, imageView, nullptr);
    }

    vkDestroySwapchainKHR(mDevice, mSwapChain, nullptr);
    vkDestroyDevice(mDevice, nullptr);
    vkDestroySurfaceKHR(mInstance, mSurface, nullptr);
    vkDestroyInstance(mInstance, nullptr);

    mbIsInitialized = false;

    RAD_LOG(ELogType::Renderer, ELogClass::Log, "Complete renderer module deinitialization.");
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
    vkEnumerateInstanceExtensionProperties(nullptr, &vkExtensionCount, nullptr);
    mVkExtensions.resize(vkExtensionCount);
    vkEnumerateInstanceExtensionProperties(nullptr, &vkExtensionCount, mVkExtensions.data());
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
    vkEnumerateInstanceLayerProperties(&vkLayerCount, nullptr);
    mVkLayers.resize(vkLayerCount);
    vkEnumerateInstanceLayerProperties(&vkLayerCount, mVkLayers.data());
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
    const Application* app = Application::GetApplicationOrNull();
    assert(app != nullptr);

    GLFWwindow* windowObject = app->GetWindowObject();
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
    vkEnumeratePhysicalDevices(mInstance, &deviceCount, nullptr);
    if (deviceCount == 0)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "There are no graphics devices that support Vulkan.");
        return false;
    }

    std::vector<VkPhysicalDevice> vkDevices(deviceCount);
    vkEnumeratePhysicalDevices(mInstance, &deviceCount, vkDevices.data());
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
    QueueFamilyIndices indices = FindQueueFamily(mPhysicalDevice);
    if (IsValidQueueFamilyIndices(indices) == false)
    {
        return false;
    }

    std::vector<VkDeviceQueueCreateInfo> queueCreatInfos;
    std::unordered_set<uint32_t> uniqueQueueFamilies;
    uniqueQueueFamilies.insert(indices.GraphicFamily.value());
    uniqueQueueFamilies.insert(indices.PresentFamily.value());

    float queuePriority = 1.f;
    for (uint32_t queueFamily : uniqueQueueFamilies)
    {
        VkDeviceQueueCreateInfo queueCreateInfo = {};
        queueCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO;
        queueCreateInfo.queueFamilyIndex = indices.GraphicFamily.value();
        queueCreateInfo.queueCount = 1;
        queueCreateInfo.pQueuePriorities = &queuePriority;

        queueCreatInfos.push_back(queueCreateInfo);
    }

    VkPhysicalDeviceFeatures deviceFeatures = {};

    VkDeviceCreateInfo deviceCreateInfo = {};
    deviceCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO;
    deviceCreateInfo.pQueueCreateInfos = queueCreatInfos.data();
    deviceCreateInfo.queueCreateInfoCount = static_cast<uint32_t>(queueCreatInfos.size());
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

    QueueFamilyIndices indices = FindQueueFamily(mPhysicalDevice);
    assert(IsValidQueueFamilyIndices(indices) == true);
    uint32_t queueFamilyIndices[2] = { indices.GraphicFamily.value(), indices.PresentFamily.value() };

    if (indices.GraphicFamily != indices.PresentFamily)
    {
        swapChainCreateInfo.imageSharingMode = VK_SHARING_MODE_CONCURRENT;
        swapChainCreateInfo.queueFamilyIndexCount = static_cast<uint32_t>(ArraySize(queueFamilyIndices));
        swapChainCreateInfo.pQueueFamilyIndices = queueFamilyIndices;
    }
    else
    {
        swapChainCreateInfo.imageSharingMode = VK_SHARING_MODE_EXCLUSIVE;
        swapChainCreateInfo.queueFamilyIndexCount = 0;
        swapChainCreateInfo.pQueueFamilyIndices = nullptr;
    }

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
    vkGetSwapchainImagesKHR(mDevice, mSwapChain, &swapImageCount, nullptr);
    mSwapChainImages.resize(swapImageCount);
    vkGetSwapchainImagesKHR(mDevice, mSwapChain, &swapImageCount, mSwapChainImages.data());

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

    VkRenderPassCreateInfo renderPassCreateInfo = {};
    renderPassCreateInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO;
    renderPassCreateInfo.attachmentCount = 1;
    renderPassCreateInfo.pAttachments = &colorAttachment;
    renderPassCreateInfo.subpassCount = 1;
    renderPassCreateInfo.pSubpasses = &subPass;

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
        return false;
    }

    bResult = TryReadShaderFile(&fragShaderBinary, FRAG_SHADER_PATH);
    if (!bResult)
    {
        return false;
    }

    VkShaderModule vertShaderModule;
    bResult = CreateShaderModule(&vertShaderModule, vertShaderBinary);
    if (!bResult)
    {
        return false;
    }

    VkShaderModule fragShaderModule;
    bResult = CreateShaderModule(&fragShaderModule, fragShaderBinary);
    if (!bResult)
    {
        return false;
    }

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
    VkPipelineVertexInputStateCreateInfo vertexInputCreateInfo = {};
    vertexInputCreateInfo.sType = VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO;
    vertexInputCreateInfo.vertexBindingDescriptionCount = 0;
    vertexInputCreateInfo.pVertexBindingDescriptions = nullptr;
    vertexInputCreateInfo.vertexAttributeDescriptionCount = 0;
    vertexInputCreateInfo.pVertexAttributeDescriptions = nullptr;
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
    viewport.y = 0.f;
    viewport.width = static_cast<float>(mSwapChainExtent.width);
    viewport.height = static_cast<float>(mSwapChainExtent.height);
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
    pipelineLayoutCreateInfo.setLayoutCount = 0;
    pipelineLayoutCreateInfo.pSetLayouts = nullptr;
    pipelineLayoutCreateInfo.pushConstantRangeCount = 0;
    pipelineLayoutCreateInfo.pPushConstantRanges = nullptr;

    VkResult result = vkCreatePipelineLayout(mDevice, &pipelineLayoutCreateInfo, nullptr, &mPipelineLayout);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create pipeline layout.");
        return false;
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
        return false;
    }
    // End graphics pipeline


    vkDestroyShaderModule(mDevice, vertShaderModule, nullptr);
    vkDestroyShaderModule(mDevice, fragShaderModule, nullptr);

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

    QueueFamilyIndices indices = FindQueueFamily(physicalDevice);

    const bool bIsValidQueueFamilies = IsValidQueueFamilyIndices(indices);
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
    vkEnumerateDeviceExtensionProperties(physicalDevice, nullptr, &extensionCount, nullptr);

    std::vector<VkExtensionProperties> extensions(extensionCount);
    vkEnumerateDeviceExtensionProperties(physicalDevice, nullptr, &extensionCount, extensions.data());

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

QueueFamilyIndices Renderer::FindQueueFamily(VkPhysicalDevice physicalDevice) const
{
    QueueFamilyIndices indices;
    uint32_t queueFamilyCount = 0;
    vkGetPhysicalDeviceQueueFamilyProperties(physicalDevice, &queueFamilyCount, nullptr);

    std::vector<VkQueueFamilyProperties> queueFamilies(queueFamilyCount);
    vkGetPhysicalDeviceQueueFamilyProperties(physicalDevice, &queueFamilyCount, queueFamilies.data());

    for (size_t i = 0; i < queueFamilies.size(); ++i)
    {
        const uint32_t index = static_cast<uint32_t>(i);
        if (IsValidQueueFamilyIndices(indices) == true)
        {
            break;
        }

        const VkQueueFamilyProperties& queueFamily = queueFamilies[i];
        if ((queueFamily.queueFlags & VK_QUEUE_GRAPHICS_BIT) != 0)
        {
            indices.GraphicFamily = index;
        }

        VkBool32 bSupportPresent = false;
        vkGetPhysicalDeviceSurfaceSupportKHR(physicalDevice, index, mSurface, &bSupportPresent);
        if (bSupportPresent)
        {
            indices.PresentFamily = index;
        }
    }

    return indices;
}

SwapChainSupportDetails Renderer::QuerySwapCahinSupport(VkPhysicalDevice physicalDevice) const
{
    SwapChainSupportDetails details;

    vkGetPhysicalDeviceSurfaceCapabilitiesKHR(physicalDevice, mSurface, &details.Capabilities);

    uint32_t formatCount = 0;
    vkGetPhysicalDeviceSurfaceFormatsKHR(physicalDevice, mSurface, &formatCount, nullptr);
    details.Formats.resize(formatCount);
    vkGetPhysicalDeviceSurfaceFormatsKHR(physicalDevice, mSurface, &formatCount, details.Formats.data());

    uint32_t presentModeCount = 0;
    vkGetPhysicalDeviceSurfacePresentModesKHR(physicalDevice, mSurface, &presentModeCount, nullptr);
    details.PresentModes.resize(presentModeCount);
    vkGetPhysicalDeviceSurfacePresentModesKHR(physicalDevice, mSurface, &presentModeCount, details.PresentModes.data());

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

        Application* app = Application::GetApplicationOrNull();
        assert(app != nullptr);

        GLFWwindow* windowObject = app->GetWindowObject();
        glfwGetFramebufferSize(windowObject, &width, &height);

        actualExtent.width = static_cast<uint32_t>(width);
        actualExtent.height = static_cast<uint32_t>(height);
        actualExtent.width = std::clamp(actualExtent.width, capabilities.minImageExtent.width, capabilities.maxImageExtent.width);
        actualExtent.height = std::clamp(actualExtent.height, capabilities.minImageExtent.height, capabilities.maxImageExtent.height);
    }

    return actualExtent;
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

bool Renderer::TryReadShaderFile(std::vector<uint8_t>* outBinary, const std::string& filePath)
{
    std::ifstream file(filePath, std::ios::ate | std::ios::binary);
    if (file.is_open() == false)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to open file at that path");
        return false;
    }

    const size_t fileSize = static_cast<size_t>(file.tellg());
    const size_t padding = sizeof(uint32_t) - (fileSize % sizeof(uint32_t));

    outBinary->reserve(fileSize + padding);
    outBinary->resize(fileSize);

    file.seekg(0);
    file.read(reinterpret_cast<char*>(outBinary->data()), fileSize);
    file.close();

    return true;
}
