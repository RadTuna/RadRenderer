#pragma once

// Internal Include
#include "Core/IModule.h"


class Editor final : public IModule
{
public:
    Editor();
    ~Editor();

    // IModule interfaces...
    void Initialize() override;
    void Loop() override;
    void Deinitialize() override;

};
