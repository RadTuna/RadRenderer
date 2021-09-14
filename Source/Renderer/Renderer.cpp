
// Primary Include
#include "Renderer.h"

// External Include
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
#include <cstring>
#include <cassert>
#include <unordered_set>
#include <algorithm>

// Internal Include
#include "Core/Application.h"
#include "Core/Logger.h"
#include "Core/Helper.h"


constexpr char* defaultValidationLayer = "VK_LAYER_KHRONOS_validation";

// vulkan proxy function.
VkResult CreateDebugUtilsMessengerEXT(
    VkInstance instance,
    const VkDebugUtilsMessengerCreateInfoEXT* createInfo,
    const VkAllocationCallbacks* allocator, VkDebugUtilsMessengerEXT* debugMessenger)
{
    static constexpr char* funcName = "vkCreateDebugUtilsMessengerEXT";
    auto func = reinterpret_cast<PFN_vkCreateDebugUtilsMessengerEXT>(vkGetInstanceProcAddr(instance, funcName));
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
    static constexpr char* funcName = "vkDestroyDebugUtilsMessengerEXT";
    auto func = reinterpret_cast<PFN_vkDestroyDebugUtilsMessengerEXT>(vkGetInstanceProcAddr(instance, funcName));
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
    : mInstance(nullptr)
    , mbEnableValidationLayer(true)
    , mPhysicalDevice(VK_NULL_HANDLE)
{
    // required extension
    mDeviceExtensions.push_back(VK_KHR_SWAPCHAIN_EXTENSION_NAME);

    // required layer
    mValidationLayers.push_back(defaultValidationLayer);
}

Renderer::~Renderer()
{
}

bool Renderer::Initialize()
{
    RAD_LOG(ELogType::Renderer, ELogClass::Log, "Start renderer module initialization.");
    bool bResult = true;

    bResult &= CreateInstance();
    if (!bResult)
    {
        return false;
    }

#if !defined NDEBUG
    bResult &= CreateDebugMessenger();
    if (!bResult)
    {
        return false;
    }
#endif

    bResult &= CreateSurface();
    if (!bResult)
    {
        return false;
    }

    bResult &= PickPhysicalDevice();
    if (!bResult)
    {
        return false;
    }

    bResult &= CreateLogicalDevice();
    if (!bResult)
    {
        return false;
    }

    bResult &= CreateSwapChain();
    if (!bResult)
    {
        return false;
    }

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

    vkDestroyDevice(mDevice, nullptr);
    vkDestroySurfaceKHR(mInstance, mSurface, nullptr);
    vkDestroyInstance(mInstance, nullptr);

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
    GetRequiredExtensions(requiredExtensions);
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

    return true;
}

bool Renderer::CheckValidationLayerSupport() const
{
    auto iterator = std::find_if(mVkLayers.begin(), mVkLayers.end(), [](const VkLayerProperties& layer)
        {
            return strcmp(defaultValidationLayer, layer.layerName) == 0;
        });

    if (iterator == mVkLayers.end())
    {
        return false;
    }

    return true;
}

void Renderer::GetRequiredExtensions(std::vector<const char*>& outExtensions) const
{
    uint32_t glfwExtensionCount = 0;
    const char** glfwExtensions = nullptr;
    glfwExtensions = glfwGetRequiredInstanceExtensions(&glfwExtensionCount);

    for (uint32_t i = 0; i < glfwExtensionCount; ++i)
    {
        outExtensions.push_back(glfwExtensions[i]);
    }

#if !defined NDEBUG 
    if (mbEnableValidationLayer)
    {
        outExtensions.push_back(VK_EXT_DEBUG_UTILS_EXTENSION_NAME);
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

    for (int i = 0; i < queueFamilies.size(); ++i)
    {
        if (IsValidQueueFamilyIndices(indices) == true)
        {
            break;
        }

        const VkQueueFamilyProperties& queueFamily = queueFamilies[i];
        if ((queueFamily.queueFlags & VK_QUEUE_GRAPHICS_BIT) != 0)
        {
            indices.GraphicFamily = i;
        }

        VkBool32 bSupportPresent = false;
        vkGetPhysicalDeviceSurfaceSupportKHR(physicalDevice, i, mSurface, &bSupportPresent);
        if (bSupportPresent)
        {
            indices.PresentFamily = i;
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

