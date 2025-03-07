#import "FearthUtils.h"

@implementation FearthUtils

+ (void)openURL:(NSString *)url {
    NSLog(@"[FearthUtils] <openURL> url: %@", url);
    if (!url) return;
    NSURL *nsurl = [NSURL URLWithString:url];
    if (!nsurl) {
        NSLog(@"[FearthUtils] <openURL> Invalid URL: %@", url);
        return;
    }
    [[UIApplication sharedApplication] openURL:nsurl options:@{} completionHandler:^(BOOL success) {
        if (!success) NSLog(@"[FearthUtils] <openURL> Failed!!! URL: %@", url);
    }];
}

+ (void)openURLInAppBrowser:(NSString *)url fromViewController:(UIViewController *)viewController {
    NSLog(@"[FearthUtils] <openURLInAppBrowser> url: %@", url);
    if (!url || !viewController) return;

    NSURL *nsurl = [NSURL URLWithString:url];
    if (!nsurl) {
        NSLog(@"[FearthUtils] <openURLInAppBrowser> Invalid URL: %@", url);
        return;
    }

    if (@available(iOS 9.0, *)) {
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:nsurl];
        [viewController presentViewController:safariVC animated:YES completion:nil];
    } else {
        NSLog(@"[FearthUtils] <openURLInAppBrowser> SFSafariViewController only available from iOS 9.0");
        [FearthUtils openURL:url];
    }
}

@end
