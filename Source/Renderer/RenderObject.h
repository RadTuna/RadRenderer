#pragma once

// Primary Include
#include "Renderer/RendererHeader.h"


class RenderDevice;

class RenderObject
{
public:
    RenderObject() = default;
    virtual ~RenderObject() = default;

    // RenderObject interfaces...
    virtual bool Create(RenderDevice* renderDevice) = 0;
    virtual void Destroy() = 0;

};
