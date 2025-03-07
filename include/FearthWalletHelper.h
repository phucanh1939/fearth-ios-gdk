#ifndef FearthWalletHelper_h
#define FearthWalletHelper_h

#import <Foundation/Foundation.h>

@interface FearthWalletHelper : NSObject
+ (NSString *)createWallet;
+ (NSString *)addressFromPhrase:(NSString*) phrase;
+ (NSString *)signMessage:(NSString *)message withPhrase:(NSString *)phrase;
@end

#endif
