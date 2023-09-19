#include "BaseBuffer.h"

// Internal Include
#include "Core/Logger.h"
#include "Renderer/VkHelper.h"
#include "Renderer/RenderDevice.h"


BaseBuffer::BaseBuffer(RenderDevice* inRenderDevice, uint64_t inBufferSize)
    : mRenderDevice(inRenderDevice)
    , mBuffer(VK_NULL_HANDLE)
    , mBufferMemory(VK_NULL_HANDLE)
    , mStagingBuffer(VK_NULL_HANDLE)
    , mStagingBufferMemory(VK_NULL_HANDLE)
    , mBufferSize(inBufferSize)
{
    assert(mRenderDevice != nullptr);
}

BaseBuffer::~BaseBuffer()
{
    DestroyBuffer();
}

bool BaseBuffer::CreateBufferInternal(VkBuffer* buffer, VkDeviceMemory* bufferMemory, VkDeviceSize size, VkBufferUsageFlags usage, VkMemoryPropertyFlags properties)
{
    VkBufferCreateInfo bufferCreateInfo = {};
    bufferCreateInfo.sType = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
    bufferCreateInfo.size = size;
    bufferCreateInfo.usage = usage;
    bufferCreateInfo.sharingMode = VK_SHARING_MODE_EXCLUSIVE;

    // 버퍼 리소스 생성
    VkResult result = vkCreateBuffer(*mRenderDevice, &bufferCreateInfo, nullptr, buffer);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to create buffer.");
        return false;
    }

    // 버퍼에서 요구하는 메모리 크기 획득
    VkMemoryRequirements memRequirements;
    vkGetBufferMemoryRequirements(*mRenderDevice, *buffer, &memRequirements);

    VkMemoryAllocateInfo allocInfo = {};
    allocInfo.sType = VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
    allocInfo.allocationSize = memRequirements.size;
    const VkMemoryPropertyFlags memFlag = VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT;
    allocInfo.memoryTypeIndex = mRenderDevice->FindPhysicalMemoryType(memRequirements.memoryTypeBits, memFlag);

    // 버퍼 VRAM 할당
    result = vkAllocateMemory(*mRenderDevice, &allocInfo, nullptr, bufferMemory);
    if (result != VK_SUCCESS)
    {
        RAD_LOG(ELogType::Renderer, ELogClass::Error, "Failed to allocate buffer memory.");
        return false;
    }

    // 버퍼 리소스와 VRAM 바인딩
    vkBindBufferMemory(*mRenderDevice, *buffer, *bufferMemory, 0);

    return true;
}

bool BaseBuffer::CreateBuffer()
{
    // 스테이징 소스 버퍼 생성
    bool bResult = CreateBufferInternal(
        &mStagingBuffer,
        &mStagingBufferMemory,
        mBufferSize,
        VK_BUFFER_USAGE_TRANSFER_SRC_BIT,
        VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT);
    if (!bResult)
    {
        return false;
    }

    VkBufferUsageFlagBits usageBit = GetBufferUsage();
    // 스테이징 데스티네이션 버퍼 생성
    bResult = CreateBufferInternal(
        &mBuffer,
        &mBufferMemory,
        mBufferSize,
        VK_BUFFER_USAGE_TRANSFER_DST_BIT | usageBit,
        VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT);
    if (!bResult)
    {
        vkDestroyBuffer(*mRenderDevice, mStagingBuffer, nullptr);
        vkFreeMemory(*mRenderDevice, mStagingBufferMemory, nullptr);
        return false;
    }

    return true;
}

void BaseBuffer::DestroyBuffer()
{
    if (mStagingBuffer != VK_NULL_HANDLE)
    {
        vkDestroyBuffer(*mRenderDevice, mStagingBuffer, nullptr);
        mStagingBuffer = VK_NULL_HANDLE;
    }
    if (mStagingBufferMemory != VK_NULL_HANDLE)
    {
        vkFreeMemory(*mRenderDevice, mStagingBufferMemory, nullptr);
        mStagingBufferMemory = VK_NULL_HANDLE;
    }

    if (mBuffer != VK_NULL_HANDLE)
    {
        vkDestroyBuffer(*mRenderDevice, mBuffer, nullptr);
        mBuffer = VK_NULL_HANDLE;
    }
    if (mBufferMemory != VK_NULL_HANDLE)
    {
        vkFreeMemory(*mRenderDevice, mBufferMemory, nullptr);
        mBufferMemory = VK_NULL_HANDLE;
    }
}

void BaseBuffer::MapStagingBuffer(void* inData, uint64_t size)
{
    size = std::min(size, mBufferSize);

    void* mappedData;
    VK_ASSERT(vkMapMemory(*mRenderDevice, mStagingBufferMemory, 0, VK_WHOLE_SIZE, 0, &mappedData));
    memcpy(mappedData, inData, size);
    vkUnmapMemory(*mRenderDevice, mStagingBufferMemory);
}

void BaseBuffer::TransferBuffer(VkCommandPool commandPool)
{
    VkCommandBufferAllocateInfo allocInfo = {};
    allocInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
    allocInfo.level = VK_COMMAND_BUFFER_LEVEL_PRIMARY;
    allocInfo.commandPool = commandPool;
    allocInfo.commandBufferCount = 1;

    VkCommandBuffer commandBuffer;
    VK_ASSERT(vkAllocateCommandBuffers(*mRenderDevice, &allocInfo, &commandBuffer));

    VkCommandBufferBeginInfo beginInfo = {};
    beginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
    beginInfo.flags = VK_COMMAND_BUFFER_USAGE_ONE_TIME_SUBMIT_BIT;

    VK_ASSERT(vkBeginCommandBuffer(commandBuffer, &beginInfo));

    VkBufferCopy copyRegion = {};
    copyRegion.srcOffset = 0;
    copyRegion.dstOffset = 0;
    copyRegion.size = mBufferSize;

    vkCmdCopyBuffer(commandBuffer, mStagingBuffer, mBuffer, 1, &copyRegion);

    VK_ASSERT(vkEndCommandBuffer(commandBuffer));

    VkSubmitInfo submitInfo = {};
    submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;
    submitInfo.commandBufferCount = 1;
    submitInfo.pCommandBuffers = &commandBuffer;

    VK_ASSERT(vkQueueSubmit(mRenderDevice->GetTransferQueue(), 1, &submitInfo, VK_NULL_HANDLE));
    VK_ASSERT(vkQueueWaitIdle(mRenderDevice->GetTransferQueue()));
    
    vkFreeCommandBuffers(*mRenderDevice, commandPool, 1, &commandBuffer);
}
