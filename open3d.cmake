include(ProcessorCount)
ProcessorCount(num_cores)

set(open3d_root ${CMAKE_BINARY_DIR}/open3d_root)
set(open3d_install_prefix ${open3d_root}/open3d_install)

include(ProcessorCount)
ProcessorCount(num_proc)

# Ref: How to find_package after ExternalProject_Add
# https://stackoverflow.com/q/17446981
# https://git.io/fpFTE
function(build_open3d)
    configure_file(${CMAKE_SOURCE_DIR}/open3d_builder.cmake
                   ${open3d_root}/CMakeLists.txt
                   COPYONLY)

    if (WIN32)
        set(CMAKE_GENERATOR "Visual Studio 15 2017 Win64")
    endif ()

    execute_process(
        COMMAND ${CMAKE_COMMAND} -G ${CMAKE_GENERATOR} .
                                 -DCMAKE_INSTALL_PREFIX=${open3d_install_prefix}
                                 -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                                 -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
                                 -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                                 -DBUILD_PYBIND11=OFF
                                 -DBUILD_PYTHON_MODULE=OFF
                                 -DBUILD_PYTHON_TUTORIALS=OFF
                                 -DENABLE_JUPYTER=OFF
        WORKING_DIRECTORY ${open3d_root}
    )

    if (WIN32)
        execute_process(
            COMMAND ${CMAKE_COMMAND} --build . --parallel ${num_proc} --config Release
            WORKING_DIRECTORY ${open3d_root}
        )
    else ()
        execute_process(
            COMMAND ${CMAKE_COMMAND} --build . -- -j ${num_cores}
            WORKING_DIRECTORY ${open3d_root}
        )
    endif ()

    find_package(Open3D HINTS ${open3d_install_prefix}/lib/cmake)
    if (Open3D_FOUND)
        message(STATUS "Found Open3D at ${Open3D_LIBRARY_DIRS}")
        set(Open3D_FOUND ${Open3D_FOUND} PARENT_SCOPE)
        set(Open3D_INCLUDE_DIRS ${Open3D_INCLUDE_DIRS} PARENT_SCOPE)
        set(Open3D_LIBRARY_DIRS ${Open3D_LIBRARY_DIRS} PARENT_SCOPE)
        set(Open3D_LIBRARIES ${Open3D_LIBRARIES} PARENT_SCOPE)
        set(Open3D_C_FLAGS ${Open3D_C_FLAGS} PARENT_SCOPE)
        set(Open3D_CXX_FLAGS ${Open3D_CXX_FLAGS} PARENT_SCOPE)
        set(Open3D_EXE_LINKER_FLAGS ${Open3D_EXE_LINKER_FLAGS} PARENT_SCOPE)
    else ()
        message(FATAL_ERROR "Open3D build was not successful")
    endif ()
endfunction()

build_open3d()
