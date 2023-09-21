
// Primary Include
#include "RenderDevice.h"

// External Include
#include <unordered_set>
#include <iterator>

// Internal Include
#include "Core/Application.h"


bool QueueFamilyIndices::IsValidQueueFamilyIndices(const QueueFamilyIndices& indices)
{
    const bool bIsValidGraphicQueue = indices.GraphicsFamily.has_value();
    const bool bIsValidPresentQueue = indices.PresentFamily.has_value();
    const bool bIsValidTransferQueue = indices.TransferFamily.has_value();

    return bIsValidGraphicQueue && bIsValidPresentQueue && bIsValidTransferQueue;
}

std::vector<uint32_t> QueueFamilyIndices::GetUniqueFamilies(const QueueFamilyIndices& indices)
{
    std::unordered_set<uint32_t> uniqueQueueFamilies;
    uniqueQueueFamilies.insert(indices.GraphicsFamily.value());
    uniqueQueueFamilies.insert(indices.PresentFamily.value());
    uniqueQueueFamilies.insert(indices.TransferFamily.value());

    std::vector<uint32_t> outVector;
    copy(uniqueQueueFamilies.begin(), uniqueQueueFamilies.end(), std::back_inserter(outVector));

    return outVector;
}


constexpr char* DEFAULT_VALIDATION_LAYER_NAME = "VK_LAYER_KHRONOS_validation";

RenderDevice::RenderDevice()
    : mInstance(VK_NULL_HANDLE)
    , mDebugMessenger(VK_NULL_HANDLE)
    , mPhysicalDevice(VK_NULL_HANDLE)
    , mDevice(VK_NULL_HANDLE)
    , mSurface(VK_NULL_HANDLE)
    , mGraphicsQueue(VK_NULL_HANDLE)
    , mPresentQueue(VK_NULL_HANDLE)
    , mTransferQueue(VK_NULL_HANDLE)
    , mbEnableValidationLayer(true)
{
    // required extension
    mDeviceExtensions.push_back(VK_KHR_SWAPCHAIN_EXTENSION_NAME);
    mDeviceExtensions.push_back(VK_KHR_MAINTENANCE1_EXTENSION_NAME);

    // required layer
    mValidationLayers.push_back(DEFAULT_VALIDATION_LAYER_NAME);
}

RenderDevice::~RenderDevice()
{
    Destroy();
}

bool RenderDevice::Create(RenderDevice* renderDevice)
{
    bool bResult = true;

    bResult = CreateInstance();
    if (!bResult)
    {
        return bResult;
    }

    bResult = CreateDebugMessenger();
    if (!bResult)
    {
        return bResult;
    }

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

    return bResult;
}

void RenderDevice::Destroy()
{
    if (mDevice != VK_NULL_HANDLE)
    {
        vkDestroyDevice(mDevice, nullptr);
        mDevice = VK_NULL_HANDLE;
    }

    if (mSurface != VK_NULL_HANDLE)
    {
        vkDestroySurfaceKHR(mInstance, mSurface, nullptr);
        mSurface = VK_NULL_HANDLE;
    }
#if !defined NDEBUG
    if (mbEnableValidationLayer && mDebugMessenger != VK_NULL_HANDLE)
    {
        VkHelper::DestroyDebugUtilsMessengerEXT(mInstance, mDebugMessenger, nullptr);
        mDebugMessenger = VK_NULL_HANDLE;
    }
#endif

    if (mInstance != VK_NULL_HANDLE)
    {
        vkDestroyInstance(mInstance, nullptr);
        mInstance = VK_NULL_HANDLE;
    }
}

QueueFamilyIndices RenderDevice::FindQueueFamilies() const
{
    return FindQueueFamilies(mPhysicalDevice);
}

QueueFamilyIndices RenderDevice::FindQueueFamilies(VkPhysicalDevice physicalDevice) const
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

        if (indices.GraphicsFamily.has_value() == false)
        {
            if (bMatchGraphicsBit)
            {
                indices.GraphicsFamily = index;
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
            // Graphics bit이 set 된 Queue는 암시적으로 Transfer bit이 set 됨.
            if (!bMatchGraphicsBit && bMatchTransferBit)
            {
                indices.TransferFamily = index;
            }
        }
    }

    return indices;
}

SwapChainSupportDetails RenderDevice::QuerySwapChainSupport() const
{
    return QuerySwapChainSupport(mPhysicalDevice);
}

SwapChainSupportDetails RenderDevice::QuerySwapChainSupport(VkPhysicalDevice physicalDevice) const
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

uint32_t RenderDevice::FindPhysicalMemoryType(uint32_t typeFilter, VkMemoryPropertyFlags properties)
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

    RAD_LOG(Renderer, Error, "Failed to find suitable physical device memory type.");
    return UINT32_MAX;
}

bool RenderDevice::CreateInstance()
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
        RAD_LOG(Renderer, Error, "Failed to create Vulkan instance.");
        return false;
    }

    uint32_t vkExtensionCount = 0;
    VK_ASSERT(vkEnumerateInstanceExtensionProperties(nullptr, &vkExtensionCount, nullptr));
    mVkInstanceExtensions.resize(vkExtensionCount);
    VK_ASSERT(vkEnumerateInstanceExtensionProperties(nullptr, &vkExtensionCount, mVkInstanceExtensions.data()));
    for (size_t i = 0; i < requiredExtensions.size(); ++i)
    {
        const char* requireExtension = requiredExtensions[i];
        auto iterator = std::find_if(mVkInstanceExtensions.begin(), mVkInstanceExtensions.end(), [requireExtension](const VkExtensionProperties& extension)
            {
                return std::strcmp(requireExtension, extension.extensionName) == 0;
            });
        if (iterator == mVkInstanceExtensions.end())
        {
            RAD_LOG(Renderer, Error, "Required Vulkan extension does not exist");
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
        RAD_LOG(Renderer, Error, "Tried to use the validation layer, but does not exist.");
        return false;
    }
#endif

    return true;
}

bool RenderDevice::CreateDebugMessenger()
{
#if !defined NDEBUG 
    VkDebugUtilsMessengerCreateInfoEXT createInfo = {};
    PopulateDebugMessengerCreateInfo(createInfo);

    VkResult result = VkHelper::CreateDebugUtilsMessengerEXT(mInstance, &createInfo, nullptr, &mDebugMessenger);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(Renderer, Error, "Failed to create Vulkan debug messenger.");
        return false;
    }

#endif
    return true;
}

bool RenderDevice::CreateSurface()
{
    Application* app = Application::GetApplicationOrNull();
    if (app == nullptr)
    {
        return false;
    }

    GLFWwindow* windowObject = app->GetWindowObject();
    VkResult vkResult = glfwCreateWindowSurface(mInstance, windowObject, nullptr, &mSurface);
    if (vkResult != VK_SUCCESS)
    {
        RAD_LOG(Renderer, Error, "Failed to create window surface.");
        return false;
    }

    return true;
}

bool RenderDevice::PickPhysicalDevice()
{
    uint32_t deviceCount = 0;;
    VK_ASSERT(vkEnumeratePhysicalDevices(mInstance, &deviceCount, nullptr));
    if (deviceCount == 0)
    {
        RAD_LOG(Renderer, Error, "There are no graphics devices that support Vulkan.");
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
        RAD_LOG(Renderer, Error, "Falied to find a suitable GPU.");
        return false;
    }

    return true;
}

bool RenderDevice::CreateLogicalDevice()
{
    const QueueFamilyIndices indices = FindQueueFamilies();
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
        RAD_LOG(Renderer, Error, "Failed to create Vulkan logical device.");
        return false;
    }

    vkGetDeviceQueue(mDevice, indices.GraphicsFamily.value(), 0, &mGraphicsQueue);
    vkGetDeviceQueue(mDevice, indices.PresentFamily.value(), 0, &mPresentQueue);
    vkGetDeviceQueue(mDevice, indices.TransferFamily.value(), 0, &mTransferQueue);

    return true;
}

void RenderDevice::GetRequiredExtensions(std::vector<const char*>* outExtensions)
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

bool RenderDevice::CheckValidationLayerSupport() const
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

void RenderDevice::PopulateDebugMessengerCreateInfo(VkDebugUtilsMessengerCreateInfoEXT& createInfo) const
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

bool RenderDevice::IsDeviceSuitable(VkPhysicalDevice physicalDevice) const
{
    VkPhysicalDeviceProperties deviceProperties;
    vkGetPhysicalDeviceProperties(physicalDevice, &deviceProperties);

    VkPhysicalDeviceFeatures deviceFeatures;
    vkGetPhysicalDeviceFeatures(physicalDevice, &deviceFeatures);

    const QueueFamilyIndices indices = FindQueueFamilies(physicalDevice);
    const bool bIsValidQueueFamilies = QueueFamilyIndices::IsValidQueueFamilyIndices(indices);
    const bool bExtensionSupported = CheckDeviceExtensionSupport(physicalDevice);
    bool bSwapChainSupported = false;
    if (bExtensionSupported)
    {
        const SwapChainSupportDetails details = QuerySwapChainSupport(physicalDevice);
        bSwapChainSupported = !details.Formats.empty() && !details.PresentModes.empty();
    }

    const bool bDiscreteGPU = deviceProperties.deviceType == VK_PHYSICAL_DEVICE_TYPE_DISCRETE_GPU;
    const bool bSupportGeometryShader = deviceFeatures.geometryShader;

    return bIsValidQueueFamilies && bExtensionSupported && bSwapChainSupported
        && bDiscreteGPU && bSupportGeometryShader;
}

bool RenderDevice::CheckDeviceExtensionSupport(VkPhysicalDevice physicalDevice) const
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

VKAPI_ATTR VkBool32 VKAPI_CALL RenderDevice::OnVkDebugLog(
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

    RAD_DYN_LOG(ELogType::Renderer, logClass, pCallBackData->pMessage);

    return VK_FALSE;
}
