
@echo off

echo:
echo remove bineries, intermediate and logs directories
echo ==================================================
echo:
rmdir /s /q Binaries
rmdir /s /q Intermediate
rmdir /s /q Logs

echo:
echo generate vs 2022 project
echo ==================================================
echo:
cmake -B Intermediate -A x64 -G "Visual Studio 17 2022" -D CMAKE_TOOLCHAIN_FILE=vcpkg\scripts\buildsystems\vcpkg.cmake

echo end project generation.
pause