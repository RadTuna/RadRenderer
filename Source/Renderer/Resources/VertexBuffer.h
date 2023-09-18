#pragma once

// External Include
#include <vulkan/vulkan.h>

// Internal Include
#include "BaseBuffer.h"


class VertexBuffer final : public BaseBuffer
{
public:
    VertexBuffer(RenderDevice* inRenderDevice, uint64_t inBufferSize)
        : BaseBuffer(inRenderDevice, inBufferSize)
    {}
    virtual ~VertexBuffer() = default;

    virtual VkBufferUsageFlagBits GetBufferUsage() const override;

};
