
// Primary Include 
#include "World.h"

// Internal Include
#include "Core/Logger.h"


World::World()
{
}

World::~World()
{
}

bool World::Initialize()
{
    RAD_LOG(ELogType::World, ELogClass::Log, "Start world module initialization.");

    RAD_LOG(ELogType::World, ELogClass::Log, "Complete world module initialization.");
    return true;
}

void World::Loop()
{
}

void World::Deinitialize()
{
    RAD_LOG(ELogType::World, ELogClass::Log, "Start world module deinitialization.");

    RAD_LOG(ELogType::World, ELogClass::Log, "Complete world module deinitialization.");
}
