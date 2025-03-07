//
//  ViewController.m
//  fearth-ios-gdk-sample
//
//  Created by Phuc Anh on 05/03/2025.
//

#import "ViewController.h"
#import <FearthGdk/FearthHelper.h>
#import <FearthGdk/FearthWalletHelper.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // [FearthHelper openURL:@"https://google.com"];
    // [FearthHelper openURLInAppBrowser:@"https://google.com" fromViewController:self];
    NSString* phrase = [FearthWalletHelper createWallet];
    NSLog(@"________ phrase = %@", phrase);
    NSString* address = [FearthWalletHelper addressFromPhrase:phrase];
    NSLog(@"________ address = %@", address);
    NSString* signature = [FearthWalletHelper signMessage:@"testMessage" withPhrase:phrase];
    NSLog(@"________ signature = %@", signature);

}


@end
