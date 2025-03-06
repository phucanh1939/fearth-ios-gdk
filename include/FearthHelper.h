#ifndef FearthHelper_h
#define FearthHelper_h

#import <Foundation/Foundation.h>
#import <SafariServices/SafariServices.h>

@interface FearthHelper : NSObject

+ (void)openURL:(NSString *)url;
+ (void)openURLInAppBrowser:(NSString *)url fromViewController:(UIViewController *)viewController;

@end

#endif /* FearthHelper_h */
