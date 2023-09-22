#pragma once

// Primary Include
#include "Renderer/RendererHeader.h"


class RenderDevice;

class RenderObject
{
public:
    RenderObject(RenderDevice* renderDevice)
        : RenderObject(renderDevice, false)
    { }
    RenderObject(RenderDevice* renderDevice, bool bAllowNull)
        : mRenderDevice(renderDevice)
    {
        if (bAllowNull == false)
        {
            ASSERT(mRenderDevice != nullptr);
        }
    }

    virtual ~RenderObject() = default;

protected:
    RenderDevice* mRenderDevice;

};
