#pragma once

// External Include
#include <vulkan/vulkan.h>

// Internal Include
#include "BaseBuffer.h"


class IndexBuffer final : public BaseBuffer
{
public:
    IndexBuffer(VkDevice inDevice, uint64_t inBufferSize)
        : BaseBuffer(inDevice, inBufferSize)
    {}
    virtual ~IndexBuffer() = default;

    virtual VkBufferUsageFlagBits GetBufferUsage() const override;

};