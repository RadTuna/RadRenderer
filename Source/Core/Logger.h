#pragma once

#if !defined NDEBUG
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
    World,
    Count
};

constexpr char* LogTypeStringTable[static_cast<uint32_t>(ELogType::Count)] = {
    "Unknown",
    "Core",
    "Editor",
    "Renderer",
    "World"
};

enum class ELogClass
{
    Log = 0,
    Warning,
    Error,
    Count
};

constexpr char* LogClassStringTable[static_cast<uint32_t>(ELogClass::Count)] = {
    "Log",
    "Warning",
    "Error"
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


#if defined NDEBUG
#define RAD_LOG(LogType, LogClass, LogBody)
#define RAD_QLOG(LogBody)
#define SETUP_RAD_LOGGER(LogPath, LogName)
#define PRINT_RAD_LOGGER()
#else
#define RAD_LOG(LogType, LogClass, LogBody) Logger::LogStatic(LogType, LogClass, LogBody)
#define RAD_QLOG(LogBody) Logger::LogStatic(ELogType::Unknown, ELogClass::Log, LogBody)
#define SETUP_RAD_LOGGER(LogPath, LogName) Logger::CreateLogger(LogPath, LogName)
#define PRINT_RAD_LOGGER() Logger::PrintLogStatic()
#endif
