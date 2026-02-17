//
//  GPUImageLookupFilter.m
//  RMVision
//
//  Created on 9/23/13.
//  Copyright (c) 2013 Romotive, Inc. All rights reserved.
//

#import "GPUImageCustomLookupFilter.h"
#import "RMGPUImageCompatibility.h"
#import <UIKit/UIKit.h>

static UIImage *RMLookupImageFromBundles(NSString *imageName)
{
    NSString *name = [imageName stringByDeletingPathExtension];
    NSString *ext = [imageName pathExtension];
    if (ext.length == 0) {
        ext = @"png";
    }

    for (NSBundle *bundle in [NSBundle allBundles]) {
        NSString *path = [bundle pathForResource:name ofType:ext];
        if (path) {
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            if (image) {
                return image;
            }
        }
    }

    for (NSBundle *bundle in [NSBundle allFrameworks]) {
        NSString *path = [bundle pathForResource:name ofType:ext];
        if (path) {
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            if (image) {
                return image;
            }
        }
    }

    return nil;
}

@implementation GPUImageCustomLookupFilter

- (id)initWithImageNamed:(NSString *) imageName;
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
    UIImage *image = [UIImage imageNamed:imageName];
    
    // Try again to load the image but treating the string as the path
    if (!image)
    {
        image = [UIImage imageWithContentsOfFile:imageName];
    }

    // SwiftPM resources live in bundles, not necessarily the app's main bundle.
    if (!image)
    {
        image = RMLookupImageFromBundles(imageName);
    }
#else
    NSImage *image = [NSImage imageNamed:imageName];
    
    // Try again to load the image but treating the string as the path
    if (!image)
    {
        image = [NSImage imageWithContentsOfFile:imageName];
    }
#endif
    
    NSAssert(image, @"To use GPUImageCustomLookupFilter you need to add <LookUpTable>.png to GPUImage/framework/Resources to your application bundle.");
    
    lookupImageSource = [[GPUImagePicture alloc] initWithImage:image];
    GPUImageLookupFilter *lookupFilter = [[GPUImageLookupFilter alloc] init];
    [self addFilter:lookupFilter];
    
    [lookupImageSource addTarget:lookupFilter atTextureLocation:1];
    [lookupImageSource processImage];
    
    self.initialFilters = [NSArray arrayWithObjects:lookupFilter, nil];
    self.terminalFilter = lookupFilter;
    
    return self;
}

// 23/6/17 This is probably not needed anymore since the method has been removed from GPUImage and there is no equivalent
//-(void)prepareForImageCapture {
//    [lookupImageSource processImage];
//    [super prepareForImageCapture];
//}

#pragma mark -
#pragma mark Accessors

@end
