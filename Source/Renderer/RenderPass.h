#pragma once

// Primary Include
#include "Renderer/RendererHeader.h"

// External Include
#include <memory>
#include <vulkan/vulkan.h>

// Internal Include
#include "Renderer/RenderObject.h"
#include "Renderer/VkHelper.h"
#include "Renderer/Renderer.h"


class RenderSwapChain;

struct RenderPassBuffer
{
    VkFramebuffer FrameBuffer;
    VkImage Image;
    VkDeviceMemory Memory;
    VkImageView ImageView;
    VkSampler Sampler;
};

class RenderPass final : public RenderObject
{
public:
    RenderPass(RenderDevice* renderDevice, RenderSwapChain* swapChain);
    virtual ~RenderPass();

    VkRenderPass GetRenderPass() const { return mRenderPass; }
    operator VkRenderPass() const { return mRenderPass; }

    VkFramebuffer GetFrameBuffer(size_t frameIndex) const { return mFinalBuffers[frameIndex].FrameBuffer; }
    VkImageView GetBufferImageView(size_t frameIndex) const { return mFinalBuffers[frameIndex].ImageView; }
    VkImage GetBufferImage(size_t frameIndex) const { return mFinalBuffers[frameIndex].Image; }
    VkSampler GetBufferSampler(size_t frameIndex) const { return mFinalBuffers[frameIndex].Sampler; }

private:
    bool CreateRenderPass();
    bool CreateBuffer(size_t index);
    bool CreateSampler(size_t index);

private:
    RenderSwapChain* mSwapChain;

    VkRenderPass mRenderPass;
    VkFormat mFinalFormat;

    std::array<RenderPassBuffer, Renderer::MAX_FRAME_IN_FLIGHT> mFinalBuffers;

};
