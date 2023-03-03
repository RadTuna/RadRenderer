#pragma once

// External Include
#include <vulkan/vulkan.h>


class BaseBuffer
{
public:
    BaseBuffer(VkDevice inDevice, uint64_t inBufferSize);
    virtual ~BaseBuffer();

    virtual VkBufferUsageFlagBits GetBufferUsage() const = 0;

    bool CreateBuffer(VkPhysicalDevice physicalDevice);
    void DestroyBuffer();

    void MapStagingBuffer(void* inData, uint64_t size);
    void TransferBuffer(VkCommandPool commandPool, VkQueue targetQueue);

    inline VkBuffer GetVkBuffer() const { return mBuffer; }

private:
    bool CreateBufferInternal(VkPhysicalDevice physicalDevice, VkBuffer* buffer, VkDeviceMemory* bufferMemory, VkDeviceSize size, VkBufferUsageFlags usage, VkMemoryPropertyFlags properties);

protected:
    VkDevice mDevice;

    VkBuffer mBuffer;
    VkDeviceMemory mBufferMemory;

    VkBuffer mStagingBuffer;
    VkDeviceMemory mStagingBufferMemory;

    uint64_t mBufferSize;

};
