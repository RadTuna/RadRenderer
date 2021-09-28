#version 450

layout(binding = 0) uniform UniformBufferObject 
{
    mat4 modelMatrix;
    mat4 viewMatrix;
    mat4 projMatrix;
} ubo;

layout(location = 0) in vec2 inPosition;
layout(location = 1) in vec3 inColor;

layout(location = 0) out vec3 fragColor;

void main()
{
    vec4 position = vec4(inPosition, 0.f, 1.f);
    position = ubo.modelMatrix * position;
    position = ubo.viewMatrix * position;
    position = ubo.projMatrix * position;

    gl_Position = position;
    fragColor = inColor;
}
