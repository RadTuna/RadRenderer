#pragma once

// Internal Include
#include "Core/IModule.h"

class Renderer final : public IModule 
{
public:
    Renderer();
    ~Renderer();

    // IModule interfaces...
    bool Initialize() override;
    void Loop() override;
    void Deinitialize() override;

private:
    bool CreateInstance();

private:
    struct VkInstance_T* mInstance;

};
