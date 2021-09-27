#pragma once

// External Include
#include <vector>
#include <string>
#include <cassert>
#include <vulkan/vulkan.h>


// Begin macros

#if defined NDEBUG
#define VK_ASSERT(Return)
#else
#define VK_ASSERT(Return) if ((Return) != VK_SUCCESS) { assert(false); }
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

bool CreateBuffer(
    VkBuffer* outBuffer, 
    VkDeviceMemory* outMemory, 
    VkPhysicalDevice physicalDevice, 
    VkDeviceSize size, 
    VkBufferUsageFlags usage, 
    VkMemoryPropertyFlags properties);

uint32_t FindPhysicalMemoryType(uint32_t typeFilter, VkMemoryPropertyFlags properties);

// End functions
