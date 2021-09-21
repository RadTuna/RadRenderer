###################################
# CMake settings for rad renderer #
###################################

# required cmake over 3.8 ver
cmake_minimum_required(VERSION 3.8)

# using cpp 17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# export compile command for vscode
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# set project name
project(RadRenderer)

# set base variables
set(SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Source)
set(BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Binaries)
set(PROJECT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Project)

# gather all underlying files
file(GLOB_RECURSE HEADER_FILES ${SOURCE_DIR}/*.h)
file(GLOB_RECURSE SOURCE_FILES ${SOURCE_DIR}/*.cpp) 
set(ALL_FILES ${HEADER_FILES} ${SOURCE_FILES})

# set source group
source_group(TREE ${SOURCE_DIR} PREFIX "Source" FILES ${ALL_FILES})

# set relevant build properties
set(CMAKE_OUTPUT_NAME ${PROJECT_NAME})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${BINARY_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${BINARY_DIR})
set(CMAKE_SUPPRESS_REGENERATION true)

#include source
include_directories(${SOURCE_DIR})

#include conan package
set(CONAN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Conan)
include(${CONAN_DIR}/conanbuildinfo.cmake)
conan_basic_setup(TARGETS NO_OUTPUT_DIRS)

# set executable
if (WIN32)
    add_executable(${PROJECT_NAME} WIN32 ${ALL_FILES})
elseif (UNIX)
    add_executable(${PROJECT_NAME} ${ALL_FILES})
else()
    message(FATEL_ERROR "You can't build cmake from this platform")
endif()

# link conan packages
target_link_libraries(${PROJECT_NAME} CONAN_PKG::assimp)
target_link_libraries(${PROJECT_NAME} CONAN_PKG::imgui)
target_link_libraries(${PROJECT_NAME} CONAN_PKG::glm)
target_link_libraries(${PROJECT_NAME} CONAN_PKG::glfw)
target_link_libraries(${PROJECT_NAME} CONAN_PKG::openimageio)

# link vulkan sdk
find_package(Vulkan REQUIRED)
include_directories(${Vulkan_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} Vulkan::Vulkan)




