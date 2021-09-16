#pragma once

// External Include
#include <vector>
#include <string>
#include <optional>
#include <vulkan/vulkan.h>

// Internal Include
#include "Core/IModule.h"


struct QueueFamilyIndices
{
    std::optional<uint32_t> GraphicFamily;
    std::optional<uint32_t> PresentFamily;
};

struct SwapChainSupportDetails
{
    VkSurfaceCapabilitiesKHR Capabilities;
    std::vector<VkSurfaceFormatKHR> Formats;
    std::vector<VkPresentModeKHR> PresentModes;
};

class Renderer final : public IModule 
{
public:
    Renderer();
    ~Renderer();

    // IModule interfaces...
    bool Initialize() override;
    void Loop() override;
    void Deinitialize() override;

private:
    bool CreateInstance();
    bool CreateDebugMessenger();
    bool CreateSurface();
    bool PickPhysicalDevice();
    bool CreateLogicalDevice();
    bool CreateSwapChain();
    bool CreateGraphicsPipeline();

    bool CheckValidationLayerSupport() const;
    void GetRequiredExtensions(std::vector<const char*>& outExtensions) const;
    void PopulateDebugMessengerCreateInfo(VkDebugUtilsMessengerCreateInfoEXT& createInfo) const;
    bool IsDeviceSuitable(VkPhysicalDevice physicalDevice) const;
    bool CheckDeviceExtensionSupport(VkPhysicalDevice physicalDevice) const;
    QueueFamilyIndices FindQueueFamily(VkPhysicalDevice physicalDevice) const;
    SwapChainSupportDetails QuerySwapCahinSupport(VkPhysicalDevice physicalDevice) const;

    VkSurfaceFormatKHR ChooseSwapSurfaceFormat(const std::vector<VkSurfaceFormatKHR>& avaliableFormats) const;
    VkPresentModeKHR ChooseSwapPresentMode(const std::vector<VkPresentModeKHR>& avaliablePresentModes) const;
    VkExtent2D ChooseSwapExtent(const VkSurfaceCapabilitiesKHR& capabilites) const;

    static VKAPI_ATTR VkBool32 VKAPI_CALL OnVkDebugLog(
        VkDebugUtilsMessageSeverityFlagBitsEXT messageServerity,
        VkDebugUtilsMessageTypeFlagsEXT messageType,
        const VkDebugUtilsMessengerCallbackDataEXT* pCallBackData,
        void* pUserData);

private:
    VkInstance mInstance;
    VkDebugUtilsMessengerEXT mDebugMessenger;
    VkPhysicalDevice mPhysicalDevice;
    VkDevice mDevice;
    VkQueue mGraphicsQueue;
    VkQueue mPresentQueue;
    VkSurfaceKHR mSurface;
    VkSwapchainKHR mSwapChain;

    std::vector<VkExtensionProperties> mVkExtensions;
    std::vector<const char*> mDeviceExtensions;

    std::vector<VkLayerProperties> mVkLayers;
    std::vector<const char*> mValidationLayers;

    std::vector<VkImage> mSwapChainImages;
    std::vector<VkImageView> mSwapChainImageViews;

    bool mbEnableValidationLayer;

};
