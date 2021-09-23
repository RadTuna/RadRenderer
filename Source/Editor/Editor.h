#pragma once

// Internal Include
#include "Core/Module.h"


class Editor final : public Module
{
public:
    Editor(class Application* inApp);
    ~Editor() override = default;

    // IModule interfaces...
    bool Initialize() override;
    void Loop() override;
    void Deinitialize() override;

};
