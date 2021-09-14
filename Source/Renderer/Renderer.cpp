
// Primary Include
#include "Renderer.h"

// External Include
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
#include <cstring>
#include <cassert>

// Internal Include
#include "Core/Application.h"
#include "Core/Logger.h"

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

Renderer::Renderer()
    : mInstance(nullptr)
    , mbEnableValidationLayer(true)
    , mPhysicalDevice(VK_NULL_HANDLE)
{
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

    vkDestroyInstance(mInstance, nullptr);
    vkDestroyDevice(mDevice, nullptr);

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
    if (indices.GraphicFamily.has_value() == false)
    {
        return false;
    }

    VkDeviceQueueCreateInfo queueCreateInfo = {};
    queueCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO;
    queueCreateInfo.queueFamilyIndex = indices.GraphicFamily.value();
    queueCreateInfo.queueCount = 1;
    float queuePriority = 1.f;
    queueCreateInfo.pQueuePriorities = &queuePriority;

    VkPhysicalDeviceFeatures deviceFeatures = {};

    VkDeviceCreateInfo deviceCreateInfo = {};
    deviceCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO;
    deviceCreateInfo.pQueueCreateInfos = &queueCreateInfo;
    deviceCreateInfo.queueCreateInfoCount = 1;
    deviceCreateInfo.pEnabledFeatures = &deviceFeatures;

    deviceCreateInfo.enabledExtensionCount = 0;
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

    return true;
}

bool Renderer::CheckValidationLayerSupport()
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

void Renderer::GetRequiredExtensions(std::vector<const char*>& outExtensions)
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

void Renderer::PopulateDebugMessengerCreateInfo(VkDebugUtilsMessengerCreateInfoEXT& createInfo)
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

bool Renderer::IsDeviceSuitable(VkPhysicalDevice physicalDevice)
{
    VkPhysicalDeviceProperties deviceProperties;
    vkGetPhysicalDeviceProperties(physicalDevice, &deviceProperties);

    VkPhysicalDeviceFeatures deviceFeatures;
    vkGetPhysicalDeviceFeatures(physicalDevice, &deviceFeatures);

    QueueFamilyIndices indices = FindQueueFamily(physicalDevice);

    const bool bHasGraphicQueueFamily = indices.GraphicFamily.has_value();
    const bool bDiscreteGPU = deviceProperties.deviceType == VK_PHYSICAL_DEVICE_TYPE_DISCRETE_GPU;
    const bool bSupportGeometryShader = deviceFeatures.geometryShader;

    return bHasGraphicQueueFamily && bDiscreteGPU && bSupportGeometryShader;
}

QueueFamilyIndices Renderer::FindQueueFamily(VkPhysicalDevice physicalDevice)
{
    QueueFamilyIndices indices;
    uint32_t queueFamilyCount = 0;
    vkGetPhysicalDeviceQueueFamilyProperties(physicalDevice, &queueFamilyCount, nullptr);

    std::vector<VkQueueFamilyProperties> queueFamilies(queueFamilyCount);
    vkGetPhysicalDeviceQueueFamilyProperties(physicalDevice, &queueFamilyCount, queueFamilies.data());

    for (int i = 0; i < queueFamilies.size(); ++i)
    {
        const VkQueueFamilyProperties& queueFamily = queueFamilies[i];
        if ((queueFamily.queueFlags & VK_QUEUE_GRAPHICS_BIT) != 0)
        {
            indices.GraphicFamily = i;
            break;
        }
    }

    return indices;
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

