cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(open3d_viewer LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Open3D cmake
include(open3d.cmake)
message(STATUS "Open3D installed to: ${Open3D_LIBRARY_DIRS}")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${Open3D_C_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${Open3D_CXX_FLAGS} -O3")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${Open3D_EXE_LINKER_FLAGS}")
include_directories(${Open3D_INCLUDE_DIRS})

# Viewer
link_directories(${Open3D_LIBRARY_DIRS})
add_executable(open3d-viewer
    open3d_viewer.cpp
)
target_link_libraries(open3d-viewer ${Open3D_LIBRARIES} dl)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR})

# Debian package
if (DEBIAN_FOUND)
    # Installation locations
    # TODO: add icons
    install(TARGETS open3d-viewer DESTINATION bin)
    install(FILES debian/open3d-viewer.desktop DESTINATION share/applications)
    install(FILES debian/open3d-viewer.xml DESTINATION share/mime/packages)
    install(FILES debian/open3d-viewer DESTINATION lib/mime/packages)
    message(CMAKE_INSTALL_PREFIX)
    message(CPACK_PACKAGING_INSTALL_PREFIX)

    # CPACK parameters
    set(CPACK_GENERATOR "DEB")
    set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Open3D Viewer")
    set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Intel ISL")
    set(CPACK_PACKAGE_NAME "open3d-viewer")
    set(CPACK_PACKAGE_VERSION_MAJOR "0")
    set(CPACK_PACKAGE_VERSION_MINOR "5")
    set(CPACK_PACKAGE_VERSION_PATCH "0")

    # How to set cpack prefix: https://stackoverflow.com/a/7363073/1255535
    set(CPACK_SET_DESTDIR true)
    set(CPACK_INSTALL_PREFIX /usr)
endif()

# macOS package
# Difference betwwen MACOSX_BUNDLE and CPACK_BUNDLE_*:
# https://gitlab.kitware.com/cmake/community/wikis/doc/cpack/PackageGenerators#dragndrop-osx-only
if (APPLE)
    message(STATUS "I am apple")
    message(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH})
    set_target_properties(open3d-viewer PROPERTIES MACOSX_BUNDLE TRUE)

    set(MACOSX_BUNDLE_EXECUTABLE_NAME "open3d-viewer")
    set(MACOSX_BUNDLE_INFO_STRING "Open3D-Viewer: 3D Model viewer with Open3D")
    set(MACOSX_BUNDLE_ICON_FILE "")
    set(MACOSX_BUNDLE_GUI_IDENTIFIER "Open3D-Viewer-GUI")
    set(MACOSX_BUNDLE_LONG_VERSION_STRING "0.5.0")
    set(MACOSX_BUNDLE_BUNDLE_NAME "BNDL") # Default
    set(MACOSX_BUNDLE_SHORT_VERSION_STRING "0.5.0")
    set(MACOSX_BUNDLE_BUNDLE_VERSION "1") # Default
    set(MACOSX_BUNDLE_COPYRIGHT "Copyright © 2019 Intel Corporation. All rights reserved.")
endif()

include(CPack)
