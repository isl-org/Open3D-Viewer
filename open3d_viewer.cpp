// ----------------------------------------------------------------------------
// -                        Open3D: www.open3d.org                            -
// ----------------------------------------------------------------------------
// The MIT License (MIT)
//
// Copyright (c) 2018 www.open3d.org
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
// ----------------------------------------------------------------------------

#include <iostream>
#include <memory>
#include <thread>
#include <thread>

#include <Core/Core.h>
#include <IO/IO.h>
#include <Visualization/Visualization.h>

using namespace open3d;

bool read_and_visualize_mesh(const std::string &file_name) {
    auto mesh_ptr = std::make_shared<TriangleMesh>();
    if (ReadTriangleMesh(file_name, *mesh_ptr)) {
        PrintWarning("Successfully read %s\n", file_name.c_str());
        if (mesh_ptr->triangles_.size() == 0) {
            PrintWarning("Contains 0 triangles, will read as point cloud\n");
            return false;
        }
    } else {
        PrintError("Failed to read %s\n\n", file_name.c_str());
        return false;
    }
    mesh_ptr->ComputeVertexNormals();
    DrawGeometries({mesh_ptr}, "Mesh", 1600, 900);
    return true;
}

bool read_and_visualize_point_cloud(const std::string &file_name) {
    auto cloud_ptr = std::make_shared<PointCloud>();
    if (ReadPointCloud(file_name, *cloud_ptr)) {
        PrintWarning("Successfully read %s\n", file_name.c_str());
    } else {
        PrintError("Failed to read %s\n\n", file_name.c_str());
        return false;
    }
    cloud_ptr->NormalizeNormals();
    DrawGeometries({cloud_ptr}, "PointCloud", 1600, 900);
    return true;
}

int main(int argc, char *argv[]) {
    SetVerbosityLevel(VerbosityLevel::VerboseAlways);
    if (argc < 2) {
        PrintOpen3DVersion();
        PrintInfo("Usage: Visualizer [filename]\n");
        std::this_thread::sleep_for(std::chrono::seconds(5));
        return 1;
    }

    std::string file_name(argv[1]);
    bool rc = true;
    if (!read_and_visualize_mesh(file_name)) {
        rc = read_and_visualize_point_cloud(file_name);
    }
    return rc ? 0 : 1;
}
