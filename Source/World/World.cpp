
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
    Logger::LogStatic(ELogType::World, ELogClass::Log, "Start world module initialization.");

    Logger::LogStatic(ELogType::World, ELogClass::Log, "Complete world module initialization.");
    return true;
}

void World::Loop()
{
}

void World::Deinitialize()
{
    Logger::LogStatic(ELogType::World, ELogClass::Log, "Start world module deinitialization.");

    Logger::LogStatic(ELogType::World, ELogClass::Log, "Complete world module deinitialization.");
}
