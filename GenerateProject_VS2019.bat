
@echo off

echo:
echo generate vs 2019 project...
echo ==================================================
echo:
cmake -B Intermediate -D CMAKE_TOOLCHAIN_FILE=vcpkg\scripts\buildsystems\vcpkg.cmake -G "Visual Studio 16 2019"

echo end project generation.
pause