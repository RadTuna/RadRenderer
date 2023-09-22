#pragma once

// External Include
#include <cstdint>


#pragma region Functions

template<typename Type, size_t Size>
constexpr size_t ArraySize(const Type(&arr)[Size])
{
    return Size;
}

#pragma endregion

#pragma region Macro

#define DEBUG_BUILD (!defined NDEBUG)
#define RELEASE_BUILD (defined NDEBUG)

#if defined NDEBUG

#define ASSERT(Expr)
#define ASSERT_NEVER()

#else

#define ASSERT(Expr) assert(Expr)
#define ASSERT_NEVER() assert(false)

#endif

#pragma region
