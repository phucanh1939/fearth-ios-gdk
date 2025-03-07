#ifndef FearthUtils_h
#define FearthUtils_h

#import <Foundation/Foundation.h>
#import <SafariServices/SafariServices.h>

@interface FearthUtils : NSObject

+ (void)openURL:(NSString *)url;
+ (void)openURLInAppBrowser:(NSString *)url fromViewController:(UIViewController *)viewController;

@end

#endif /* FearthUtils_h */
