#pragma once

#if !defined NDEBUG

// External Include
#include <deque>
#include <string>
#include <memory>
#include <functional>


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

struct LogBlock
{
    ELogType LogType;
    ELogClass LogClass;
    std::string LogBody;
};

class Logger final
{
public:
    ~Logger();

    // Singleton pattern method
    static void CreateLogger(uint32_t maxLog);
    static Logger* GetLoggerOrNull() { return LoggerInstance.get(); }

    static std::string Stringify(const LogBlock& logBlock);

    static void LogStatic(ELogType logType, ELogClass logClass, const std::string& logBody);
    void Log(ELogType logType, ELogClass logClass, const std::string& logBody);

    void ForEachRawLogs(std::function<void(const LogBlock&)> func);
    void ForEachLogs(std::function<void(const std::string)> func);
    void FlushLogs();

private:
    Logger(uint32_t maxLog);

private:
    // Singleton pattern property
    static std::unique_ptr<Logger> LoggerInstance;

    std::deque<LogBlock> mLogs;
    uint32_t mMaxLogCount;

};
#endif


#if defined NDEBUG
#define RAD_LOG(LogType, LogClass, LogBody)
#define RAD_QLOG(LogBody)
#define SETUP_RAD_LOGGER(LogPath, LogName)
#define PRINT_RAD_LOGGER()
#else
#define RAD_LOG(LogType, LogClass, LogBody) Logger::LogStatic(ELogType::##LogType, ELogClass::##LogClass, LogBody)
#define RAD_DYN_LOG(LogType, LogClass, LogBody) Logger::LogStatic(LogType, LogClass, LogBody)
#define RAD_QLOG(LogBody) Logger::LogStatic(ELogType::Unknown, ELogClass::Log, LogBody)
#define SETUP_RAD_LOGGER(MaxLogCount) Logger::CreateLogger(MaxLogCount)
#define PRINT_RAD_LOGGER() Logger::PrintLogStatic()
#endif
