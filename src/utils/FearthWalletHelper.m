#import "FearthWalletHelper.h"
#import <WalletCore/TWHDWallet.h>
//#import <WalletCore/TWHDWallet.h>
#import <WalletCore/TWHash.h>

@implementation FearthWalletHelper

// Helper function to convert NSString to TWString
+ (TWString *)TWStringCreateWithNSString:(NSString *)string {
    return TWStringCreateWithUTF8Bytes([string UTF8String]);
}

// Helper function to convert TWString to NSString
+ (NSString *)NSStringFromTWString:(TWString *)twString {
    const char *utf8String = TWStringUTF8Bytes(twString);
    return [NSString stringWithUTF8String:utf8String];
}

// Convert NSData to TWData
+ (TWData *)TWDataCreateWithNSData:(NSData *)data {
    return TWDataCreateWithBytes(data.bytes, data.length);
}

// Convert TWData to NSData
+ (NSData *)NSDataFromTWData:(TWData *)twData {
    return [NSData dataWithBytes:TWDataBytes(twData) length:TWDataSize(twData)];
}

// Create a new wallet
+ (NSString *)createWallet {
    @try {
        // Generate a new wallet with 128-bit entropy
        struct TWHDWallet *wallet = TWHDWalletCreate(128, [self TWStringCreateWithNSString:@""]);
        
        // Get mnemonic phrase
        TWString *mnemonic = TWHDWalletMnemonic(wallet);
        NSString *mnemonicString = [self NSStringFromTWString:mnemonic];
        
        // Clean up
        TWStringDelete(mnemonic);
        TWHDWalletDelete(wallet);
        
        NSLog(@"[FearthWalletHelper] <createWallet> phrase = %@", mnemonicString);
        return mnemonicString;
    } @catch (NSException *exception) {
        NSLog(@"[FearthWalletHelper] <createWallet> error = %@", exception.reason);
        return nil;
    }
}

+ (NSString *)addressFromPhrase:(NSString *)phrase {
    @try {
        // Create wallet from mnemonic
        struct TWHDWallet *wallet = TWHDWalletCreateWithMnemonic([self TWStringCreateWithNSString:phrase], [self TWStringCreateWithNSString:@""]);

        if (!wallet) {
            NSLog(@"[FearthWalletHelper] <addressFromPhrase> wallet is null");
            TWHDWalletDelete(wallet);
            return nil;
        }
        
        TWString *address = TWHDWalletGetAddressForCoin(wallet, TWCoinTypeEthereum);
        NSString *addressString = [self NSStringFromTWString:address];

        TWStringDelete(address);
        TWHDWalletDelete(wallet);

        return addressString;
    } @catch (NSException *exception) {
        NSLog(@"[FearthWalletHelper] <addressFromPhrase> Exception: %@", exception.reason);
        return nil;
    }
}

// Sign a message
+ (NSString*)signMessage:(NSString *)message withPhrase:(NSString *)phrase {
    @try {
        // Create wallet from mnemonic
        struct TWHDWallet *wallet = TWHDWalletCreateWithMnemonic([self TWStringCreateWithNSString:phrase], [self TWStringCreateWithNSString:@""]);
        if (!wallet) {
            NSLog(@"[FearthWalletHelper] <signMessage> Wallet creation failed.");
            return nil;
        }

        // Get private key for Ethereum
        struct TWPrivateKey *privateKey = TWHDWalletGetKeyForCoin(wallet, TWCoinTypeEthereum);
        if (!privateKey) {
            NSLog(@"[FearthWalletHelper] <signMessage> Failed to get private key.");
            TWHDWalletDelete(wallet);
            return nil;
        }

        // Convert message to NSData
        NSData *messageData = [message dataUsingEncoding:NSUTF8StringEncoding];

        // Hash the message (Ethereum signs hashed messages)
        TWData *messageHash = TWHashKeccak256([self TWDataCreateWithNSData:messageData]);

        // Sign the hashed message
        TWData *signatureData = TWPrivateKeySign(privateKey, messageHash, TWCurveSECP256k1);
        if (!signatureData) {
            NSLog(@"[FearthWalletHelper] <signMessage> Signing failed.");
            TWDataDelete(messageHash);
            TWPrivateKeyDelete(privateKey);
            TWHDWalletDelete(wallet);
            return nil;
        }

        // Convert signature to base64 string
        NSData *signatureNSData = [self NSDataFromTWData:signatureData];
        NSString *signatureString = [signatureNSData base64EncodedStringWithOptions:0];

        // Clean up
        TWDataDelete(messageHash);
        TWDataDelete(signatureData);
        TWPrivateKeyDelete(privateKey);
        TWHDWalletDelete(wallet);

        return signatureString;
    } @catch (NSException *exception) {
        NSLog(@"[FearthWalletHelper] <signMessage> Exception: %@", exception.reason);
        return nil;
    }
}


@end
