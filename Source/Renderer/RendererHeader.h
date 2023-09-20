#pragma once

// Primary Include
#include "Core/CoreHeader.h"


#pragma region GLFW pre-macros

#define GLFW_INCLUDE_VULKAN

#pragma endregion

#pragma region pre-macros

#define GLM_FORCE_RADIAN // glm 각도 관련 인자를 Radian으로 강제.
#define GLM_FORCE_DEPTH_ZERO_TO_ONE
#define GLM_FORCE_LEFT_HANDED

#pragma endregion

#pragma region Constant

constexpr uint32_t MAX_SWAPCHAIN_IMAGE_COUNT = 6;

#pragma endregion



