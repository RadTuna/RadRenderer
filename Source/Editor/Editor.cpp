
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
    RAD_LOG(ELogType::Editor, ELogClass::Log, "Start editor module initialization.");

    RAD_LOG(ELogType::Editor, ELogClass::Log, "Complete editor module initialization.");
    return true;
}

void Editor::Loop()
{
}

void Editor::Deinitialize()
{
    RAD_LOG(ELogType::Editor, ELogClass::Log, "Start editor module deinitialization.");

    RAD_LOG(ELogType::Editor, ELogClass::Log, "Complete editor module deinitialization.");
}
