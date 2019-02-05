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

#import "AppDelegate.h"
#import "string"

@implementation AppDelegate

@synthesize window = _windows;
- (void)applicationDidFinishLaunching:(NSNotification*)aNotification {
    // Insert code here to initialize your application
}

- (BOOL)application:(NSApplication*)sender openFile:(NSString*)filename {
    // Redirect log for debugging
    // int fd = creat("/Users/ylao/repo/Open3D-Viewer/log.txt",
    //                S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    // close(STDERR_FILENO);
    // dup(fd);
    // close(fd);

    // Get full command
    NSString* resource_path = [[NSBundle mainBundle] resourcePath];
    NSString* open3d_viewer_path = [NSString
            stringWithFormat:@"%@/%@", resource_path, @"open3d-viewer-core"];
    NSString* full_command =
            [NSString stringWithFormat:@"%@ %@", open3d_viewer_path, filename];

    NSTask* task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
    [task setArguments:[NSArray arrayWithObjects:@"-c", full_command, nil]];
    // [task setStandardOutput:[NSPipe pipe]];
    // [task setStandardInput:[NSPipe pipe]];
    [task launch];
    // [task waitUntilExit];
    [task release];

    // Terminate app: https://stackoverflow.com/a/25259343/1255535
    [[NSApplication sharedApplication] terminate:nil];
    return YES;
}
@end
