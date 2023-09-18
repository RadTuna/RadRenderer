#pragma once

// Primary Include
#include "Renderer/RendererHeader.h"

// External Include
#include <optional>
#include <memory>
#include <vulkan/vulkan.h>

// Internal Include
#include "Core/Module.h"
#include "RenderDevice.h"


class VertexBuffer;
class IndexBuffer;
class UniformBuffer;

class Renderer final : public Module 
{
public:
    Renderer(class Application* inApp);
    ~Renderer() override;

    // IModule interfaces...
    bool Initialize() override;
    void Loop() override;
    void Deinitialize() override;

    bool RecreateDependSwapChainObjects();
    void DestroyDependSwapChainObjects();

    void FrameBufferResized() { mbFrameBufferResized = true; }
    void SetRender(bool bCanRender) { mbCanRender = bCanRender; }
    bool CanRender() const { return mbCanRender; }

private:
    bool CreateSwapChain();
    bool CreateRenderPass();
    bool CreateDescriptorSetLayout();
    bool CreateGraphicsPipeline();
    bool CreateFrameBuffers();
    bool CreateCommandPools();
    bool CreateVertexBuffer();
    bool CreateIndexBuffer();
    bool CreateUniformBuffer();
    bool CreateDescriptorPool();
    bool CreateDescriptorSets();
    bool CreateCommandBuffers();
    bool CreateSyncObjects();

    bool CreateShaderModule(VkShaderModule* outShaderModule, const std::vector<uint8_t>& shaderBinary);
    VkSurfaceFormatKHR ChooseSwapSurfaceFormat(const std::vector<VkSurfaceFormatKHR>& avaliableFormats) const;
    VkPresentModeKHR ChooseSwapPresentMode(const std::vector<VkPresentModeKHR>& avaliablePresentModes) const;
    VkExtent2D ChooseSwapExtent(const VkSurfaceCapabilitiesKHR& capabilites) const;

    // temp transform function
    void UpdateUniformBuffer(uint32_t currentImage);

private:
    static const uint32_t MAX_FRAME_IN_FLIGHT;

    std::vector<RenderObject*> mAllRenderObjects;
    std::unique_ptr<RenderDevice> mRenderDevice;

    VkQueue mGraphicsQueue;
    VkQueue mPresentQueue;
    VkQueue mTransferQueue;
    VkSwapchainKHR mSwapChain;
    VkRenderPass mRenderPass;
    VkDescriptorSetLayout mDescriptorSetLayout;
    VkPipelineLayout mPipelineLayout;
    VkPipeline mGraphicPipeline;
    VkCommandPool mGraphicsCommandPool;
    VkCommandPool mTransferCommandPool;
    VkDescriptorPool mDescriptorPool;

    std::unique_ptr<VertexBuffer> mVertexBuffer;
    std::unique_ptr<IndexBuffer> mIndexBuffer;
    std::vector<std::unique_ptr<UniformBuffer>> mUniformBuffers;

    std::vector<VkSemaphore> mImageAvailableSemaphores;
    std::vector<VkSemaphore> mRenderFinishedSemaphores;
    std::vector<VkFence> mInFlightFence;
    std::vector<VkFence> mImageInFlightFence;
    uint32_t mCurrentFrame;

    std::vector<VkImage> mSwapChainImages;
    std::vector<VkImageView> mSwapChainImageViews;
    VkExtent2D mSwapChainExtent;
    VkFormat mSwapChainImageFormat;

    std::vector<VkFramebuffer> mSwapChainFrameBuffers;
    std::vector<VkCommandBuffer> mCommandBuffers;

    std::vector<VkDescriptorSet> mDescriptorSets;

    bool mbFrameBufferResized;
    bool mbCanRender;

};
