cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(tf_ops LANGUAGES CXX CUDA)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Open3D cmake
include(open3d.cmake)
message(STATUS "Open3D installed to: ${Open3D_LIBRARY_DIRS}")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${Open3D_C_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Open3D_CXX_FLAGS} -O3")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${Open3D_EXE_LINKER_FLAGS}")
message(STATUS ${Open3D_INCLUDE_DIRS})
include_directories(${Open3D_INCLUDE_DIRS})

# Viewer
link_directories(${Open3D_LIBRARY_DIRS})
add_executable(open3d_viewer
    open3d_viewer.cpp
)
target_link_libraries(open3d_viewer ${Open3D_LIBRARIES} dl)