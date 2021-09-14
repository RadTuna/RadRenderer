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
    bool PickPhysicalDevice();
    bool CreateLogicalDevice();

    bool CheckValidationLayerSupport();
    void GetRequiredExtensions(std::vector<const char*>& outExtensions);
    void PopulateDebugMessengerCreateInfo(VkDebugUtilsMessengerCreateInfoEXT& createInfo);
    bool IsDeviceSuitable(VkPhysicalDevice physicalDevice);
    QueueFamilyIndices FindQueueFamily(VkPhysicalDevice physicalDevice);

    static VKAPI_ATTR VkBool32 VKAPI_CALL OnVkDebugLog(
        VkDebugUtilsMessageSeverityFlagBitsEXT messageServerity,
        VkDebugUtilsMessageTypeFlagsEXT messageType,
        const VkDebugUtilsMessengerCallbackDataEXT* pCallBackData,
        void* pUserData);

private:
    VkInstance_T* mInstance;
    VkDebugUtilsMessengerEXT mDebugMessenger;
    VkPhysicalDevice mPhysicalDevice;
    VkDevice mDevice;
    VkQueue mGraphicsQueue;

    std::vector<VkExtensionProperties> mVkExtensions;
    std::vector<VkLayerProperties> mVkLayers;
    std::vector<const char*> mValidationLayers;

    bool mbEnableValidationLayer;

};
