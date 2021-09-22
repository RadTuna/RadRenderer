#pragma once

// Internal Include
#include "Core/IModule.h"


class World final : public IModule
{
public:
    World();
    ~World();

    // IModule interfaces...
    bool Initialize() override;
    void Loop() override;
    void Deinitialize() override;
    bool IsInitialized() const override { return true; }

};