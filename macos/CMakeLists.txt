# macOS package
message(STATUS "Building package for macOS")

link_directories(${Open3D_LIBRARY_DIRS})

add_executable(
    open3d-viewer
    MACOSX_BUNDLE
    # Obj-C++ files
    AppDelegate.h
    AppDelegate.mm
    main.mm
    # C++ files
    ../auto_visualize.cc
    # Misc files
    MainMenu.xib
    open3d.icns
    open3d_docs.icns
)

set_source_files_properties(
    MainMenu.xib
    PROPERTIES
    MACOSX_PACKAGE_LOCATION
    Resources
)

set_source_files_properties(
    open3d.icns
    PROPERTIES
    MACOSX_PACKAGE_LOCATION
    Resources
)

set_source_files_properties(
    open3d_docs.icns
    PROPERTIES
    MACOSX_PACKAGE_LOCATION
    Resources
)

set_target_properties(
    open3d-viewer
    PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST
    ${CMAKE_CURRENT_LIST_DIR}/plist.in
)

target_link_libraries(open3d-viewer ${Open3D_LIBRARIES} dl)
target_include_directories(open3d-viewer PUBLIC ${PROJECT_SOURCE_DIR})
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework AppKit")
