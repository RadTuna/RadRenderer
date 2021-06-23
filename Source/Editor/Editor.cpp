
// Primary Include
#include "Editor.h"

// Internal Include
#include "Core/Logger.h"


Editor::Editor()
{
}

Editor::~Editor()
{
}

bool Editor::Initialize()
{
    Logger::LogStatic(ELogType::Editor, ELogClass::Log, "Start editor module initialization.");

    Logger::LogStatic(ELogType::Editor, ELogClass::Log, "Complete editor module initialization.");
    return true;
}

void Editor::Loop()
{
}

void Editor::Deinitialize()
{
    Logger::LogStatic(ELogType::Editor, ELogClass::Log, "Start editor module deinitialization.");

    Logger::LogStatic(ELogType::Editor, ELogClass::Log, "Complete editor module deinitialization.");
}
