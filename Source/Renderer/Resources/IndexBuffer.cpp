#include "IndexBuffer.h"

VkBufferUsageFlagBits IndexBuffer::GetBufferUsage() const
{
    return VK_BUFFER_USAGE_INDEX_BUFFER_BIT;
}
