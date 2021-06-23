#pragma once

// External Include
#include <vector>
#include <string>
#include <memory>

enum class ELogType
{
    Unknown = 0,
    Core,
    Editor,
    Renderer,
    Resource,
    World,
    Count = 6
};

constexpr char* LogTypeStringTable[static_cast<uint32_t>(ELogType::Count)] = {
    "Unknown",
    "Core",
    "Editor",
    "Renderer",
    "Resource",
    "World"
};

enum class ELogClass
{
    Log = 0,
    Warning,
    Error,
    FatalError,
    Count = 4
};

constexpr char* LogClassStringTable[static_cast<uint32_t>(ELogClass::Count)] = {
    "Log",
    "Warning",
    "Error",
    "FatalError"
};

class Logger final
{
public:
    ~Logger();

    // Singleton pattern method
    static void CreateLogger(const std::string& logPath, const std::string& logName);
    static Logger* GetLoggerOrNull() { return LoggerInstance.get(); }

    static void LogStatic(ELogType logType, ELogClass logClass, const std::string logBody);
    static void LogQuick(const std::string logBody);

    void Log(ELogType logType, ELogClass logClass, const std::string logBody);
    void PrintLog() const;

private:
    Logger(const std::string& logPath, const std::string& logName);

private:
    // Singleton pattern property
    static std::unique_ptr<Logger> LoggerInstance;

    std::vector<std::string> mLogs;
    std::string mLogPath;
    std::string mLogName;

};
