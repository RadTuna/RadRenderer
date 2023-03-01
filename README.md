# Rad Renderer
A cross-platform renderer based on Vulkan.
It aims to support Windows.

## Preparations
The following software is required to build RadRender.
- CMake 3.21 or later
    - Windows: Use Installer - https://cmake.org/download
- Vulkan SDK
    - Windows: Use Installer - https://vulkan.lunarg.com/sdk/home  

## Installation
If the above software is ready, follow the steps below to build it.  
1. Clone this repository and update the vcpkg submodule.
2. Run ```vcpkg/bootstrap-vcpkg.bat``` to install vcpkg. 
3. Run ```GenerateProject.bat``` to install dependent libraries and configure the Makefile.
4. Builds can be performed using IDE or CMake commands.

## Recommended Compiler and Editor
- Windows: MSVC + Visual Studio 2022

## Libraries
Vulkan: https://www.vulkan.org/   
glm: https://github.com/g-truc/glm  
glfw: https://www.glfw.org/  
Dear ImGUI: https://github.com/ocornut/imgui  
SAIL: https://github.com/HappySeaFox/sail  
assimp: https://github.com/assimp/assimp  

