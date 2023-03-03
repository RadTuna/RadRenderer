#include "UniformBuffer.h"

VkBufferUsageFlagBits UniformBuffer::GetBufferUsage() const
{
    return VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT;
}
