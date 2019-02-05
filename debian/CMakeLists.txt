# Debian package
message(STATUS "Building package for Debian")

# Viewer
link_directories(${Open3D_LIBRARY_DIRS})
add_executable(open3d-viewer
    ../main.cc
    ../auto_visualize.cc
)
target_include_directories(open3d-viewer PUBLIC ${PROJECT_SOURCE_DIR})
target_link_libraries(open3d-viewer ${Open3D_LIBRARIES} dl)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR})

# Installation locations
# TODO: add icons
install(TARGETS open3d-viewer DESTINATION bin)
install(FILES open3d-viewer.desktop DESTINATION share/applications)
install(FILES open3d-viewer.xml DESTINATION share/mime/packages)
install(FILES open3d-viewer DESTINATION lib/mime/packages)
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

include(CPack)
