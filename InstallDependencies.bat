@echo off

echo:
echo install dependencies...
echo ==================================================
echo:
rd /s /q Conan
md Conan
cd Conan
conan install ..

pause