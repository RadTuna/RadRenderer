
// Primary Include
#include "Logger.h"

#if DEBUG_BUILD

// External Include
#include <fstream>
#include <filesystem>


std::unique_ptr<Logger> Logger::LoggerInstance = nullptr;

Logger::Logger(uint32_t maxLog)
    : mMaxLogCount(maxLog)
{
}

std::string Logger::Stringify(const LogBlock& logBlock)
{
    const std::string typeString = LogTypeStringTable[static_cast<uint32_t>(logBlock.LogType)];
    const std::string classString = LogClassStringTable[static_cast<uint32_t>(logBlock.LogClass)];
    return "[" + classString + "] " + typeString + ": " + logBlock.LogBody;
}

Logger::~Logger()
{
}

void Logger::CreateLogger(uint32_t maxLog)
{
    if (LoggerInstance == nullptr)
    {
        LoggerInstance = std::move(std::unique_ptr<Logger>(new Logger(maxLog)));
    }
}

void Logger::LogStatic(ELogType logType, ELogClass logClass, const std::string& logBody)
{
    if (LoggerInstance != nullptr)
    {
        LoggerInstance->Log(logType, logClass, logBody);
    }
}

void Logger::ForEachRawLogs(std::function<void(const LogBlock&)> func)
{
    for (const LogBlock& log : mLogs)
    {
        func(log);
    }
}

void Logger::ForEachLogs(std::function<void(const std::string)> func)
{
    for (const LogBlock& log : mLogs)
    {
        func(Stringify(log));
    }
}

void Logger::FlushLogs()
{
    while (mLogs.empty() == false)
    {
        mLogs.pop_back();
    }
}

void Logger::Log(ELogType logType, ELogClass logClass, const std::string& logBody)
{
    const int32_t overCount = mLogs.size() - mMaxLogCount;
    for (int32_t i = 0; i < overCount; ++i)
    {
        mLogs.pop_front();
    }

    LogBlock logBlock;
    logBlock.LogType = logType;
    logBlock.LogClass = logClass;
    logBlock.LogBody = logBody;

    mLogs.push_back(logBlock);
}

#endif
