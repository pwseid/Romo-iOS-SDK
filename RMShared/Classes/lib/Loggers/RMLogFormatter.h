//
//  RMLogFormatter.h
//  Romo
//

#import <Foundation/Foundation.h>
#import "RMCocoaLumberjack.h"

@interface RMLogFormatter : NSObject <DDLogFormatter>

- (id)initWithColors:(BOOL)colors;

@end
