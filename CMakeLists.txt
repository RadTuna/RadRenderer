###################################
# CMake settings for rad renderer #
###################################

# required cmake over 3.21 ver
cmake_minimum_required(VERSION 3.21)

# using cpp 17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# setup vcpkg
set(VCPKG_INSTALLED_DIR ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg_installed)
set(VCPKG_MANIFEST_DIR ${CMAKE_CURRENT_SOURCE_DIR})

# set project
project(RadRenderer)

# set visual studio settings
VS_STARTUP_PROJECT(${PROJECT_NAME})

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

# find vcpkg packages
find_package(assimp REQUIRED)
find_package(imgui REQUIRED)
find_package(glm REQUIRED)
find_package(glfw3 REQUIRED)
find_package(SailC++ REQUIRED)

# find vulkan sdk
find_package(Vulkan REQUIRED)
include_directories(${Vulkan_INCLUDE_DIRS})

# set executable
if (WIN32)
    add_executable(${PROJECT_NAME} WIN32 ${ALL_FILES})
else()
    message(FATEL_ERROR "You can't build cmake from this platform")
endif()

# link vcpkg packages
target_link_libraries(${PROJECT_NAME} assimp::assimp)
target_link_libraries(${PROJECT_NAME} imgui::imgui)
target_link_libraries(${PROJECT_NAME} glm::glm)
target_link_libraries(${PROJECT_NAME} glfw)
target_link_libraries(${PROJECT_NAME} SAIL::sail-c++)

# link vulkan sdk
target_link_libraries(${PROJECT_NAME} Vulkan::Vulkan)

