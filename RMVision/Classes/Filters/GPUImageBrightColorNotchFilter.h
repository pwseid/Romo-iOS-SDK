//
//  GPUImageBrightColorNotchFilter.h
//  RMVision
//
//  Created on 10/2/13.
//  Copyright (c) 2013 Romotive, Inc. All rights reserved.
//

#import "RMGPUImageCompatibility.h"

@interface GPUImageBrightColorNotchFilter : GPUImageFilter


@property (readwrite, nonatomic) float saturationThreshold;
@property (readwrite, nonatomic) float brightnessThreshold;

@end
