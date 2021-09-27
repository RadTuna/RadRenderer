#pragma once

// External Include
#include <vector>
#include <string>
#include <cassert>
#include <vulkan/vulkan.h>


// Begin macros

#if defined NDEBUG
#define VK_ASSERT_RETURN(Return)
#else
#define VK_ASSERT_RETURN(Return) if ((Return) != VK_SUCCESS) { assert(false); }
#endif

// End macros


// Begin functions

VkResult CreateDebugUtilsMessengerEXT(
    VkInstance instance,
    const VkDebugUtilsMessengerCreateInfoEXT * createInfo,
    const VkAllocationCallbacks * allocator, VkDebugUtilsMessengerEXT * debugMessenger);

void DestroyDebugUtilsMessengerEXT(
    VkInstance instance,
    VkDebugUtilsMessengerEXT debugMessenger,
    const VkAllocationCallbacks * allocator);

bool TryReadShaderFile(std::vector<uint8_t>*outBinary, const std::string& filePath);

// End functions
