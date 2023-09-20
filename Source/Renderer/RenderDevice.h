#pragma once

// Primary Include
#include "Renderer/RendererHeader.h"

// External Include
#include <optional>
#include <memory>
#include <vulkan/vulkan.h>

// Internal Include
#include "Renderer/RenderObject.h"
#include "Renderer/VkHelper.h"


struct QueueFamilyIndices
{
    std::optional<uint32_t> GraphicsFamily;
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

class RenderDevice final : public RenderObject
{
public:
    RenderDevice();
    virtual ~RenderDevice();

    virtual bool Create(RenderDevice* renderDevice) override;
    virtual void Destroy() override;

    QueueFamilyIndices FindQueueFamilies() const;
    QueueFamilyIndices FindQueueFamilies(VkPhysicalDevice physicalDevice) const;
    SwapChainSupportDetails QuerySwapChainSupport() const;
    SwapChainSupportDetails QuerySwapChainSupport(VkPhysicalDevice physicalDevice) const;
    uint32_t FindPhysicalMemoryType(uint32_t typeFilter, VkMemoryPropertyFlags properties);

    VkQueue GetGraphicsQueue() const { return mGraphicsQueue; }
    VkQueue GetPresentQueue() const { return mPresentQueue; }
    VkQueue GetTransferQueue() const { return mTransferQueue; }

    VkDevice GetDevice() const { return mDevice; }
    operator VkDevice() const { return mDevice; }

    VkInstance GetInstance() const { return mInstance; }
    VkPhysicalDevice GetPhysicalDevice() const { return mPhysicalDevice; }
    VkSurfaceKHR GetSurface() const { return mSurface; }

private:
    bool CreateInstance();
    bool CreateDebugMessenger();
    bool CreateSurface();
    bool PickPhysicalDevice();
    bool CreateLogicalDevice();

    void GetRequiredExtensions(std::vector<const char*>* outExtensions);
    bool CheckValidationLayerSupport() const;
    void PopulateDebugMessengerCreateInfo(VkDebugUtilsMessengerCreateInfoEXT& createInfo) const;
    bool IsDeviceSuitable(VkPhysicalDevice physicalDevice) const;
    bool CheckDeviceExtensionSupport(VkPhysicalDevice physicalDevice) const;

    static VKAPI_ATTR VkBool32 VKAPI_CALL OnVkDebugLog(
        VkDebugUtilsMessageSeverityFlagBitsEXT messageServerity,
        VkDebugUtilsMessageTypeFlagsEXT messageType,
        const VkDebugUtilsMessengerCallbackDataEXT* pCallBackData,
        void* pUserData);

private:
    VkInstance mInstance;
    VkPhysicalDevice mPhysicalDevice;
    VkDevice mDevice;
    VkSurfaceKHR mSurface;
    VkDebugUtilsMessengerEXT mDebugMessenger;

    VkQueue mGraphicsQueue;
    VkQueue mPresentQueue;
    VkQueue mTransferQueue;

    std::vector<VkExtensionProperties> mVkInstanceExtensions;
    std::vector<const char*> mDeviceExtensions;
    std::vector<VkLayerProperties> mVkLayers;
    std::vector<const char*> mValidationLayers;

    bool mbEnableValidationLayer;

};
