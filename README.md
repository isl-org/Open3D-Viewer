# Open3D-Viewer

## Ubuntu

```bash
mkdir build
cd build
cmake ..
make -j
cpack ..
sudo dpkg -i open3d-viewer-0.5.0-Linux.deb
```

```bash
sudo apt remove open3d-viewer
```

## Mac

```bash
mkdir build
cd build
cmake -GXcode ..
cmake --build . --target open3d-viewer-core
cmake --build . --target open3d-viewer
cp bundle/open3d-viewer-core bundle/open3d-viewer.app/Contents/Resources
rm -rf /Applications/open3d-viewer.app
cp -r bundle/open3d-viewer.app /Applications
```
