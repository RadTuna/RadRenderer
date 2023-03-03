#pragma once

// Primary Include
#include "Renderer/RendererHeader.h"

// External Include
#include <optional>
#include <memory>
#include <vulkan/vulkan.h>

// Internal Include
#include "Core/Module.h"


class VertexBuffer;
class IndexBuffer;
class UniformBuffer;

struct QueueFamilyIndices
{
    std::optional<uint32_t> GraphicFamily;
    std::optional<uint32_t> PresentFamily;
    std::optional<uint32_t> TransferFamily;

    static bool IsValidQueueFamilyIndices(const QueueFamilyIndices& indices);
    static std::vector<uint32_t> GetUniqueFamilies(const QueueFamilyIndices& indices);

};

struct SwapChainSupportDetails
{
    VkSurfaceCapabilitiesKHR Capabilities;
    std::vector<VkSurfaceFormatKHR> Formats;
    std::vector<VkPresentModeKHR> PresentModes;
};

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
    bool CreateInstance();
    bool CreateDebugMessenger();
    bool CreateSurface();
    bool PickPhysicalDevice();
    bool CreateLogicalDevice();
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

    bool CheckValidationLayerSupport() const;
    void GetRequiredExtensions(std::vector<const char*>* outExtensions) const;
    void PopulateDebugMessengerCreateInfo(VkDebugUtilsMessengerCreateInfoEXT& createInfo) const;
    bool IsDeviceSuitable(VkPhysicalDevice physicalDevice) const;
    bool CheckDeviceExtensionSupport(VkPhysicalDevice physicalDevice) const;
    QueueFamilyIndices FindQueueFamilies(VkPhysicalDevice physicalDevice) const;
    SwapChainSupportDetails QuerySwapCahinSupport(VkPhysicalDevice physicalDevice) const;
    bool CreateShaderModule(VkShaderModule* outShaderModule, const std::vector<uint8_t>& shaderBinary);

    VkSurfaceFormatKHR ChooseSwapSurfaceFormat(const std::vector<VkSurfaceFormatKHR>& avaliableFormats) const;
    VkPresentModeKHR ChooseSwapPresentMode(const std::vector<VkPresentModeKHR>& avaliablePresentModes) const;
    VkExtent2D ChooseSwapExtent(const VkSurfaceCapabilitiesKHR& capabilites) const;

    // temp transform function
    void UpdateUniformBuffer(uint32_t currentImage);

    static VKAPI_ATTR VkBool32 VKAPI_CALL OnVkDebugLog(
        VkDebugUtilsMessageSeverityFlagBitsEXT messageServerity,
        VkDebugUtilsMessageTypeFlagsEXT messageType,
        const VkDebugUtilsMessengerCallbackDataEXT* pCallBackData,
        void* pUserData);

private:
    static const uint32_t MAX_FRAME_IN_FLIGHT;

    VkInstance mInstance;
    VkDebugUtilsMessengerEXT mDebugMessenger;
    VkPhysicalDevice mPhysicalDevice;
    VkDevice mDevice;
    VkQueue mGraphicsQueue;
    VkQueue mPresentQueue;
    VkQueue mTransferQueue;
    VkSurfaceKHR mSurface;
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

    std::vector<VkExtensionProperties> mVkExtensions;
    std::vector<const char*> mDeviceExtensions;

    std::vector<VkLayerProperties> mVkLayers;
    std::vector<const char*> mValidationLayers;

    std::vector<VkImage> mSwapChainImages;
    std::vector<VkImageView> mSwapChainImageViews;
    VkExtent2D mSwapChainExtent;
    VkFormat mSwapChainImageFormat;

    std::vector<VkFramebuffer> mSwapChainFrameBuffers;
    std::vector<VkCommandBuffer> mCommandBuffers;

    std::vector<VkDescriptorSet> mDescriptorSets;

    bool mbEnableValidationLayer;
    bool mbFrameBufferResized;
    bool mbCanRender;

};
