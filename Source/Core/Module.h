#pragma once

// Primary Include
#include "Core/CoreHeader.h"


class Module
{
public:
    Module(class Application* inApp);
    virtual ~Module() = default;

    Module(const Module& other) = delete;
    Module& operator=(const Module& other) = delete;

    virtual bool Initialize() = 0;
    virtual void Loop() = 0;
    virtual void Deinitialize() = 0;

    virtual void StartFrame() { }
    virtual void EndFrame() { }

protected:
    class Application* mApp;

};

