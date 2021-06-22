
@echo off

echo:
echo generate vs 2019 project...
echo ==================================================
echo:
cmake -B Intermediate -G "Visual Studio 16 2019"

echo end project generation.
pause