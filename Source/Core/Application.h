#pragma once

// External Include
#include <memory>
#include <vector>
#include <string>

class Application final
{
public:
    ~Application();

    // Singleton pattern method
    static void CreateApplication(uint32_t width, uint32_t height, const std::string& title);
    static Application* GetApplicationOrNull() { return ApplicationInstance.get(); };

    bool Run();

    class Editor* GetEditor() const { return mEditor.get(); }
    class Renderer* GetRenderer() const { return mRenderer.get(); }
    class World* GetWorld() const { return mWorld.get(); }

    uint32_t GetWidth() const { return mWidth; }
    uint32_t GetHeight() const { return mHeight; }
    const std::string& GetAppTitle() const { return mAppTitle; }

private:
    Application(uint32_t width, uint32_t height, const std::string& title);

    void Loop();
    void InitializeWindow();
    void DeinitializeWindow();

private:
    // Singleton pattern property
    static std::unique_ptr<Application> ApplicationInstance;

    std::vector<class IModule*> mModules;

    std::unique_ptr<class Editor> mEditor;
    std::unique_ptr<class Renderer> mRenderer;
    std::unique_ptr<class World> mWorld;

    struct GLFWwindow* mWindow;

    const std::string mAppTitle;
    uint32_t mWidth;
    uint32_t mHeight;

};

