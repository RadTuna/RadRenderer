#pragma once

#if defined _DEBUG
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
    static void PrintLogStatic();

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
#endif

#if defined _DEBUG
#define RAD_LOG(LogType, LogClass, LogBody) Logger::LogStatic(LogType, LogClass, LogBody)
#else
#define RAD_LOG(LogType, LogClass, LogBody)
#endif

#if defined _DEBUG
#define RAD_QLOG(LogBody) Logger::LogStatic(ELogType::Unknown, ELogClass::Log, LogBody)
#else
#define RAD_QLOG(LogBody)
#endif

#if defined _DEBUG
#define SETUP_RAD_LOGGER(LogPath, LogName) Logger::CreateLogger(LogPath, LogName)
#else
#define SETUP_RAD_LOGGER(LogPath, LogName)
#endif

#if defined _DEBUG
#define PRINT_RAD_LOGGER() Logger::PrintLogStatic()
#else
#define PRINT_RAD_LOGGER()
#endif
