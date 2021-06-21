@echo off

echo:
echo remove prev vcpkg folders...
echo ==================================================
echo:
rd /s /q vcpkg
rd /s /q vcpkg_installed

echo:
echo cloning vcpkg...
echo ==================================================
echo:
git clone https://github.com/Microsoft/vcpkg.git

echo:
echo build vcpkg...
echo ==================================================
echo:
cd vcpkg
call bootstrap-vcpkg.bat

pause