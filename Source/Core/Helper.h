#pragma once

// External Include
#include <cstdint>
#include <cassert>

#if defined NDEBUG
#define VK_ASSERT_RETURN(Return)
#else
#define VK_ASSERT_RETURN(Return) if ((Return) != VK_SUCCESS) { assert(false); }
#endif

template<typename Type, size_t Size>
constexpr size_t ArraySize(const Type(&arr)[Size])
{
    return Size;
}
