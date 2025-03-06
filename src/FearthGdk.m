#import "FearthGdk.h"
#import "FearthGdkPrivate.h"

@implementation FearthGdk

+ (NSString *)greet:(NSString *)name {
    return [NSString stringWithFormat:@"Hello, %@! Welcome to FearthGdk.", name];
}

@end
