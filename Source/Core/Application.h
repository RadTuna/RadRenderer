#pragma once

// External Include
#include <memory>
#include <vector>
#include <string>

class Application final
{
public:
    Application();
    ~Application();

    void Run();

private:
    void Loop();
    void InitializeWindow();
    void DeinitializeWindow();

private:
    std::vector<class IModule*> mModules;

    std::unique_ptr<class Editor> mEditor;
    std::unique_ptr<class Renderer> mRenderer;

    struct GLFWwindow* mWindow;

    // temporal value
    static uint32_t ScreenWidth;
    static uint32_t ScreenHeight;
    static std::string AppTitle;

};

