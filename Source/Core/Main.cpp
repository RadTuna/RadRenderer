
#include "Application.h"
#include "Logger.h"

#if defined WIN32
#define CROSS_MAIN WinMain
#else
#define CROSS_MAIN main
#endif


constexpr uint32_t LOG_MAX_COUNT = 10000;

int CROSS_MAIN(int argc, char* argv[])
{
    SETUP_RAD_LOGGER(LOG_MAX_COUNT);

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

    return EXIT_SUCCESS;
}
