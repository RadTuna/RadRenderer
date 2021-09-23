#pragma once

// Internal Include
#include "Core/Module.h"


class World final : public Module
{
public:
    World(class Application* inApp);
    ~World() override = default;

    // IModule interfaces...
    bool Initialize() override;
    void Loop() override;
    void Deinitialize() override;

};