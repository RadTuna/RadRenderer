# Rad Renderer

Vulkan 라이브러리를 활용 한 크로스 플랫폼 렌더러입니다.  
Windows, Linux 지원을 목표로 하고 있습니다.

## Preparations
Rad Renderer를 빌드하기 위해서는 다음과 같은 소프트웨어가 필요합니다.  
- CMake 3.8 or later
    - Windows: 인스톨러 사용 - https://cmake.org/download
    - Linux(Ubuntu): 패키지 매니저 사용 - ```sudo apt install cmake```
- Vulkan SDK
    - Windows: 인스톨러 사용 - https://vulkan.lunarg.com/sdk/home  
    - Linux(Ubuntu): 패키지 매니저 사용 - ```sudo apt install vulkan-sdk```
- Conan package manager
    - Windows and Linux(Ubuntu): 인스톨러 사용 - https://conan.io  

## Installation
위의 소프트웨어를 준비했다면 다음의 절차를 따라서 빌드하면 됩니다.  
1. InstallDependencies.bat or .sh 를 실행하여 종속된 라이브러리를 설치합니다.  
2. GenerateProject.bat or .sh 를 실행하여 Makefile을 구성합니다.  
3. 플랫폼에 따라 다음과 같이 빌드를 수행합니다.
    - Common: Intermediate 폴더에서 CMake의 cmake --build . 명령을 사용해서 빌드합니다.  
    - Windows: Intermediate 폴더 안에 존재하는 .sln 파일을 실행하여 VS를 이용해 빌드합니다.  
    - Linux: Intermediate 폴더에서 Shell의 make 명령을 사용해서 빌드합니다.  

## Libraries
Vulkan: https://www.vulkan.org/   
glm: https://github.com/g-truc/glm  
glfw: https://www.glfw.org/  
Dear ImGUI: https://github.com/ocornut/imgui  
SAIL: https://github.com/HappySeaFox/sail  
assimp: https://github.com/assimp/assimp  

