include(CMakeParseArguments)

macro(conan_find_apple_frameworks FRAMEWORKS_FOUND FRAMEWORKS SUFFIX BUILD_TYPE)
    if(APPLE)
        if(CMAKE_BUILD_TYPE)
            set(_BTYPE ${CMAKE_BUILD_TYPE})
        elseif(NOT BUILD_TYPE STREQUAL "")
            set(_BTYPE ${BUILD_TYPE})
        endif()
        if(_BTYPE)
            if(${_BTYPE} MATCHES "Debug|_DEBUG")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_DEBUG} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_DEBUG} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "Release|_RELEASE")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_RELEASE} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_RELEASE} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "RelWithDebInfo|_RELWITHDEBINFO")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_RELWITHDEBINFO} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_RELWITHDEBINFO} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            elseif(${_BTYPE} MATCHES "MinSizeRel|_MINSIZEREL")
                set(CONAN_FRAMEWORKS${SUFFIX} ${CONAN_FRAMEWORKS${SUFFIX}_MINSIZEREL} ${CONAN_FRAMEWORKS${SUFFIX}})
                set(CONAN_FRAMEWORK_DIRS${SUFFIX} ${CONAN_FRAMEWORK_DIRS${SUFFIX}_MINSIZEREL} ${CONAN_FRAMEWORK_DIRS${SUFFIX}})
            endif()
        endif()
        foreach(_FRAMEWORK ${FRAMEWORKS})
            # https://cmake.org/pipermail/cmake-developers/2017-August/030199.html
            find_library(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND NAME ${_FRAMEWORK} PATHS ${CONAN_FRAMEWORK_DIRS${SUFFIX}} CMAKE_FIND_ROOT_PATH_BOTH)
            if(CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND)
                list(APPEND ${FRAMEWORKS_FOUND} ${CONAN_FRAMEWORK_${_FRAMEWORK}_FOUND})
            else()
                message(FATAL_ERROR "Framework library ${_FRAMEWORK} not found in paths: ${CONAN_FRAMEWORK_DIRS${SUFFIX}}")
            endif()
        endforeach()
    endif()
endmacro()


#################
###  IMGUI
#################
set(CONAN_IMGUI_ROOT "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_IMGUI "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_IMGUI "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_IMGUI "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/bin")
set(CONAN_RES_DIRS_IMGUI "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/res")
set(CONAN_SRC_DIRS_IMGUI "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/res/bindings")
set(CONAN_BUILD_DIRS_IMGUI "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_IMGUI )
set(CONAN_LIBS_IMGUI imgui)
set(CONAN_PKG_LIBS_IMGUI imgui)
set(CONAN_SYSTEM_LIBS_IMGUI )
set(CONAN_FRAMEWORKS_IMGUI )
set(CONAN_FRAMEWORKS_FOUND_IMGUI "")  # Will be filled later
set(CONAN_DEFINES_IMGUI )
set(CONAN_BUILD_MODULES_PATHS_IMGUI )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_IMGUI )

set(CONAN_C_FLAGS_IMGUI "")
set(CONAN_CXX_FLAGS_IMGUI "")
set(CONAN_SHARED_LINKER_FLAGS_IMGUI "")
set(CONAN_EXE_LINKER_FLAGS_IMGUI "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_IMGUI_LIST "")
set(CONAN_CXX_FLAGS_IMGUI_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_IMGUI_LIST "")
set(CONAN_EXE_LINKER_FLAGS_IMGUI_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_IMGUI "${CONAN_FRAMEWORKS_IMGUI}" "_IMGUI" "")
# Append to aggregated values variable
set(CONAN_LIBS_IMGUI ${CONAN_PKG_LIBS_IMGUI} ${CONAN_SYSTEM_LIBS_IMGUI} ${CONAN_FRAMEWORKS_FOUND_IMGUI})


#################
###  GLM
#################
set(CONAN_GLM_ROOT "C:/Users/RadTuna/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_GLM "C:/Users/RadTuna/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_GLM )
set(CONAN_BIN_DIRS_GLM )
set(CONAN_RES_DIRS_GLM )
set(CONAN_SRC_DIRS_GLM )
set(CONAN_BUILD_DIRS_GLM "C:/Users/RadTuna/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_GLM )
set(CONAN_LIBS_GLM )
set(CONAN_PKG_LIBS_GLM )
set(CONAN_SYSTEM_LIBS_GLM )
set(CONAN_FRAMEWORKS_GLM )
set(CONAN_FRAMEWORKS_FOUND_GLM "")  # Will be filled later
set(CONAN_DEFINES_GLM )
set(CONAN_BUILD_MODULES_PATHS_GLM )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_GLM )

set(CONAN_C_FLAGS_GLM "")
set(CONAN_CXX_FLAGS_GLM "")
set(CONAN_SHARED_LINKER_FLAGS_GLM "")
set(CONAN_EXE_LINKER_FLAGS_GLM "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_GLM_LIST "")
set(CONAN_CXX_FLAGS_GLM_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_GLM_LIST "")
set(CONAN_EXE_LINKER_FLAGS_GLM_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_GLM "${CONAN_FRAMEWORKS_GLM}" "_GLM" "")
# Append to aggregated values variable
set(CONAN_LIBS_GLM ${CONAN_PKG_LIBS_GLM} ${CONAN_SYSTEM_LIBS_GLM} ${CONAN_FRAMEWORKS_FOUND_GLM})


#################
###  GLFW
#################
set(CONAN_GLFW_ROOT "C:/Users/RadTuna/.conan/data/glfw/3.3.4/_/_/package/d3cffeefc8c8bcb6be8abdd182cb1b56fc81bacc")
set(CONAN_INCLUDE_DIRS_GLFW "C:/Users/RadTuna/.conan/data/glfw/3.3.4/_/_/package/d3cffeefc8c8bcb6be8abdd182cb1b56fc81bacc/include")
set(CONAN_LIB_DIRS_GLFW "C:/Users/RadTuna/.conan/data/glfw/3.3.4/_/_/package/d3cffeefc8c8bcb6be8abdd182cb1b56fc81bacc/lib")
set(CONAN_BIN_DIRS_GLFW )
set(CONAN_RES_DIRS_GLFW )
set(CONAN_SRC_DIRS_GLFW )
set(CONAN_BUILD_DIRS_GLFW "C:/Users/RadTuna/.conan/data/glfw/3.3.4/_/_/package/d3cffeefc8c8bcb6be8abdd182cb1b56fc81bacc/"
			"C:/Users/RadTuna/.conan/data/glfw/3.3.4/_/_/package/d3cffeefc8c8bcb6be8abdd182cb1b56fc81bacc/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_GLFW )
set(CONAN_LIBS_GLFW glfw3)
set(CONAN_PKG_LIBS_GLFW glfw3)
set(CONAN_SYSTEM_LIBS_GLFW gdi32)
set(CONAN_FRAMEWORKS_GLFW )
set(CONAN_FRAMEWORKS_FOUND_GLFW "")  # Will be filled later
set(CONAN_DEFINES_GLFW )
set(CONAN_BUILD_MODULES_PATHS_GLFW "C:/Users/RadTuna/.conan/data/glfw/3.3.4/_/_/package/d3cffeefc8c8bcb6be8abdd182cb1b56fc81bacc/lib/cmake/conan-official-glfw-targets.cmake")
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_GLFW )

set(CONAN_C_FLAGS_GLFW "")
set(CONAN_CXX_FLAGS_GLFW "")
set(CONAN_SHARED_LINKER_FLAGS_GLFW "")
set(CONAN_EXE_LINKER_FLAGS_GLFW "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_GLFW_LIST "")
set(CONAN_CXX_FLAGS_GLFW_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_GLFW_LIST "")
set(CONAN_EXE_LINKER_FLAGS_GLFW_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_GLFW "${CONAN_FRAMEWORKS_GLFW}" "_GLFW" "")
# Append to aggregated values variable
set(CONAN_LIBS_GLFW ${CONAN_PKG_LIBS_GLFW} ${CONAN_SYSTEM_LIBS_GLFW} ${CONAN_FRAMEWORKS_FOUND_GLFW})


#################
###  OPENIMAGEIO
#################
set(CONAN_OPENIMAGEIO_ROOT "C:/.conan/a7a939/1")
set(CONAN_INCLUDE_DIRS_OPENIMAGEIO "C:/.conan/a7a939/1/include")
set(CONAN_LIB_DIRS_OPENIMAGEIO "C:/.conan/a7a939/1/lib")
set(CONAN_BIN_DIRS_OPENIMAGEIO "C:/.conan/a7a939/1/bin")
set(CONAN_RES_DIRS_OPENIMAGEIO )
set(CONAN_SRC_DIRS_OPENIMAGEIO )
set(CONAN_BUILD_DIRS_OPENIMAGEIO "C:/.conan/a7a939/1/")
set(CONAN_FRAMEWORK_DIRS_OPENIMAGEIO )
set(CONAN_LIBS_OPENIMAGEIO OpenImageIO OpenImageIO_Util)
set(CONAN_PKG_LIBS_OPENIMAGEIO OpenImageIO OpenImageIO_Util)
set(CONAN_SYSTEM_LIBS_OPENIMAGEIO )
set(CONAN_FRAMEWORKS_OPENIMAGEIO )
set(CONAN_FRAMEWORKS_FOUND_OPENIMAGEIO "")  # Will be filled later
set(CONAN_DEFINES_OPENIMAGEIO "-DOIIO_STATIC_DEFINE")
set(CONAN_BUILD_MODULES_PATHS_OPENIMAGEIO )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENIMAGEIO "OIIO_STATIC_DEFINE")

set(CONAN_C_FLAGS_OPENIMAGEIO "")
set(CONAN_CXX_FLAGS_OPENIMAGEIO "")
set(CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO "")
set(CONAN_EXE_LINKER_FLAGS_OPENIMAGEIO "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENIMAGEIO_LIST "")
set(CONAN_CXX_FLAGS_OPENIMAGEIO_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENIMAGEIO_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENIMAGEIO "${CONAN_FRAMEWORKS_OPENIMAGEIO}" "_OPENIMAGEIO" "")
# Append to aggregated values variable
set(CONAN_LIBS_OPENIMAGEIO ${CONAN_PKG_LIBS_OPENIMAGEIO} ${CONAN_SYSTEM_LIBS_OPENIMAGEIO} ${CONAN_FRAMEWORKS_FOUND_OPENIMAGEIO})


#################
###  ASSIMP
#################
set(CONAN_ASSIMP_ROOT "C:/Users/RadTuna/.conan/data/assimp/5.0.1/_/_/package/f58d7797d1bf95ea392fb61c670aab283acdc2e4")
set(CONAN_INCLUDE_DIRS_ASSIMP "C:/Users/RadTuna/.conan/data/assimp/5.0.1/_/_/package/f58d7797d1bf95ea392fb61c670aab283acdc2e4/include")
set(CONAN_LIB_DIRS_ASSIMP "C:/Users/RadTuna/.conan/data/assimp/5.0.1/_/_/package/f58d7797d1bf95ea392fb61c670aab283acdc2e4/lib")
set(CONAN_BIN_DIRS_ASSIMP )
set(CONAN_RES_DIRS_ASSIMP )
set(CONAN_SRC_DIRS_ASSIMP )
set(CONAN_BUILD_DIRS_ASSIMP "C:/Users/RadTuna/.conan/data/assimp/5.0.1/_/_/package/f58d7797d1bf95ea392fb61c670aab283acdc2e4/")
set(CONAN_FRAMEWORK_DIRS_ASSIMP )
set(CONAN_LIBS_ASSIMP assimp-vc142-mt)
set(CONAN_PKG_LIBS_ASSIMP assimp-vc142-mt)
set(CONAN_SYSTEM_LIBS_ASSIMP )
set(CONAN_FRAMEWORKS_ASSIMP )
set(CONAN_FRAMEWORKS_FOUND_ASSIMP "")  # Will be filled later
set(CONAN_DEFINES_ASSIMP )
set(CONAN_BUILD_MODULES_PATHS_ASSIMP )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_ASSIMP )

set(CONAN_C_FLAGS_ASSIMP "")
set(CONAN_CXX_FLAGS_ASSIMP "")
set(CONAN_SHARED_LINKER_FLAGS_ASSIMP "")
set(CONAN_EXE_LINKER_FLAGS_ASSIMP "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_ASSIMP_LIST "")
set(CONAN_CXX_FLAGS_ASSIMP_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_ASSIMP_LIST "")
set(CONAN_EXE_LINKER_FLAGS_ASSIMP_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_ASSIMP "${CONAN_FRAMEWORKS_ASSIMP}" "_ASSIMP" "")
# Append to aggregated values variable
set(CONAN_LIBS_ASSIMP ${CONAN_PKG_LIBS_ASSIMP} ${CONAN_SYSTEM_LIBS_ASSIMP} ${CONAN_FRAMEWORKS_FOUND_ASSIMP})


#################
###  OPENGL
#################
set(CONAN_OPENGL_ROOT "C:/Users/RadTuna/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_OPENGL )
set(CONAN_LIB_DIRS_OPENGL )
set(CONAN_BIN_DIRS_OPENGL )
set(CONAN_RES_DIRS_OPENGL )
set(CONAN_SRC_DIRS_OPENGL )
set(CONAN_BUILD_DIRS_OPENGL "C:/Users/RadTuna/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_OPENGL )
set(CONAN_LIBS_OPENGL )
set(CONAN_PKG_LIBS_OPENGL )
set(CONAN_SYSTEM_LIBS_OPENGL opengl32)
set(CONAN_FRAMEWORKS_OPENGL )
set(CONAN_FRAMEWORKS_FOUND_OPENGL "")  # Will be filled later
set(CONAN_DEFINES_OPENGL )
set(CONAN_BUILD_MODULES_PATHS_OPENGL )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENGL )

set(CONAN_C_FLAGS_OPENGL "")
set(CONAN_CXX_FLAGS_OPENGL "")
set(CONAN_SHARED_LINKER_FLAGS_OPENGL "")
set(CONAN_EXE_LINKER_FLAGS_OPENGL "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENGL_LIST "")
set(CONAN_CXX_FLAGS_OPENGL_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENGL_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENGL "${CONAN_FRAMEWORKS_OPENGL}" "_OPENGL" "")
# Append to aggregated values variable
set(CONAN_LIBS_OPENGL ${CONAN_PKG_LIBS_OPENGL} ${CONAN_SYSTEM_LIBS_OPENGL} ${CONAN_FRAMEWORKS_FOUND_OPENGL})


#################
###  OPENEXR
#################
set(CONAN_OPENEXR_ROOT "C:/Users/RadTuna/.conan/data/openexr/2.5.2/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63")
set(CONAN_INCLUDE_DIRS_OPENEXR "C:/Users/RadTuna/.conan/data/openexr/2.5.2/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/include/OpenEXR"
			"C:/Users/RadTuna/.conan/data/openexr/2.5.2/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/include")
set(CONAN_LIB_DIRS_OPENEXR "C:/Users/RadTuna/.conan/data/openexr/2.5.2/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/lib")
set(CONAN_BIN_DIRS_OPENEXR )
set(CONAN_RES_DIRS_OPENEXR )
set(CONAN_SRC_DIRS_OPENEXR )
set(CONAN_BUILD_DIRS_OPENEXR "C:/Users/RadTuna/.conan/data/openexr/2.5.2/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/")
set(CONAN_FRAMEWORK_DIRS_OPENEXR )
set(CONAN_LIBS_OPENEXR IlmImf-2_5 IlmImfUtil-2_5 IlmThread-2_5 Imath-2_5 Half-2_5 IexMath-2_5 Iex-2_5)
set(CONAN_PKG_LIBS_OPENEXR IlmImf-2_5 IlmImfUtil-2_5 IlmThread-2_5 Imath-2_5 Half-2_5 IexMath-2_5 Iex-2_5)
set(CONAN_SYSTEM_LIBS_OPENEXR )
set(CONAN_FRAMEWORKS_OPENEXR )
set(CONAN_FRAMEWORKS_FOUND_OPENEXR "")  # Will be filled later
set(CONAN_DEFINES_OPENEXR )
set(CONAN_BUILD_MODULES_PATHS_OPENEXR )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENEXR )

set(CONAN_C_FLAGS_OPENEXR "")
set(CONAN_CXX_FLAGS_OPENEXR "")
set(CONAN_SHARED_LINKER_FLAGS_OPENEXR "")
set(CONAN_EXE_LINKER_FLAGS_OPENEXR "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENEXR_LIST "")
set(CONAN_CXX_FLAGS_OPENEXR_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENEXR_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENEXR_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENEXR "${CONAN_FRAMEWORKS_OPENEXR}" "_OPENEXR" "")
# Append to aggregated values variable
set(CONAN_LIBS_OPENEXR ${CONAN_PKG_LIBS_OPENEXR} ${CONAN_SYSTEM_LIBS_OPENEXR} ${CONAN_FRAMEWORKS_FOUND_OPENEXR})


#################
###  LIBTIFF
#################
set(CONAN_LIBTIFF_ROOT "C:/Users/RadTuna/.conan/data/libtiff/4.1.0/_/_/package/6916df94fb880f178c7cb69b9dfd0faa0815a236")
set(CONAN_INCLUDE_DIRS_LIBTIFF "C:/Users/RadTuna/.conan/data/libtiff/4.1.0/_/_/package/6916df94fb880f178c7cb69b9dfd0faa0815a236/include")
set(CONAN_LIB_DIRS_LIBTIFF "C:/Users/RadTuna/.conan/data/libtiff/4.1.0/_/_/package/6916df94fb880f178c7cb69b9dfd0faa0815a236/lib")
set(CONAN_BIN_DIRS_LIBTIFF )
set(CONAN_RES_DIRS_LIBTIFF )
set(CONAN_SRC_DIRS_LIBTIFF )
set(CONAN_BUILD_DIRS_LIBTIFF "C:/Users/RadTuna/.conan/data/libtiff/4.1.0/_/_/package/6916df94fb880f178c7cb69b9dfd0faa0815a236/")
set(CONAN_FRAMEWORK_DIRS_LIBTIFF )
set(CONAN_LIBS_LIBTIFF tiffxx tiff)
set(CONAN_PKG_LIBS_LIBTIFF tiffxx tiff)
set(CONAN_SYSTEM_LIBS_LIBTIFF )
set(CONAN_FRAMEWORKS_LIBTIFF )
set(CONAN_FRAMEWORKS_FOUND_LIBTIFF "")  # Will be filled later
set(CONAN_DEFINES_LIBTIFF )
set(CONAN_BUILD_MODULES_PATHS_LIBTIFF )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBTIFF )

set(CONAN_C_FLAGS_LIBTIFF "")
set(CONAN_CXX_FLAGS_LIBTIFF "")
set(CONAN_SHARED_LINKER_FLAGS_LIBTIFF "")
set(CONAN_EXE_LINKER_FLAGS_LIBTIFF "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBTIFF_LIST "")
set(CONAN_CXX_FLAGS_LIBTIFF_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBTIFF_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBTIFF_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBTIFF "${CONAN_FRAMEWORKS_LIBTIFF}" "_LIBTIFF" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBTIFF ${CONAN_PKG_LIBS_LIBTIFF} ${CONAN_SYSTEM_LIBS_LIBTIFF} ${CONAN_FRAMEWORKS_FOUND_LIBTIFF})


#################
###  FMT
#################
set(CONAN_FMT_ROOT "C:/Users/RadTuna/.conan/data/fmt/7.0.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_FMT "C:/Users/RadTuna/.conan/data/fmt/7.0.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_FMT "C:/Users/RadTuna/.conan/data/fmt/7.0.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_FMT )
set(CONAN_RES_DIRS_FMT )
set(CONAN_SRC_DIRS_FMT )
set(CONAN_BUILD_DIRS_FMT "C:/Users/RadTuna/.conan/data/fmt/7.0.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_FMT )
set(CONAN_LIBS_FMT fmt)
set(CONAN_PKG_LIBS_FMT fmt)
set(CONAN_SYSTEM_LIBS_FMT )
set(CONAN_FRAMEWORKS_FMT )
set(CONAN_FRAMEWORKS_FOUND_FMT "")  # Will be filled later
set(CONAN_DEFINES_FMT )
set(CONAN_BUILD_MODULES_PATHS_FMT )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_FMT )

set(CONAN_C_FLAGS_FMT "")
set(CONAN_CXX_FLAGS_FMT "")
set(CONAN_SHARED_LINKER_FLAGS_FMT "")
set(CONAN_EXE_LINKER_FLAGS_FMT "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_FMT_LIST "")
set(CONAN_CXX_FLAGS_FMT_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_FMT_LIST "")
set(CONAN_EXE_LINKER_FLAGS_FMT_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_FMT "${CONAN_FRAMEWORKS_FMT}" "_FMT" "")
# Append to aggregated values variable
set(CONAN_LIBS_FMT ${CONAN_PKG_LIBS_FMT} ${CONAN_SYSTEM_LIBS_FMT} ${CONAN_FRAMEWORKS_FOUND_FMT})


#################
###  BOOST
#################
set(CONAN_BOOST_ROOT "C:/.conan/f87a86/1")
set(CONAN_INCLUDE_DIRS_BOOST "C:/.conan/f87a86/1/include")
set(CONAN_LIB_DIRS_BOOST "C:/.conan/f87a86/1/lib")
set(CONAN_BIN_DIRS_BOOST )
set(CONAN_RES_DIRS_BOOST )
set(CONAN_SRC_DIRS_BOOST )
set(CONAN_BUILD_DIRS_BOOST "C:/.conan/f87a86/1/")
set(CONAN_FRAMEWORK_DIRS_BOOST )
set(CONAN_LIBS_BOOST libboost_contract libboost_coroutine libboost_fiber libboost_context libboost_graph libboost_iostreams libboost_log_setup libboost_log libboost_locale libboost_math_c99 libboost_math_c99f libboost_math_c99l libboost_math_tr1 libboost_math_tr1f libboost_math_tr1l libboost_nowide libboost_program_options libboost_random libboost_regex libboost_stacktrace_noop libboost_stacktrace_windbg libboost_stacktrace_windbg_cached libboost_timer libboost_type_erasure libboost_thread libboost_atomic libboost_chrono libboost_container libboost_date_time libboost_unit_test_framework libboost_prg_exec_monitor libboost_test_exec_monitor libboost_exception libboost_wave libboost_filesystem libboost_system libboost_wserialization libboost_serialization)
set(CONAN_PKG_LIBS_BOOST libboost_contract libboost_coroutine libboost_fiber libboost_context libboost_graph libboost_iostreams libboost_log_setup libboost_log libboost_locale libboost_math_c99 libboost_math_c99f libboost_math_c99l libboost_math_tr1 libboost_math_tr1f libboost_math_tr1l libboost_nowide libboost_program_options libboost_random libboost_regex libboost_stacktrace_noop libboost_stacktrace_windbg libboost_stacktrace_windbg_cached libboost_timer libboost_type_erasure libboost_thread libboost_atomic libboost_chrono libboost_container libboost_date_time libboost_unit_test_framework libboost_prg_exec_monitor libboost_test_exec_monitor libboost_exception libboost_wave libboost_filesystem libboost_system libboost_wserialization libboost_serialization)
set(CONAN_SYSTEM_LIBS_BOOST bcrypt ole32 dbgeng)
set(CONAN_FRAMEWORKS_BOOST )
set(CONAN_FRAMEWORKS_FOUND_BOOST "")  # Will be filled later
set(CONAN_DEFINES_BOOST "-DBOOST_STACKTRACE_USE_NOOP"
			"-DBOOST_ALL_NO_LIB"
			"-DBOOST_STACKTRACE_USE_WINDBG"
			"-DBOOST_STACKTRACE_USE_WINDBG_CACHED")
set(CONAN_BUILD_MODULES_PATHS_BOOST )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BOOST "BOOST_STACKTRACE_USE_NOOP"
			"BOOST_ALL_NO_LIB"
			"BOOST_STACKTRACE_USE_WINDBG"
			"BOOST_STACKTRACE_USE_WINDBG_CACHED")

set(CONAN_C_FLAGS_BOOST "")
set(CONAN_CXX_FLAGS_BOOST "")
set(CONAN_SHARED_LINKER_FLAGS_BOOST "")
set(CONAN_EXE_LINKER_FLAGS_BOOST "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BOOST_LIST "")
set(CONAN_CXX_FLAGS_BOOST_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BOOST_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BOOST_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BOOST "${CONAN_FRAMEWORKS_BOOST}" "_BOOST" "")
# Append to aggregated values variable
set(CONAN_LIBS_BOOST ${CONAN_PKG_LIBS_BOOST} ${CONAN_SYSTEM_LIBS_BOOST} ${CONAN_FRAMEWORKS_FOUND_BOOST})


#################
###  TSL-ROBIN-MAP
#################
set(CONAN_TSL-ROBIN-MAP_ROOT "C:/Users/RadTuna/.conan/data/tsl-robin-map/0.6.3/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_TSL-ROBIN-MAP "C:/Users/RadTuna/.conan/data/tsl-robin-map/0.6.3/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_TSL-ROBIN-MAP )
set(CONAN_BIN_DIRS_TSL-ROBIN-MAP )
set(CONAN_RES_DIRS_TSL-ROBIN-MAP )
set(CONAN_SRC_DIRS_TSL-ROBIN-MAP )
set(CONAN_BUILD_DIRS_TSL-ROBIN-MAP "C:/Users/RadTuna/.conan/data/tsl-robin-map/0.6.3/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_TSL-ROBIN-MAP )
set(CONAN_LIBS_TSL-ROBIN-MAP )
set(CONAN_PKG_LIBS_TSL-ROBIN-MAP )
set(CONAN_SYSTEM_LIBS_TSL-ROBIN-MAP )
set(CONAN_FRAMEWORKS_TSL-ROBIN-MAP )
set(CONAN_FRAMEWORKS_FOUND_TSL-ROBIN-MAP "")  # Will be filled later
set(CONAN_DEFINES_TSL-ROBIN-MAP )
set(CONAN_BUILD_MODULES_PATHS_TSL-ROBIN-MAP )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_TSL-ROBIN-MAP )

set(CONAN_C_FLAGS_TSL-ROBIN-MAP "")
set(CONAN_CXX_FLAGS_TSL-ROBIN-MAP "")
set(CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP "")
set(CONAN_EXE_LINKER_FLAGS_TSL-ROBIN-MAP "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_TSL-ROBIN-MAP_LIST "")
set(CONAN_CXX_FLAGS_TSL-ROBIN-MAP_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP_LIST "")
set(CONAN_EXE_LINKER_FLAGS_TSL-ROBIN-MAP_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_TSL-ROBIN-MAP "${CONAN_FRAMEWORKS_TSL-ROBIN-MAP}" "_TSL-ROBIN-MAP" "")
# Append to aggregated values variable
set(CONAN_LIBS_TSL-ROBIN-MAP ${CONAN_PKG_LIBS_TSL-ROBIN-MAP} ${CONAN_SYSTEM_LIBS_TSL-ROBIN-MAP} ${CONAN_FRAMEWORKS_FOUND_TSL-ROBIN-MAP})


#################
###  PUGIXML
#################
set(CONAN_PUGIXML_ROOT "C:/Users/RadTuna/.conan/data/pugixml/1.10/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_PUGIXML "C:/Users/RadTuna/.conan/data/pugixml/1.10/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_PUGIXML "C:/Users/RadTuna/.conan/data/pugixml/1.10/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_PUGIXML )
set(CONAN_RES_DIRS_PUGIXML )
set(CONAN_SRC_DIRS_PUGIXML )
set(CONAN_BUILD_DIRS_PUGIXML "C:/Users/RadTuna/.conan/data/pugixml/1.10/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_PUGIXML )
set(CONAN_LIBS_PUGIXML pugixml)
set(CONAN_PKG_LIBS_PUGIXML pugixml)
set(CONAN_SYSTEM_LIBS_PUGIXML )
set(CONAN_FRAMEWORKS_PUGIXML )
set(CONAN_FRAMEWORKS_FOUND_PUGIXML "")  # Will be filled later
set(CONAN_DEFINES_PUGIXML )
set(CONAN_BUILD_MODULES_PATHS_PUGIXML )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_PUGIXML )

set(CONAN_C_FLAGS_PUGIXML "")
set(CONAN_CXX_FLAGS_PUGIXML "")
set(CONAN_SHARED_LINKER_FLAGS_PUGIXML "")
set(CONAN_EXE_LINKER_FLAGS_PUGIXML "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_PUGIXML_LIST "")
set(CONAN_CXX_FLAGS_PUGIXML_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_PUGIXML_LIST "")
set(CONAN_EXE_LINKER_FLAGS_PUGIXML_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_PUGIXML "${CONAN_FRAMEWORKS_PUGIXML}" "_PUGIXML" "")
# Append to aggregated values variable
set(CONAN_LIBS_PUGIXML ${CONAN_PKG_LIBS_PUGIXML} ${CONAN_SYSTEM_LIBS_PUGIXML} ${CONAN_FRAMEWORKS_FOUND_PUGIXML})


#################
###  LIBSQUISH
#################
set(CONAN_LIBSQUISH_ROOT "C:/Users/RadTuna/.conan/data/libsquish/1.15/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_LIBSQUISH "C:/Users/RadTuna/.conan/data/libsquish/1.15/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_LIBSQUISH "C:/Users/RadTuna/.conan/data/libsquish/1.15/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_LIBSQUISH )
set(CONAN_RES_DIRS_LIBSQUISH )
set(CONAN_SRC_DIRS_LIBSQUISH )
set(CONAN_BUILD_DIRS_LIBSQUISH "C:/Users/RadTuna/.conan/data/libsquish/1.15/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_LIBSQUISH )
set(CONAN_LIBS_LIBSQUISH squish)
set(CONAN_PKG_LIBS_LIBSQUISH squish)
set(CONAN_SYSTEM_LIBS_LIBSQUISH )
set(CONAN_FRAMEWORKS_LIBSQUISH )
set(CONAN_FRAMEWORKS_FOUND_LIBSQUISH "")  # Will be filled later
set(CONAN_DEFINES_LIBSQUISH )
set(CONAN_BUILD_MODULES_PATHS_LIBSQUISH )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBSQUISH )

set(CONAN_C_FLAGS_LIBSQUISH "")
set(CONAN_CXX_FLAGS_LIBSQUISH "")
set(CONAN_SHARED_LINKER_FLAGS_LIBSQUISH "")
set(CONAN_EXE_LINKER_FLAGS_LIBSQUISH "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBSQUISH_LIST "")
set(CONAN_CXX_FLAGS_LIBSQUISH_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBSQUISH_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBSQUISH_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBSQUISH "${CONAN_FRAMEWORKS_LIBSQUISH}" "_LIBSQUISH" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBSQUISH ${CONAN_PKG_LIBS_LIBSQUISH} ${CONAN_SYSTEM_LIBS_LIBSQUISH} ${CONAN_FRAMEWORKS_FOUND_LIBSQUISH})


#################
###  OPENJPEG
#################
set(CONAN_OPENJPEG_ROOT "C:/Users/RadTuna/.conan/data/openjpeg/2.3.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_OPENJPEG "C:/Users/RadTuna/.conan/data/openjpeg/2.3.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/openjpeg/2.3.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include/openjpeg-2.3")
set(CONAN_LIB_DIRS_OPENJPEG "C:/Users/RadTuna/.conan/data/openjpeg/2.3.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_OPENJPEG )
set(CONAN_RES_DIRS_OPENJPEG )
set(CONAN_SRC_DIRS_OPENJPEG )
set(CONAN_BUILD_DIRS_OPENJPEG "C:/Users/RadTuna/.conan/data/openjpeg/2.3.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/openjpeg/2.3.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_OPENJPEG )
set(CONAN_LIBS_OPENJPEG openjp2)
set(CONAN_PKG_LIBS_OPENJPEG openjp2)
set(CONAN_SYSTEM_LIBS_OPENJPEG )
set(CONAN_FRAMEWORKS_OPENJPEG )
set(CONAN_FRAMEWORKS_FOUND_OPENJPEG "")  # Will be filled later
set(CONAN_DEFINES_OPENJPEG "-DOPJ_STATIC")
set(CONAN_BUILD_MODULES_PATHS_OPENJPEG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENJPEG "OPJ_STATIC")

set(CONAN_C_FLAGS_OPENJPEG "")
set(CONAN_CXX_FLAGS_OPENJPEG "")
set(CONAN_SHARED_LINKER_FLAGS_OPENJPEG "")
set(CONAN_EXE_LINKER_FLAGS_OPENJPEG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENJPEG_LIST "")
set(CONAN_CXX_FLAGS_OPENJPEG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENJPEG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENJPEG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENJPEG "${CONAN_FRAMEWORKS_OPENJPEG}" "_OPENJPEG" "")
# Append to aggregated values variable
set(CONAN_LIBS_OPENJPEG ${CONAN_PKG_LIBS_OPENJPEG} ${CONAN_SYSTEM_LIBS_OPENJPEG} ${CONAN_FRAMEWORKS_FOUND_OPENJPEG})


#################
###  GIFLIB
#################
set(CONAN_GIFLIB_ROOT "C:/Users/RadTuna/.conan/data/giflib/5.2.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_GIFLIB "C:/Users/RadTuna/.conan/data/giflib/5.2.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_GIFLIB "C:/Users/RadTuna/.conan/data/giflib/5.2.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_GIFLIB )
set(CONAN_RES_DIRS_GIFLIB )
set(CONAN_SRC_DIRS_GIFLIB )
set(CONAN_BUILD_DIRS_GIFLIB "C:/Users/RadTuna/.conan/data/giflib/5.2.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_GIFLIB )
set(CONAN_LIBS_GIFLIB gif)
set(CONAN_PKG_LIBS_GIFLIB gif)
set(CONAN_SYSTEM_LIBS_GIFLIB )
set(CONAN_FRAMEWORKS_GIFLIB )
set(CONAN_FRAMEWORKS_FOUND_GIFLIB "")  # Will be filled later
set(CONAN_DEFINES_GIFLIB "-DUSE_GIF_LIB")
set(CONAN_BUILD_MODULES_PATHS_GIFLIB )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_GIFLIB "USE_GIF_LIB")

set(CONAN_C_FLAGS_GIFLIB "")
set(CONAN_CXX_FLAGS_GIFLIB "")
set(CONAN_SHARED_LINKER_FLAGS_GIFLIB "")
set(CONAN_EXE_LINKER_FLAGS_GIFLIB "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_GIFLIB_LIST "")
set(CONAN_CXX_FLAGS_GIFLIB_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_GIFLIB_LIST "")
set(CONAN_EXE_LINKER_FLAGS_GIFLIB_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_GIFLIB "${CONAN_FRAMEWORKS_GIFLIB}" "_GIFLIB" "")
# Append to aggregated values variable
set(CONAN_LIBS_GIFLIB ${CONAN_PKG_LIBS_GIFLIB} ${CONAN_SYSTEM_LIBS_GIFLIB} ${CONAN_FRAMEWORKS_FOUND_GIFLIB})


#################
###  FREETYPE
#################
set(CONAN_FREETYPE_ROOT "C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16")
set(CONAN_INCLUDE_DIRS_FREETYPE "C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include"
			"C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include/freetype2")
set(CONAN_LIB_DIRS_FREETYPE "C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib")
set(CONAN_BIN_DIRS_FREETYPE "C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/bin")
set(CONAN_RES_DIRS_FREETYPE )
set(CONAN_SRC_DIRS_FREETYPE )
set(CONAN_BUILD_DIRS_FREETYPE "C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/"
			"C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_FREETYPE )
set(CONAN_LIBS_FREETYPE freetype)
set(CONAN_PKG_LIBS_FREETYPE freetype)
set(CONAN_SYSTEM_LIBS_FREETYPE )
set(CONAN_FRAMEWORKS_FREETYPE )
set(CONAN_FRAMEWORKS_FOUND_FREETYPE "")  # Will be filled later
set(CONAN_DEFINES_FREETYPE )
set(CONAN_BUILD_MODULES_PATHS_FREETYPE )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_FREETYPE )

set(CONAN_C_FLAGS_FREETYPE "")
set(CONAN_CXX_FLAGS_FREETYPE "")
set(CONAN_SHARED_LINKER_FLAGS_FREETYPE "")
set(CONAN_EXE_LINKER_FLAGS_FREETYPE "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_FREETYPE_LIST "")
set(CONAN_CXX_FLAGS_FREETYPE_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_FREETYPE_LIST "")
set(CONAN_EXE_LINKER_FLAGS_FREETYPE_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_FREETYPE "${CONAN_FRAMEWORKS_FREETYPE}" "_FREETYPE" "")
# Append to aggregated values variable
set(CONAN_LIBS_FREETYPE ${CONAN_PKG_LIBS_FREETYPE} ${CONAN_SYSTEM_LIBS_FREETYPE} ${CONAN_FRAMEWORKS_FOUND_FREETYPE})


#################
###  OPENCOLORIO
#################
set(CONAN_OPENCOLORIO_ROOT "C:/Users/RadTuna/.conan/data/opencolorio/1.1.1/_/_/package/a7d7488418cb3d62b4c5dc93873b6cb6d0a14be8")
set(CONAN_INCLUDE_DIRS_OPENCOLORIO "C:/Users/RadTuna/.conan/data/opencolorio/1.1.1/_/_/package/a7d7488418cb3d62b4c5dc93873b6cb6d0a14be8/include")
set(CONAN_LIB_DIRS_OPENCOLORIO "C:/Users/RadTuna/.conan/data/opencolorio/1.1.1/_/_/package/a7d7488418cb3d62b4c5dc93873b6cb6d0a14be8/lib")
set(CONAN_BIN_DIRS_OPENCOLORIO "C:/Users/RadTuna/.conan/data/opencolorio/1.1.1/_/_/package/a7d7488418cb3d62b4c5dc93873b6cb6d0a14be8/bin")
set(CONAN_RES_DIRS_OPENCOLORIO )
set(CONAN_SRC_DIRS_OPENCOLORIO )
set(CONAN_BUILD_DIRS_OPENCOLORIO "C:/Users/RadTuna/.conan/data/opencolorio/1.1.1/_/_/package/a7d7488418cb3d62b4c5dc93873b6cb6d0a14be8/")
set(CONAN_FRAMEWORK_DIRS_OPENCOLORIO )
set(CONAN_LIBS_OPENCOLORIO OpenColorIO)
set(CONAN_PKG_LIBS_OPENCOLORIO OpenColorIO)
set(CONAN_SYSTEM_LIBS_OPENCOLORIO )
set(CONAN_FRAMEWORKS_OPENCOLORIO )
set(CONAN_FRAMEWORKS_FOUND_OPENCOLORIO "")  # Will be filled later
set(CONAN_DEFINES_OPENCOLORIO "-DOpenColorIO_STATIC")
set(CONAN_BUILD_MODULES_PATHS_OPENCOLORIO )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_OPENCOLORIO "OpenColorIO_STATIC")

set(CONAN_C_FLAGS_OPENCOLORIO "")
set(CONAN_CXX_FLAGS_OPENCOLORIO "")
set(CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO "")
set(CONAN_EXE_LINKER_FLAGS_OPENCOLORIO "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_OPENCOLORIO_LIST "")
set(CONAN_CXX_FLAGS_OPENCOLORIO_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO_LIST "")
set(CONAN_EXE_LINKER_FLAGS_OPENCOLORIO_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_OPENCOLORIO "${CONAN_FRAMEWORKS_OPENCOLORIO}" "_OPENCOLORIO" "")
# Append to aggregated values variable
set(CONAN_LIBS_OPENCOLORIO ${CONAN_PKG_LIBS_OPENCOLORIO} ${CONAN_SYSTEM_LIBS_OPENCOLORIO} ${CONAN_FRAMEWORKS_FOUND_OPENCOLORIO})


#################
###  IRRXML
#################
set(CONAN_IRRXML_ROOT "C:/Users/RadTuna/.conan/data/irrxml/1.2/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_IRRXML "C:/Users/RadTuna/.conan/data/irrxml/1.2/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_IRRXML "C:/Users/RadTuna/.conan/data/irrxml/1.2/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_IRRXML )
set(CONAN_RES_DIRS_IRRXML )
set(CONAN_SRC_DIRS_IRRXML )
set(CONAN_BUILD_DIRS_IRRXML "C:/Users/RadTuna/.conan/data/irrxml/1.2/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_IRRXML )
set(CONAN_LIBS_IRRXML IrrXML)
set(CONAN_PKG_LIBS_IRRXML IrrXML)
set(CONAN_SYSTEM_LIBS_IRRXML )
set(CONAN_FRAMEWORKS_IRRXML )
set(CONAN_FRAMEWORKS_FOUND_IRRXML "")  # Will be filled later
set(CONAN_DEFINES_IRRXML )
set(CONAN_BUILD_MODULES_PATHS_IRRXML )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_IRRXML )

set(CONAN_C_FLAGS_IRRXML "")
set(CONAN_CXX_FLAGS_IRRXML "")
set(CONAN_SHARED_LINKER_FLAGS_IRRXML "")
set(CONAN_EXE_LINKER_FLAGS_IRRXML "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_IRRXML_LIST "")
set(CONAN_CXX_FLAGS_IRRXML_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_IRRXML_LIST "")
set(CONAN_EXE_LINKER_FLAGS_IRRXML_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_IRRXML "${CONAN_FRAMEWORKS_IRRXML}" "_IRRXML" "")
# Append to aggregated values variable
set(CONAN_LIBS_IRRXML ${CONAN_PKG_LIBS_IRRXML} ${CONAN_SYSTEM_LIBS_IRRXML} ${CONAN_FRAMEWORKS_FOUND_IRRXML})


#################
###  MINIZIP
#################
set(CONAN_MINIZIP_ROOT "C:/Users/RadTuna/.conan/data/minizip/1.2.11/_/_/package/153ff990bb7a331b443365f9878a3991adbdea9d")
set(CONAN_INCLUDE_DIRS_MINIZIP "C:/Users/RadTuna/.conan/data/minizip/1.2.11/_/_/package/153ff990bb7a331b443365f9878a3991adbdea9d/include"
			"C:/Users/RadTuna/.conan/data/minizip/1.2.11/_/_/package/153ff990bb7a331b443365f9878a3991adbdea9d/include/minizip")
set(CONAN_LIB_DIRS_MINIZIP "C:/Users/RadTuna/.conan/data/minizip/1.2.11/_/_/package/153ff990bb7a331b443365f9878a3991adbdea9d/lib")
set(CONAN_BIN_DIRS_MINIZIP )
set(CONAN_RES_DIRS_MINIZIP )
set(CONAN_SRC_DIRS_MINIZIP )
set(CONAN_BUILD_DIRS_MINIZIP "C:/Users/RadTuna/.conan/data/minizip/1.2.11/_/_/package/153ff990bb7a331b443365f9878a3991adbdea9d/")
set(CONAN_FRAMEWORK_DIRS_MINIZIP )
set(CONAN_LIBS_MINIZIP minizip)
set(CONAN_PKG_LIBS_MINIZIP minizip)
set(CONAN_SYSTEM_LIBS_MINIZIP )
set(CONAN_FRAMEWORKS_MINIZIP )
set(CONAN_FRAMEWORKS_FOUND_MINIZIP "")  # Will be filled later
set(CONAN_DEFINES_MINIZIP "-DHAVE_BZIP2")
set(CONAN_BUILD_MODULES_PATHS_MINIZIP )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_MINIZIP "HAVE_BZIP2")

set(CONAN_C_FLAGS_MINIZIP "")
set(CONAN_CXX_FLAGS_MINIZIP "")
set(CONAN_SHARED_LINKER_FLAGS_MINIZIP "")
set(CONAN_EXE_LINKER_FLAGS_MINIZIP "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_MINIZIP_LIST "")
set(CONAN_CXX_FLAGS_MINIZIP_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_MINIZIP_LIST "")
set(CONAN_EXE_LINKER_FLAGS_MINIZIP_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_MINIZIP "${CONAN_FRAMEWORKS_MINIZIP}" "_MINIZIP" "")
# Append to aggregated values variable
set(CONAN_LIBS_MINIZIP ${CONAN_PKG_LIBS_MINIZIP} ${CONAN_SYSTEM_LIBS_MINIZIP} ${CONAN_FRAMEWORKS_FOUND_MINIZIP})


#################
###  UTFCPP
#################
set(CONAN_UTFCPP_ROOT "C:/Users/RadTuna/.conan/data/utfcpp/3.1.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_UTFCPP "C:/Users/RadTuna/.conan/data/utfcpp/3.1.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/RadTuna/.conan/data/utfcpp/3.1.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include/utf8cpp")
set(CONAN_LIB_DIRS_UTFCPP "C:/Users/RadTuna/.conan/data/utfcpp/3.1.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib")
set(CONAN_BIN_DIRS_UTFCPP )
set(CONAN_RES_DIRS_UTFCPP )
set(CONAN_SRC_DIRS_UTFCPP )
set(CONAN_BUILD_DIRS_UTFCPP "C:/Users/RadTuna/.conan/data/utfcpp/3.1.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/RadTuna/.conan/data/utfcpp/3.1.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_UTFCPP )
set(CONAN_LIBS_UTFCPP )
set(CONAN_PKG_LIBS_UTFCPP )
set(CONAN_SYSTEM_LIBS_UTFCPP )
set(CONAN_FRAMEWORKS_UTFCPP )
set(CONAN_FRAMEWORKS_FOUND_UTFCPP "")  # Will be filled later
set(CONAN_DEFINES_UTFCPP )
set(CONAN_BUILD_MODULES_PATHS_UTFCPP )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_UTFCPP )

set(CONAN_C_FLAGS_UTFCPP "")
set(CONAN_CXX_FLAGS_UTFCPP "")
set(CONAN_SHARED_LINKER_FLAGS_UTFCPP "")
set(CONAN_EXE_LINKER_FLAGS_UTFCPP "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_UTFCPP_LIST "")
set(CONAN_CXX_FLAGS_UTFCPP_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_UTFCPP_LIST "")
set(CONAN_EXE_LINKER_FLAGS_UTFCPP_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_UTFCPP "${CONAN_FRAMEWORKS_UTFCPP}" "_UTFCPP" "")
# Append to aggregated values variable
set(CONAN_LIBS_UTFCPP ${CONAN_PKG_LIBS_UTFCPP} ${CONAN_SYSTEM_LIBS_UTFCPP} ${CONAN_FRAMEWORKS_FOUND_UTFCPP})


#################
###  KUBA-ZIP
#################
set(CONAN_KUBA-ZIP_ROOT "C:/Users/RadTuna/.conan/data/kuba-zip/0.1.31/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_KUBA-ZIP "C:/Users/RadTuna/.conan/data/kuba-zip/0.1.31/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_KUBA-ZIP "C:/Users/RadTuna/.conan/data/kuba-zip/0.1.31/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_KUBA-ZIP )
set(CONAN_RES_DIRS_KUBA-ZIP )
set(CONAN_SRC_DIRS_KUBA-ZIP )
set(CONAN_BUILD_DIRS_KUBA-ZIP "C:/Users/RadTuna/.conan/data/kuba-zip/0.1.31/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_KUBA-ZIP )
set(CONAN_LIBS_KUBA-ZIP zip)
set(CONAN_PKG_LIBS_KUBA-ZIP zip)
set(CONAN_SYSTEM_LIBS_KUBA-ZIP )
set(CONAN_FRAMEWORKS_KUBA-ZIP )
set(CONAN_FRAMEWORKS_FOUND_KUBA-ZIP "")  # Will be filled later
set(CONAN_DEFINES_KUBA-ZIP )
set(CONAN_BUILD_MODULES_PATHS_KUBA-ZIP )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_KUBA-ZIP )

set(CONAN_C_FLAGS_KUBA-ZIP "")
set(CONAN_CXX_FLAGS_KUBA-ZIP "")
set(CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP "")
set(CONAN_EXE_LINKER_FLAGS_KUBA-ZIP "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_KUBA-ZIP_LIST "")
set(CONAN_CXX_FLAGS_KUBA-ZIP_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP_LIST "")
set(CONAN_EXE_LINKER_FLAGS_KUBA-ZIP_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_KUBA-ZIP "${CONAN_FRAMEWORKS_KUBA-ZIP}" "_KUBA-ZIP" "")
# Append to aggregated values variable
set(CONAN_LIBS_KUBA-ZIP ${CONAN_PKG_LIBS_KUBA-ZIP} ${CONAN_SYSTEM_LIBS_KUBA-ZIP} ${CONAN_FRAMEWORKS_FOUND_KUBA-ZIP})


#################
###  POLY2TRI
#################
set(CONAN_POLY2TRI_ROOT "C:/Users/RadTuna/.conan/data/poly2tri/cci.20130502/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_POLY2TRI "C:/Users/RadTuna/.conan/data/poly2tri/cci.20130502/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_POLY2TRI "C:/Users/RadTuna/.conan/data/poly2tri/cci.20130502/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_POLY2TRI )
set(CONAN_RES_DIRS_POLY2TRI )
set(CONAN_SRC_DIRS_POLY2TRI )
set(CONAN_BUILD_DIRS_POLY2TRI "C:/Users/RadTuna/.conan/data/poly2tri/cci.20130502/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_POLY2TRI )
set(CONAN_LIBS_POLY2TRI poly2tri)
set(CONAN_PKG_LIBS_POLY2TRI poly2tri)
set(CONAN_SYSTEM_LIBS_POLY2TRI )
set(CONAN_FRAMEWORKS_POLY2TRI )
set(CONAN_FRAMEWORKS_FOUND_POLY2TRI "")  # Will be filled later
set(CONAN_DEFINES_POLY2TRI )
set(CONAN_BUILD_MODULES_PATHS_POLY2TRI )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_POLY2TRI )

set(CONAN_C_FLAGS_POLY2TRI "")
set(CONAN_CXX_FLAGS_POLY2TRI "")
set(CONAN_SHARED_LINKER_FLAGS_POLY2TRI "")
set(CONAN_EXE_LINKER_FLAGS_POLY2TRI "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_POLY2TRI_LIST "")
set(CONAN_CXX_FLAGS_POLY2TRI_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_POLY2TRI_LIST "")
set(CONAN_EXE_LINKER_FLAGS_POLY2TRI_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_POLY2TRI "${CONAN_FRAMEWORKS_POLY2TRI}" "_POLY2TRI" "")
# Append to aggregated values variable
set(CONAN_LIBS_POLY2TRI ${CONAN_PKG_LIBS_POLY2TRI} ${CONAN_SYSTEM_LIBS_POLY2TRI} ${CONAN_FRAMEWORKS_FOUND_POLY2TRI})


#################
###  RAPIDJSON
#################
set(CONAN_RAPIDJSON_ROOT "C:/Users/RadTuna/.conan/data/rapidjson/cci.20200410/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9")
set(CONAN_INCLUDE_DIRS_RAPIDJSON "C:/Users/RadTuna/.conan/data/rapidjson/cci.20200410/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include")
set(CONAN_LIB_DIRS_RAPIDJSON )
set(CONAN_BIN_DIRS_RAPIDJSON )
set(CONAN_RES_DIRS_RAPIDJSON )
set(CONAN_SRC_DIRS_RAPIDJSON )
set(CONAN_BUILD_DIRS_RAPIDJSON "C:/Users/RadTuna/.conan/data/rapidjson/cci.20200410/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/")
set(CONAN_FRAMEWORK_DIRS_RAPIDJSON )
set(CONAN_LIBS_RAPIDJSON )
set(CONAN_PKG_LIBS_RAPIDJSON )
set(CONAN_SYSTEM_LIBS_RAPIDJSON )
set(CONAN_FRAMEWORKS_RAPIDJSON )
set(CONAN_FRAMEWORKS_FOUND_RAPIDJSON "")  # Will be filled later
set(CONAN_DEFINES_RAPIDJSON )
set(CONAN_BUILD_MODULES_PATHS_RAPIDJSON )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_RAPIDJSON )

set(CONAN_C_FLAGS_RAPIDJSON "")
set(CONAN_CXX_FLAGS_RAPIDJSON "")
set(CONAN_SHARED_LINKER_FLAGS_RAPIDJSON "")
set(CONAN_EXE_LINKER_FLAGS_RAPIDJSON "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_RAPIDJSON_LIST "")
set(CONAN_CXX_FLAGS_RAPIDJSON_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_LIST "")
set(CONAN_EXE_LINKER_FLAGS_RAPIDJSON_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_RAPIDJSON "${CONAN_FRAMEWORKS_RAPIDJSON}" "_RAPIDJSON" "")
# Append to aggregated values variable
set(CONAN_LIBS_RAPIDJSON ${CONAN_PKG_LIBS_RAPIDJSON} ${CONAN_SYSTEM_LIBS_RAPIDJSON} ${CONAN_FRAMEWORKS_FOUND_RAPIDJSON})


#################
###  XZ_UTILS
#################
set(CONAN_XZ_UTILS_ROOT "C:/Users/RadTuna/.conan/data/xz_utils/5.2.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_XZ_UTILS "C:/Users/RadTuna/.conan/data/xz_utils/5.2.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_XZ_UTILS "C:/Users/RadTuna/.conan/data/xz_utils/5.2.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_XZ_UTILS )
set(CONAN_RES_DIRS_XZ_UTILS )
set(CONAN_SRC_DIRS_XZ_UTILS )
set(CONAN_BUILD_DIRS_XZ_UTILS "C:/Users/RadTuna/.conan/data/xz_utils/5.2.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/xz_utils/5.2.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_XZ_UTILS )
set(CONAN_LIBS_XZ_UTILS lzma)
set(CONAN_PKG_LIBS_XZ_UTILS lzma)
set(CONAN_SYSTEM_LIBS_XZ_UTILS )
set(CONAN_FRAMEWORKS_XZ_UTILS )
set(CONAN_FRAMEWORKS_FOUND_XZ_UTILS "")  # Will be filled later
set(CONAN_DEFINES_XZ_UTILS "-DLZMA_API_STATIC")
set(CONAN_BUILD_MODULES_PATHS_XZ_UTILS )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_XZ_UTILS "LZMA_API_STATIC")

set(CONAN_C_FLAGS_XZ_UTILS "")
set(CONAN_CXX_FLAGS_XZ_UTILS "")
set(CONAN_SHARED_LINKER_FLAGS_XZ_UTILS "")
set(CONAN_EXE_LINKER_FLAGS_XZ_UTILS "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_XZ_UTILS_LIST "")
set(CONAN_CXX_FLAGS_XZ_UTILS_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_XZ_UTILS_LIST "")
set(CONAN_EXE_LINKER_FLAGS_XZ_UTILS_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_XZ_UTILS "${CONAN_FRAMEWORKS_XZ_UTILS}" "_XZ_UTILS" "")
# Append to aggregated values variable
set(CONAN_LIBS_XZ_UTILS ${CONAN_PKG_LIBS_XZ_UTILS} ${CONAN_SYSTEM_LIBS_XZ_UTILS} ${CONAN_FRAMEWORKS_FOUND_XZ_UTILS})


#################
###  LIBJPEG
#################
set(CONAN_LIBJPEG_ROOT "C:/Users/RadTuna/.conan/data/libjpeg/9d/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_LIBJPEG "C:/Users/RadTuna/.conan/data/libjpeg/9d/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_LIBJPEG "C:/Users/RadTuna/.conan/data/libjpeg/9d/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_LIBJPEG )
set(CONAN_RES_DIRS_LIBJPEG "C:/Users/RadTuna/.conan/data/libjpeg/9d/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/res")
set(CONAN_SRC_DIRS_LIBJPEG )
set(CONAN_BUILD_DIRS_LIBJPEG "C:/Users/RadTuna/.conan/data/libjpeg/9d/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_LIBJPEG )
set(CONAN_LIBS_LIBJPEG libjpeg)
set(CONAN_PKG_LIBS_LIBJPEG libjpeg)
set(CONAN_SYSTEM_LIBS_LIBJPEG )
set(CONAN_FRAMEWORKS_LIBJPEG )
set(CONAN_FRAMEWORKS_FOUND_LIBJPEG "")  # Will be filled later
set(CONAN_DEFINES_LIBJPEG "-DLIBJPEG_STATIC")
set(CONAN_BUILD_MODULES_PATHS_LIBJPEG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBJPEG "LIBJPEG_STATIC")

set(CONAN_C_FLAGS_LIBJPEG "")
set(CONAN_CXX_FLAGS_LIBJPEG "")
set(CONAN_SHARED_LINKER_FLAGS_LIBJPEG "")
set(CONAN_EXE_LINKER_FLAGS_LIBJPEG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBJPEG_LIST "")
set(CONAN_CXX_FLAGS_LIBJPEG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBJPEG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBJPEG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBJPEG "${CONAN_FRAMEWORKS_LIBJPEG}" "_LIBJPEG" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBJPEG ${CONAN_PKG_LIBS_LIBJPEG} ${CONAN_SYSTEM_LIBS_LIBJPEG} ${CONAN_FRAMEWORKS_FOUND_LIBJPEG})


#################
###  JBIG
#################
set(CONAN_JBIG_ROOT "C:/Users/RadTuna/.conan/data/jbig/20160605/_/_/package/1c06f8aa5b65435590877732bd94377a1ed95260")
set(CONAN_INCLUDE_DIRS_JBIG "C:/Users/RadTuna/.conan/data/jbig/20160605/_/_/package/1c06f8aa5b65435590877732bd94377a1ed95260/include")
set(CONAN_LIB_DIRS_JBIG "C:/Users/RadTuna/.conan/data/jbig/20160605/_/_/package/1c06f8aa5b65435590877732bd94377a1ed95260/lib")
set(CONAN_BIN_DIRS_JBIG "C:/Users/RadTuna/.conan/data/jbig/20160605/_/_/package/1c06f8aa5b65435590877732bd94377a1ed95260/bin")
set(CONAN_RES_DIRS_JBIG )
set(CONAN_SRC_DIRS_JBIG )
set(CONAN_BUILD_DIRS_JBIG "C:/Users/RadTuna/.conan/data/jbig/20160605/_/_/package/1c06f8aa5b65435590877732bd94377a1ed95260/")
set(CONAN_FRAMEWORK_DIRS_JBIG )
set(CONAN_LIBS_JBIG jbig)
set(CONAN_PKG_LIBS_JBIG jbig)
set(CONAN_SYSTEM_LIBS_JBIG )
set(CONAN_FRAMEWORKS_JBIG )
set(CONAN_FRAMEWORKS_FOUND_JBIG "")  # Will be filled later
set(CONAN_DEFINES_JBIG )
set(CONAN_BUILD_MODULES_PATHS_JBIG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_JBIG )

set(CONAN_C_FLAGS_JBIG "")
set(CONAN_CXX_FLAGS_JBIG "")
set(CONAN_SHARED_LINKER_FLAGS_JBIG "")
set(CONAN_EXE_LINKER_FLAGS_JBIG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_JBIG_LIST "")
set(CONAN_CXX_FLAGS_JBIG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_JBIG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_JBIG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_JBIG "${CONAN_FRAMEWORKS_JBIG}" "_JBIG" "")
# Append to aggregated values variable
set(CONAN_LIBS_JBIG ${CONAN_PKG_LIBS_JBIG} ${CONAN_SYSTEM_LIBS_JBIG} ${CONAN_FRAMEWORKS_FOUND_JBIG})


#################
###  ZSTD
#################
set(CONAN_ZSTD_ROOT "C:/Users/RadTuna/.conan/data/zstd/1.5.0/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_ZSTD "C:/Users/RadTuna/.conan/data/zstd/1.5.0/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_ZSTD "C:/Users/RadTuna/.conan/data/zstd/1.5.0/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_ZSTD )
set(CONAN_RES_DIRS_ZSTD )
set(CONAN_SRC_DIRS_ZSTD )
set(CONAN_BUILD_DIRS_ZSTD "C:/Users/RadTuna/.conan/data/zstd/1.5.0/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_ZSTD )
set(CONAN_LIBS_ZSTD zstd_static)
set(CONAN_PKG_LIBS_ZSTD zstd_static)
set(CONAN_SYSTEM_LIBS_ZSTD )
set(CONAN_FRAMEWORKS_ZSTD )
set(CONAN_FRAMEWORKS_FOUND_ZSTD "")  # Will be filled later
set(CONAN_DEFINES_ZSTD )
set(CONAN_BUILD_MODULES_PATHS_ZSTD )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_ZSTD )

set(CONAN_C_FLAGS_ZSTD "")
set(CONAN_CXX_FLAGS_ZSTD "")
set(CONAN_SHARED_LINKER_FLAGS_ZSTD "")
set(CONAN_EXE_LINKER_FLAGS_ZSTD "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_ZSTD_LIST "")
set(CONAN_CXX_FLAGS_ZSTD_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_ZSTD_LIST "")
set(CONAN_EXE_LINKER_FLAGS_ZSTD_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_ZSTD "${CONAN_FRAMEWORKS_ZSTD}" "_ZSTD" "")
# Append to aggregated values variable
set(CONAN_LIBS_ZSTD ${CONAN_PKG_LIBS_ZSTD} ${CONAN_SYSTEM_LIBS_ZSTD} ${CONAN_FRAMEWORKS_FOUND_ZSTD})


#################
###  LIBWEBP
#################
set(CONAN_LIBWEBP_ROOT "C:/Users/RadTuna/.conan/data/libwebp/1.1.0/_/_/package/638042d3fd356128c913f5e725646a0c2af264c7")
set(CONAN_INCLUDE_DIRS_LIBWEBP "C:/Users/RadTuna/.conan/data/libwebp/1.1.0/_/_/package/638042d3fd356128c913f5e725646a0c2af264c7/include")
set(CONAN_LIB_DIRS_LIBWEBP "C:/Users/RadTuna/.conan/data/libwebp/1.1.0/_/_/package/638042d3fd356128c913f5e725646a0c2af264c7/lib")
set(CONAN_BIN_DIRS_LIBWEBP )
set(CONAN_RES_DIRS_LIBWEBP )
set(CONAN_SRC_DIRS_LIBWEBP )
set(CONAN_BUILD_DIRS_LIBWEBP "C:/Users/RadTuna/.conan/data/libwebp/1.1.0/_/_/package/638042d3fd356128c913f5e725646a0c2af264c7/")
set(CONAN_FRAMEWORK_DIRS_LIBWEBP )
set(CONAN_LIBS_LIBWEBP webpdecoder webpdemux webpmux webp)
set(CONAN_PKG_LIBS_LIBWEBP webpdecoder webpdemux webpmux webp)
set(CONAN_SYSTEM_LIBS_LIBWEBP )
set(CONAN_FRAMEWORKS_LIBWEBP )
set(CONAN_FRAMEWORKS_FOUND_LIBWEBP "")  # Will be filled later
set(CONAN_DEFINES_LIBWEBP )
set(CONAN_BUILD_MODULES_PATHS_LIBWEBP )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBWEBP )

set(CONAN_C_FLAGS_LIBWEBP "")
set(CONAN_CXX_FLAGS_LIBWEBP "")
set(CONAN_SHARED_LINKER_FLAGS_LIBWEBP "")
set(CONAN_EXE_LINKER_FLAGS_LIBWEBP "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBWEBP_LIST "")
set(CONAN_CXX_FLAGS_LIBWEBP_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBWEBP_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBWEBP_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBWEBP "${CONAN_FRAMEWORKS_LIBWEBP}" "_LIBWEBP" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBWEBP ${CONAN_PKG_LIBS_LIBWEBP} ${CONAN_SYSTEM_LIBS_LIBWEBP} ${CONAN_FRAMEWORKS_FOUND_LIBWEBP})


#################
###  BZIP2
#################
set(CONAN_BZIP2_ROOT "C:/Users/RadTuna/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5")
set(CONAN_INCLUDE_DIRS_BZIP2 "C:/Users/RadTuna/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/include")
set(CONAN_LIB_DIRS_BZIP2 "C:/Users/RadTuna/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/lib")
set(CONAN_BIN_DIRS_BZIP2 "C:/Users/RadTuna/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/bin")
set(CONAN_RES_DIRS_BZIP2 )
set(CONAN_SRC_DIRS_BZIP2 )
set(CONAN_BUILD_DIRS_BZIP2 "C:/Users/RadTuna/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/"
			"C:/Users/RadTuna/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/lib/cmake")
set(CONAN_FRAMEWORK_DIRS_BZIP2 )
set(CONAN_LIBS_BZIP2 bz2)
set(CONAN_PKG_LIBS_BZIP2 bz2)
set(CONAN_SYSTEM_LIBS_BZIP2 )
set(CONAN_FRAMEWORKS_BZIP2 )
set(CONAN_FRAMEWORKS_FOUND_BZIP2 "")  # Will be filled later
set(CONAN_DEFINES_BZIP2 )
set(CONAN_BUILD_MODULES_PATHS_BZIP2 )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BZIP2 )

set(CONAN_C_FLAGS_BZIP2 "")
set(CONAN_CXX_FLAGS_BZIP2 "")
set(CONAN_SHARED_LINKER_FLAGS_BZIP2 "")
set(CONAN_EXE_LINKER_FLAGS_BZIP2 "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BZIP2_LIST "")
set(CONAN_CXX_FLAGS_BZIP2_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BZIP2_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BZIP2 "${CONAN_FRAMEWORKS_BZIP2}" "_BZIP2" "")
# Append to aggregated values variable
set(CONAN_LIBS_BZIP2 ${CONAN_PKG_LIBS_BZIP2} ${CONAN_SYSTEM_LIBS_BZIP2} ${CONAN_FRAMEWORKS_FOUND_BZIP2})


#################
###  LIBPNG
#################
set(CONAN_LIBPNG_ROOT "C:/Users/RadTuna/.conan/data/libpng/1.6.37/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63")
set(CONAN_INCLUDE_DIRS_LIBPNG "C:/Users/RadTuna/.conan/data/libpng/1.6.37/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/include")
set(CONAN_LIB_DIRS_LIBPNG "C:/Users/RadTuna/.conan/data/libpng/1.6.37/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/lib")
set(CONAN_BIN_DIRS_LIBPNG )
set(CONAN_RES_DIRS_LIBPNG )
set(CONAN_SRC_DIRS_LIBPNG )
set(CONAN_BUILD_DIRS_LIBPNG "C:/Users/RadTuna/.conan/data/libpng/1.6.37/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/")
set(CONAN_FRAMEWORK_DIRS_LIBPNG )
set(CONAN_LIBS_LIBPNG libpng16)
set(CONAN_PKG_LIBS_LIBPNG libpng16)
set(CONAN_SYSTEM_LIBS_LIBPNG )
set(CONAN_FRAMEWORKS_LIBPNG )
set(CONAN_FRAMEWORKS_FOUND_LIBPNG "")  # Will be filled later
set(CONAN_DEFINES_LIBPNG )
set(CONAN_BUILD_MODULES_PATHS_LIBPNG )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LIBPNG )

set(CONAN_C_FLAGS_LIBPNG "")
set(CONAN_CXX_FLAGS_LIBPNG "")
set(CONAN_SHARED_LINKER_FLAGS_LIBPNG "")
set(CONAN_EXE_LINKER_FLAGS_LIBPNG "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LIBPNG_LIST "")
set(CONAN_CXX_FLAGS_LIBPNG_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LIBPNG_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LIBPNG_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LIBPNG "${CONAN_FRAMEWORKS_LIBPNG}" "_LIBPNG" "")
# Append to aggregated values variable
set(CONAN_LIBS_LIBPNG ${CONAN_PKG_LIBS_LIBPNG} ${CONAN_SYSTEM_LIBS_LIBPNG} ${CONAN_FRAMEWORKS_FOUND_LIBPNG})


#################
###  BROTLI
#################
set(CONAN_BROTLI_ROOT "C:/Users/RadTuna/.conan/data/brotli/1.0.9/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_BROTLI "C:/Users/RadTuna/.conan/data/brotli/1.0.9/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/brotli/1.0.9/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include/brotli")
set(CONAN_LIB_DIRS_BROTLI "C:/Users/RadTuna/.conan/data/brotli/1.0.9/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_BROTLI )
set(CONAN_RES_DIRS_BROTLI )
set(CONAN_SRC_DIRS_BROTLI )
set(CONAN_BUILD_DIRS_BROTLI "C:/Users/RadTuna/.conan/data/brotli/1.0.9/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_BROTLI )
set(CONAN_LIBS_BROTLI brotlidec-static brotlienc-static brotlicommon-static)
set(CONAN_PKG_LIBS_BROTLI brotlidec-static brotlienc-static brotlicommon-static)
set(CONAN_SYSTEM_LIBS_BROTLI )
set(CONAN_FRAMEWORKS_BROTLI )
set(CONAN_FRAMEWORKS_FOUND_BROTLI "")  # Will be filled later
set(CONAN_DEFINES_BROTLI )
set(CONAN_BUILD_MODULES_PATHS_BROTLI )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_BROTLI )

set(CONAN_C_FLAGS_BROTLI "")
set(CONAN_CXX_FLAGS_BROTLI "")
set(CONAN_SHARED_LINKER_FLAGS_BROTLI "")
set(CONAN_EXE_LINKER_FLAGS_BROTLI "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_BROTLI_LIST "")
set(CONAN_CXX_FLAGS_BROTLI_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_BROTLI_LIST "")
set(CONAN_EXE_LINKER_FLAGS_BROTLI_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_BROTLI "${CONAN_FRAMEWORKS_BROTLI}" "_BROTLI" "")
# Append to aggregated values variable
set(CONAN_LIBS_BROTLI ${CONAN_PKG_LIBS_BROTLI} ${CONAN_SYSTEM_LIBS_BROTLI} ${CONAN_FRAMEWORKS_FOUND_BROTLI})


#################
###  LCMS
#################
set(CONAN_LCMS_ROOT "C:/Users/RadTuna/.conan/data/lcms/2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_LCMS "C:/Users/RadTuna/.conan/data/lcms/2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_LCMS "C:/Users/RadTuna/.conan/data/lcms/2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_LCMS )
set(CONAN_RES_DIRS_LCMS )
set(CONAN_SRC_DIRS_LCMS )
set(CONAN_BUILD_DIRS_LCMS "C:/Users/RadTuna/.conan/data/lcms/2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_LCMS )
set(CONAN_LIBS_LCMS lcms2_static)
set(CONAN_PKG_LIBS_LCMS lcms2_static)
set(CONAN_SYSTEM_LIBS_LCMS )
set(CONAN_FRAMEWORKS_LCMS )
set(CONAN_FRAMEWORKS_FOUND_LCMS "")  # Will be filled later
set(CONAN_DEFINES_LCMS )
set(CONAN_BUILD_MODULES_PATHS_LCMS )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_LCMS )

set(CONAN_C_FLAGS_LCMS "")
set(CONAN_CXX_FLAGS_LCMS "")
set(CONAN_SHARED_LINKER_FLAGS_LCMS "")
set(CONAN_EXE_LINKER_FLAGS_LCMS "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_LCMS_LIST "")
set(CONAN_CXX_FLAGS_LCMS_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_LCMS_LIST "")
set(CONAN_EXE_LINKER_FLAGS_LCMS_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_LCMS "${CONAN_FRAMEWORKS_LCMS}" "_LCMS" "")
# Append to aggregated values variable
set(CONAN_LIBS_LCMS ${CONAN_PKG_LIBS_LCMS} ${CONAN_SYSTEM_LIBS_LCMS} ${CONAN_FRAMEWORKS_FOUND_LCMS})


#################
###  YAML-CPP
#################
set(CONAN_YAML-CPP_ROOT "C:/Users/RadTuna/.conan/data/yaml-cpp/0.6.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_YAML-CPP "C:/Users/RadTuna/.conan/data/yaml-cpp/0.6.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_YAML-CPP "C:/Users/RadTuna/.conan/data/yaml-cpp/0.6.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_YAML-CPP )
set(CONAN_RES_DIRS_YAML-CPP )
set(CONAN_SRC_DIRS_YAML-CPP )
set(CONAN_BUILD_DIRS_YAML-CPP "C:/Users/RadTuna/.conan/data/yaml-cpp/0.6.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_YAML-CPP )
set(CONAN_LIBS_YAML-CPP libyaml-cppmd)
set(CONAN_PKG_LIBS_YAML-CPP libyaml-cppmd)
set(CONAN_SYSTEM_LIBS_YAML-CPP )
set(CONAN_FRAMEWORKS_YAML-CPP )
set(CONAN_FRAMEWORKS_FOUND_YAML-CPP "")  # Will be filled later
set(CONAN_DEFINES_YAML-CPP "-D_NOEXCEPT=noexcept")
set(CONAN_BUILD_MODULES_PATHS_YAML-CPP )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_YAML-CPP "_NOEXCEPT=noexcept")

set(CONAN_C_FLAGS_YAML-CPP "")
set(CONAN_CXX_FLAGS_YAML-CPP "")
set(CONAN_SHARED_LINKER_FLAGS_YAML-CPP "")
set(CONAN_EXE_LINKER_FLAGS_YAML-CPP "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_YAML-CPP_LIST "")
set(CONAN_CXX_FLAGS_YAML-CPP_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_YAML-CPP_LIST "")
set(CONAN_EXE_LINKER_FLAGS_YAML-CPP_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_YAML-CPP "${CONAN_FRAMEWORKS_YAML-CPP}" "_YAML-CPP" "")
# Append to aggregated values variable
set(CONAN_LIBS_YAML-CPP ${CONAN_PKG_LIBS_YAML-CPP} ${CONAN_SYSTEM_LIBS_YAML-CPP} ${CONAN_FRAMEWORKS_FOUND_YAML-CPP})


#################
###  ZLIB
#################
set(CONAN_ZLIB_ROOT "C:/Users/RadTuna/.conan/data/zlib/1.2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab")
set(CONAN_INCLUDE_DIRS_ZLIB "C:/Users/RadTuna/.conan/data/zlib/1.2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include")
set(CONAN_LIB_DIRS_ZLIB "C:/Users/RadTuna/.conan/data/zlib/1.2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib")
set(CONAN_BIN_DIRS_ZLIB )
set(CONAN_RES_DIRS_ZLIB )
set(CONAN_SRC_DIRS_ZLIB )
set(CONAN_BUILD_DIRS_ZLIB "C:/Users/RadTuna/.conan/data/zlib/1.2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/")
set(CONAN_FRAMEWORK_DIRS_ZLIB )
set(CONAN_LIBS_ZLIB zlib)
set(CONAN_PKG_LIBS_ZLIB zlib)
set(CONAN_SYSTEM_LIBS_ZLIB )
set(CONAN_FRAMEWORKS_ZLIB )
set(CONAN_FRAMEWORKS_FOUND_ZLIB "")  # Will be filled later
set(CONAN_DEFINES_ZLIB )
set(CONAN_BUILD_MODULES_PATHS_ZLIB )
# COMPILE_DEFINITIONS are equal to CONAN_DEFINES without -D, for targets
set(CONAN_COMPILE_DEFINITIONS_ZLIB )

set(CONAN_C_FLAGS_ZLIB "")
set(CONAN_CXX_FLAGS_ZLIB "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB "")

# For modern cmake targets we use the list variables (separated with ;)
set(CONAN_C_FLAGS_ZLIB_LIST "")
set(CONAN_CXX_FLAGS_ZLIB_LIST "")
set(CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST "")
set(CONAN_EXE_LINKER_FLAGS_ZLIB_LIST "")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND_ZLIB "${CONAN_FRAMEWORKS_ZLIB}" "_ZLIB" "")
# Append to aggregated values variable
set(CONAN_LIBS_ZLIB ${CONAN_PKG_LIBS_ZLIB} ${CONAN_SYSTEM_LIBS_ZLIB} ${CONAN_FRAMEWORKS_FOUND_ZLIB})


### Definition of global aggregated variables ###

set(CONAN_PACKAGE_NAME None)
set(CONAN_PACKAGE_VERSION None)

set(CONAN_SETTINGS_ARCH "x86_64")
set(CONAN_SETTINGS_ARCH_BUILD "x86_64")
set(CONAN_SETTINGS_BUILD_TYPE "Release")
set(CONAN_SETTINGS_COMPILER "Visual Studio")
set(CONAN_SETTINGS_COMPILER_RUNTIME "MD")
set(CONAN_SETTINGS_COMPILER_VERSION "16")
set(CONAN_SETTINGS_OS "Windows")
set(CONAN_SETTINGS_OS_BUILD "Windows")

set(CONAN_DEPENDENCIES imgui glm glfw openimageio assimp opengl openexr libtiff fmt boost tsl-robin-map pugixml libsquish openjpeg giflib freetype opencolorio irrxml minizip utfcpp kuba-zip poly2tri rapidjson xz_utils libjpeg jbig zstd libwebp bzip2 libpng brotli lcms yaml-cpp zlib)
# Storing original command line args (CMake helper) flags
set(CONAN_CMD_CXX_FLAGS ${CONAN_CXX_FLAGS})

set(CONAN_CMD_SHARED_LINKER_FLAGS ${CONAN_SHARED_LINKER_FLAGS})
set(CONAN_CMD_C_FLAGS ${CONAN_C_FLAGS})
# Defining accumulated conan variables for all deps

set(CONAN_INCLUDE_DIRS "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/RadTuna/.conan/data/glfw/3.3.4/_/_/package/d3cffeefc8c8bcb6be8abdd182cb1b56fc81bacc/include"
			"C:/.conan/a7a939/1/include"
			"C:/Users/RadTuna/.conan/data/assimp/5.0.1/_/_/package/f58d7797d1bf95ea392fb61c670aab283acdc2e4/include"
			"C:/Users/RadTuna/.conan/data/openexr/2.5.2/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/include/OpenEXR"
			"C:/Users/RadTuna/.conan/data/openexr/2.5.2/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/include"
			"C:/Users/RadTuna/.conan/data/libtiff/4.1.0/_/_/package/6916df94fb880f178c7cb69b9dfd0faa0815a236/include"
			"C:/Users/RadTuna/.conan/data/fmt/7.0.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/.conan/f87a86/1/include"
			"C:/Users/RadTuna/.conan/data/tsl-robin-map/0.6.3/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/RadTuna/.conan/data/pugixml/1.10/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/libsquish/1.15/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/openjpeg/2.3.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/openjpeg/2.3.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include/openjpeg-2.3"
			"C:/Users/RadTuna/.conan/data/giflib/5.2.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include"
			"C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/include/freetype2"
			"C:/Users/RadTuna/.conan/data/opencolorio/1.1.1/_/_/package/a7d7488418cb3d62b4c5dc93873b6cb6d0a14be8/include"
			"C:/Users/RadTuna/.conan/data/irrxml/1.2/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/minizip/1.2.11/_/_/package/153ff990bb7a331b443365f9878a3991adbdea9d/include"
			"C:/Users/RadTuna/.conan/data/minizip/1.2.11/_/_/package/153ff990bb7a331b443365f9878a3991adbdea9d/include/minizip"
			"C:/Users/RadTuna/.conan/data/utfcpp/3.1.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/RadTuna/.conan/data/utfcpp/3.1.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include/utf8cpp"
			"C:/Users/RadTuna/.conan/data/kuba-zip/0.1.31/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/poly2tri/cci.20130502/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/rapidjson/cci.20200410/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/include"
			"C:/Users/RadTuna/.conan/data/xz_utils/5.2.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/libjpeg/9d/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/jbig/20160605/_/_/package/1c06f8aa5b65435590877732bd94377a1ed95260/include"
			"C:/Users/RadTuna/.conan/data/zstd/1.5.0/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/libwebp/1.1.0/_/_/package/638042d3fd356128c913f5e725646a0c2af264c7/include"
			"C:/Users/RadTuna/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/include"
			"C:/Users/RadTuna/.conan/data/libpng/1.6.37/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/include"
			"C:/Users/RadTuna/.conan/data/brotli/1.0.9/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/brotli/1.0.9/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include/brotli"
			"C:/Users/RadTuna/.conan/data/lcms/2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/yaml-cpp/0.6.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include"
			"C:/Users/RadTuna/.conan/data/zlib/1.2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/include" ${CONAN_INCLUDE_DIRS})
set(CONAN_LIB_DIRS "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/glfw/3.3.4/_/_/package/d3cffeefc8c8bcb6be8abdd182cb1b56fc81bacc/lib"
			"C:/.conan/a7a939/1/lib"
			"C:/Users/RadTuna/.conan/data/assimp/5.0.1/_/_/package/f58d7797d1bf95ea392fb61c670aab283acdc2e4/lib"
			"C:/Users/RadTuna/.conan/data/openexr/2.5.2/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/lib"
			"C:/Users/RadTuna/.conan/data/libtiff/4.1.0/_/_/package/6916df94fb880f178c7cb69b9dfd0faa0815a236/lib"
			"C:/Users/RadTuna/.conan/data/fmt/7.0.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/.conan/f87a86/1/lib"
			"C:/Users/RadTuna/.conan/data/pugixml/1.10/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/libsquish/1.15/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/openjpeg/2.3.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/giflib/5.2.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib"
			"C:/Users/RadTuna/.conan/data/opencolorio/1.1.1/_/_/package/a7d7488418cb3d62b4c5dc93873b6cb6d0a14be8/lib"
			"C:/Users/RadTuna/.conan/data/irrxml/1.2/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/minizip/1.2.11/_/_/package/153ff990bb7a331b443365f9878a3991adbdea9d/lib"
			"C:/Users/RadTuna/.conan/data/utfcpp/3.1.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib"
			"C:/Users/RadTuna/.conan/data/kuba-zip/0.1.31/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/poly2tri/cci.20130502/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/xz_utils/5.2.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/libjpeg/9d/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/jbig/20160605/_/_/package/1c06f8aa5b65435590877732bd94377a1ed95260/lib"
			"C:/Users/RadTuna/.conan/data/zstd/1.5.0/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/libwebp/1.1.0/_/_/package/638042d3fd356128c913f5e725646a0c2af264c7/lib"
			"C:/Users/RadTuna/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/lib"
			"C:/Users/RadTuna/.conan/data/libpng/1.6.37/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/lib"
			"C:/Users/RadTuna/.conan/data/brotli/1.0.9/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/lcms/2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/yaml-cpp/0.6.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib"
			"C:/Users/RadTuna/.conan/data/zlib/1.2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib" ${CONAN_LIB_DIRS})
set(CONAN_BIN_DIRS "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/bin"
			"C:/.conan/a7a939/1/bin"
			"C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/bin"
			"C:/Users/RadTuna/.conan/data/opencolorio/1.1.1/_/_/package/a7d7488418cb3d62b4c5dc93873b6cb6d0a14be8/bin"
			"C:/Users/RadTuna/.conan/data/jbig/20160605/_/_/package/1c06f8aa5b65435590877732bd94377a1ed95260/bin"
			"C:/Users/RadTuna/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/bin" ${CONAN_BIN_DIRS})
set(CONAN_RES_DIRS "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/res"
			"C:/Users/RadTuna/.conan/data/libjpeg/9d/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/res" ${CONAN_RES_DIRS})
set(CONAN_FRAMEWORK_DIRS  ${CONAN_FRAMEWORK_DIRS})
set(CONAN_LIBS imgui glfw3 OpenImageIO OpenImageIO_Util assimp-vc142-mt IlmImf-2_5 IlmImfUtil-2_5 IlmThread-2_5 Imath-2_5 Half-2_5 IexMath-2_5 Iex-2_5 tiffxx tiff fmt libboost_contract libboost_coroutine libboost_fiber libboost_context libboost_graph libboost_iostreams libboost_log_setup libboost_log libboost_locale libboost_math_c99 libboost_math_c99f libboost_math_c99l libboost_math_tr1 libboost_math_tr1f libboost_math_tr1l libboost_nowide libboost_program_options libboost_random libboost_regex libboost_stacktrace_noop libboost_stacktrace_windbg libboost_stacktrace_windbg_cached libboost_timer libboost_type_erasure libboost_thread libboost_atomic libboost_chrono libboost_container libboost_date_time libboost_unit_test_framework libboost_prg_exec_monitor libboost_test_exec_monitor libboost_exception libboost_wave libboost_filesystem libboost_system libboost_wserialization libboost_serialization pugixml squish openjp2 gif freetype OpenColorIO IrrXML minizip zip poly2tri lzma libjpeg jbig zstd_static webpdecoder webpdemux webpmux webp bz2 libpng16 brotlidec-static brotlienc-static brotlicommon-static lcms2_static libyaml-cppmd zlib ${CONAN_LIBS})
set(CONAN_PKG_LIBS imgui glfw3 OpenImageIO OpenImageIO_Util assimp-vc142-mt IlmImf-2_5 IlmImfUtil-2_5 IlmThread-2_5 Imath-2_5 Half-2_5 IexMath-2_5 Iex-2_5 tiffxx tiff fmt libboost_contract libboost_coroutine libboost_fiber libboost_context libboost_graph libboost_iostreams libboost_log_setup libboost_log libboost_locale libboost_math_c99 libboost_math_c99f libboost_math_c99l libboost_math_tr1 libboost_math_tr1f libboost_math_tr1l libboost_nowide libboost_program_options libboost_random libboost_regex libboost_stacktrace_noop libboost_stacktrace_windbg libboost_stacktrace_windbg_cached libboost_timer libboost_type_erasure libboost_thread libboost_atomic libboost_chrono libboost_container libboost_date_time libboost_unit_test_framework libboost_prg_exec_monitor libboost_test_exec_monitor libboost_exception libboost_wave libboost_filesystem libboost_system libboost_wserialization libboost_serialization pugixml squish openjp2 gif freetype OpenColorIO IrrXML minizip zip poly2tri lzma libjpeg jbig zstd_static webpdecoder webpdemux webpmux webp bz2 libpng16 brotlidec-static brotlienc-static brotlicommon-static lcms2_static libyaml-cppmd zlib ${CONAN_PKG_LIBS})
set(CONAN_SYSTEM_LIBS gdi32 opengl32 bcrypt ole32 dbgeng ${CONAN_SYSTEM_LIBS})
set(CONAN_FRAMEWORKS  ${CONAN_FRAMEWORKS})
set(CONAN_FRAMEWORKS_FOUND "")  # Will be filled later
set(CONAN_DEFINES "-D_NOEXCEPT=noexcept"
			"-DLIBJPEG_STATIC"
			"-DLZMA_API_STATIC"
			"-DHAVE_BZIP2"
			"-DOpenColorIO_STATIC"
			"-DUSE_GIF_LIB"
			"-DOPJ_STATIC"
			"-DBOOST_STACKTRACE_USE_NOOP"
			"-DBOOST_ALL_NO_LIB"
			"-DBOOST_STACKTRACE_USE_WINDBG"
			"-DBOOST_STACKTRACE_USE_WINDBG_CACHED"
			"-DOIIO_STATIC_DEFINE" ${CONAN_DEFINES})
set(CONAN_BUILD_MODULES_PATHS "C:/Users/RadTuna/.conan/data/glfw/3.3.4/_/_/package/d3cffeefc8c8bcb6be8abdd182cb1b56fc81bacc/lib/cmake/conan-official-glfw-targets.cmake" ${CONAN_BUILD_MODULES_PATHS})
set(CONAN_CMAKE_MODULE_PATH "C:/Users/RadTuna/.conan/data/imgui/1.83/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/glm/0.9.9.8/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/RadTuna/.conan/data/glfw/3.3.4/_/_/package/d3cffeefc8c8bcb6be8abdd182cb1b56fc81bacc/"
			"C:/Users/RadTuna/.conan/data/glfw/3.3.4/_/_/package/d3cffeefc8c8bcb6be8abdd182cb1b56fc81bacc/lib/cmake"
			"C:/.conan/a7a939/1/"
			"C:/Users/RadTuna/.conan/data/assimp/5.0.1/_/_/package/f58d7797d1bf95ea392fb61c670aab283acdc2e4/"
			"C:/Users/RadTuna/.conan/data/opengl/system/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/RadTuna/.conan/data/openexr/2.5.2/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/"
			"C:/Users/RadTuna/.conan/data/libtiff/4.1.0/_/_/package/6916df94fb880f178c7cb69b9dfd0faa0815a236/"
			"C:/Users/RadTuna/.conan/data/fmt/7.0.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/.conan/f87a86/1/"
			"C:/Users/RadTuna/.conan/data/tsl-robin-map/0.6.3/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/RadTuna/.conan/data/pugixml/1.10/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/libsquish/1.15/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/openjpeg/2.3.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/openjpeg/2.3.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib/cmake"
			"C:/Users/RadTuna/.conan/data/giflib/5.2.1/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/"
			"C:/Users/RadTuna/.conan/data/freetype/2.10.2/_/_/package/27b2733304cef577b19f699fec3a5bdbefb36d16/lib/cmake"
			"C:/Users/RadTuna/.conan/data/opencolorio/1.1.1/_/_/package/a7d7488418cb3d62b4c5dc93873b6cb6d0a14be8/"
			"C:/Users/RadTuna/.conan/data/irrxml/1.2/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/minizip/1.2.11/_/_/package/153ff990bb7a331b443365f9878a3991adbdea9d/"
			"C:/Users/RadTuna/.conan/data/utfcpp/3.1.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/RadTuna/.conan/data/utfcpp/3.1.2/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/lib/cmake"
			"C:/Users/RadTuna/.conan/data/kuba-zip/0.1.31/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/poly2tri/cci.20130502/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/rapidjson/cci.20200410/_/_/package/5ab84d6acfe1f23c4fae0ab88f26e3a396351ac9/"
			"C:/Users/RadTuna/.conan/data/xz_utils/5.2.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/xz_utils/5.2.5/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/lib/cmake"
			"C:/Users/RadTuna/.conan/data/libjpeg/9d/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/jbig/20160605/_/_/package/1c06f8aa5b65435590877732bd94377a1ed95260/"
			"C:/Users/RadTuna/.conan/data/zstd/1.5.0/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/libwebp/1.1.0/_/_/package/638042d3fd356128c913f5e725646a0c2af264c7/"
			"C:/Users/RadTuna/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/"
			"C:/Users/RadTuna/.conan/data/bzip2/1.0.8/_/_/package/d16a91eadaaf5829b928b12d2f836ff7680d3df5/lib/cmake"
			"C:/Users/RadTuna/.conan/data/libpng/1.6.37/_/_/package/d140711d95cc16a85766a8fc3a551dfafe84cf63/"
			"C:/Users/RadTuna/.conan/data/brotli/1.0.9/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/lcms/2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/yaml-cpp/0.6.3/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/"
			"C:/Users/RadTuna/.conan/data/zlib/1.2.11/_/_/package/3fb49604f9c2f729b85ba3115852006824e72cab/" ${CONAN_CMAKE_MODULE_PATH})

set(CONAN_CXX_FLAGS " ${CONAN_CXX_FLAGS}")
set(CONAN_SHARED_LINKER_FLAGS " ${CONAN_SHARED_LINKER_FLAGS}")
set(CONAN_EXE_LINKER_FLAGS " ${CONAN_EXE_LINKER_FLAGS}")
set(CONAN_C_FLAGS " ${CONAN_C_FLAGS}")

# Apple Frameworks
conan_find_apple_frameworks(CONAN_FRAMEWORKS_FOUND "${CONAN_FRAMEWORKS}" "" "")
# Append to aggregated values variable: Use CONAN_LIBS instead of CONAN_PKG_LIBS to include user appended vars
set(CONAN_LIBS ${CONAN_LIBS} ${CONAN_SYSTEM_LIBS} ${CONAN_FRAMEWORKS_FOUND})


###  Definition of macros and functions ###

macro(conan_define_targets)
    if(${CMAKE_VERSION} VERSION_LESS "3.1.2")
        message(FATAL_ERROR "TARGETS not supported by your CMake version!")
    endif()  # CMAKE > 3.x
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CONAN_CMD_CXX_FLAGS}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CONAN_CMD_C_FLAGS}")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${CONAN_CMD_SHARED_LINKER_FLAGS}")


    set(_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES "${CONAN_SYSTEM_LIBS_IMGUI} ${CONAN_FRAMEWORKS_FOUND_IMGUI} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IMGUI_DEPENDENCIES "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IMGUI}" "${CONAN_LIB_DIRS_IMGUI}"
                                  CONAN_PACKAGE_TARGETS_IMGUI "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES}"
                                  "" imgui)
    set(_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_IMGUI_DEBUG} ${CONAN_FRAMEWORKS_FOUND_IMGUI_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IMGUI_DEBUG}" "${CONAN_LIB_DIRS_IMGUI_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_IMGUI_DEBUG "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_DEBUG}"
                                  "debug" imgui)
    set(_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_IMGUI_RELEASE} ${CONAN_FRAMEWORKS_FOUND_IMGUI_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IMGUI_RELEASE}" "${CONAN_LIB_DIRS_IMGUI_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_IMGUI_RELEASE "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELEASE}"
                                  "release" imgui)
    set(_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_IMGUI_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_IMGUI_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IMGUI_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_IMGUI_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_IMGUI_RELWITHDEBINFO "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" imgui)
    set(_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_IMGUI_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_IMGUI_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IMGUI_MINSIZEREL}" "${CONAN_LIB_DIRS_IMGUI_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_IMGUI_MINSIZEREL "${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" imgui)

    add_library(CONAN_PKG::imgui INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::imgui PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_IMGUI} ${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IMGUI_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_IMGUI_RELEASE} ${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IMGUI_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_IMGUI_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IMGUI_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_IMGUI_MINSIZEREL} ${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IMGUI_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_IMGUI_DEBUG} ${_CONAN_PKG_LIBS_IMGUI_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IMGUI_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IMGUI_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::imgui PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_IMGUI}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_IMGUI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_IMGUI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_IMGUI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_IMGUI_DEBUG}>)
    set_property(TARGET CONAN_PKG::imgui PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_IMGUI}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_IMGUI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_IMGUI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_IMGUI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_IMGUI_DEBUG}>)
    set_property(TARGET CONAN_PKG::imgui PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_IMGUI_LIST} ${CONAN_CXX_FLAGS_IMGUI_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_IMGUI_RELEASE_LIST} ${CONAN_CXX_FLAGS_IMGUI_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_IMGUI_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_IMGUI_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_IMGUI_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_IMGUI_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_IMGUI_DEBUG_LIST}  ${CONAN_CXX_FLAGS_IMGUI_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES "${CONAN_SYSTEM_LIBS_GLM} ${CONAN_FRAMEWORKS_FOUND_GLM} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM}" "${CONAN_LIB_DIRS_GLM}"
                                  CONAN_PACKAGE_TARGETS_GLM "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES}"
                                  "" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_GLM_DEBUG} ${CONAN_FRAMEWORKS_FOUND_GLM_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_DEBUG}" "${CONAN_LIB_DIRS_GLM_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_GLM_DEBUG "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG}"
                                  "debug" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_GLM_RELEASE} ${CONAN_FRAMEWORKS_FOUND_GLM_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_RELEASE}" "${CONAN_LIB_DIRS_GLM_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_GLM_RELEASE "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE}"
                                  "release" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_GLM_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_GLM_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_GLM_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_GLM_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" glm)
    set(_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_GLM_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_GLM_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLM_MINSIZEREL}" "${CONAN_LIB_DIRS_GLM_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_GLM_MINSIZEREL "${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" glm)

    add_library(CONAN_PKG::glm INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_GLM} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_GLM_RELEASE} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_GLM_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_GLM_MINSIZEREL} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_GLM_DEBUG} ${_CONAN_PKG_LIBS_GLM_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLM_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLM_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_GLM}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_GLM_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_GLM_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_GLM_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_GLM_DEBUG}>)
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_GLM}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_GLM_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_GLM_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_GLM_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_GLM_DEBUG}>)
    set_property(TARGET CONAN_PKG::glm PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_GLM_LIST} ${CONAN_CXX_FLAGS_GLM_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_GLM_RELEASE_LIST} ${CONAN_CXX_FLAGS_GLM_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_GLM_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_GLM_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_GLM_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_GLM_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_GLM_DEBUG_LIST}  ${CONAN_CXX_FLAGS_GLM_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_GLFW_DEPENDENCIES "${CONAN_SYSTEM_LIBS_GLFW} ${CONAN_FRAMEWORKS_FOUND_GLFW} CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLFW_DEPENDENCIES "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLFW}" "${CONAN_LIB_DIRS_GLFW}"
                                  CONAN_PACKAGE_TARGETS_GLFW "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES}"
                                  "" glfw)
    set(_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_GLFW_DEBUG} ${CONAN_FRAMEWORKS_FOUND_GLFW_DEBUG} CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLFW_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLFW_DEBUG}" "${CONAN_LIB_DIRS_GLFW_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_GLFW_DEBUG "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_DEBUG}"
                                  "debug" glfw)
    set(_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_GLFW_RELEASE} ${CONAN_FRAMEWORKS_FOUND_GLFW_RELEASE} CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLFW_RELEASE}" "${CONAN_LIB_DIRS_GLFW_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_GLFW_RELEASE "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELEASE}"
                                  "release" glfw)
    set(_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_GLFW_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_GLFW_RELWITHDEBINFO} CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLFW_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_GLFW_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_GLFW_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" glfw)
    set(_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_GLFW_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_GLFW_MINSIZEREL} CONAN_PKG::opengl")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GLFW_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GLFW_MINSIZEREL}" "${CONAN_LIB_DIRS_GLFW_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_GLFW_MINSIZEREL "${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" glfw)

    add_library(CONAN_PKG::glfw INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::glfw PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_GLFW} ${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLFW_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_GLFW_RELEASE} ${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLFW_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_GLFW_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLFW_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_GLFW_MINSIZEREL} ${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLFW_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_GLFW_DEBUG} ${_CONAN_PKG_LIBS_GLFW_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GLFW_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GLFW_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::glfw PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_GLFW}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_GLFW_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_GLFW_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_GLFW_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_GLFW_DEBUG}>)
    set_property(TARGET CONAN_PKG::glfw PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_GLFW}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_GLFW_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_GLFW_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_GLFW_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_GLFW_DEBUG}>)
    set_property(TARGET CONAN_PKG::glfw PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_GLFW_LIST} ${CONAN_CXX_FLAGS_GLFW_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_GLFW_RELEASE_LIST} ${CONAN_CXX_FLAGS_GLFW_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_GLFW_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_GLFW_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_GLFW_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_GLFW_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_GLFW_DEBUG_LIST}  ${CONAN_CXX_FLAGS_GLFW_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENIMAGEIO} ${CONAN_FRAMEWORKS_FOUND_OPENIMAGEIO} CONAN_PKG::openexr CONAN_PKG::libtiff CONAN_PKG::fmt CONAN_PKG::boost CONAN_PKG::tsl-robin-map CONAN_PKG::pugixml CONAN_PKG::libsquish CONAN_PKG::libpng CONAN_PKG::libwebp CONAN_PKG::openjpeg CONAN_PKG::giflib CONAN_PKG::freetype CONAN_PKG::opencolorio CONAN_PKG::libjpeg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENIMAGEIO}" "${CONAN_LIB_DIRS_OPENIMAGEIO}"
                                  CONAN_PACKAGE_TARGETS_OPENIMAGEIO "${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES}"
                                  "" openimageio)
    set(_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENIMAGEIO_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENIMAGEIO_DEBUG} CONAN_PKG::openexr CONAN_PKG::libtiff CONAN_PKG::fmt CONAN_PKG::boost CONAN_PKG::tsl-robin-map CONAN_PKG::pugixml CONAN_PKG::libsquish CONAN_PKG::libpng CONAN_PKG::libwebp CONAN_PKG::openjpeg CONAN_PKG::giflib CONAN_PKG::freetype CONAN_PKG::opencolorio CONAN_PKG::libjpeg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENIMAGEIO_DEBUG}" "${CONAN_LIB_DIRS_OPENIMAGEIO_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENIMAGEIO_DEBUG "${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_DEBUG}"
                                  "debug" openimageio)
    set(_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENIMAGEIO_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENIMAGEIO_RELEASE} CONAN_PKG::openexr CONAN_PKG::libtiff CONAN_PKG::fmt CONAN_PKG::boost CONAN_PKG::tsl-robin-map CONAN_PKG::pugixml CONAN_PKG::libsquish CONAN_PKG::libpng CONAN_PKG::libwebp CONAN_PKG::openjpeg CONAN_PKG::giflib CONAN_PKG::freetype CONAN_PKG::opencolorio CONAN_PKG::libjpeg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENIMAGEIO_RELEASE}" "${CONAN_LIB_DIRS_OPENIMAGEIO_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENIMAGEIO_RELEASE "${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_RELEASE}"
                                  "release" openimageio)
    set(_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENIMAGEIO_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENIMAGEIO_RELWITHDEBINFO} CONAN_PKG::openexr CONAN_PKG::libtiff CONAN_PKG::fmt CONAN_PKG::boost CONAN_PKG::tsl-robin-map CONAN_PKG::pugixml CONAN_PKG::libsquish CONAN_PKG::libpng CONAN_PKG::libwebp CONAN_PKG::openjpeg CONAN_PKG::giflib CONAN_PKG::freetype CONAN_PKG::opencolorio CONAN_PKG::libjpeg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENIMAGEIO_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENIMAGEIO_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENIMAGEIO_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" openimageio)
    set(_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENIMAGEIO_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENIMAGEIO_MINSIZEREL} CONAN_PKG::openexr CONAN_PKG::libtiff CONAN_PKG::fmt CONAN_PKG::boost CONAN_PKG::tsl-robin-map CONAN_PKG::pugixml CONAN_PKG::libsquish CONAN_PKG::libpng CONAN_PKG::libwebp CONAN_PKG::openjpeg CONAN_PKG::giflib CONAN_PKG::freetype CONAN_PKG::opencolorio CONAN_PKG::libjpeg")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENIMAGEIO_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENIMAGEIO_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENIMAGEIO_MINSIZEREL "${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" openimageio)

    add_library(CONAN_PKG::openimageio INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::openimageio PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENIMAGEIO} ${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENIMAGEIO_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENIMAGEIO_RELEASE} ${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENIMAGEIO_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENIMAGEIO_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENIMAGEIO_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENIMAGEIO_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENIMAGEIO_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENIMAGEIO_DEBUG} ${_CONAN_PKG_LIBS_OPENIMAGEIO_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENIMAGEIO_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENIMAGEIO_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::openimageio PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENIMAGEIO}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENIMAGEIO_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENIMAGEIO_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENIMAGEIO_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENIMAGEIO_DEBUG}>)
    set_property(TARGET CONAN_PKG::openimageio PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENIMAGEIO}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENIMAGEIO_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENIMAGEIO_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENIMAGEIO_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENIMAGEIO_DEBUG}>)
    set_property(TARGET CONAN_PKG::openimageio PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENIMAGEIO_LIST} ${CONAN_CXX_FLAGS_OPENIMAGEIO_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENIMAGEIO_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENIMAGEIO_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENIMAGEIO_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENIMAGEIO_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENIMAGEIO_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENIMAGEIO_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENIMAGEIO_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENIMAGEIO_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES "${CONAN_SYSTEM_LIBS_ASSIMP} ${CONAN_FRAMEWORKS_FOUND_ASSIMP} CONAN_PKG::irrxml CONAN_PKG::minizip CONAN_PKG::utfcpp CONAN_PKG::kuba-zip CONAN_PKG::poly2tri CONAN_PKG::rapidjson CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ASSIMP}" "${CONAN_LIB_DIRS_ASSIMP}"
                                  CONAN_PACKAGE_TARGETS_ASSIMP "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES}"
                                  "" assimp)
    set(_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_ASSIMP_DEBUG} ${CONAN_FRAMEWORKS_FOUND_ASSIMP_DEBUG} CONAN_PKG::irrxml CONAN_PKG::minizip CONAN_PKG::utfcpp CONAN_PKG::kuba-zip CONAN_PKG::poly2tri CONAN_PKG::rapidjson CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ASSIMP_DEBUG}" "${CONAN_LIB_DIRS_ASSIMP_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_ASSIMP_DEBUG "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_DEBUG}"
                                  "debug" assimp)
    set(_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_ASSIMP_RELEASE} ${CONAN_FRAMEWORKS_FOUND_ASSIMP_RELEASE} CONAN_PKG::irrxml CONAN_PKG::minizip CONAN_PKG::utfcpp CONAN_PKG::kuba-zip CONAN_PKG::poly2tri CONAN_PKG::rapidjson CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ASSIMP_RELEASE}" "${CONAN_LIB_DIRS_ASSIMP_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_ASSIMP_RELEASE "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELEASE}"
                                  "release" assimp)
    set(_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_ASSIMP_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_ASSIMP_RELWITHDEBINFO} CONAN_PKG::irrxml CONAN_PKG::minizip CONAN_PKG::utfcpp CONAN_PKG::kuba-zip CONAN_PKG::poly2tri CONAN_PKG::rapidjson CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ASSIMP_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_ASSIMP_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_ASSIMP_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" assimp)
    set(_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_ASSIMP_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_ASSIMP_MINSIZEREL} CONAN_PKG::irrxml CONAN_PKG::minizip CONAN_PKG::utfcpp CONAN_PKG::kuba-zip CONAN_PKG::poly2tri CONAN_PKG::rapidjson CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ASSIMP_MINSIZEREL}" "${CONAN_LIB_DIRS_ASSIMP_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_ASSIMP_MINSIZEREL "${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" assimp)

    add_library(CONAN_PKG::assimp INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::assimp PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_ASSIMP} ${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ASSIMP_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_ASSIMP_RELEASE} ${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ASSIMP_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_ASSIMP_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ASSIMP_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_ASSIMP_MINSIZEREL} ${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ASSIMP_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_ASSIMP_DEBUG} ${_CONAN_PKG_LIBS_ASSIMP_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ASSIMP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ASSIMP_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::assimp PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_ASSIMP}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_ASSIMP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_ASSIMP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_ASSIMP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_ASSIMP_DEBUG}>)
    set_property(TARGET CONAN_PKG::assimp PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_ASSIMP}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_ASSIMP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_ASSIMP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_ASSIMP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_ASSIMP_DEBUG}>)
    set_property(TARGET CONAN_PKG::assimp PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_ASSIMP_LIST} ${CONAN_CXX_FLAGS_ASSIMP_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_ASSIMP_RELEASE_LIST} ${CONAN_CXX_FLAGS_ASSIMP_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_ASSIMP_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_ASSIMP_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_ASSIMP_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_ASSIMP_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_ASSIMP_DEBUG_LIST}  ${CONAN_CXX_FLAGS_ASSIMP_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENGL} ${CONAN_FRAMEWORKS_FOUND_OPENGL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL}" "${CONAN_LIB_DIRS_OPENGL}"
                                  CONAN_PACKAGE_TARGETS_OPENGL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}"
                                  "" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENGL_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENGL_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_DEBUG}" "${CONAN_LIB_DIRS_OPENGL_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_DEBUG "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}"
                                  "debug" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENGL_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENGL_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_RELEASE}" "${CONAN_LIB_DIRS_OPENGL_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_RELEASE "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}"
                                  "release" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENGL_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENGL_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENGL_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" opengl)
    set(_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENGL_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENGL_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENGL_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENGL_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENGL_MINSIZEREL "${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" opengl)

    add_library(CONAN_PKG::opengl INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENGL} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENGL_RELEASE} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENGL_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENGL_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENGL_DEBUG} ${_CONAN_PKG_LIBS_OPENGL_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENGL_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENGL_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENGL}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENGL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENGL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENGL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENGL_DEBUG}>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENGL}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENGL_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENGL_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENGL_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENGL_DEBUG}>)
    set_property(TARGET CONAN_PKG::opengl PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENGL_LIST} ${CONAN_CXX_FLAGS_OPENGL_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENGL_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENGL_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENGL_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENGL_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENGL_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENGL_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENGL_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENGL_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENEXR} ${CONAN_FRAMEWORKS_FOUND_OPENEXR} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENEXR}" "${CONAN_LIB_DIRS_OPENEXR}"
                                  CONAN_PACKAGE_TARGETS_OPENEXR "${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES}"
                                  "" openexr)
    set(_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENEXR_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENEXR_DEBUG} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENEXR_DEBUG}" "${CONAN_LIB_DIRS_OPENEXR_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENEXR_DEBUG "${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_DEBUG}"
                                  "debug" openexr)
    set(_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENEXR_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENEXR_RELEASE} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENEXR_RELEASE}" "${CONAN_LIB_DIRS_OPENEXR_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENEXR_RELEASE "${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_RELEASE}"
                                  "release" openexr)
    set(_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENEXR_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENEXR_RELWITHDEBINFO} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENEXR_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENEXR_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENEXR_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" openexr)
    set(_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENEXR_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENEXR_MINSIZEREL} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENEXR_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENEXR_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENEXR_MINSIZEREL "${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" openexr)

    add_library(CONAN_PKG::openexr INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::openexr PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENEXR} ${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENEXR_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENEXR_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENEXR_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENEXR_RELEASE} ${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENEXR_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENEXR_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENEXR_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENEXR_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENEXR_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENEXR_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENEXR_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENEXR_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENEXR_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENEXR_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENEXR_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENEXR_DEBUG} ${_CONAN_PKG_LIBS_OPENEXR_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENEXR_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENEXR_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENEXR_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::openexr PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENEXR}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENEXR_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENEXR_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENEXR_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENEXR_DEBUG}>)
    set_property(TARGET CONAN_PKG::openexr PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENEXR}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENEXR_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENEXR_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENEXR_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENEXR_DEBUG}>)
    set_property(TARGET CONAN_PKG::openexr PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENEXR_LIST} ${CONAN_CXX_FLAGS_OPENEXR_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENEXR_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENEXR_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENEXR_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENEXR_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENEXR_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENEXR_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENEXR_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENEXR_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBTIFF} ${CONAN_FRAMEWORKS_FOUND_LIBTIFF} CONAN_PKG::zlib CONAN_PKG::xz_utils CONAN_PKG::libjpeg CONAN_PKG::jbig CONAN_PKG::zstd CONAN_PKG::libwebp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBTIFF}" "${CONAN_LIB_DIRS_LIBTIFF}"
                                  CONAN_PACKAGE_TARGETS_LIBTIFF "${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES}"
                                  "" libtiff)
    set(_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBTIFF_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBTIFF_DEBUG} CONAN_PKG::zlib CONAN_PKG::xz_utils CONAN_PKG::libjpeg CONAN_PKG::jbig CONAN_PKG::zstd CONAN_PKG::libwebp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBTIFF_DEBUG}" "${CONAN_LIB_DIRS_LIBTIFF_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBTIFF_DEBUG "${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_DEBUG}"
                                  "debug" libtiff)
    set(_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBTIFF_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBTIFF_RELEASE} CONAN_PKG::zlib CONAN_PKG::xz_utils CONAN_PKG::libjpeg CONAN_PKG::jbig CONAN_PKG::zstd CONAN_PKG::libwebp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBTIFF_RELEASE}" "${CONAN_LIB_DIRS_LIBTIFF_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBTIFF_RELEASE "${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_RELEASE}"
                                  "release" libtiff)
    set(_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBTIFF_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBTIFF_RELWITHDEBINFO} CONAN_PKG::zlib CONAN_PKG::xz_utils CONAN_PKG::libjpeg CONAN_PKG::jbig CONAN_PKG::zstd CONAN_PKG::libwebp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBTIFF_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBTIFF_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBTIFF_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libtiff)
    set(_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBTIFF_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBTIFF_MINSIZEREL} CONAN_PKG::zlib CONAN_PKG::xz_utils CONAN_PKG::libjpeg CONAN_PKG::jbig CONAN_PKG::zstd CONAN_PKG::libwebp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBTIFF_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBTIFF_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBTIFF_MINSIZEREL "${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libtiff)

    add_library(CONAN_PKG::libtiff INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libtiff PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBTIFF} ${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBTIFF_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBTIFF_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBTIFF_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBTIFF_RELEASE} ${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBTIFF_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBTIFF_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBTIFF_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBTIFF_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBTIFF_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBTIFF_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBTIFF_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBTIFF_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBTIFF_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBTIFF_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBTIFF_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBTIFF_DEBUG} ${_CONAN_PKG_LIBS_LIBTIFF_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBTIFF_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBTIFF_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBTIFF_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libtiff PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBTIFF}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBTIFF_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBTIFF_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBTIFF_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBTIFF_DEBUG}>)
    set_property(TARGET CONAN_PKG::libtiff PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBTIFF}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBTIFF_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBTIFF_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBTIFF_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBTIFF_DEBUG}>)
    set_property(TARGET CONAN_PKG::libtiff PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBTIFF_LIST} ${CONAN_CXX_FLAGS_LIBTIFF_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBTIFF_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBTIFF_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBTIFF_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBTIFF_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBTIFF_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBTIFF_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBTIFF_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBTIFF_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES "${CONAN_SYSTEM_LIBS_FMT} ${CONAN_FRAMEWORKS_FOUND_FMT} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT}" "${CONAN_LIB_DIRS_FMT}"
                                  CONAN_PACKAGE_TARGETS_FMT "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES}"
                                  "" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_FMT_DEBUG} ${CONAN_FRAMEWORKS_FOUND_FMT_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_DEBUG}" "${CONAN_LIB_DIRS_FMT_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_FMT_DEBUG "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG}"
                                  "debug" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_FMT_RELEASE} ${CONAN_FRAMEWORKS_FOUND_FMT_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_RELEASE}" "${CONAN_LIB_DIRS_FMT_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_FMT_RELEASE "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE}"
                                  "release" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_FMT_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_FMT_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_FMT_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_FMT_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" fmt)
    set(_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_FMT_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_FMT_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FMT_MINSIZEREL}" "${CONAN_LIB_DIRS_FMT_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_FMT_MINSIZEREL "${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" fmt)

    add_library(CONAN_PKG::fmt INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_FMT} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_FMT_RELEASE} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_FMT_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_FMT_MINSIZEREL} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_FMT_DEBUG} ${_CONAN_PKG_LIBS_FMT_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FMT_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FMT_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_FMT}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_FMT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_FMT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_FMT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_FMT_DEBUG}>)
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_FMT}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_FMT_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_FMT_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_FMT_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_FMT_DEBUG}>)
    set_property(TARGET CONAN_PKG::fmt PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_FMT_LIST} ${CONAN_CXX_FLAGS_FMT_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_FMT_RELEASE_LIST} ${CONAN_CXX_FLAGS_FMT_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_FMT_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_FMT_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_FMT_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_FMT_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_FMT_DEBUG_LIST}  ${CONAN_CXX_FLAGS_FMT_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_BOOST_DEPENDENCIES "${CONAN_SYSTEM_LIBS_BOOST} ${CONAN_FRAMEWORKS_FOUND_BOOST} CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOOST_DEPENDENCIES "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOOST}" "${CONAN_LIB_DIRS_BOOST}"
                                  CONAN_PACKAGE_TARGETS_BOOST "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES}"
                                  "" boost)
    set(_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_BOOST_DEBUG} ${CONAN_FRAMEWORKS_FOUND_BOOST_DEBUG} CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOOST_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOOST_DEBUG}" "${CONAN_LIB_DIRS_BOOST_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_BOOST_DEBUG "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_DEBUG}"
                                  "debug" boost)
    set(_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_BOOST_RELEASE} ${CONAN_FRAMEWORKS_FOUND_BOOST_RELEASE} CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOOST_RELEASE}" "${CONAN_LIB_DIRS_BOOST_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_BOOST_RELEASE "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELEASE}"
                                  "release" boost)
    set(_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_BOOST_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_BOOST_RELWITHDEBINFO} CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOOST_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_BOOST_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_BOOST_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" boost)
    set(_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_BOOST_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_BOOST_MINSIZEREL} CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BOOST_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BOOST_MINSIZEREL}" "${CONAN_LIB_DIRS_BOOST_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_BOOST_MINSIZEREL "${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" boost)

    add_library(CONAN_PKG::boost INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::boost PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_BOOST} ${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOOST_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_BOOST_RELEASE} ${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOOST_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_BOOST_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOOST_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_BOOST_MINSIZEREL} ${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOOST_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_BOOST_DEBUG} ${_CONAN_PKG_LIBS_BOOST_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BOOST_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BOOST_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::boost PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_BOOST}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_BOOST_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_BOOST_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_BOOST_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_BOOST_DEBUG}>)
    set_property(TARGET CONAN_PKG::boost PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_BOOST}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_BOOST_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_BOOST_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_BOOST_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_BOOST_DEBUG}>)
    set_property(TARGET CONAN_PKG::boost PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_BOOST_LIST} ${CONAN_CXX_FLAGS_BOOST_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_BOOST_RELEASE_LIST} ${CONAN_CXX_FLAGS_BOOST_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_BOOST_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_BOOST_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_BOOST_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_BOOST_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_BOOST_DEBUG_LIST}  ${CONAN_CXX_FLAGS_BOOST_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES "${CONAN_SYSTEM_LIBS_TSL-ROBIN-MAP} ${CONAN_FRAMEWORKS_FOUND_TSL-ROBIN-MAP} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES "${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_TSL-ROBIN-MAP}" "${CONAN_LIB_DIRS_TSL-ROBIN-MAP}"
                                  CONAN_PACKAGE_TARGETS_TSL-ROBIN-MAP "${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES}"
                                  "" tsl-robin-map)
    set(_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_TSL-ROBIN-MAP_DEBUG} ${CONAN_FRAMEWORKS_FOUND_TSL-ROBIN-MAP_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEBUG}" "${CONAN_LIB_DIRS_TSL-ROBIN-MAP_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_TSL-ROBIN-MAP_DEBUG "${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_DEBUG}"
                                  "debug" tsl-robin-map)
    set(_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_TSL-ROBIN-MAP_RELEASE} ${CONAN_FRAMEWORKS_FOUND_TSL-ROBIN-MAP_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_TSL-ROBIN-MAP_RELEASE}" "${CONAN_LIB_DIRS_TSL-ROBIN-MAP_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_TSL-ROBIN-MAP_RELEASE "${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_RELEASE}"
                                  "release" tsl-robin-map)
    set(_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_TSL-ROBIN-MAP_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_TSL-ROBIN-MAP_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_TSL-ROBIN-MAP_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_TSL-ROBIN-MAP_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_TSL-ROBIN-MAP_RELWITHDEBINFO "${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" tsl-robin-map)
    set(_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_TSL-ROBIN-MAP_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_TSL-ROBIN-MAP_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_TSL-ROBIN-MAP_MINSIZEREL}" "${CONAN_LIB_DIRS_TSL-ROBIN-MAP_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_TSL-ROBIN-MAP_MINSIZEREL "${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" tsl-robin-map)

    add_library(CONAN_PKG::tsl-robin-map INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::tsl-robin-map PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_TSL-ROBIN-MAP} ${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_TSL-ROBIN-MAP_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_TSL-ROBIN-MAP_RELEASE} ${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_TSL-ROBIN-MAP_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_TSL-ROBIN-MAP_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_TSL-ROBIN-MAP_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_TSL-ROBIN-MAP_MINSIZEREL} ${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_TSL-ROBIN-MAP_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_TSL-ROBIN-MAP_DEBUG} ${_CONAN_PKG_LIBS_TSL-ROBIN-MAP_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_TSL-ROBIN-MAP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_TSL-ROBIN-MAP_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::tsl-robin-map PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_TSL-ROBIN-MAP}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_TSL-ROBIN-MAP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_TSL-ROBIN-MAP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_TSL-ROBIN-MAP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_TSL-ROBIN-MAP_DEBUG}>)
    set_property(TARGET CONAN_PKG::tsl-robin-map PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_TSL-ROBIN-MAP}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_TSL-ROBIN-MAP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_TSL-ROBIN-MAP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_TSL-ROBIN-MAP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_TSL-ROBIN-MAP_DEBUG}>)
    set_property(TARGET CONAN_PKG::tsl-robin-map PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_TSL-ROBIN-MAP_LIST} ${CONAN_CXX_FLAGS_TSL-ROBIN-MAP_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_TSL-ROBIN-MAP_RELEASE_LIST} ${CONAN_CXX_FLAGS_TSL-ROBIN-MAP_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_TSL-ROBIN-MAP_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_TSL-ROBIN-MAP_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_TSL-ROBIN-MAP_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_TSL-ROBIN-MAP_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_TSL-ROBIN-MAP_DEBUG_LIST}  ${CONAN_CXX_FLAGS_TSL-ROBIN-MAP_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES "${CONAN_SYSTEM_LIBS_PUGIXML} ${CONAN_FRAMEWORKS_FOUND_PUGIXML} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES "${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PUGIXML}" "${CONAN_LIB_DIRS_PUGIXML}"
                                  CONAN_PACKAGE_TARGETS_PUGIXML "${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES}"
                                  "" pugixml)
    set(_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_PUGIXML_DEBUG} ${CONAN_FRAMEWORKS_FOUND_PUGIXML_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PUGIXML_DEBUG}" "${CONAN_LIB_DIRS_PUGIXML_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_PUGIXML_DEBUG "${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_DEBUG}"
                                  "debug" pugixml)
    set(_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_PUGIXML_RELEASE} ${CONAN_FRAMEWORKS_FOUND_PUGIXML_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PUGIXML_RELEASE}" "${CONAN_LIB_DIRS_PUGIXML_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_PUGIXML_RELEASE "${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_RELEASE}"
                                  "release" pugixml)
    set(_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_PUGIXML_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_PUGIXML_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PUGIXML_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_PUGIXML_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_PUGIXML_RELWITHDEBINFO "${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" pugixml)
    set(_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_PUGIXML_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_PUGIXML_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_PUGIXML_MINSIZEREL}" "${CONAN_LIB_DIRS_PUGIXML_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_PUGIXML_MINSIZEREL "${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" pugixml)

    add_library(CONAN_PKG::pugixml INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::pugixml PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_PUGIXML} ${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PUGIXML_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PUGIXML_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PUGIXML_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_PUGIXML_RELEASE} ${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PUGIXML_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PUGIXML_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PUGIXML_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_PUGIXML_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PUGIXML_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PUGIXML_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PUGIXML_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_PUGIXML_MINSIZEREL} ${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PUGIXML_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PUGIXML_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PUGIXML_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_PUGIXML_DEBUG} ${_CONAN_PKG_LIBS_PUGIXML_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PUGIXML_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_PUGIXML_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_PUGIXML_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::pugixml PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_PUGIXML}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_PUGIXML_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_PUGIXML_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_PUGIXML_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_PUGIXML_DEBUG}>)
    set_property(TARGET CONAN_PKG::pugixml PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_PUGIXML}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_PUGIXML_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_PUGIXML_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_PUGIXML_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_PUGIXML_DEBUG}>)
    set_property(TARGET CONAN_PKG::pugixml PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_PUGIXML_LIST} ${CONAN_CXX_FLAGS_PUGIXML_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_PUGIXML_RELEASE_LIST} ${CONAN_CXX_FLAGS_PUGIXML_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_PUGIXML_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_PUGIXML_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_PUGIXML_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_PUGIXML_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_PUGIXML_DEBUG_LIST}  ${CONAN_CXX_FLAGS_PUGIXML_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBSQUISH} ${CONAN_FRAMEWORKS_FOUND_LIBSQUISH} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBSQUISH}" "${CONAN_LIB_DIRS_LIBSQUISH}"
                                  CONAN_PACKAGE_TARGETS_LIBSQUISH "${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES}"
                                  "" libsquish)
    set(_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBSQUISH_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBSQUISH_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBSQUISH_DEBUG}" "${CONAN_LIB_DIRS_LIBSQUISH_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBSQUISH_DEBUG "${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_DEBUG}"
                                  "debug" libsquish)
    set(_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBSQUISH_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBSQUISH_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBSQUISH_RELEASE}" "${CONAN_LIB_DIRS_LIBSQUISH_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBSQUISH_RELEASE "${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_RELEASE}"
                                  "release" libsquish)
    set(_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBSQUISH_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBSQUISH_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBSQUISH_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBSQUISH_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBSQUISH_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libsquish)
    set(_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBSQUISH_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBSQUISH_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBSQUISH_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBSQUISH_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBSQUISH_MINSIZEREL "${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libsquish)

    add_library(CONAN_PKG::libsquish INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libsquish PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBSQUISH} ${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBSQUISH_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBSQUISH_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBSQUISH_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBSQUISH_RELEASE} ${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBSQUISH_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBSQUISH_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBSQUISH_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBSQUISH_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBSQUISH_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBSQUISH_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBSQUISH_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBSQUISH_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBSQUISH_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBSQUISH_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBSQUISH_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBSQUISH_DEBUG} ${_CONAN_PKG_LIBS_LIBSQUISH_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBSQUISH_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBSQUISH_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBSQUISH_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libsquish PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBSQUISH}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBSQUISH_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBSQUISH_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBSQUISH_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBSQUISH_DEBUG}>)
    set_property(TARGET CONAN_PKG::libsquish PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBSQUISH}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBSQUISH_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBSQUISH_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBSQUISH_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBSQUISH_DEBUG}>)
    set_property(TARGET CONAN_PKG::libsquish PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBSQUISH_LIST} ${CONAN_CXX_FLAGS_LIBSQUISH_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBSQUISH_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBSQUISH_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBSQUISH_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBSQUISH_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBSQUISH_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBSQUISH_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBSQUISH_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBSQUISH_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENJPEG} ${CONAN_FRAMEWORKS_FOUND_OPENJPEG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENJPEG}" "${CONAN_LIB_DIRS_OPENJPEG}"
                                  CONAN_PACKAGE_TARGETS_OPENJPEG "${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES}"
                                  "" openjpeg)
    set(_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENJPEG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENJPEG_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENJPEG_DEBUG}" "${CONAN_LIB_DIRS_OPENJPEG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENJPEG_DEBUG "${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_DEBUG}"
                                  "debug" openjpeg)
    set(_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENJPEG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENJPEG_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENJPEG_RELEASE}" "${CONAN_LIB_DIRS_OPENJPEG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENJPEG_RELEASE "${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_RELEASE}"
                                  "release" openjpeg)
    set(_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENJPEG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENJPEG_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENJPEG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENJPEG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENJPEG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" openjpeg)
    set(_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENJPEG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENJPEG_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENJPEG_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENJPEG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENJPEG_MINSIZEREL "${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" openjpeg)

    add_library(CONAN_PKG::openjpeg INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::openjpeg PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENJPEG} ${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENJPEG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENJPEG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENJPEG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENJPEG_RELEASE} ${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENJPEG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENJPEG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENJPEG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENJPEG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENJPEG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENJPEG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENJPEG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENJPEG_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENJPEG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENJPEG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENJPEG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENJPEG_DEBUG} ${_CONAN_PKG_LIBS_OPENJPEG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENJPEG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENJPEG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENJPEG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::openjpeg PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENJPEG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENJPEG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENJPEG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENJPEG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENJPEG_DEBUG}>)
    set_property(TARGET CONAN_PKG::openjpeg PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENJPEG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENJPEG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENJPEG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENJPEG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENJPEG_DEBUG}>)
    set_property(TARGET CONAN_PKG::openjpeg PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENJPEG_LIST} ${CONAN_CXX_FLAGS_OPENJPEG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENJPEG_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENJPEG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENJPEG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENJPEG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENJPEG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENJPEG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENJPEG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENJPEG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES "${CONAN_SYSTEM_LIBS_GIFLIB} ${CONAN_FRAMEWORKS_FOUND_GIFLIB} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES "${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GIFLIB}" "${CONAN_LIB_DIRS_GIFLIB}"
                                  CONAN_PACKAGE_TARGETS_GIFLIB "${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES}"
                                  "" giflib)
    set(_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_GIFLIB_DEBUG} ${CONAN_FRAMEWORKS_FOUND_GIFLIB_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GIFLIB_DEBUG}" "${CONAN_LIB_DIRS_GIFLIB_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_GIFLIB_DEBUG "${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_DEBUG}"
                                  "debug" giflib)
    set(_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_GIFLIB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_GIFLIB_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GIFLIB_RELEASE}" "${CONAN_LIB_DIRS_GIFLIB_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_GIFLIB_RELEASE "${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_RELEASE}"
                                  "release" giflib)
    set(_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_GIFLIB_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_GIFLIB_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GIFLIB_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_GIFLIB_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_GIFLIB_RELWITHDEBINFO "${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" giflib)
    set(_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_GIFLIB_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_GIFLIB_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_GIFLIB_MINSIZEREL}" "${CONAN_LIB_DIRS_GIFLIB_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_GIFLIB_MINSIZEREL "${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" giflib)

    add_library(CONAN_PKG::giflib INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::giflib PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_GIFLIB} ${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GIFLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GIFLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GIFLIB_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_GIFLIB_RELEASE} ${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GIFLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GIFLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GIFLIB_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_GIFLIB_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GIFLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GIFLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GIFLIB_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_GIFLIB_MINSIZEREL} ${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GIFLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GIFLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GIFLIB_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_GIFLIB_DEBUG} ${_CONAN_PKG_LIBS_GIFLIB_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GIFLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_GIFLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_GIFLIB_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::giflib PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_GIFLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_GIFLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_GIFLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_GIFLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_GIFLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::giflib PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_GIFLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_GIFLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_GIFLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_GIFLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_GIFLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::giflib PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_GIFLIB_LIST} ${CONAN_CXX_FLAGS_GIFLIB_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_GIFLIB_RELEASE_LIST} ${CONAN_CXX_FLAGS_GIFLIB_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_GIFLIB_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_GIFLIB_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_GIFLIB_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_GIFLIB_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_GIFLIB_DEBUG_LIST}  ${CONAN_CXX_FLAGS_GIFLIB_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES "${CONAN_SYSTEM_LIBS_FREETYPE} ${CONAN_FRAMEWORKS_FOUND_FREETYPE} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2 CONAN_PKG::brotli")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE}" "${CONAN_LIB_DIRS_FREETYPE}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES}"
                                  "" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_FREETYPE_DEBUG} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_DEBUG} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2 CONAN_PKG::brotli")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_DEBUG}" "${CONAN_LIB_DIRS_FREETYPE_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_DEBUG "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG}"
                                  "debug" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_FREETYPE_RELEASE} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_RELEASE} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2 CONAN_PKG::brotli")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_RELEASE}" "${CONAN_LIB_DIRS_FREETYPE_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_RELEASE "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE}"
                                  "release" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_FREETYPE_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_RELWITHDEBINFO} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2 CONAN_PKG::brotli")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_FREETYPE_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_RELWITHDEBINFO "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" freetype)
    set(_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_FREETYPE_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_FREETYPE_MINSIZEREL} CONAN_PKG::libpng CONAN_PKG::zlib CONAN_PKG::bzip2 CONAN_PKG::brotli")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_FREETYPE_MINSIZEREL}" "${CONAN_LIB_DIRS_FREETYPE_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_FREETYPE_MINSIZEREL "${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" freetype)

    add_library(CONAN_PKG::freetype INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_FREETYPE} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_FREETYPE_RELEASE} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_FREETYPE_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_FREETYPE_MINSIZEREL} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_FREETYPE_DEBUG} ${_CONAN_PKG_LIBS_FREETYPE_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_FREETYPE_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_FREETYPE_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_FREETYPE}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_FREETYPE_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_FREETYPE_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_FREETYPE_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_FREETYPE_DEBUG}>)
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_FREETYPE}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_FREETYPE_DEBUG}>)
    set_property(TARGET CONAN_PKG::freetype PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_FREETYPE_LIST} ${CONAN_CXX_FLAGS_FREETYPE_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_FREETYPE_RELEASE_LIST} ${CONAN_CXX_FLAGS_FREETYPE_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_FREETYPE_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_FREETYPE_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_FREETYPE_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_FREETYPE_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_FREETYPE_DEBUG_LIST}  ${CONAN_CXX_FLAGS_FREETYPE_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES "${CONAN_SYSTEM_LIBS_OPENCOLORIO} ${CONAN_FRAMEWORKS_FOUND_OPENCOLORIO} CONAN_PKG::lcms CONAN_PKG::yaml-cpp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES "${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENCOLORIO}" "${CONAN_LIB_DIRS_OPENCOLORIO}"
                                  CONAN_PACKAGE_TARGETS_OPENCOLORIO "${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES}"
                                  "" opencolorio)
    set(_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_OPENCOLORIO_DEBUG} ${CONAN_FRAMEWORKS_FOUND_OPENCOLORIO_DEBUG} CONAN_PKG::lcms CONAN_PKG::yaml-cpp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENCOLORIO_DEBUG}" "${CONAN_LIB_DIRS_OPENCOLORIO_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_OPENCOLORIO_DEBUG "${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_DEBUG}"
                                  "debug" opencolorio)
    set(_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_OPENCOLORIO_RELEASE} ${CONAN_FRAMEWORKS_FOUND_OPENCOLORIO_RELEASE} CONAN_PKG::lcms CONAN_PKG::yaml-cpp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENCOLORIO_RELEASE}" "${CONAN_LIB_DIRS_OPENCOLORIO_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_OPENCOLORIO_RELEASE "${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_RELEASE}"
                                  "release" opencolorio)
    set(_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_OPENCOLORIO_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_OPENCOLORIO_RELWITHDEBINFO} CONAN_PKG::lcms CONAN_PKG::yaml-cpp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENCOLORIO_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_OPENCOLORIO_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_OPENCOLORIO_RELWITHDEBINFO "${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" opencolorio)
    set(_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_OPENCOLORIO_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_OPENCOLORIO_MINSIZEREL} CONAN_PKG::lcms CONAN_PKG::yaml-cpp")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_OPENCOLORIO_MINSIZEREL}" "${CONAN_LIB_DIRS_OPENCOLORIO_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_OPENCOLORIO_MINSIZEREL "${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" opencolorio)

    add_library(CONAN_PKG::opencolorio INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::opencolorio PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_OPENCOLORIO} ${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENCOLORIO_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_OPENCOLORIO_RELEASE} ${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENCOLORIO_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_OPENCOLORIO_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENCOLORIO_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_OPENCOLORIO_MINSIZEREL} ${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENCOLORIO_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_OPENCOLORIO_DEBUG} ${_CONAN_PKG_LIBS_OPENCOLORIO_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_OPENCOLORIO_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_OPENCOLORIO_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::opencolorio PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_OPENCOLORIO}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_OPENCOLORIO_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_OPENCOLORIO_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_OPENCOLORIO_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_OPENCOLORIO_DEBUG}>)
    set_property(TARGET CONAN_PKG::opencolorio PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_OPENCOLORIO}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_OPENCOLORIO_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_OPENCOLORIO_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_OPENCOLORIO_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_OPENCOLORIO_DEBUG}>)
    set_property(TARGET CONAN_PKG::opencolorio PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_OPENCOLORIO_LIST} ${CONAN_CXX_FLAGS_OPENCOLORIO_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_OPENCOLORIO_RELEASE_LIST} ${CONAN_CXX_FLAGS_OPENCOLORIO_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_OPENCOLORIO_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_OPENCOLORIO_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_OPENCOLORIO_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_OPENCOLORIO_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_OPENCOLORIO_DEBUG_LIST}  ${CONAN_CXX_FLAGS_OPENCOLORIO_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES "${CONAN_SYSTEM_LIBS_IRRXML} ${CONAN_FRAMEWORKS_FOUND_IRRXML} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IRRXML_DEPENDENCIES "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IRRXML}" "${CONAN_LIB_DIRS_IRRXML}"
                                  CONAN_PACKAGE_TARGETS_IRRXML "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES}"
                                  "" irrxml)
    set(_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_IRRXML_DEBUG} ${CONAN_FRAMEWORKS_FOUND_IRRXML_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IRRXML_DEBUG}" "${CONAN_LIB_DIRS_IRRXML_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_IRRXML_DEBUG "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_DEBUG}"
                                  "debug" irrxml)
    set(_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_IRRXML_RELEASE} ${CONAN_FRAMEWORKS_FOUND_IRRXML_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IRRXML_RELEASE}" "${CONAN_LIB_DIRS_IRRXML_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_IRRXML_RELEASE "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELEASE}"
                                  "release" irrxml)
    set(_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_IRRXML_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_IRRXML_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IRRXML_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_IRRXML_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_IRRXML_RELWITHDEBINFO "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" irrxml)
    set(_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_IRRXML_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_IRRXML_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_IRRXML_MINSIZEREL}" "${CONAN_LIB_DIRS_IRRXML_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_IRRXML_MINSIZEREL "${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" irrxml)

    add_library(CONAN_PKG::irrxml INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::irrxml PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_IRRXML} ${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IRRXML_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_IRRXML_RELEASE} ${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IRRXML_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_IRRXML_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IRRXML_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_IRRXML_MINSIZEREL} ${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IRRXML_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_IRRXML_DEBUG} ${_CONAN_PKG_LIBS_IRRXML_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_IRRXML_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_IRRXML_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::irrxml PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_IRRXML}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_IRRXML_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_IRRXML_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_IRRXML_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_IRRXML_DEBUG}>)
    set_property(TARGET CONAN_PKG::irrxml PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_IRRXML}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_IRRXML_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_IRRXML_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_IRRXML_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_IRRXML_DEBUG}>)
    set_property(TARGET CONAN_PKG::irrxml PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_IRRXML_LIST} ${CONAN_CXX_FLAGS_IRRXML_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_IRRXML_RELEASE_LIST} ${CONAN_CXX_FLAGS_IRRXML_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_IRRXML_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_IRRXML_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_IRRXML_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_IRRXML_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_IRRXML_DEBUG_LIST}  ${CONAN_CXX_FLAGS_IRRXML_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES "${CONAN_SYSTEM_LIBS_MINIZIP} ${CONAN_FRAMEWORKS_FOUND_MINIZIP} CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES "${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_MINIZIP}" "${CONAN_LIB_DIRS_MINIZIP}"
                                  CONAN_PACKAGE_TARGETS_MINIZIP "${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES}"
                                  "" minizip)
    set(_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_MINIZIP_DEBUG} ${CONAN_FRAMEWORKS_FOUND_MINIZIP_DEBUG} CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_MINIZIP_DEBUG}" "${CONAN_LIB_DIRS_MINIZIP_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_MINIZIP_DEBUG "${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_DEBUG}"
                                  "debug" minizip)
    set(_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_MINIZIP_RELEASE} ${CONAN_FRAMEWORKS_FOUND_MINIZIP_RELEASE} CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_MINIZIP_RELEASE}" "${CONAN_LIB_DIRS_MINIZIP_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_MINIZIP_RELEASE "${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_RELEASE}"
                                  "release" minizip)
    set(_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_MINIZIP_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_MINIZIP_RELWITHDEBINFO} CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_MINIZIP_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_MINIZIP_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_MINIZIP_RELWITHDEBINFO "${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" minizip)
    set(_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_MINIZIP_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_MINIZIP_MINSIZEREL} CONAN_PKG::zlib CONAN_PKG::bzip2")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_MINIZIP_MINSIZEREL}" "${CONAN_LIB_DIRS_MINIZIP_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_MINIZIP_MINSIZEREL "${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" minizip)

    add_library(CONAN_PKG::minizip INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::minizip PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_MINIZIP} ${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MINIZIP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MINIZIP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_MINIZIP_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_MINIZIP_RELEASE} ${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MINIZIP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MINIZIP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_MINIZIP_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_MINIZIP_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MINIZIP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MINIZIP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_MINIZIP_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_MINIZIP_MINSIZEREL} ${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MINIZIP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MINIZIP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_MINIZIP_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_MINIZIP_DEBUG} ${_CONAN_PKG_LIBS_MINIZIP_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MINIZIP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_MINIZIP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_MINIZIP_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::minizip PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_MINIZIP}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_MINIZIP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_MINIZIP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINIZIP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_MINIZIP_DEBUG}>)
    set_property(TARGET CONAN_PKG::minizip PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_MINIZIP}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_MINIZIP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_MINIZIP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_MINIZIP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_MINIZIP_DEBUG}>)
    set_property(TARGET CONAN_PKG::minizip PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_MINIZIP_LIST} ${CONAN_CXX_FLAGS_MINIZIP_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_MINIZIP_RELEASE_LIST} ${CONAN_CXX_FLAGS_MINIZIP_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_MINIZIP_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_MINIZIP_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_MINIZIP_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_MINIZIP_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_MINIZIP_DEBUG_LIST}  ${CONAN_CXX_FLAGS_MINIZIP_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES "${CONAN_SYSTEM_LIBS_UTFCPP} ${CONAN_FRAMEWORKS_FOUND_UTFCPP} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES "${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_UTFCPP}" "${CONAN_LIB_DIRS_UTFCPP}"
                                  CONAN_PACKAGE_TARGETS_UTFCPP "${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES}"
                                  "" utfcpp)
    set(_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_UTFCPP_DEBUG} ${CONAN_FRAMEWORKS_FOUND_UTFCPP_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_UTFCPP_DEBUG}" "${CONAN_LIB_DIRS_UTFCPP_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_UTFCPP_DEBUG "${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_DEBUG}"
                                  "debug" utfcpp)
    set(_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_UTFCPP_RELEASE} ${CONAN_FRAMEWORKS_FOUND_UTFCPP_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_UTFCPP_RELEASE}" "${CONAN_LIB_DIRS_UTFCPP_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_UTFCPP_RELEASE "${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_RELEASE}"
                                  "release" utfcpp)
    set(_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_UTFCPP_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_UTFCPP_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_UTFCPP_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_UTFCPP_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_UTFCPP_RELWITHDEBINFO "${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" utfcpp)
    set(_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_UTFCPP_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_UTFCPP_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_UTFCPP_MINSIZEREL}" "${CONAN_LIB_DIRS_UTFCPP_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_UTFCPP_MINSIZEREL "${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" utfcpp)

    add_library(CONAN_PKG::utfcpp INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::utfcpp PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_UTFCPP} ${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTFCPP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTFCPP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_UTFCPP_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_UTFCPP_RELEASE} ${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTFCPP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTFCPP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_UTFCPP_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_UTFCPP_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTFCPP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTFCPP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_UTFCPP_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_UTFCPP_MINSIZEREL} ${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTFCPP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTFCPP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_UTFCPP_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_UTFCPP_DEBUG} ${_CONAN_PKG_LIBS_UTFCPP_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTFCPP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_UTFCPP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_UTFCPP_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::utfcpp PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_UTFCPP}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_UTFCPP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_UTFCPP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_UTFCPP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_UTFCPP_DEBUG}>)
    set_property(TARGET CONAN_PKG::utfcpp PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_UTFCPP}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_UTFCPP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_UTFCPP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_UTFCPP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_UTFCPP_DEBUG}>)
    set_property(TARGET CONAN_PKG::utfcpp PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_UTFCPP_LIST} ${CONAN_CXX_FLAGS_UTFCPP_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_UTFCPP_RELEASE_LIST} ${CONAN_CXX_FLAGS_UTFCPP_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_UTFCPP_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_UTFCPP_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_UTFCPP_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_UTFCPP_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_UTFCPP_DEBUG_LIST}  ${CONAN_CXX_FLAGS_UTFCPP_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES "${CONAN_SYSTEM_LIBS_KUBA-ZIP} ${CONAN_FRAMEWORKS_FOUND_KUBA-ZIP} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES "${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_KUBA-ZIP}" "${CONAN_LIB_DIRS_KUBA-ZIP}"
                                  CONAN_PACKAGE_TARGETS_KUBA-ZIP "${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES}"
                                  "" kuba-zip)
    set(_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_KUBA-ZIP_DEBUG} ${CONAN_FRAMEWORKS_FOUND_KUBA-ZIP_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_KUBA-ZIP_DEBUG}" "${CONAN_LIB_DIRS_KUBA-ZIP_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_KUBA-ZIP_DEBUG "${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_DEBUG}"
                                  "debug" kuba-zip)
    set(_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_KUBA-ZIP_RELEASE} ${CONAN_FRAMEWORKS_FOUND_KUBA-ZIP_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_KUBA-ZIP_RELEASE}" "${CONAN_LIB_DIRS_KUBA-ZIP_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_KUBA-ZIP_RELEASE "${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_RELEASE}"
                                  "release" kuba-zip)
    set(_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_KUBA-ZIP_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_KUBA-ZIP_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_KUBA-ZIP_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_KUBA-ZIP_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_KUBA-ZIP_RELWITHDEBINFO "${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" kuba-zip)
    set(_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_KUBA-ZIP_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_KUBA-ZIP_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_KUBA-ZIP_MINSIZEREL}" "${CONAN_LIB_DIRS_KUBA-ZIP_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_KUBA-ZIP_MINSIZEREL "${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" kuba-zip)

    add_library(CONAN_PKG::kuba-zip INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::kuba-zip PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_KUBA-ZIP} ${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_KUBA-ZIP_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_KUBA-ZIP_RELEASE} ${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_KUBA-ZIP_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_KUBA-ZIP_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_KUBA-ZIP_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_KUBA-ZIP_MINSIZEREL} ${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_KUBA-ZIP_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_KUBA-ZIP_DEBUG} ${_CONAN_PKG_LIBS_KUBA-ZIP_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_KUBA-ZIP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_KUBA-ZIP_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::kuba-zip PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_KUBA-ZIP}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_KUBA-ZIP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_KUBA-ZIP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_KUBA-ZIP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_KUBA-ZIP_DEBUG}>)
    set_property(TARGET CONAN_PKG::kuba-zip PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_KUBA-ZIP}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_KUBA-ZIP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_KUBA-ZIP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_KUBA-ZIP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_KUBA-ZIP_DEBUG}>)
    set_property(TARGET CONAN_PKG::kuba-zip PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_KUBA-ZIP_LIST} ${CONAN_CXX_FLAGS_KUBA-ZIP_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_KUBA-ZIP_RELEASE_LIST} ${CONAN_CXX_FLAGS_KUBA-ZIP_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_KUBA-ZIP_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_KUBA-ZIP_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_KUBA-ZIP_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_KUBA-ZIP_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_KUBA-ZIP_DEBUG_LIST}  ${CONAN_CXX_FLAGS_KUBA-ZIP_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES "${CONAN_SYSTEM_LIBS_POLY2TRI} ${CONAN_FRAMEWORKS_FOUND_POLY2TRI} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES "${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_POLY2TRI}" "${CONAN_LIB_DIRS_POLY2TRI}"
                                  CONAN_PACKAGE_TARGETS_POLY2TRI "${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES}"
                                  "" poly2tri)
    set(_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_POLY2TRI_DEBUG} ${CONAN_FRAMEWORKS_FOUND_POLY2TRI_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_POLY2TRI_DEBUG}" "${CONAN_LIB_DIRS_POLY2TRI_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_POLY2TRI_DEBUG "${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_DEBUG}"
                                  "debug" poly2tri)
    set(_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_POLY2TRI_RELEASE} ${CONAN_FRAMEWORKS_FOUND_POLY2TRI_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_POLY2TRI_RELEASE}" "${CONAN_LIB_DIRS_POLY2TRI_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_POLY2TRI_RELEASE "${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_RELEASE}"
                                  "release" poly2tri)
    set(_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_POLY2TRI_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_POLY2TRI_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_POLY2TRI_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_POLY2TRI_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_POLY2TRI_RELWITHDEBINFO "${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" poly2tri)
    set(_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_POLY2TRI_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_POLY2TRI_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_POLY2TRI_MINSIZEREL}" "${CONAN_LIB_DIRS_POLY2TRI_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_POLY2TRI_MINSIZEREL "${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" poly2tri)

    add_library(CONAN_PKG::poly2tri INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::poly2tri PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_POLY2TRI} ${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_POLY2TRI_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_POLY2TRI_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_POLY2TRI_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_POLY2TRI_RELEASE} ${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_POLY2TRI_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_POLY2TRI_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_POLY2TRI_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_POLY2TRI_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_POLY2TRI_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_POLY2TRI_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_POLY2TRI_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_POLY2TRI_MINSIZEREL} ${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_POLY2TRI_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_POLY2TRI_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_POLY2TRI_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_POLY2TRI_DEBUG} ${_CONAN_PKG_LIBS_POLY2TRI_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_POLY2TRI_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_POLY2TRI_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_POLY2TRI_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::poly2tri PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_POLY2TRI}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_POLY2TRI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_POLY2TRI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_POLY2TRI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_POLY2TRI_DEBUG}>)
    set_property(TARGET CONAN_PKG::poly2tri PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_POLY2TRI}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_POLY2TRI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_POLY2TRI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_POLY2TRI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_POLY2TRI_DEBUG}>)
    set_property(TARGET CONAN_PKG::poly2tri PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_POLY2TRI_LIST} ${CONAN_CXX_FLAGS_POLY2TRI_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_POLY2TRI_RELEASE_LIST} ${CONAN_CXX_FLAGS_POLY2TRI_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_POLY2TRI_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_POLY2TRI_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_POLY2TRI_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_POLY2TRI_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_POLY2TRI_DEBUG_LIST}  ${CONAN_CXX_FLAGS_POLY2TRI_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES "${CONAN_SYSTEM_LIBS_RAPIDJSON} ${CONAN_FRAMEWORKS_FOUND_RAPIDJSON} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES "${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_RAPIDJSON}" "${CONAN_LIB_DIRS_RAPIDJSON}"
                                  CONAN_PACKAGE_TARGETS_RAPIDJSON "${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES}"
                                  "" rapidjson)
    set(_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_RAPIDJSON_DEBUG} ${CONAN_FRAMEWORKS_FOUND_RAPIDJSON_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_RAPIDJSON_DEBUG}" "${CONAN_LIB_DIRS_RAPIDJSON_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_RAPIDJSON_DEBUG "${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_DEBUG}"
                                  "debug" rapidjson)
    set(_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_RAPIDJSON_RELEASE} ${CONAN_FRAMEWORKS_FOUND_RAPIDJSON_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_RAPIDJSON_RELEASE}" "${CONAN_LIB_DIRS_RAPIDJSON_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_RAPIDJSON_RELEASE "${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_RELEASE}"
                                  "release" rapidjson)
    set(_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_RAPIDJSON_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_RAPIDJSON_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_RAPIDJSON_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_RAPIDJSON_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_RAPIDJSON_RELWITHDEBINFO "${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" rapidjson)
    set(_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_RAPIDJSON_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_RAPIDJSON_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_RAPIDJSON_MINSIZEREL}" "${CONAN_LIB_DIRS_RAPIDJSON_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_RAPIDJSON_MINSIZEREL "${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" rapidjson)

    add_library(CONAN_PKG::rapidjson INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::rapidjson PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_RAPIDJSON} ${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_RAPIDJSON_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_RAPIDJSON_RELEASE} ${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_RAPIDJSON_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_RAPIDJSON_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_RAPIDJSON_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_RAPIDJSON_MINSIZEREL} ${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_RAPIDJSON_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_RAPIDJSON_DEBUG} ${_CONAN_PKG_LIBS_RAPIDJSON_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_RAPIDJSON_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_RAPIDJSON_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::rapidjson PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_RAPIDJSON}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RAPIDJSON_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RAPIDJSON_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_RAPIDJSON_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_RAPIDJSON_DEBUG}>)
    set_property(TARGET CONAN_PKG::rapidjson PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_RAPIDJSON}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_RAPIDJSON_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_RAPIDJSON_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_RAPIDJSON_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_RAPIDJSON_DEBUG}>)
    set_property(TARGET CONAN_PKG::rapidjson PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_RAPIDJSON_LIST} ${CONAN_CXX_FLAGS_RAPIDJSON_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_RAPIDJSON_RELEASE_LIST} ${CONAN_CXX_FLAGS_RAPIDJSON_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_RAPIDJSON_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_RAPIDJSON_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_RAPIDJSON_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_RAPIDJSON_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_RAPIDJSON_DEBUG_LIST}  ${CONAN_CXX_FLAGS_RAPIDJSON_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES "${CONAN_SYSTEM_LIBS_XZ_UTILS} ${CONAN_FRAMEWORKS_FOUND_XZ_UTILS} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES "${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XZ_UTILS}" "${CONAN_LIB_DIRS_XZ_UTILS}"
                                  CONAN_PACKAGE_TARGETS_XZ_UTILS "${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES}"
                                  "" xz_utils)
    set(_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_XZ_UTILS_DEBUG} ${CONAN_FRAMEWORKS_FOUND_XZ_UTILS_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XZ_UTILS_DEBUG}" "${CONAN_LIB_DIRS_XZ_UTILS_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_XZ_UTILS_DEBUG "${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_DEBUG}"
                                  "debug" xz_utils)
    set(_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_XZ_UTILS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_XZ_UTILS_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XZ_UTILS_RELEASE}" "${CONAN_LIB_DIRS_XZ_UTILS_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_XZ_UTILS_RELEASE "${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_RELEASE}"
                                  "release" xz_utils)
    set(_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_XZ_UTILS_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_XZ_UTILS_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XZ_UTILS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_XZ_UTILS_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_XZ_UTILS_RELWITHDEBINFO "${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" xz_utils)
    set(_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_XZ_UTILS_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_XZ_UTILS_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_XZ_UTILS_MINSIZEREL}" "${CONAN_LIB_DIRS_XZ_UTILS_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_XZ_UTILS_MINSIZEREL "${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" xz_utils)

    add_library(CONAN_PKG::xz_utils INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::xz_utils PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_XZ_UTILS} ${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XZ_UTILS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XZ_UTILS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XZ_UTILS_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_XZ_UTILS_RELEASE} ${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XZ_UTILS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XZ_UTILS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XZ_UTILS_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_XZ_UTILS_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XZ_UTILS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XZ_UTILS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XZ_UTILS_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_XZ_UTILS_MINSIZEREL} ${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XZ_UTILS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XZ_UTILS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XZ_UTILS_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_XZ_UTILS_DEBUG} ${_CONAN_PKG_LIBS_XZ_UTILS_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XZ_UTILS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_XZ_UTILS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_XZ_UTILS_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::xz_utils PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_XZ_UTILS}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_XZ_UTILS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_XZ_UTILS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_XZ_UTILS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_XZ_UTILS_DEBUG}>)
    set_property(TARGET CONAN_PKG::xz_utils PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_XZ_UTILS}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_XZ_UTILS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_XZ_UTILS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_XZ_UTILS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_XZ_UTILS_DEBUG}>)
    set_property(TARGET CONAN_PKG::xz_utils PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_XZ_UTILS_LIST} ${CONAN_CXX_FLAGS_XZ_UTILS_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_XZ_UTILS_RELEASE_LIST} ${CONAN_CXX_FLAGS_XZ_UTILS_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_XZ_UTILS_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_XZ_UTILS_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_XZ_UTILS_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_XZ_UTILS_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_XZ_UTILS_DEBUG_LIST}  ${CONAN_CXX_FLAGS_XZ_UTILS_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBJPEG} ${CONAN_FRAMEWORKS_FOUND_LIBJPEG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBJPEG}" "${CONAN_LIB_DIRS_LIBJPEG}"
                                  CONAN_PACKAGE_TARGETS_LIBJPEG "${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES}"
                                  "" libjpeg)
    set(_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBJPEG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBJPEG_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBJPEG_DEBUG}" "${CONAN_LIB_DIRS_LIBJPEG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBJPEG_DEBUG "${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_DEBUG}"
                                  "debug" libjpeg)
    set(_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBJPEG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBJPEG_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBJPEG_RELEASE}" "${CONAN_LIB_DIRS_LIBJPEG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBJPEG_RELEASE "${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_RELEASE}"
                                  "release" libjpeg)
    set(_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBJPEG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBJPEG_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBJPEG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBJPEG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBJPEG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libjpeg)
    set(_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBJPEG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBJPEG_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBJPEG_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBJPEG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBJPEG_MINSIZEREL "${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libjpeg)

    add_library(CONAN_PKG::libjpeg INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libjpeg PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBJPEG} ${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBJPEG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBJPEG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBJPEG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBJPEG_RELEASE} ${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBJPEG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBJPEG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBJPEG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBJPEG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBJPEG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBJPEG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBJPEG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBJPEG_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBJPEG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBJPEG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBJPEG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBJPEG_DEBUG} ${_CONAN_PKG_LIBS_LIBJPEG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBJPEG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBJPEG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBJPEG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libjpeg PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBJPEG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBJPEG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBJPEG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBJPEG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBJPEG_DEBUG}>)
    set_property(TARGET CONAN_PKG::libjpeg PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBJPEG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBJPEG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBJPEG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBJPEG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBJPEG_DEBUG}>)
    set_property(TARGET CONAN_PKG::libjpeg PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBJPEG_LIST} ${CONAN_CXX_FLAGS_LIBJPEG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBJPEG_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBJPEG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBJPEG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBJPEG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBJPEG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBJPEG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBJPEG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBJPEG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_JBIG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_JBIG} ${CONAN_FRAMEWORKS_FOUND_JBIG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_JBIG_DEPENDENCIES "${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_JBIG}" "${CONAN_LIB_DIRS_JBIG}"
                                  CONAN_PACKAGE_TARGETS_JBIG "${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES}"
                                  "" jbig)
    set(_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_JBIG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_JBIG_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_JBIG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_JBIG_DEBUG}" "${CONAN_LIB_DIRS_JBIG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_JBIG_DEBUG "${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_DEBUG}"
                                  "debug" jbig)
    set(_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_JBIG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_JBIG_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_JBIG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_JBIG_RELEASE}" "${CONAN_LIB_DIRS_JBIG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_JBIG_RELEASE "${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_RELEASE}"
                                  "release" jbig)
    set(_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_JBIG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_JBIG_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_JBIG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_JBIG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_JBIG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_JBIG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" jbig)
    set(_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_JBIG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_JBIG_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_JBIG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_JBIG_MINSIZEREL}" "${CONAN_LIB_DIRS_JBIG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_JBIG_MINSIZEREL "${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" jbig)

    add_library(CONAN_PKG::jbig INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::jbig PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_JBIG} ${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JBIG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JBIG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_JBIG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_JBIG_RELEASE} ${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JBIG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JBIG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_JBIG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_JBIG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JBIG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JBIG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_JBIG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_JBIG_MINSIZEREL} ${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JBIG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JBIG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_JBIG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_JBIG_DEBUG} ${_CONAN_PKG_LIBS_JBIG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JBIG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_JBIG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_JBIG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::jbig PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_JBIG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_JBIG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_JBIG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_JBIG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_JBIG_DEBUG}>)
    set_property(TARGET CONAN_PKG::jbig PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_JBIG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_JBIG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_JBIG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_JBIG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_JBIG_DEBUG}>)
    set_property(TARGET CONAN_PKG::jbig PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_JBIG_LIST} ${CONAN_CXX_FLAGS_JBIG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_JBIG_RELEASE_LIST} ${CONAN_CXX_FLAGS_JBIG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_JBIG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_JBIG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_JBIG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_JBIG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_JBIG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_JBIG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES "${CONAN_SYSTEM_LIBS_ZSTD} ${CONAN_FRAMEWORKS_FOUND_ZSTD} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZSTD_DEPENDENCIES "${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZSTD}" "${CONAN_LIB_DIRS_ZSTD}"
                                  CONAN_PACKAGE_TARGETS_ZSTD "${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES}"
                                  "" zstd)
    set(_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_ZSTD_DEBUG} ${CONAN_FRAMEWORKS_FOUND_ZSTD_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZSTD_DEBUG}" "${CONAN_LIB_DIRS_ZSTD_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_ZSTD_DEBUG "${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_DEBUG}"
                                  "debug" zstd)
    set(_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_ZSTD_RELEASE} ${CONAN_FRAMEWORKS_FOUND_ZSTD_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZSTD_RELEASE}" "${CONAN_LIB_DIRS_ZSTD_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_ZSTD_RELEASE "${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_RELEASE}"
                                  "release" zstd)
    set(_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_ZSTD_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_ZSTD_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZSTD_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_ZSTD_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_ZSTD_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" zstd)
    set(_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_ZSTD_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_ZSTD_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZSTD_MINSIZEREL}" "${CONAN_LIB_DIRS_ZSTD_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_ZSTD_MINSIZEREL "${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" zstd)

    add_library(CONAN_PKG::zstd INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::zstd PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_ZSTD} ${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZSTD_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZSTD_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZSTD_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_ZSTD_RELEASE} ${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZSTD_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZSTD_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZSTD_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_ZSTD_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZSTD_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZSTD_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZSTD_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_ZSTD_MINSIZEREL} ${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZSTD_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZSTD_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZSTD_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_ZSTD_DEBUG} ${_CONAN_PKG_LIBS_ZSTD_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZSTD_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZSTD_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZSTD_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::zstd PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_ZSTD}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_ZSTD_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_ZSTD_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_ZSTD_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_ZSTD_DEBUG}>)
    set_property(TARGET CONAN_PKG::zstd PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_ZSTD}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_ZSTD_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_ZSTD_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_ZSTD_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_ZSTD_DEBUG}>)
    set_property(TARGET CONAN_PKG::zstd PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_ZSTD_LIST} ${CONAN_CXX_FLAGS_ZSTD_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_ZSTD_RELEASE_LIST} ${CONAN_CXX_FLAGS_ZSTD_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_ZSTD_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_ZSTD_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_ZSTD_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_ZSTD_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_ZSTD_DEBUG_LIST}  ${CONAN_CXX_FLAGS_ZSTD_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBWEBP} ${CONAN_FRAMEWORKS_FOUND_LIBWEBP} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBWEBP}" "${CONAN_LIB_DIRS_LIBWEBP}"
                                  CONAN_PACKAGE_TARGETS_LIBWEBP "${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES}"
                                  "" libwebp)
    set(_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBWEBP_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBWEBP_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBWEBP_DEBUG}" "${CONAN_LIB_DIRS_LIBWEBP_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBWEBP_DEBUG "${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_DEBUG}"
                                  "debug" libwebp)
    set(_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBWEBP_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBWEBP_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBWEBP_RELEASE}" "${CONAN_LIB_DIRS_LIBWEBP_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBWEBP_RELEASE "${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_RELEASE}"
                                  "release" libwebp)
    set(_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBWEBP_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBWEBP_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBWEBP_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBWEBP_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBWEBP_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libwebp)
    set(_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBWEBP_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBWEBP_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBWEBP_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBWEBP_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBWEBP_MINSIZEREL "${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libwebp)

    add_library(CONAN_PKG::libwebp INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libwebp PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBWEBP} ${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBWEBP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBWEBP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBWEBP_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBWEBP_RELEASE} ${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBWEBP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBWEBP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBWEBP_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBWEBP_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBWEBP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBWEBP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBWEBP_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBWEBP_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBWEBP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBWEBP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBWEBP_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBWEBP_DEBUG} ${_CONAN_PKG_LIBS_LIBWEBP_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBWEBP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBWEBP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBWEBP_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libwebp PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBWEBP}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBWEBP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBWEBP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBWEBP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBWEBP_DEBUG}>)
    set_property(TARGET CONAN_PKG::libwebp PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBWEBP}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBWEBP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBWEBP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBWEBP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBWEBP_DEBUG}>)
    set_property(TARGET CONAN_PKG::libwebp PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBWEBP_LIST} ${CONAN_CXX_FLAGS_LIBWEBP_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBWEBP_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBWEBP_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBWEBP_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBWEBP_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBWEBP_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBWEBP_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBWEBP_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBWEBP_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES "${CONAN_SYSTEM_LIBS_BZIP2} ${CONAN_FRAMEWORKS_FOUND_BZIP2} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2}" "${CONAN_LIB_DIRS_BZIP2}"
                                  CONAN_PACKAGE_TARGETS_BZIP2 "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}"
                                  "" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_BZIP2_DEBUG} ${CONAN_FRAMEWORKS_FOUND_BZIP2_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_DEBUG}" "${CONAN_LIB_DIRS_BZIP2_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_DEBUG "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}"
                                  "debug" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_BZIP2_RELEASE} ${CONAN_FRAMEWORKS_FOUND_BZIP2_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_RELEASE}" "${CONAN_LIB_DIRS_BZIP2_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_RELEASE "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}"
                                  "release" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_BZIP2_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_BZIP2_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_BZIP2_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" bzip2)
    set(_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_BZIP2_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_BZIP2_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BZIP2_MINSIZEREL}" "${CONAN_LIB_DIRS_BZIP2_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_BZIP2_MINSIZEREL "${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" bzip2)

    add_library(CONAN_PKG::bzip2 INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_BZIP2} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_BZIP2_RELEASE} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_BZIP2_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_BZIP2_MINSIZEREL} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_BZIP2_DEBUG} ${_CONAN_PKG_LIBS_BZIP2_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BZIP2_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BZIP2_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_BZIP2}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_BZIP2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_BZIP2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_BZIP2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_BZIP2_DEBUG}>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_BZIP2}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_BZIP2_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_BZIP2_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_BZIP2_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_BZIP2_DEBUG}>)
    set_property(TARGET CONAN_PKG::bzip2 PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_BZIP2_LIST} ${CONAN_CXX_FLAGS_BZIP2_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_BZIP2_RELEASE_LIST} ${CONAN_CXX_FLAGS_BZIP2_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_BZIP2_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_BZIP2_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_BZIP2_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_BZIP2_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_BZIP2_DEBUG_LIST}  ${CONAN_CXX_FLAGS_BZIP2_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LIBPNG} ${CONAN_FRAMEWORKS_FOUND_LIBPNG} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG}" "${CONAN_LIB_DIRS_LIBPNG}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES}"
                                  "" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LIBPNG_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_DEBUG} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_DEBUG}" "${CONAN_LIB_DIRS_LIBPNG_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_DEBUG "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG}"
                                  "debug" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LIBPNG_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_RELEASE} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_RELEASE}" "${CONAN_LIB_DIRS_LIBPNG_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_RELEASE "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE}"
                                  "release" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LIBPNG_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_RELWITHDEBINFO} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LIBPNG_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" libpng)
    set(_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LIBPNG_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LIBPNG_MINSIZEREL} CONAN_PKG::zlib")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LIBPNG_MINSIZEREL}" "${CONAN_LIB_DIRS_LIBPNG_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LIBPNG_MINSIZEREL "${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" libpng)

    add_library(CONAN_PKG::libpng INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LIBPNG} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LIBPNG_RELEASE} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LIBPNG_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LIBPNG_MINSIZEREL} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LIBPNG_DEBUG} ${_CONAN_PKG_LIBS_LIBPNG_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LIBPNG_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LIBPNG_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LIBPNG}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LIBPNG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LIBPNG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LIBPNG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LIBPNG_DEBUG}>)
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LIBPNG}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LIBPNG_DEBUG}>)
    set_property(TARGET CONAN_PKG::libpng PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LIBPNG_LIST} ${CONAN_CXX_FLAGS_LIBPNG_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LIBPNG_RELEASE_LIST} ${CONAN_CXX_FLAGS_LIBPNG_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LIBPNG_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LIBPNG_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LIBPNG_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LIBPNG_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LIBPNG_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LIBPNG_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES "${CONAN_SYSTEM_LIBS_BROTLI} ${CONAN_FRAMEWORKS_FOUND_BROTLI} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BROTLI_DEPENDENCIES "${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BROTLI}" "${CONAN_LIB_DIRS_BROTLI}"
                                  CONAN_PACKAGE_TARGETS_BROTLI "${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES}"
                                  "" brotli)
    set(_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_BROTLI_DEBUG} ${CONAN_FRAMEWORKS_FOUND_BROTLI_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BROTLI_DEBUG}" "${CONAN_LIB_DIRS_BROTLI_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_BROTLI_DEBUG "${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_DEBUG}"
                                  "debug" brotli)
    set(_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_BROTLI_RELEASE} ${CONAN_FRAMEWORKS_FOUND_BROTLI_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BROTLI_RELEASE}" "${CONAN_LIB_DIRS_BROTLI_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_BROTLI_RELEASE "${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_RELEASE}"
                                  "release" brotli)
    set(_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_BROTLI_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_BROTLI_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BROTLI_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_BROTLI_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_BROTLI_RELWITHDEBINFO "${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" brotli)
    set(_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_BROTLI_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_BROTLI_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_BROTLI_MINSIZEREL}" "${CONAN_LIB_DIRS_BROTLI_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_BROTLI_MINSIZEREL "${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" brotli)

    add_library(CONAN_PKG::brotli INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::brotli PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_BROTLI} ${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BROTLI_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BROTLI_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BROTLI_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_BROTLI_RELEASE} ${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BROTLI_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BROTLI_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BROTLI_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_BROTLI_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BROTLI_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BROTLI_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BROTLI_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_BROTLI_MINSIZEREL} ${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BROTLI_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BROTLI_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BROTLI_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_BROTLI_DEBUG} ${_CONAN_PKG_LIBS_BROTLI_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BROTLI_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_BROTLI_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_BROTLI_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::brotli PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_BROTLI}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_BROTLI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_BROTLI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_BROTLI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_BROTLI_DEBUG}>)
    set_property(TARGET CONAN_PKG::brotli PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_BROTLI}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_BROTLI_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_BROTLI_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_BROTLI_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_BROTLI_DEBUG}>)
    set_property(TARGET CONAN_PKG::brotli PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_BROTLI_LIST} ${CONAN_CXX_FLAGS_BROTLI_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_BROTLI_RELEASE_LIST} ${CONAN_CXX_FLAGS_BROTLI_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_BROTLI_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_BROTLI_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_BROTLI_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_BROTLI_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_BROTLI_DEBUG_LIST}  ${CONAN_CXX_FLAGS_BROTLI_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_LCMS_DEPENDENCIES "${CONAN_SYSTEM_LIBS_LCMS} ${CONAN_FRAMEWORKS_FOUND_LCMS} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LCMS_DEPENDENCIES "${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LCMS}" "${CONAN_LIB_DIRS_LCMS}"
                                  CONAN_PACKAGE_TARGETS_LCMS "${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES}"
                                  "" lcms)
    set(_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_LCMS_DEBUG} ${CONAN_FRAMEWORKS_FOUND_LCMS_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LCMS_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LCMS_DEBUG}" "${CONAN_LIB_DIRS_LCMS_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_LCMS_DEBUG "${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_DEBUG}"
                                  "debug" lcms)
    set(_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_LCMS_RELEASE} ${CONAN_FRAMEWORKS_FOUND_LCMS_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LCMS_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LCMS_RELEASE}" "${CONAN_LIB_DIRS_LCMS_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_LCMS_RELEASE "${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_RELEASE}"
                                  "release" lcms)
    set(_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_LCMS_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_LCMS_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LCMS_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LCMS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_LCMS_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_LCMS_RELWITHDEBINFO "${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" lcms)
    set(_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_LCMS_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_LCMS_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_LCMS_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_LCMS_MINSIZEREL}" "${CONAN_LIB_DIRS_LCMS_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_LCMS_MINSIZEREL "${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" lcms)

    add_library(CONAN_PKG::lcms INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::lcms PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_LCMS} ${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LCMS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LCMS_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LCMS_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_LCMS_RELEASE} ${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LCMS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LCMS_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LCMS_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_LCMS_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LCMS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LCMS_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LCMS_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_LCMS_MINSIZEREL} ${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LCMS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LCMS_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LCMS_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_LCMS_DEBUG} ${_CONAN_PKG_LIBS_LCMS_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LCMS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_LCMS_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_LCMS_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::lcms PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_LCMS}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_LCMS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_LCMS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_LCMS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_LCMS_DEBUG}>)
    set_property(TARGET CONAN_PKG::lcms PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_LCMS}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_LCMS_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_LCMS_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_LCMS_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_LCMS_DEBUG}>)
    set_property(TARGET CONAN_PKG::lcms PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_LCMS_LIST} ${CONAN_CXX_FLAGS_LCMS_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_LCMS_RELEASE_LIST} ${CONAN_CXX_FLAGS_LCMS_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_LCMS_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_LCMS_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_LCMS_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_LCMS_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_LCMS_DEBUG_LIST}  ${CONAN_CXX_FLAGS_LCMS_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES "${CONAN_SYSTEM_LIBS_YAML-CPP} ${CONAN_FRAMEWORKS_FOUND_YAML-CPP} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES "${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_YAML-CPP}" "${CONAN_LIB_DIRS_YAML-CPP}"
                                  CONAN_PACKAGE_TARGETS_YAML-CPP "${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES}"
                                  "" yaml-cpp)
    set(_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_YAML-CPP_DEBUG} ${CONAN_FRAMEWORKS_FOUND_YAML-CPP_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_YAML-CPP_DEBUG}" "${CONAN_LIB_DIRS_YAML-CPP_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_YAML-CPP_DEBUG "${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_DEBUG}"
                                  "debug" yaml-cpp)
    set(_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_YAML-CPP_RELEASE} ${CONAN_FRAMEWORKS_FOUND_YAML-CPP_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_YAML-CPP_RELEASE}" "${CONAN_LIB_DIRS_YAML-CPP_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_YAML-CPP_RELEASE "${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_RELEASE}"
                                  "release" yaml-cpp)
    set(_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_YAML-CPP_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_YAML-CPP_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_YAML-CPP_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_YAML-CPP_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_YAML-CPP_RELWITHDEBINFO "${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" yaml-cpp)
    set(_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_YAML-CPP_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_YAML-CPP_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_YAML-CPP_MINSIZEREL}" "${CONAN_LIB_DIRS_YAML-CPP_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_YAML-CPP_MINSIZEREL "${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" yaml-cpp)

    add_library(CONAN_PKG::yaml-cpp INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::yaml-cpp PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_YAML-CPP} ${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_YAML-CPP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_YAML-CPP_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_YAML-CPP_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_YAML-CPP_RELEASE} ${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_YAML-CPP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_YAML-CPP_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_YAML-CPP_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_YAML-CPP_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_YAML-CPP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_YAML-CPP_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_YAML-CPP_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_YAML-CPP_MINSIZEREL} ${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_YAML-CPP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_YAML-CPP_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_YAML-CPP_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_YAML-CPP_DEBUG} ${_CONAN_PKG_LIBS_YAML-CPP_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_YAML-CPP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_YAML-CPP_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_YAML-CPP_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::yaml-cpp PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_YAML-CPP}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_YAML-CPP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_YAML-CPP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_YAML-CPP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_YAML-CPP_DEBUG}>)
    set_property(TARGET CONAN_PKG::yaml-cpp PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_YAML-CPP}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_YAML-CPP_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_YAML-CPP_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_YAML-CPP_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_YAML-CPP_DEBUG}>)
    set_property(TARGET CONAN_PKG::yaml-cpp PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_YAML-CPP_LIST} ${CONAN_CXX_FLAGS_YAML-CPP_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_YAML-CPP_RELEASE_LIST} ${CONAN_CXX_FLAGS_YAML-CPP_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_YAML-CPP_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_YAML-CPP_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_YAML-CPP_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_YAML-CPP_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_YAML-CPP_DEBUG_LIST}  ${CONAN_CXX_FLAGS_YAML-CPP_DEBUG_LIST}>)


    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES "${CONAN_SYSTEM_LIBS_ZLIB} ${CONAN_FRAMEWORKS_FOUND_ZLIB} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB}" "${CONAN_LIB_DIRS_ZLIB}"
                                  CONAN_PACKAGE_TARGETS_ZLIB "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}"
                                  "" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG "${CONAN_SYSTEM_LIBS_ZLIB_DEBUG} ${CONAN_FRAMEWORKS_FOUND_ZLIB_DEBUG} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_DEBUG}" "${CONAN_LIB_DIRS_ZLIB_DEBUG}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_DEBUG "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}"
                                  "debug" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE "${CONAN_SYSTEM_LIBS_ZLIB_RELEASE} ${CONAN_FRAMEWORKS_FOUND_ZLIB_RELEASE} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_RELEASE}" "${CONAN_LIB_DIRS_ZLIB_RELEASE}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_RELEASE "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}"
                                  "release" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO "${CONAN_SYSTEM_LIBS_ZLIB_RELWITHDEBINFO} ${CONAN_FRAMEWORKS_FOUND_ZLIB_RELWITHDEBINFO} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_ZLIB_RELWITHDEBINFO}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_RELWITHDEBINFO "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}"
                                  "relwithdebinfo" zlib)
    set(_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL "${CONAN_SYSTEM_LIBS_ZLIB_MINSIZEREL} ${CONAN_FRAMEWORKS_FOUND_ZLIB_MINSIZEREL} ")
    string(REPLACE " " ";" _CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}")
    conan_package_library_targets("${CONAN_PKG_LIBS_ZLIB_MINSIZEREL}" "${CONAN_LIB_DIRS_ZLIB_MINSIZEREL}"
                                  CONAN_PACKAGE_TARGETS_ZLIB_MINSIZEREL "${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}"
                                  "minsizerel" zlib)

    add_library(CONAN_PKG::zlib INTERFACE IMPORTED)

    # Property INTERFACE_LINK_FLAGS do not work, necessary to add to INTERFACE_LINK_LIBRARIES
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_LINK_LIBRARIES ${CONAN_PACKAGE_TARGETS_ZLIB} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_LIST}>

                                                                 $<$<CONFIG:Release>:${CONAN_PACKAGE_TARGETS_ZLIB_RELEASE} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELEASE}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELEASE_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_RELEASE_LIST}>>

                                                                 $<$<CONFIG:RelWithDebInfo>:${CONAN_PACKAGE_TARGETS_ZLIB_RELWITHDEBINFO} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_RELWITHDEBINFO}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>>

                                                                 $<$<CONFIG:MinSizeRel>:${CONAN_PACKAGE_TARGETS_ZLIB_MINSIZEREL} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_MINSIZEREL}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_MINSIZEREL_LIST}>>

                                                                 $<$<CONFIG:Debug>:${CONAN_PACKAGE_TARGETS_ZLIB_DEBUG} ${_CONAN_PKG_LIBS_ZLIB_DEPENDENCIES_DEBUG}
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${CONAN_SHARED_LINKER_FLAGS_ZLIB_DEBUG_LIST}>
                                                                 $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${CONAN_EXE_LINKER_FLAGS_ZLIB_DEBUG_LIST}>>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CONAN_INCLUDE_DIRS_ZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_ZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_ZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_ZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_ZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_COMPILE_DEFINITIONS ${CONAN_COMPILE_DEFINITIONS_ZLIB}
                                                                      $<$<CONFIG:Release>:${CONAN_COMPILE_DEFINITIONS_ZLIB_RELEASE}>
                                                                      $<$<CONFIG:RelWithDebInfo>:${CONAN_COMPILE_DEFINITIONS_ZLIB_RELWITHDEBINFO}>
                                                                      $<$<CONFIG:MinSizeRel>:${CONAN_COMPILE_DEFINITIONS_ZLIB_MINSIZEREL}>
                                                                      $<$<CONFIG:Debug>:${CONAN_COMPILE_DEFINITIONS_ZLIB_DEBUG}>)
    set_property(TARGET CONAN_PKG::zlib PROPERTY INTERFACE_COMPILE_OPTIONS ${CONAN_C_FLAGS_ZLIB_LIST} ${CONAN_CXX_FLAGS_ZLIB_LIST}
                                                                  $<$<CONFIG:Release>:${CONAN_C_FLAGS_ZLIB_RELEASE_LIST} ${CONAN_CXX_FLAGS_ZLIB_RELEASE_LIST}>
                                                                  $<$<CONFIG:RelWithDebInfo>:${CONAN_C_FLAGS_ZLIB_RELWITHDEBINFO_LIST} ${CONAN_CXX_FLAGS_ZLIB_RELWITHDEBINFO_LIST}>
                                                                  $<$<CONFIG:MinSizeRel>:${CONAN_C_FLAGS_ZLIB_MINSIZEREL_LIST} ${CONAN_CXX_FLAGS_ZLIB_MINSIZEREL_LIST}>
                                                                  $<$<CONFIG:Debug>:${CONAN_C_FLAGS_ZLIB_DEBUG_LIST}  ${CONAN_CXX_FLAGS_ZLIB_DEBUG_LIST}>)

    set(CONAN_TARGETS CONAN_PKG::imgui CONAN_PKG::glm CONAN_PKG::glfw CONAN_PKG::openimageio CONAN_PKG::assimp CONAN_PKG::opengl CONAN_PKG::openexr CONAN_PKG::libtiff CONAN_PKG::fmt CONAN_PKG::boost CONAN_PKG::tsl-robin-map CONAN_PKG::pugixml CONAN_PKG::libsquish CONAN_PKG::openjpeg CONAN_PKG::giflib CONAN_PKG::freetype CONAN_PKG::opencolorio CONAN_PKG::irrxml CONAN_PKG::minizip CONAN_PKG::utfcpp CONAN_PKG::kuba-zip CONAN_PKG::poly2tri CONAN_PKG::rapidjson CONAN_PKG::xz_utils CONAN_PKG::libjpeg CONAN_PKG::jbig CONAN_PKG::zstd CONAN_PKG::libwebp CONAN_PKG::bzip2 CONAN_PKG::libpng CONAN_PKG::brotli CONAN_PKG::lcms CONAN_PKG::yaml-cpp CONAN_PKG::zlib)

endmacro()


macro(conan_basic_setup)
    set(options TARGETS NO_OUTPUT_DIRS SKIP_RPATH KEEP_RPATHS SKIP_STD SKIP_FPIC)
    cmake_parse_arguments(ARGUMENTS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN} )

    if(CONAN_EXPORTED)
        conan_message(STATUS "Conan: called by CMake conan helper")
    endif()

    if(CONAN_IN_LOCAL_CACHE)
        conan_message(STATUS "Conan: called inside local cache")
    endif()

    if(NOT ARGUMENTS_NO_OUTPUT_DIRS)
        conan_message(STATUS "Conan: Adjusting output directories")
        conan_output_dirs_setup()
    endif()

    if(NOT ARGUMENTS_TARGETS)
        conan_message(STATUS "Conan: Using cmake global configuration")
        conan_global_flags()
    else()
        conan_message(STATUS "Conan: Using cmake targets configuration")
        conan_define_targets()
    endif()

    if(ARGUMENTS_SKIP_RPATH)
        # Change by "DEPRECATION" or "SEND_ERROR" when we are ready
        conan_message(WARNING "Conan: SKIP_RPATH is deprecated, it has been renamed to KEEP_RPATHS")
    endif()

    if(NOT ARGUMENTS_SKIP_RPATH AND NOT ARGUMENTS_KEEP_RPATHS)
        # Parameter has renamed, but we keep the compatibility with old SKIP_RPATH
        conan_set_rpath()
    endif()

    if(NOT ARGUMENTS_SKIP_STD)
        conan_set_std()
    endif()

    if(NOT ARGUMENTS_SKIP_FPIC)
        conan_set_fpic()
    endif()

    conan_check_compiler()
    conan_set_libcxx()
    conan_set_vs_runtime()
    conan_set_find_paths()
    conan_include_build_modules()
    conan_set_find_library_paths()
endmacro()


macro(conan_set_find_paths)
    # CMAKE_MODULE_PATH does not have Debug/Release config, but there are variables
    # CONAN_CMAKE_MODULE_PATH_DEBUG to be used by the consumer
    # CMake can find findXXX.cmake files in the root of packages
    set(CMAKE_MODULE_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_MODULE_PATH})

    # Make find_package() to work
    set(CMAKE_PREFIX_PATH ${CONAN_CMAKE_MODULE_PATH} ${CMAKE_PREFIX_PATH})

    # Set the find root path (cross build)
    set(CMAKE_FIND_ROOT_PATH ${CONAN_CMAKE_FIND_ROOT_PATH} ${CMAKE_FIND_ROOT_PATH})
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM)
        set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_PROGRAM})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY)
        set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_LIBRARY})
    endif()
    if(CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE)
        set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ${CONAN_CMAKE_FIND_ROOT_PATH_MODE_INCLUDE})
    endif()
endmacro()


macro(conan_set_find_library_paths)
    # CMAKE_INCLUDE_PATH, CMAKE_LIBRARY_PATH does not have Debug/Release config, but there are variables
    # CONAN_INCLUDE_DIRS_DEBUG/RELEASE CONAN_LIB_DIRS_DEBUG/RELEASE to be used by the consumer
    # For find_library
    set(CMAKE_INCLUDE_PATH ${CONAN_INCLUDE_DIRS} ${CMAKE_INCLUDE_PATH})
    set(CMAKE_LIBRARY_PATH ${CONAN_LIB_DIRS} ${CMAKE_LIBRARY_PATH})
endmacro()


macro(conan_set_vs_runtime)
    if(CONAN_LINK_RUNTIME)
        conan_get_policy(CMP0091 policy_0091)
        if(policy_0091 STREQUAL "NEW")
            if(CONAN_LINK_RUNTIME MATCHES "MTd")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebug")
            elseif(CONAN_LINK_RUNTIME MATCHES "MDd")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebugDLL")
            elseif(CONAN_LINK_RUNTIME MATCHES "MT")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")
            elseif(CONAN_LINK_RUNTIME MATCHES "MD")
                set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")
            endif()
        else()
            foreach(flag CMAKE_C_FLAGS_RELEASE CMAKE_CXX_FLAGS_RELEASE
                         CMAKE_C_FLAGS_RELWITHDEBINFO CMAKE_CXX_FLAGS_RELWITHDEBINFO
                         CMAKE_C_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_MINSIZEREL)
                if(DEFINED ${flag})
                    string(REPLACE "/MD" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
                endif()
            endforeach()
            foreach(flag CMAKE_C_FLAGS_DEBUG CMAKE_CXX_FLAGS_DEBUG)
                if(DEFINED ${flag})
                    string(REPLACE "/MDd" ${CONAN_LINK_RUNTIME} ${flag} "${${flag}}")
                endif()
            endforeach()
        endif()
    endif()
endmacro()


macro(conan_flags_setup)
    # Macro maintained for backwards compatibility
    conan_set_find_library_paths()
    conan_global_flags()
    conan_set_rpath()
    conan_set_vs_runtime()
    conan_set_libcxx()
endmacro()


function(conan_message MESSAGE_OUTPUT)
    if(NOT CONAN_CMAKE_SILENT_OUTPUT)
        message(${ARGV${0}})
    endif()
endfunction()


function(conan_get_policy policy_id policy)
    if(POLICY "${policy_id}")
        cmake_policy(GET "${policy_id}" _policy)
        set(${policy} "${_policy}" PARENT_SCOPE)
    else()
        set(${policy} "" PARENT_SCOPE)
    endif()
endfunction()


function(conan_find_libraries_abs_path libraries package_libdir libraries_abs_path)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${CONAN_FOUND_LIBRARY})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()
    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()


function(conan_package_library_targets libraries package_libdir libraries_abs_path deps build_type package_name)
    unset(_CONAN_ACTUAL_TARGETS CACHE)
    unset(_CONAN_FOUND_SYSTEM_LIBS CACHE)
    foreach(_LIBRARY_NAME ${libraries})
        find_library(CONAN_FOUND_LIBRARY NAME ${_LIBRARY_NAME} PATHS ${package_libdir}
                     NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
        if(CONAN_FOUND_LIBRARY)
            conan_message(STATUS "Library ${_LIBRARY_NAME} found ${CONAN_FOUND_LIBRARY}")
            set(_LIB_NAME CONAN_LIB::${package_name}_${_LIBRARY_NAME}${build_type})
            add_library(${_LIB_NAME} UNKNOWN IMPORTED)
            set_target_properties(${_LIB_NAME} PROPERTIES IMPORTED_LOCATION ${CONAN_FOUND_LIBRARY})
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIB_NAME})
            set(_CONAN_ACTUAL_TARGETS ${_CONAN_ACTUAL_TARGETS} ${_LIB_NAME})
        else()
            conan_message(STATUS "Library ${_LIBRARY_NAME} not found in package, might be system one")
            set(CONAN_FULLPATH_LIBS ${CONAN_FULLPATH_LIBS} ${_LIBRARY_NAME})
            set(_CONAN_FOUND_SYSTEM_LIBS "${_CONAN_FOUND_SYSTEM_LIBS};${_LIBRARY_NAME}")
        endif()
        unset(CONAN_FOUND_LIBRARY CACHE)
    endforeach()

    # Add all dependencies to all targets
    string(REPLACE " " ";" deps_list "${deps}")
    foreach(_CONAN_ACTUAL_TARGET ${_CONAN_ACTUAL_TARGETS})
        set_property(TARGET ${_CONAN_ACTUAL_TARGET} PROPERTY INTERFACE_LINK_LIBRARIES "${_CONAN_FOUND_SYSTEM_LIBS};${deps_list}")
    endforeach()

    set(${libraries_abs_path} ${CONAN_FULLPATH_LIBS} PARENT_SCOPE)
endfunction()


macro(conan_set_libcxx)
    if(DEFINED CONAN_LIBCXX)
        conan_message(STATUS "Conan: C++ stdlib: ${CONAN_LIBCXX}")
        if(CONAN_COMPILER STREQUAL "clang" OR CONAN_COMPILER STREQUAL "apple-clang")
            if(CONAN_LIBCXX STREQUAL "libstdc++" OR CONAN_LIBCXX STREQUAL "libstdc++11" )
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libstdc++")
            elseif(CONAN_LIBCXX STREQUAL "libc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
            endif()
        endif()
        if(CONAN_COMPILER STREQUAL "sun-cc")
            if(CONAN_LIBCXX STREQUAL "libCstd")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=Cstd")
            elseif(CONAN_LIBCXX STREQUAL "libstdcxx")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcxx4")
            elseif(CONAN_LIBCXX STREQUAL "libstlport")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stlport4")
            elseif(CONAN_LIBCXX STREQUAL "libstdc++")
                set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -library=stdcpp")
            endif()
        endif()
        if(CONAN_LIBCXX STREQUAL "libstdc++11")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=1)
        elseif(CONAN_LIBCXX STREQUAL "libstdc++")
            add_definitions(-D_GLIBCXX_USE_CXX11_ABI=0)
        endif()
    endif()
endmacro()


macro(conan_set_std)
    conan_message(STATUS "Conan: Adjusting language standard")
    # Do not warn "Manually-specified variables were not used by the project"
    set(ignorevar "${CONAN_STD_CXX_FLAG}${CONAN_CMAKE_CXX_STANDARD}${CONAN_CMAKE_CXX_EXTENSIONS}")
    if (CMAKE_VERSION VERSION_LESS "3.1" OR
        (CMAKE_VERSION VERSION_LESS "3.12" AND ("${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "20" OR "${CONAN_CMAKE_CXX_STANDARD}" STREQUAL "gnu20")))
        if(CONAN_STD_CXX_FLAG)
            conan_message(STATUS "Conan setting CXX_FLAGS flags: ${CONAN_STD_CXX_FLAG}")
            set(CMAKE_CXX_FLAGS "${CONAN_STD_CXX_FLAG} ${CMAKE_CXX_FLAGS}")
        endif()
    else()
        if(CONAN_CMAKE_CXX_STANDARD)
            conan_message(STATUS "Conan setting CPP STANDARD: ${CONAN_CMAKE_CXX_STANDARD} WITH EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS}")
            set(CMAKE_CXX_STANDARD ${CONAN_CMAKE_CXX_STANDARD})
            set(CMAKE_CXX_EXTENSIONS ${CONAN_CMAKE_CXX_EXTENSIONS})
        endif()
    endif()
endmacro()


macro(conan_set_rpath)
    conan_message(STATUS "Conan: Adjusting default RPATHs Conan policies")
    if(APPLE)
        # https://cmake.org/Wiki/CMake_RPATH_handling
        # CONAN GUIDE: All generated libraries should have the id and dependencies to other
        # dylibs without path, just the name, EX:
        # libMyLib1.dylib:
        #     libMyLib1.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     libMyLib0.dylib (compatibility version 0.0.0, current version 0.0.0)
        #     /usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 120.0.0)
        #     /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1197.1.1)
        # AVOID RPATH FOR *.dylib, ALL LIBS BETWEEN THEM AND THE EXE
        # SHOULD BE ON THE LINKER RESOLVER PATH (./ IS ONE OF THEM)
        set(CMAKE_SKIP_RPATH 1 CACHE BOOL "rpaths" FORCE)
        # Policy CMP0068
        # We want the old behavior, in CMake >= 3.9 CMAKE_SKIP_RPATH won't affect the install_name in OSX
        set(CMAKE_INSTALL_NAME_DIR "")
    endif()
endmacro()


macro(conan_set_fpic)
    if(DEFINED CONAN_CMAKE_POSITION_INDEPENDENT_CODE)
        conan_message(STATUS "Conan: Adjusting fPIC flag (${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})")
        set(CMAKE_POSITION_INDEPENDENT_CODE ${CONAN_CMAKE_POSITION_INDEPENDENT_CODE})
    endif()
endmacro()


macro(conan_output_dirs_setup)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})

    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
endmacro()


macro(conan_split_version VERSION_STRING MAJOR MINOR)
    #make a list from the version string
    string(REPLACE "." ";" VERSION_LIST "${VERSION_STRING}")

    #write output values
    list(LENGTH VERSION_LIST _version_len)
    list(GET VERSION_LIST 0 ${MAJOR})
    if(${_version_len} GREATER 1)
        list(GET VERSION_LIST 1 ${MINOR})
    endif()
endmacro()


macro(conan_error_compiler_version)
    message(FATAL_ERROR "Detected a mismatch for the compiler version between your conan profile settings and CMake: \n"
                        "Compiler version specified in your conan profile: ${CONAN_COMPILER_VERSION}\n"
                        "Compiler version detected in CMake: ${VERSION_MAJOR}.${VERSION_MINOR}\n"
                        "Please check your conan profile settings (conan profile show [default|your_profile_name])\n"
                        "P.S. You may set CONAN_DISABLE_CHECK_COMPILER CMake variable in order to disable this check."
           )
endmacro()

set(_CONAN_CURRENT_DIR ${CMAKE_CURRENT_LIST_DIR})

function(conan_get_compiler CONAN_INFO_COMPILER CONAN_INFO_COMPILER_VERSION)
    conan_message(STATUS "Current conanbuildinfo.cmake directory: " ${_CONAN_CURRENT_DIR})
    if(NOT EXISTS ${_CONAN_CURRENT_DIR}/conaninfo.txt)
        conan_message(STATUS "WARN: conaninfo.txt not found")
        return()
    endif()

    file (READ "${_CONAN_CURRENT_DIR}/conaninfo.txt" CONANINFO)

    # MATCHALL will match all, including the last one, which is the full_settings one
    string(REGEX MATCH "full_settings.*" _FULL_SETTINGS_MATCHED ${CONANINFO})
    string(REGEX MATCH "compiler=([-A-Za-z0-9_ ]+)" _MATCHED ${_FULL_SETTINGS_MATCHED})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER)
        set(${CONAN_INFO_COMPILER} ${_CONAN_INFO_COMPILER} PARENT_SCOPE)
    endif()

    string(REGEX MATCH "compiler.version=([-A-Za-z0-9_.]+)" _MATCHED ${_FULL_SETTINGS_MATCHED})
    if(DEFINED CMAKE_MATCH_1)
        string(STRIP "${CMAKE_MATCH_1}" _CONAN_INFO_COMPILER_VERSION)
        set(${CONAN_INFO_COMPILER_VERSION} ${_CONAN_INFO_COMPILER_VERSION} PARENT_SCOPE)
    endif()
endfunction()


function(check_compiler_version)
    conan_split_version(${CMAKE_CXX_COMPILER_VERSION} VERSION_MAJOR VERSION_MINOR)
    if(DEFINED CONAN_SETTINGS_COMPILER_TOOLSET)
       conan_message(STATUS "Conan: Skipping compiler check: Declared 'compiler.toolset'")
       return()
    endif()
    if(CMAKE_CXX_COMPILER_ID MATCHES MSVC)
        # MSVC_VERSION is defined since 2.8.2 at least
        # https://cmake.org/cmake/help/v2.8.2/cmake.html#variable:MSVC_VERSION
        # https://cmake.org/cmake/help/v3.14/variable/MSVC_VERSION.html
        if(
            # 1920-1929 = VS 16.0 (v142 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "16" AND NOT((MSVC_VERSION GREATER 1919) AND (MSVC_VERSION LESS 1930))) OR
            # 1910-1919 = VS 15.0 (v141 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "15" AND NOT((MSVC_VERSION GREATER 1909) AND (MSVC_VERSION LESS 1920))) OR
            # 1900      = VS 14.0 (v140 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "14" AND NOT(MSVC_VERSION EQUAL 1900)) OR
            # 1800      = VS 12.0 (v120 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "12" AND NOT VERSION_MAJOR STREQUAL "18") OR
            # 1700      = VS 11.0 (v110 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "11" AND NOT VERSION_MAJOR STREQUAL "17") OR
            # 1600      = VS 10.0 (v100 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "10" AND NOT VERSION_MAJOR STREQUAL "16") OR
            # 1500      = VS  9.0 (v90 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "9" AND NOT VERSION_MAJOR STREQUAL "15") OR
            # 1400      = VS  8.0 (v80 toolset)
            (CONAN_COMPILER_VERSION STREQUAL "8" AND NOT VERSION_MAJOR STREQUAL "14") OR
            # 1310      = VS  7.1, 1300      = VS  7.0
            (CONAN_COMPILER_VERSION STREQUAL "7" AND NOT VERSION_MAJOR STREQUAL "13") OR
            # 1200      = VS  6.0
            (CONAN_COMPILER_VERSION STREQUAL "6" AND NOT VERSION_MAJOR STREQUAL "12") )
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "gcc")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 5.0)
            conan_message(STATUS "Conan: Compiler GCC>=5, checking major version ${CONAN_COMPILER_VERSION}")
            conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
                set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL ${_CONAN_VERSION})
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "clang")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        set(_CHECK_VERSION ${VERSION_MAJOR}.${VERSION_MINOR})
        set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 8.0)
            conan_message(STATUS "Conan: Compiler Clang>=8, checking major version ${CONAN_COMPILER_VERSION}")
            if("${CONAN_COMPILER_MINOR}" STREQUAL "")
                set(_CHECK_VERSION ${VERSION_MAJOR})
                set(_CONAN_VERSION ${CONAN_COMPILER_MAJOR})
            endif()
        endif()
        conan_message(STATUS "Conan: Checking correct version: ${_CHECK_VERSION}")
        if(NOT ${_CHECK_VERSION} VERSION_EQUAL ${_CONAN_VERSION})
            conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "apple-clang" OR CONAN_COMPILER STREQUAL "sun-cc" OR CONAN_COMPILER STREQUAL "mcst-lcc")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        if(NOT ${VERSION_MAJOR}.${VERSION_MINOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
           conan_error_compiler_version()
        endif()
    elseif(CONAN_COMPILER STREQUAL "intel")
        conan_split_version(${CONAN_COMPILER_VERSION} CONAN_COMPILER_MAJOR CONAN_COMPILER_MINOR)
        if(NOT ${CONAN_COMPILER_VERSION} VERSION_LESS 19.1)
            if(NOT ${VERSION_MAJOR}.${VERSION_MINOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR}.${CONAN_COMPILER_MINOR})
               conan_error_compiler_version()
            endif()
        else()
            if(NOT ${VERSION_MAJOR} VERSION_EQUAL ${CONAN_COMPILER_MAJOR})
               conan_error_compiler_version()
            endif()
        endif()
    else()
        conan_message(STATUS "WARN: Unknown compiler '${CONAN_COMPILER}', skipping the version check...")
    endif()
endfunction()


function(conan_check_compiler)
    if(CONAN_DISABLE_CHECK_COMPILER)
        conan_message(STATUS "WARN: Disabled conan compiler checks")
        return()
    endif()
    if(NOT DEFINED CMAKE_CXX_COMPILER_ID)
        if(DEFINED CMAKE_C_COMPILER_ID)
            conan_message(STATUS "This project seems to be plain C, using '${CMAKE_C_COMPILER_ID}' compiler")
            set(CMAKE_CXX_COMPILER_ID ${CMAKE_C_COMPILER_ID})
            set(CMAKE_CXX_COMPILER_VERSION ${CMAKE_C_COMPILER_VERSION})
        else()
            message(FATAL_ERROR "This project seems to be plain C, but no compiler defined")
        endif()
    endif()
    if(NOT CMAKE_CXX_COMPILER_ID AND NOT CMAKE_C_COMPILER_ID)
        # This use case happens when compiler is not identified by CMake, but the compilers are there and work
        conan_message(STATUS "*** WARN: CMake was not able to identify a C or C++ compiler ***")
        conan_message(STATUS "*** WARN: Disabling compiler checks. Please make sure your settings match your environment ***")
        return()
    endif()
    if(NOT DEFINED CONAN_COMPILER)
        conan_get_compiler(CONAN_COMPILER CONAN_COMPILER_VERSION)
        if(NOT DEFINED CONAN_COMPILER)
            conan_message(STATUS "WARN: CONAN_COMPILER variable not set, please make sure yourself that "
                          "your compiler and version matches your declared settings")
            return()
        endif()
    endif()

    if(NOT CMAKE_HOST_SYSTEM_NAME STREQUAL ${CMAKE_SYSTEM_NAME})
        set(CROSS_BUILDING 1)
    endif()

    # If using VS, verify toolset
    if (CONAN_COMPILER STREQUAL "Visual Studio")
        if (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "LLVM" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "llvm" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "clang" OR
            CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "Clang")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Clang")
        elseif (CONAN_SETTINGS_COMPILER_TOOLSET MATCHES "Intel")
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "Intel")
        else()
            set(EXPECTED_CMAKE_CXX_COMPILER_ID "MSVC")
        endif()

        if (NOT CMAKE_CXX_COMPILER_ID MATCHES ${EXPECTED_CMAKE_CXX_COMPILER_ID})
            message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}'. Toolset specifies compiler as '${EXPECTED_CMAKE_CXX_COMPILER_ID}' "
                                "but CMake detected '${CMAKE_CXX_COMPILER_ID}'")
        endif()

    # Avoid checks when cross compiling, apple-clang crashes because its APPLE but not apple-clang
    # Actually CMake is detecting "clang" when you are using apple-clang, only if CMP0025 is set to NEW will detect apple-clang
    elseif((CONAN_COMPILER STREQUAL "gcc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "GNU") OR
        (CONAN_COMPILER STREQUAL "apple-clang" AND NOT CROSS_BUILDING AND (NOT APPLE OR NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang")) OR
        (CONAN_COMPILER STREQUAL "clang" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang") OR
        (CONAN_COMPILER STREQUAL "sun-cc" AND NOT CMAKE_CXX_COMPILER_ID MATCHES "SunPro") )
        message(FATAL_ERROR "Incorrect '${CONAN_COMPILER}', is not the one detected by CMake: '${CMAKE_CXX_COMPILER_ID}'")
    endif()


    if(NOT DEFINED CONAN_COMPILER_VERSION)
        conan_message(STATUS "WARN: CONAN_COMPILER_VERSION variable not set, please make sure yourself "
                             "that your compiler version matches your declared settings")
        return()
    endif()
    check_compiler_version()
endfunction()


macro(conan_set_flags build_type)
    set(CMAKE_CXX_FLAGS${build_type} "${CMAKE_CXX_FLAGS${build_type}} ${CONAN_CXX_FLAGS${build_type}}")
    set(CMAKE_C_FLAGS${build_type} "${CMAKE_C_FLAGS${build_type}} ${CONAN_C_FLAGS${build_type}}")
    set(CMAKE_SHARED_LINKER_FLAGS${build_type} "${CMAKE_SHARED_LINKER_FLAGS${build_type}} ${CONAN_SHARED_LINKER_FLAGS${build_type}}")
    set(CMAKE_EXE_LINKER_FLAGS${build_type} "${CMAKE_EXE_LINKER_FLAGS${build_type}} ${CONAN_EXE_LINKER_FLAGS${build_type}}")
endmacro()


macro(conan_global_flags)
    if(CONAN_SYSTEM_INCLUDES)
        include_directories(SYSTEM ${CONAN_INCLUDE_DIRS}
                                   "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                                   "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                                   "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                                   "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    else()
        include_directories(${CONAN_INCLUDE_DIRS}
                            "$<$<CONFIG:Release>:${CONAN_INCLUDE_DIRS_RELEASE}>"
                            "$<$<CONFIG:RelWithDebInfo>:${CONAN_INCLUDE_DIRS_RELWITHDEBINFO}>"
                            "$<$<CONFIG:MinSizeRel>:${CONAN_INCLUDE_DIRS_MINSIZEREL}>"
                            "$<$<CONFIG:Debug>:${CONAN_INCLUDE_DIRS_DEBUG}>")
    endif()

    link_directories(${CONAN_LIB_DIRS})

    conan_find_libraries_abs_path("${CONAN_LIBS_DEBUG}" "${CONAN_LIB_DIRS_DEBUG}"
                                  CONAN_LIBS_DEBUG)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELEASE}" "${CONAN_LIB_DIRS_RELEASE}"
                                  CONAN_LIBS_RELEASE)
    conan_find_libraries_abs_path("${CONAN_LIBS_RELWITHDEBINFO}" "${CONAN_LIB_DIRS_RELWITHDEBINFO}"
                                  CONAN_LIBS_RELWITHDEBINFO)
    conan_find_libraries_abs_path("${CONAN_LIBS_MINSIZEREL}" "${CONAN_LIB_DIRS_MINSIZEREL}"
                                  CONAN_LIBS_MINSIZEREL)

    add_compile_options(${CONAN_DEFINES}
                        "$<$<CONFIG:Debug>:${CONAN_DEFINES_DEBUG}>"
                        "$<$<CONFIG:Release>:${CONAN_DEFINES_RELEASE}>"
                        "$<$<CONFIG:RelWithDebInfo>:${CONAN_DEFINES_RELWITHDEBINFO}>"
                        "$<$<CONFIG:MinSizeRel>:${CONAN_DEFINES_MINSIZEREL}>")

    conan_set_flags("")
    conan_set_flags("_RELEASE")
    conan_set_flags("_DEBUG")

endmacro()


macro(conan_target_link_libraries target)
    if(CONAN_TARGETS)
        target_link_libraries(${target} ${CONAN_TARGETS})
    else()
        target_link_libraries(${target} ${CONAN_LIBS})
        foreach(_LIB ${CONAN_LIBS_RELEASE})
            target_link_libraries(${target} optimized ${_LIB})
        endforeach()
        foreach(_LIB ${CONAN_LIBS_DEBUG})
            target_link_libraries(${target} debug ${_LIB})
        endforeach()
    endif()
endmacro()


macro(conan_include_build_modules)
    if(CMAKE_BUILD_TYPE)
        if(${CMAKE_BUILD_TYPE} MATCHES "Debug")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_DEBUG} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "Release")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELEASE} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "RelWithDebInfo")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_RELWITHDEBINFO} ${CONAN_BUILD_MODULES_PATHS})
        elseif(${CMAKE_BUILD_TYPE} MATCHES "MinSizeRel")
            set(CONAN_BUILD_MODULES_PATHS ${CONAN_BUILD_MODULES_PATHS_MINSIZEREL} ${CONAN_BUILD_MODULES_PATHS})
        endif()
    endif()

    foreach(_BUILD_MODULE_PATH ${CONAN_BUILD_MODULES_PATHS})
        include(${_BUILD_MODULE_PATH})
    endforeach()
endmacro()


### Definition of user declared vars (user_info) ###

set(CONAN_USER_BOOST_stacktrace_addr2line_available "False")
set(CONAN_USER_FREETYPE_LIBTOOL_VERSION "23.0.17")