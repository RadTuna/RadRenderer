# Rad Renderer
A cross-platform renderer based on Vulkan.
It aims to support Windows and Linux.

## Preparations
The following software is required to build RadRender.
- CMake 3.8 or later
    - Windows: Use Installer - https://cmake.org/download
    - Linux(Ubuntu): Use APT - ```sudo apt install cmake```
- Vulkan SDK
    - Windows: Use Installer - https://vulkan.lunarg.com/sdk/home  
    - Linux(Ubuntu): Use APT - ```sudo apt install vulkan-sdk```
- Conan package manager
    - Windows and Linux(Ubuntu): Use Installer - https://conan.io  

## Installation
If the above software is ready, follow the steps below to build it.  
1. Run ```InstallDependencies.bat or .sh``` to install dependent libraries.  
2. Run ```GenerateProject.bat or .sh``` to configure the Makefile.
3. Builds are performed using the IDE or CMake command.
    - CMake Command: ```cd Intermediate``` ```cmake --build .```

## Recommended Compiler and Editor
- Windows: MSVC + Visual Studio 2019
- Linux: GCC + Visual Studio Code (with CMake, CMakeTools, C/C++ plugins)

## Libraries
Vulkan: https://www.vulkan.org/   
glm: https://github.com/g-truc/glm  
glfw: https://www.glfw.org/  
Dear ImGUI: https://github.com/ocornut/imgui  
SAIL: https://github.com/HappySeaFox/sail  
assimp: https://github.com/assimp/assimp  

