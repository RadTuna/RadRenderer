#pragma once

class IModule
{
public:
    IModule() { }

    virtual bool Initialize() = 0;
    virtual void Loop() = 0;
    virtual void Deinitialize() = 0;

public:

};

