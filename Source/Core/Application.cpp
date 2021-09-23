
// Primary Include
#include "Application.h"

// External Include
#include <cassert>

// Internal Include
#include "Core/Module.h"
#include "Editor/Editor.h"
#include "Renderer/Renderer.h"
#include "World/World.h"
#include "Logger.h"


std::unique_ptr<Application> Application::ApplicationInstance = nullptr;

Application::Application(uint32_t width, uint32_t height, const std::string& title)
    : mEditor(std::make_unique<Editor>(this))
    , mRenderer(std::make_unique<Renderer>(this))
    , mWorld(std::make_unique<World>(this))
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
    RAD_LOG(ELogType::Core, ELogClass::Log, "Start application.");

    bool bSuccessInit = true;
    for (Module* myModule : mModules)
    {
        if (myModule->Initialize() == false)
        {
            bSuccessInit = false;
            break;
        }
    }

    if (bSuccessInit)
    {
        while (glfwWindowShouldClose(mWindow) == false)
        {
            Loop();

            glfwPollEvents();
        }
    }

    for (Module* myModule : mModules)
    {
        myModule->Deinitialize();
    }

    RAD_LOG(ELogType::Core, ELogClass::Log, "End application.");

    return bSuccessInit;
}

void Application::Loop()
{
    for (Module* myModule : mModules)
    {
        myModule->Loop();
    }
}

void Application::InitializeWindow()
{
    RAD_LOG(ELogType::Core, ELogClass::Log, "Start window creation.");
    // pre setting for create window
    glfwInit();
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    //glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

    // create glfw window
    mWindow = glfwCreateWindow(
        mWidth, 
        mHeight, 
        mAppTitle.c_str(),
        nullptr, 
        nullptr);

    // bind frame buffer resize callback
    glfwSetWindowUserPointer(mWindow, this);
    glfwSetFramebufferSizeCallback(mWindow, &OnResizeFrameBuffer);

    RAD_LOG(ELogType::Core, ELogClass::Log, "Complete window creation.");
}

void Application::DeinitializeWindow()
{
    glfwDestroyWindow(mWindow);
    glfwTerminate();
}

void Application::OnResizeFrameBuffer(GLFWwindow* window, int width, int height)
{
    Application* self = reinterpret_cast<Application*>(glfwGetWindowUserPointer(window));
    assert(self != nullptr);

    self->mRenderer->FrameBufferResized();
    const bool bStopRender = width == 0 || height == 0;
    self->mRenderer->SetRender(!bStopRender);
}
