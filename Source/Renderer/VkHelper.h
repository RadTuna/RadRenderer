#pragma once

// External Include
#include <vector>
#include <string>
#include <cassert>
#include <vulkan/vulkan.h>


#pragma region Macros

#if DEBUG_BUILD
#define VK_ASSERT(Return) if ((Return) != VK_SUCCESS) { assert(false); }
#else
#define VK_ASSERT(Return)
#endif

#pragma endregion

#pragma region Class

class ScopedVkCommand final
{
public:
    ScopedVkCommand(VkCommandBuffer commandBuffer, uint32_t inFlags = 0, VkCommandBufferInheritanceInfo* inheritInfo = nullptr)
        : mCommandBuffer(commandBuffer)
    {
        VkCommandBufferBeginInfo commandBufferBeginInfo = {};
        commandBufferBeginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
        commandBufferBeginInfo.flags = inFlags;
        commandBufferBeginInfo.pInheritanceInfo = inheritInfo;
        vkBeginCommandBuffer(commandBuffer, &commandBufferBeginInfo);
    }

    ~ScopedVkCommand()
    {
        vkEndCommandBuffer(mCommandBuffer);
    }

private:
    VkCommandBuffer mCommandBuffer;

};

#define SCOPED_VK_COMMAND(CmdBuffer) ScopedVkCommand scopedVkCommand(CmdBuffer)

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
