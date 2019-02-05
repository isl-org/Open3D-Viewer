# macOS package
message(STATUS "Building package for macOS")

link_directories(${Open3D_LIBRARY_DIRS})

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bundle)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/bundle)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/bundle)

# open3d-viewer-core
# For some reason we cannot set_target_properties to sepcify the RUNTIME_OUTPUT_DIRECTORY
add_executable(open3d-viewer-core
    ../main.cc
    ../auto_visualize.cc
)
target_include_directories(open3d-viewer-core PUBLIC ${PROJECT_SOURCE_DIR})
target_link_libraries(open3d-viewer-core ${Open3D_LIBRARIES} dl)
set_target_properties(
    open3d-viewer-core
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY
    ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/open3d-viewer.app/Contents/Resources)

# open3d-viewer
add_executable(
    open3d-viewer
    MACOSX_BUNDLE
    # Obj-C++ files
    AppDelegate.h
    AppDelegate.mm
    main.mm
    # Misc files
    MainMenu.xib
    open3d.icns
    open3d_docs.icns
)
set_source_files_properties(
    MainMenu.xib
    open3d.icns
    open3d_docs.icns
    PROPERTIES
    MACOSX_PACKAGE_LOCATION Resources
)
set_target_properties(
    open3d-viewer
    PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST
    ${CMAKE_CURRENT_LIST_DIR}/plist.in
)
target_include_directories(open3d-viewer PUBLIC ${PROJECT_SOURCE_DIR})
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework AppKit")

# get_target_property(archive_output_dir open3d-viewer LINK_FLAGS)
# message(STATUS "archive_output_dir: ${archive_output_dir}")
# get_target_property(library_output_dir open3d-viewer LIBRARY_OUTPUT_DIRECTORY)
# message(STATUS "library_output_dir: ${library_output_dir}")
# get_target_property(runtime_output_dir open3d-viewer RUNTIME_OUTPUT_DIRECTORY)
# message(STATUS "runtime_output_dir: ${runtime_output_dir}")
