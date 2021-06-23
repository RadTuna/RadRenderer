
// Primary Include
#include "Application.h"

// External Include
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

// Internal Include
#include "Editor/Editor.h"
#include "Renderer/Renderer.h"


uint32_t Application::ScreenWidth = 800;
uint32_t Application::ScreenHeight = 600;
std::string Application::AppTitle = "RadRenderer";

Application::Application()
    : mEditor(std::make_unique<Editor>())
    , mRenderer(std::make_unique<Renderer>())
    , mWindow(nullptr)
{
    mModules.push_back(mEditor.get());
    mModules.push_back(mRenderer.get());

    InitializeWindow();
}

Application::~Application()
{
    DeinitializeWindow();
}

void Application::Run()
{
    for (IModule* myModule : mModules)
    {
        myModule->Initialize();
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
    // pre setting for create window
    glfwInit();
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

    // create glfw window
    mWindow = glfwCreateWindow(
        Application::ScreenWidth, 
        Application::ScreenHeight, 
        Application::AppTitle.c_str(),
        nullptr, 
        nullptr);
}

void Application::DeinitializeWindow()
{
    glfwDestroyWindow(mWindow);
    glfwTerminate();
}
