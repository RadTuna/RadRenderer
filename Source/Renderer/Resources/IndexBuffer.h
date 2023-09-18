#pragma once

// External Include
#include <vulkan/vulkan.h>

// Internal Include
#include "BaseBuffer.h"


class IndexBuffer final : public BaseBuffer
{
public:
    IndexBuffer(RenderDevice* inRenderDevice, uint64_t inBufferSize)
        : BaseBuffer(inRenderDevice, inBufferSize)
    {}
    virtual ~IndexBuffer() = default;

    virtual VkBufferUsageFlagBits GetBufferUsage() const override;

};