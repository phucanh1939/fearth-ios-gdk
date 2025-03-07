#ifndef FEARTH_WALLET_HELPER_H
#define FEARTH_WALLET_HELPER_H

#import <Foundation/Foundation.h>

@interface FearthWalletHelper : NSObject
+ (NSString *)createWallet;
+ (NSString *)addressFromPhrase:(NSString*) phrase;
+ (NSString *)signMessage:(NSString *)message withPhrase:(NSString *)phrase;
@end

#endif
