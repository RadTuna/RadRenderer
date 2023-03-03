#pragma once

// External Include
#include <glm/glm.hpp>
#include <vulkan/vulkan.h>
#include <array>
#include <vector>


struct Vertex
{
    glm::vec2 Pos;
    glm::vec3 Color;

    // 개발 용 임시 값
    static const std::vector<Vertex> Vertices;
    static const std::vector<uint16_t> Indices;

public:
    static constexpr VkVertexInputBindingDescription GetVkBindingDescription();
    static constexpr std::array<VkVertexInputAttributeDescription, 2> GetVkAttributeDescriptions();

};

constexpr VkVertexInputBindingDescription Vertex::GetVkBindingDescription()
{
    VkVertexInputBindingDescription bindingDesc = {};
    bindingDesc.binding = 0;
    bindingDesc.stride = sizeof(Vertex);
    bindingDesc.inputRate = VK_VERTEX_INPUT_RATE_VERTEX;

    return bindingDesc;
}

constexpr std::array<VkVertexInputAttributeDescription, 2> Vertex::GetVkAttributeDescriptions()
{
    std::array<VkVertexInputAttributeDescription, 2> attributeDescription = {};

    attributeDescription[0].binding = 0;
    attributeDescription[0].location = 0;
    attributeDescription[0].format = VK_FORMAT_R32G32_SFLOAT;
    attributeDescription[0].offset = offsetof(Vertex, Pos);

    attributeDescription[1].binding = 0;
    attributeDescription[1].location = 1;
    attributeDescription[1].format = VK_FORMAT_R32G32B32_SFLOAT;
    attributeDescription[1].offset = offsetof(Vertex, Color);

    return attributeDescription;
}

