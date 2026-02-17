//
//  RMGPUImageCompatibility.h
//  RMVision
//
//  Unifies GPUImage imports across dependency managers.
//

#pragma once

#if __has_feature(modules)
@import GPUImage;
#elif __has_include(<GPUImage/GPUImage.h>)
#import <GPUImage/GPUImage.h>
#elif __has_include(<GPUImage.h>)
#import <GPUImage.h>
#else
#error "GPUImage headers are unavailable."
#endif
