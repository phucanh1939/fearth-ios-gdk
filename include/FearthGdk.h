#ifndef FearthGdk_h
#define FearthGdk_h

#import <Foundation/Foundation.h>
#import "FearthGdkConfig.h"

typedef void (^FearthInitCallback)(NSInteger errorCode);

@interface FearthGdk : NSObject

+ (instancetype)sharedInstance;

- (void)initialize:(FearthGdkConfig*)config callback:(FearthInitCallback)callback;
- (NSString *)createWallet;

@end

#endif /* FearthGdk_h */
