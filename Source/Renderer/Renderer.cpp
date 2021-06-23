
// Primary Include
#include "Renderer.h"

// External Include
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
#include <vulkan/vulkan.h>

// Internal Include
#include "Core/Application.h"
#include "Core/Logger.h"


Renderer::Renderer()
{
}

Renderer::~Renderer()
{
}

bool Renderer::Initialize()
{
    Logger::LogStatic(ELogType::Renderer, ELogClass::Log, "Start renderer module initialization.");
    bool bResult = true;

    bResult &= CreateInstance();
    if (!bResult)
    {
        return false;
    }

    Logger::LogStatic(ELogType::Renderer, ELogClass::Log, "Complete renderer module initialization.");
    return true;
}

void Renderer::Loop()
{
}

void Renderer::Deinitialize()
{
    Logger::LogStatic(ELogType::Renderer, ELogClass::Log, "Start renderer module deinitialization.");

    Logger::LogStatic(ELogType::Renderer, ELogClass::Log, "Complete renderer module deinitialization.");
}

bool Renderer::CreateInstance()
{
    // create vkapp info
    VkApplicationInfo vkAppInfo = {};
    vkAppInfo.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
    vkAppInfo.pApplicationName = Application::GetApplicationOrNull()->GetAppTitle().c_str();
    vkAppInfo.applicationVersion = VK_MAKE_VERSION(0, 0, 1);
    vkAppInfo.pEngineName = nullptr;
    vkAppInfo.engineVersion = VK_MAKE_VERSION(0, 0, 0);
    vkAppInfo.apiVersion = VK_API_VERSION_1_0;

    // create vkinstancecreate info
    VkInstanceCreateInfo vkInstanceCreateInfo = {};
    vkInstanceCreateInfo.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
    vkInstanceCreateInfo.pApplicationInfo = &vkAppInfo;

    uint32_t glfwExtensionCount = 0;
    const char** glfwExtensions = nullptr;
    glfwExtensions = glfwGetRequiredInstanceExtensions(&glfwExtensionCount);

    vkInstanceCreateInfo.enabledExtensionCount = glfwExtensionCount;
    vkInstanceCreateInfo.ppEnabledExtensionNames = glfwExtensions;
    vkInstanceCreateInfo.enabledLayerCount = 0;

    VkResult result = vkCreateInstance(&vkInstanceCreateInfo, nullptr, &mInstance);
    if (result != VK_SUCCESS)
    {
        return false;
    }
    
    return true;
}

