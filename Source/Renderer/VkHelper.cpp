
// Primary Include
#include "Renderer/VkHelper.h"

// External Include
#include <fstream>

// Internal Include
#include "Core/Logger.h"


namespace VkHelper
{

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

bool TryReadShaderFile(std::vector<uint8_t>* outBinary, const std::string& filePath)
{
    std::ifstream file(filePath, std::ios::ate | std::ios::binary);
    if (file.is_open() == false)
    {
        RAD_LOG(Renderer, Error, "Failed to open file at that path");
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

}
