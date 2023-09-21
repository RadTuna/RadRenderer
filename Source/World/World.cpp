
// Primary Include 
#include "World.h"

// Internal Include
#include "Core/Logger.h"


World::World(class Application* inApp)
    : Module(inApp)
{
}

bool World::Initialize()
{
    RAD_LOG(World, Log, "Start world module initialization.");

    RAD_LOG(World, Log, "Complete world module initialization.");
    return true;
}

void World::Loop()
{
}

void World::Deinitialize()
{
    RAD_LOG(World, Log, "Start world module deinitialization.");

    RAD_LOG(World, Log, "Complete world module deinitialization.");
}
