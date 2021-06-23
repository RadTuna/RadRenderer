
// Primary Include
#include "Logger.h"

// External Include
#include <fstream>
#include <filesystem>


std::unique_ptr<Logger> Logger::LoggerInstance = nullptr;

Logger::Logger(const std::string& logPath, const std::string& logName)
    : mLogPath(logPath)
    , mLogName(logName)
{
}

Logger::~Logger()
{
}

void Logger::CreateLogger(const std::string& logPath, const std::string& logName)
{
    if (LoggerInstance == nullptr)
    {
        // danger code!
        LoggerInstance = std::move(std::unique_ptr<Logger>(new Logger(logPath, logName)));
    }
}

void Logger::LogStatic(ELogType logType, ELogClass logClass, const std::string logBody)
{
    if (LoggerInstance != nullptr)
    {
        LoggerInstance->Log(logType, logClass, logBody);
    }
}

void Logger::LogQuick(const std::string logBody)
{
    LogStatic(ELogType::Unknown, ELogClass::Log, logBody);
}

void Logger::Log(ELogType logType, ELogClass logClass, const std::string logBody)
{
    const std::string typeString = LogTypeStringTable[static_cast<uint32_t>(logType)];
    const std::string classString = LogClassStringTable[static_cast<uint32_t>(logClass)];

    const std::string fullLog = "[" + typeString + "] / " + classString + ": " + logBody;
    mLogs.push_back(fullLog);
}

void Logger::PrintLog() const
{
    std::filesystem::path absolutePath = std::filesystem::absolute(mLogPath);
    std::filesystem::path fileName(mLogName);

    if (std::filesystem::exists(absolutePath) == false)
    {
        std::filesystem::create_directories(absolutePath);
    }

    absolutePath /= fileName;
    if (std::filesystem::exists(absolutePath) == true)
    {
        std::filesystem::remove(absolutePath);
    }
    
    std::ofstream fileOut;
    fileOut.open(absolutePath);

    for (const std::string& log : mLogs)
    {
        fileOut << log << "\n";
    }
    fileOut << std::endl;

    fileOut.close();
}
