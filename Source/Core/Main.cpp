
#include "Application.h"
#include "Logger.h"

#if defined WIN32
#define CROSS_MAIN WinMain
#else
#define CROSS_MAIN main
#endif

int CROSS_MAIN(int argc, char* argv[])
{
    SETUP_RAD_LOGGER("D:/RadRenderer/Logs", "RadRenderer_log.txt");

    Application::CreateApplication(1280, 720, "RadRenderer");
    Application* app = Application::GetApplicationOrNull();
    if (app == nullptr)
    {
        PRINT_RAD_LOGGER();
        return EXIT_FAILURE;
    }

    const bool bResult = app->Run();
    if (!bResult)
    {
        PRINT_RAD_LOGGER();
        return EXIT_FAILURE;
    }

    PRINT_RAD_LOGGER();
    return EXIT_SUCCESS;
}
