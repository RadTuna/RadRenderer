#pragma once

// External Include
#include <glm/glm.hpp>

// Internal Include
#include "BaseBuffer.h"


struct alignas(16) UniformBufferObject
{
    glm::mat4 ModelMatrix;
    glm::mat4 ViewMatrix;
    glm::mat4 ProjMatrix;
};


class UniformBuffer final : public BaseBuffer
{
public:
    UniformBuffer(RenderDevice* inRenderDevice, uint64_t inBufferSize)
        : BaseBuffer(inRenderDevice, inBufferSize)
    {}
    virtual ~UniformBuffer() = default;

    virtual VkBufferUsageFlagBits GetBufferUsage() const override;

};
