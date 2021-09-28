#pragma once

// External Include
#include <glm/glm.hpp>

struct alignas(16) UniformBufferObject
{
    glm::mat4 ModelMatrix;
    glm::mat4 ViewMatrix;
    glm::mat4 ProjMatrix;
};
