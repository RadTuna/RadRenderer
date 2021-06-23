
#include "Application.h"

#if defined WIN32
#define CROSS_MAIN WinMain
#else
#define CROSS_MAIN main
#endif

int CROSS_MAIN(int argc, char* argv[])
{
    Application app;

    app.Run();

    return 0;
}
