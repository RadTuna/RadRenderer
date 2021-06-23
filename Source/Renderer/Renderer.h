#pragma once

// Internal Include
#include "Core/IModule.h"

class Renderer final : public IModule 
{
public:
    Renderer();
    ~Renderer();

    // IModule interfaces...
    void Initialize() override;
    void Loop() override;
    void Deinitialize() override;

};
