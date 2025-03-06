//
//  ViewController.m
//  fearth-ios-gdk-sample
//
//  Created by Phuc Anh on 05/03/2025.
//

#import "ViewController.h"
#import <FearthGdk/FearthHelper.h>

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
    [FearthHelper openURLInAppBrowser:@"https://google.com" fromViewController:self];
}


@end
