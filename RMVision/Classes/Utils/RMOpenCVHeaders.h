//
//  RMOpenCVHeaders.h
//  RMVision
//
//  Objective-C defines `NO`, which conflicts with OpenCV stitching enums.
//  Temporarily undefine it only while including OpenCV headers.
//

#ifdef __cplusplus

#ifdef NO
#define RM_OPENCV_RESTORE_NO 1
#pragma push_macro("NO")
#undef NO
#endif

#import <opencv2/core/types_c.h>
#import <opencv2/opencv.hpp>

#ifdef RM_OPENCV_RESTORE_NO
#pragma pop_macro("NO")
#undef RM_OPENCV_RESTORE_NO
#endif

#endif
