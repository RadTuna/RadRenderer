#pragma once

// Primary Include
#include "Renderer/RendererHeader.h"

// External Include
#include <optional>
#include <memory>
#include <vulkan/vulkan.h>

// Internal Include
#include "Core/Module.h"
#include "Renderer/RenderObject.h"
#include "Renderer/RenderDevice.h"
#include "Renderer/SwapChain.h"


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

    void StartFrame() override;
    void EndFrame() override;

    template<typename Type, typename... Args>
    Type* MakeRenderObject(Args&&... args)
    {
        std::unique_ptr<Type> renderObject = std::make_unique<Type>(std::forward<Args>(args)...);
        Type* rawRenderObject = renderObject.get();
        mAllRenderObjects.push_back(std::move(renderObject));
        return rawRenderObject;
    }

    bool RecreateDependSwapChainObjects();
    void DestroyDependSwapChainObjects();

    void FrameBufferResized() { mbFrameBufferResized = true; }
    void SetRender(bool bCanRender) { mbCanRender = bCanRender; }
    bool CanRender() const { return mbCanRender; }

private:
    // for Initialize
    bool CreateRenderPass();
    bool CreateDescriptorSetLayout();
    bool CreateGraphicsPipeline();
    bool CreateCommandPools();
    bool CreateVertexBuffer();
    bool CreateIndexBuffer();
    bool CreateUniformBuffer();
    bool CreateDescriptorPool();
    bool CreateDescriptorSets();
    bool CreateCommandBuffers();
    bool CreateSyncObjects();
    bool CreateImGuiBackend();

    // for Loop
    void RecordRenderCommands(uint32_t imageIndex);

    bool CreateShaderModule(VkShaderModule* outShaderModule, const std::vector<uint8_t>& shaderBinary);
    VkCommandBuffer GetCurrrentCommandBuffer() const { return mCommandBuffers[mCurrentFrame]; }

    // temp transform function
    void UpdateUniformBuffer(uint32_t currentImage);

public:
    static constexpr uint32_t MAX_FRAME_IN_FLIGHT = 3;

private:
    std::vector<std::unique_ptr<RenderObject>> mAllRenderObjects;
    RenderDevice* mRenderDevice;
    RenderSwapChain* mSwapChain;

    VkQueue mGraphicsQueue;
    VkQueue mPresentQueue;
    VkQueue mTransferQueue;
    VkDescriptorSetLayout mDescriptorSetLayout;
    VkPipelineLayout mPipelineLayout;
    VkPipeline mGraphicPipeline;
    VkCommandPool mGraphicsCommandPool;
    VkCommandPool mTransferCommandPool;
    VkDescriptorPool mDescriptorPool;

    VkRenderPass mRenderPass;
    VkRenderPass mViewportRenderPass;

    std::unique_ptr<VertexBuffer> mVertexBuffer;
    std::unique_ptr<IndexBuffer> mIndexBuffer;
    std::vector<std::unique_ptr<UniformBuffer>> mUniformBuffers;

    std::vector<VkSemaphore> mImageAvailableSemaphores;
    std::vector<VkSemaphore> mRenderFinishedSemaphores;
    std::vector<VkFence> mInFlightFence;
    uint32_t mCurrentFrame;

    std::vector<VkCommandBuffer> mCommandBuffers;
    std::vector<VkDescriptorSet> mDescriptorSets;
    bool mbFrameBufferResized;
    bool mbCanRender;

};
