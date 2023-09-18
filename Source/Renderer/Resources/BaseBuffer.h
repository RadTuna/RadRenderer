#pragma once

// External Include
#include <vulkan/vulkan.h>


class RenderDevice;

class BaseBuffer
{
public:
    BaseBuffer(RenderDevice* inRenderDevice, uint64_t inBufferSize);
    virtual ~BaseBuffer();

    virtual VkBufferUsageFlagBits GetBufferUsage() const = 0;

    bool CreateBuffer();
    void DestroyBuffer();

    void MapStagingBuffer(void* inData, uint64_t size);
    void TransferBuffer(VkCommandPool commandPool, VkQueue targetQueue);

    inline VkBuffer GetVkBuffer() const { return mBuffer; }

private:
    bool CreateBufferInternal(VkBuffer* buffer, VkDeviceMemory* bufferMemory, VkDeviceSize size, VkBufferUsageFlags usage, VkMemoryPropertyFlags properties);

protected:
    RenderDevice* mRenderDevice;

    VkBuffer mBuffer;
    VkDeviceMemory mBufferMemory;

    VkBuffer mStagingBuffer;
    VkDeviceMemory mStagingBufferMemory;

    uint64_t mBufferSize;

};
