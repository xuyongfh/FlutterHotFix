//
//  bsdiff.h
//  DownloadTest
//
//  Created by 曹世鑫 on 2019/6/24.
//  Copyright © 2019 曹世鑫. All rights reserved.
//
#include <stdint.h>

extern "C" __attribute__((visibility("default"))) __attribute__((used)) 
int Bsdiff_bsdiff(int argc, char *argv[]);
int Bsdiff_bspatch(int argc, char *argv[]);
int32_t native_add(int32_t x, int32_t y) { return x + y; }
