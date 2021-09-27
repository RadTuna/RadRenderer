#pragma once

// External Include
#include <cstdint>

template<typename Type, size_t Size>
constexpr size_t ArraySize(const Type(&arr)[Size])
{
    return Size;
}
