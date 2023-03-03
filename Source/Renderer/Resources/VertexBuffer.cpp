#include "VertexBuffer.h"

VkBufferUsageFlagBits VertexBuffer::GetBufferUsage() const
{
    return VK_BUFFER_USAGE_VERTEX_BUFFER_BIT;
}
