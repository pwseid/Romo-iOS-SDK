//
//  RMCocoaLumberjack.h
//  Romo
//
//  Compatibility import shim for CocoaLumberjack across CocoaPods/SPM layouts.
//

#import <Foundation/Foundation.h>

#if __has_include(<CocoaLumberjack/CocoaLumberjack.h>)
#import <CocoaLumberjack/CocoaLumberjack.h>
#elif __has_include(<CocoaLumberjack/DDLog.h>)
#import <CocoaLumberjack/DDLog.h>
#import <CocoaLumberjack/DDLogMacros.h>
#elif __has_feature(modules)
@import CocoaLumberjack;
#else
#error "CocoaLumberjack headers were not found"
#endif
