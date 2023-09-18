#pragma once

// External Include
#include <vector>
#include <string>
#include <cassert>
#include <vulkan/vulkan.h>


#pragma region Macros

#if defined NDEBUG
#define VK_ASSERT(Return)
#else
#define VK_ASSERT(Return) if ((Return) != VK_SUCCESS) { assert(false); }
#endif

#pragma endregion


#pragma region Functions

namespace VkHelper
{

VkResult CreateDebugUtilsMessengerEXT(
    VkInstance instance,
    const VkDebugUtilsMessengerCreateInfoEXT* createInfo,
    const VkAllocationCallbacks* allocator, VkDebugUtilsMessengerEXT* debugMessenger);

void DestroyDebugUtilsMessengerEXT(
    VkInstance instance,
    VkDebugUtilsMessengerEXT debugMessenger,
    const VkAllocationCallbacks* allocator);

bool TryReadShaderFile(std::vector<uint8_t>* outBinary, const std::string& filePath);

}

#pragma endregion
