
// Primary Include
#include "Editor.h"

// External Include
#include <imgui.h>

// Internal Include
#include "Core/Logger.h"
#include "Core/Application.h"


Editor::Editor(class Application* inApp)
    : Module(inApp)
    , mbMainWindowOpen(true)
{
    mLogColor = static_cast<uint32_t>(IM_COL32(255, 255, 255, 255));
    mWarningColor = static_cast<uint32_t>(IM_COL32(255, 165, 56, 255));
    mErrorColor = static_cast<uint32_t>(IM_COL32(255, 56, 56, 255));
}

bool Editor::Initialize()
{
    RAD_LOG(Editor, Log, "Start editor module initialization.");

    ImGui::StyleColorsDark();

    RAD_LOG(Editor, Log, "Complete editor module initialization.");
    return true;
}

void Editor::Loop()
{
    if (mbMainWindowOpen == false)
    {
        mApp->RequestExit();
        return;
    }

    // main dockspace
    {
        ImGuiViewport* viewport = ImGui::GetMainViewport();
        ImGui::SetNextWindowPos(viewport->Pos);
        ImGui::SetNextWindowSize(viewport->Size);

        ImGui::PushStyleVar(ImGuiStyleVar_WindowRounding, 0.0f);
        ImGui::PushStyleVar(ImGuiStyleVar_WindowBorderSize, 0.0f);

        static bool bMainWindowOpen = true;
        ImGuiWindowFlags windowFlags = ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_MenuBar | ImGuiWindowFlags_NoDocking;
        windowFlags |= ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove;
        windowFlags |= ImGuiWindowFlags_NoBringToFrontOnFocus | ImGuiWindowFlags_NoNavFocus;

        ImGui::Begin(mApp->GetAppTitle().c_str(), &mbMainWindowOpen, windowFlags);
        ImGui::PopStyleVar(2);

        ImGuiID dockspaceID = ImGui::GetID("Main Dockspace");
        ImGui::DockSpace(dockspaceID, ImVec2(0.0f, 0.0f), ImGuiDockNodeFlags_None);

        if (ImGui::BeginMenuBar())
        {
            if (ImGui::BeginMenu("View"))
            {
                ImGui::MenuItem("Log");
                ImGui::EndMenu();
            }

            ImGui::EndMenuBar();
        }

        ImGui::End();
    }

    // log window
    if (Logger* logger = Logger::GetLoggerOrNull())
    {
        static bool bLogOpen = true;
        ImGui::SetNextWindowSize(ImVec2(500, 400), ImGuiCond_FirstUseEver);
        ImGui::Begin("Log", &bLogOpen);

        logger->ForEachRawLogs([this](const LogBlock& log)
            {
                ImU32 color = 0;
                switch (log.LogClass)
                {
                case ELogClass::Log:
                    color = static_cast<ImU32>(mLogColor);
                    break;
                case ELogClass::Warning:
                    color = static_cast<ImU32>(mWarningColor);
                    break;
                case ELogClass::Error:
                    color = static_cast<ImU32>(mErrorColor);
                    break;
                default:
                    assert(false);
                    break;
                }

                ImGui::PushStyleColor(ImGuiCol_Text, color);
                ImGui::TextWrapped(Logger::Stringify(log).c_str());
                ImGui::PopStyleColor();
            });

        ImGui::End();
    }
}

void Editor::Deinitialize()
{
    RAD_LOG(Editor, Log, "Start editor module deinitialization.");

    RAD_LOG(Editor, Log, "Complete editor module deinitialization.");
}
