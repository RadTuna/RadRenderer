#pragma once

// Primary Include
#include "Renderer/RendererHeader.h"

// External Include
#include <memory>
#include <vulkan/vulkan.h>

// Internal Include
#include "Renderer/RenderObject.h"
#include "Renderer/VkHelper.h"


class RenderSwapChain final : public RenderObject
{
public:
    RenderSwapChain();
    virtual ~RenderSwapChain();

    virtual bool Create(RenderDevice* device) override;
    virtual void Destroy() override;

    bool CreateFrameBuffers(VkRenderPass renderPass);

    VkFramebuffer GetFrameBuffer(size_t index) const { return mFrameBuffers[index]; }
    size_t GetImageCount() const { return mSwapChainImages.size(); }

    const VkExtent2D& GetExtent() const { return mExtent; }
    VkSurfaceFormatKHR GetSurfaceFormat() const { return mSurfaceFormat; }
    VkFormat GetImageFormat() const { return mImageFormat; }
    VkPresentModeKHR GetPresentMode() const { return mPresentMode; }

    VkSwapchainKHR GetSwapChain() const { return mSwapChain; }
    operator VkSwapchainKHR() const { return mSwapChain; }

private:
    VkSurfaceFormatKHR ChooseSwapSurfaceFormat(const std::vector<VkSurfaceFormatKHR>& avaliableFormats) const;
    VkPresentModeKHR ChooseSwapPresentMode(const std::vector<VkPresentModeKHR>& avaliablePresentModes) const;
    VkExtent2D ChooseSwapExtent(const VkSurfaceCapabilitiesKHR& capabilites) const;

private:
    RenderDevice* mRenderDevice;
    VkSwapchainKHR mSwapChain;

    std::vector<VkImage> mSwapChainImages;
    std::vector<VkImageView> mSwapChainImageViews;
    std::vector<VkFramebuffer> mFrameBuffers;

    VkExtent2D mExtent;
    VkSurfaceFormatKHR mSurfaceFormat;
    VkFormat mImageFormat;
    VkPresentModeKHR mPresentMode;

};
