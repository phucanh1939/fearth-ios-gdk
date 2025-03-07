#import "FearthGdk.h"
#import "FearthErrorCode.h"
#import "FearthWalletHelper.h"

@interface FearthGdk ()
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *name;
@end

@implementation FearthGdk

+ (instancetype)sharedInstance {
    static FearthGdk* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)loadConfig:(FearthGdkConfig*)config {
    if (config == nil) return;
    self.id = config.id;
    self.name = config.name;
}

- (void)initialize:(FearthGdkConfig*)config callback:(FearthInitCallback)callback {
    NSLog(@"[FearthGdk] <initialize>");
    if (!config) {
        if (callback) callback(FEARTH_ERROR_INVALID_CONFIG);
        return;
    }
    [self loadConfig:config];
    if (callback) callback(FEARTH_ERROR_SUCCESS);
}

- (NSString *)createWallet {
    return [FearthWalletHelper createWallet];
}

@end

