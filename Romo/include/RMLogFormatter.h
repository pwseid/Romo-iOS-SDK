//
//  RMLogFormatter.h
//  Romo
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/DDLog.h>

@interface RMLogFormatter : NSObject <DDLogFormatter>

- (id)initWithColors:(BOOL)colors;

@end
