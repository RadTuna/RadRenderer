
// Primary Include
#include "Editor.h"

// External Include
#include <imgui.h>

// Internal Include
#include "Core/Logger.h"


Editor::Editor(class Application* inApp)
    : Module(inApp)
{
}

bool Editor::Initialize()
{
    RAD_LOG(ELogType::Editor, ELogClass::Log, "Start editor module initialization.");

    ImGui::StyleColorsDark();

    RAD_LOG(ELogType::Editor, ELogClass::Log, "Complete editor module initialization.");
    return true;
}

void Editor::Loop()
{
    // demo window
    ImGui::ShowDemoWindow();
}

void Editor::Deinitialize()
{
    RAD_LOG(ELogType::Editor, ELogClass::Log, "Start editor module deinitialization.");

    RAD_LOG(ELogType::Editor, ELogClass::Log, "Complete editor module deinitialization.");
}
