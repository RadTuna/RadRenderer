
// Primary Include
#include "Application.h"

// External Include
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
#include <cassert>

// Internal Include
#include "Editor/Editor.h"
#include "Renderer/Renderer.h"
#include "World/World.h"
#include "Logger.h"


std::unique_ptr<Application> Application::ApplicationInstance = nullptr;

Application::Application(uint32_t width, uint32_t height, const std::string& title)
    : mEditor(std::make_unique<Editor>())
    , mRenderer(std::make_unique<Renderer>())
    , mWorld(std::make_unique<World>())
    , mWindow(nullptr)
    , mWidth(width)
    , mHeight(height)
    , mAppTitle(title)
{
    mModules.push_back(mEditor.get());
    mModules.push_back(mRenderer.get());
    mModules.push_back(mWorld.get());

    InitializeWindow();
}

Application::~Application()
{
    DeinitializeWindow();
}

void Application::CreateApplication(uint32_t width, uint32_t height, const std::string& title)
{
    if (ApplicationInstance == nullptr)
    {
        // danger code!
        ApplicationInstance = std::move(std::unique_ptr<Application>(new Application(width, height, title)));
    }
}

bool Application::Run()
{
    Logger::LogStatic(ELogType::Core, ELogClass::Log, "Start application.");

    for (IModule* myModule : mModules)
    {
        if (myModule->Initialize() == false)
        {
            return false;
        }
    }

    while (glfwWindowShouldClose(mWindow) == false)
    {
        Loop();

        glfwPollEvents();
    }

    for (IModule* myModule : mModules)
    {
        myModule->Deinitialize();
    }

    Logger::LogStatic(ELogType::Core, ELogClass::Log, "End application.");

    return true;
}

void Application::Loop()
{
    for (IModule* myModule : mModules)
    {
        myModule->Loop();
    }
}

void Application::InitializeWindow()
{
    Logger::LogStatic(ELogType::Core, ELogClass::Log, "Start window creation.");
    // pre setting for create window
    glfwInit();
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

    // create glfw window
    mWindow = glfwCreateWindow(
        mWidth, 
        mHeight, 
        mAppTitle.c_str(),
        nullptr, 
        nullptr);

    Logger::LogStatic(ELogType::Core, ELogClass::Log, "Complete window creation.");
}

void Application::DeinitializeWindow()
{
    glfwDestroyWindow(mWindow);
    glfwTerminate();
}
