@echo off

if defined VK_SDK_PATH (
    set VK_COMPILER_PATH=%VK_SDK_PATH%/Bin32/glslc.exe
) else (
    if defined VULKAN_SDK (
        set VK_COMPILER_PATH=%VULKAN_SDK%/Bin32/glslc.exe
    ) else (
        echo Vulkan SDK environment variable not found.
        echo Please enter the Vulkan SDK path manually.
        set /p MANUAL_VK_SDK_PATH="Input:"
        set VK_COMPILER_PATH=%MANUAL_VK_SDK_PATH%/Bin32/glslc.exe
        echo.
    )
)

if exist %VK_COMPILER_PATH% (
    echo Compile the shader files.
    echo.

    cd Shader
    for %%i in (*.vert) do %VK_COMPILER_PATH% %%i -o %%i.spv
    for %%i in (*.frag) do %VK_COMPILER_PATH% %%i -o %%i.spv

    echo.
    echo Shader compilation is complete.
) else (
    echo Vulkan SDK path not found.
)

pause
