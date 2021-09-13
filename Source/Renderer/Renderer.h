#pragma once

// External Include
#include <vector>
#include <string>
#include <vulkan/vulkan.h>

// Internal Include
#include "Core/IModule.h"

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

    bool CheckValidationLayerSupport();
    void GetRequiredExtensions(std::vector<const char*>& outExtensions);
    void PopulateDebugMessengerCreateInfo(VkDebugUtilsMessengerCreateInfoEXT& createInfo);

    static VKAPI_ATTR VkBool32 VKAPI_CALL OnVkDebugLog(
        VkDebugUtilsMessageSeverityFlagBitsEXT messageServerity,
        VkDebugUtilsMessageTypeFlagsEXT messageType,
        const VkDebugUtilsMessengerCallbackDataEXT* pCallBackData,
        void* pUserData);

private:
    VkInstance_T* mInstance;
    VkDebugUtilsMessengerEXT mDebugMessenger;

    std::vector<VkExtensionProperties> mVkExtensions;
    std::vector<VkLayerProperties> mVkLayers;
    std::vector<const char*> mValidationLayers;

    bool mbEnableValidationLayer;

};
