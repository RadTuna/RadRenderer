###########################
# CMake settings for rad renderer #
###########################

# required cmake over 3.8 ver
cmake_minimum_required(VERSION 3.8)

# using cpp 17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

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

# set executable
add_executable(${PROJECT_NAME} ${ALL_FILES})

# link package from vcpkg
# assimp
find_package(assimp CONFIG REQUIRED)
include_directories(${assimp_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} assimp::assimp)
# glm
find_package(glm CONFIG REQUIRED)
include_directories(${glm_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} glm::glm)
# glfw3
find_package(glfw3 CONFIG REQUIRED)
include_directories(${glfw3_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} glfw)
# imgui
find_package(imgui CONFIG REQUIRED)
include_directories(${imgui_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} imgui::imgui)
# sail
find_package(sail CONFIG REQUIRED)
include_directories(${sail_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} SAIL::sail)

# link vulkan sdk
find_package(Vulkan REQUIRED)
include_directories(${Vulkan_INCLUDE_DIRS})
target_link_libraries(${PROJECT_NAME} Vulkan::Vulkan)




