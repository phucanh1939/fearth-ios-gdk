#import "FearthHelper.h"

@implementation FearthHelper

+ (void)openURL:(NSString *)url {
    NSLog(@"[FearthHelper] <openURL> url: %@", url);
    if (!url) return;
    NSURL *nsurl = [NSURL URLWithString:url];
    if (!nsurl) {
        NSLog(@"[FearthHelper] <openURL> Invalid URL: %@", url);
        return;
    }
    [[UIApplication sharedApplication] openURL:nsurl options:@{} completionHandler:^(BOOL success) {
        if (!success) NSLog(@"[FearthHelper] <openURL> Failed!!! URL: %@", url);
    }];
}

+ (void)openURLInAppBrowser:(NSString *)url fromViewController:(UIViewController *)viewController {
    NSLog(@"[FearthHelper] <openURLInAppBrowser> url: %@", url);
    if (!url || !viewController) return;

    NSURL *nsurl = [NSURL URLWithString:url];
    if (!nsurl) {
        NSLog(@"[FearthHelper] <openURLInAppBrowser> Invalid URL: %@", url);
        return;
    }

    if (@available(iOS 9.0, *)) {
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:nsurl];
        [viewController presentViewController:safariVC animated:YES completion:nil];
    } else {
        NSLog(@"[FearthHelper] <openURLInAppBrowser> SFSafariViewController only available from iOS 9.0");
        [FearthHelper openURL:url];
    }
}

@end
