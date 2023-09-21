#pragma once

// Primary Include
#include "Core/CoreHeader.h"

// External Include
#include <memory>
#include <vector>
#include <string>
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

class Application final
{
public:
    ~Application();

    // Singleton pattern method
    static void CreateApplication(uint32_t width, uint32_t height, const std::string& title);
    static Application* GetApplicationOrNull() { return ApplicationInstance.get(); };

    bool Run();

    void RequestExit();

    class Editor* GetEditor() const { return mEditor.get(); }
    class Renderer* GetRenderer() const { return mRenderer.get(); }
    class World* GetWorld() const { return mWorld.get(); }

    uint32_t GetWidth() const { return mWidth; }
    uint32_t GetHeight() const { return mHeight; }
    const std::string& GetAppTitle() const { return mAppTitle; }
    GLFWwindow* GetWindowObject() const { return mWindow; }

private:
    Application(uint32_t width, uint32_t height, const std::string& title);

    void Loop();
    void InitializeWindow();
    void DeinitializeWindow();

    static void OnResizeFrameBuffer(GLFWwindow* window, int width, int height);

private:
    // Singleton pattern property
    static std::unique_ptr<Application> ApplicationInstance;

    std::vector<class Module*> mModules;
    std::unique_ptr<class Editor> mEditor;
    std::unique_ptr<class Renderer> mRenderer;
    std::unique_ptr<class World> mWorld;

    GLFWwindow* mWindow;

    const std::string mAppTitle;
    uint32_t mWidth;
    uint32_t mHeight;
    bool mbNeedExit;

};

