##
# Taken from here
#     https://github.com/microsoft/DirectXShaderCompiler/blob/master/cmake/modules/FindD3D12.cmake
#
# And slightly modified to make this work for this project.
##

# Find the win10 SDK path.
if ("$ENV{WIN10_SDK_PATH}$ENV{WIN10_SDK_VERSION}" STREQUAL "" )
  get_filename_component(WIN10_SDK_PATH "[HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\Microsoft\\Microsoft SDKs\\Windows\\v10.0;InstallationFolder]" ABSOLUTE CACHE)
  get_filename_component(TEMP_WIN10_SDK_VERSION "[HKEY_LOCAL_MACHINE\\SOFTWARE\\WOW6432Node\\Microsoft\\Microsoft SDKs\\Windows\\v10.0;ProductVersion]" ABSOLUTE CACHE)
  get_filename_component(WIN10_SDK_VERSION ${TEMP_WIN10_SDK_VERSION} NAME)
elseif(TRUE)
  set (WIN10_SDK_PATH $ENV{WIN10_SDK_PATH})
  set (WIN10_SDK_VERSION $ENV{WIN10_SDK_VERSION})
endif ("$ENV{WIN10_SDK_PATH}$ENV{WIN10_SDK_VERSION}" STREQUAL "" )

# WIN10_SDK_PATH will be something like C:\Program Files (x86)\Windows Kits\10
# WIN10_SDK_VERSION will be something like 10.0.14393 or 10.0.14393.0; we need the
# one that matches the directory name.

if (IS_DIRECTORY "${WIN10_SDK_PATH}/Include/${WIN10_SDK_VERSION}.0")
  set(WIN10_SDK_VERSION "${WIN10_SDK_VERSION}.0")
endif (IS_DIRECTORY "${WIN10_SDK_PATH}/Include/${WIN10_SDK_VERSION}.0")


# Find the d3d12 and dxgi include path, it will typically look something like this.
# C:\Program Files (x86)\Windows Kits\10\Include\10.0.10586.0\um\d3d12.h
# C:\Program Files (x86)\Windows Kits\10\Include\10.0.10586.0\shared\dxgi1_4.h
find_path(D3D12_INCLUDE_DIR    # Set variable D3D12_INCLUDE_DIR
          d3d12.h                # Find a path with d3d12.h
          HINTS "${WIN10_SDK_PATH}/Include/${WIN10_SDK_VERSION}/um"
          DOC "path to WIN10 SDK header files"
          HINTS
          )

find_path(DXGI_INCLUDE_DIR    # Set variable DXGI_INCLUDE_DIR
          dxgi1_4.h           # Find a path with dxgi1_4.h
          HINTS "${WIN10_SDK_PATH}/Include/${WIN10_SDK_VERSION}/shared"
          DOC "path to WIN10 SDK header files"
          HINTS
          )

if(D3D12_INCLUDE_DIR AND DXGI_INCLUDE_DIR)
    set(D3D12_INCLUDE_DIRS ${D3D12_INCLUDE_DIR} ${DXGI_INCLUDE_DIR})
endif()

if(CMAKE_SYSTEM_PROCESSOR MATCHES "^arm")
    set(_arch arm)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^aarch64")
    set(_arch arm64)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "(x86_64)|(AMD64|amd64)")
    set(_arch x64)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^i.86$")
    set(_arch x86)
endif()

find_library(D3D12_LIBRARY NAMES d3d12.lib
             HINTS ${WIN10_SDK_PATH}/Lib/${WIN10_SDK_VERSION}/um/${_arch} )

find_library(DXGI_LIBRARY NAMES dxgi.lib
             HINTS ${WIN10_SDK_PATH}/Lib/${WIN10_SDK_VERSION}/um/${_arch} )

find_library(DXGUID_LIBRARY NAMES dxguid.lib
             HINTS ${WIN10_SDK_PATH}/Lib/${WIN10_SDK_VERSION}/um/${_arch} )

if(D3D12_LIBRARY AND DXGI_LIBRARY AND DXGUID_LIBRARY)
    set(D3D12_LIBRARIES ${D3D12_LIBRARY} ${DXGI_LIBRARY} ${DXGUID_LIBRARY})
endif()

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set D3D12_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(D3D12  DEFAULT_MSG
                                  D3D12_INCLUDE_DIRS D3D12_LIBRARIES)

mark_as_advanced(
    D3D12_INCLUDE_DIR
    DXGI_INCLUDE_DIR
    D3D12_INCLUDE_DIRS
    D3D12_LIBRARY
    DXGI_LIBRARY
    DXGUID_LIBRARY
    D3D12_LIBRARIES
)
