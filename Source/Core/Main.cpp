
#include "Application.h"
#include "Logger.h"

#if defined WIN32
#define CROSS_MAIN WinMain
#else
#define CROSS_MAIN main
#endif

int CROSS_MAIN(int argc, char* argv[])
{
    Logger::CreateLogger("D:/RadRenderer/Logs", "RadRenderer_log.txt");
    Logger* logger = Logger::GetLoggerOrNull();
    if (logger == nullptr)
    {
        return EXIT_FAILURE;
    }

    Application::CreateApplication(1280, 720, "RadRenderer");
    Application* app = Application::GetApplicationOrNull();
    if (app == nullptr)
    {
        return EXIT_FAILURE;
    }

    const bool bResult = app->Run();
    if (!bResult)
    {
        return EXIT_FAILURE;
    }

    logger->PrintLog();

    return EXIT_SUCCESS;
}
