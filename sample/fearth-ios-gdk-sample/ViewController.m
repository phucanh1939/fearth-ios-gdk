//
//  ViewController.m
//  fearth-ios-gdk-sample
//
//  Created by Phuc Anh on 05/03/2025.
//

#import "ViewController.h"
#import <FearthGdk/FearthHelper.h>
#import <FearthGdk/FearthWalletHelper.h>
#import <FearthGdk/FearthJsonHelper.h>
#import <FearthGdk/FearthHttpHelper.h>

@interface ViewController ()

@end

@interface SampleModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@end

@implementation SampleModel
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)testURL {
    [FearthHelper openURL:@"https://google.com"];
    [FearthHelper openURLInAppBrowser:@"https://google.com" fromViewController:self];
}

- (void)testWallet {
    NSString* phrase = [FearthWalletHelper createWallet];
    NSLog(@"________ phrase = %@", phrase);
    NSString* address = [FearthWalletHelper addressFromPhrase:phrase];
    NSLog(@"________ address = %@", address);
    NSString* signature = [FearthWalletHelper signMessage:@"testMessage" withPhrase:phrase];
    NSLog(@"________ signature = %@", signature);
}

- (void)testJson {
    // Create a sample object
    SampleModel *model = [[SampleModel alloc] init];
    model.name = @"PA HEHE";
    model.age = 30;

    // Convert object to JSON
    NSString *jsonString = [FearthJsonHelper toJson:model];
    NSLog(@"JSON Output: %@", jsonString);

    // Convert JSON back to object
    SampleModel *decodedModel = [FearthJsonHelper fromJson:jsonString toClass:[SampleModel class]];
    NSLog(@"object.name: %@", decodedModel.name);
    NSLog(@"object.age: %ld", decodedModel.age);
}

- (void)testHttp {
    NSString *url = @"https://jsonplaceholder.typicode.com/posts/1";
    
    // Test GET request
    [FearthHttpHelper get:url headers:@{} callback:^(NSInteger status, NSString *text) {
        NSLog(@"GET Response: %ld - %@", (long)status, text);
        
        // Convert response text to JSON object
        id jsonObject = [FearthJsonHelper fromJson:text toClass:[NSDictionary class]];
        NSLog(@"Parsed JSON: %@", jsonObject);
    }];

    // Test POST request
    NSString *postBody = [FearthJsonHelper toJson:@{@"title": @"foo", @"body": @"bar", @"userId": @1}];
    [FearthHttpHelper post:@"https://jsonplaceholder.typicode.com/posts"
                   headers:@{@"Content-Type": @"application/json"}
                      body:postBody
                  callback:^(NSInteger status, NSString *text) {
        NSLog(@"POST Response: %ld - %@", (long)status, text);
    }];

    // Test PUT request
    NSString *putBody = [FearthJsonHelper toJson:@{@"id": @1, @"title": @"updated", @"body": @"new content", @"userId": @1}];
    [FearthHttpHelper put:@"https://jsonplaceholder.typicode.com/posts/1"
                  headers:@{@"Content-Type": @"application/json"}
                     body:putBody
                 callback:^(NSInteger status, NSString *text) {
        NSLog(@"PUT Response: %ld - %@", (long)status, text);
    }];

    // Test DELETE request
    [FearthHttpHelper delete:@"https://jsonplaceholder.typicode.com/posts/1"
                     headers:@{}
                    callback:^(NSInteger status, NSString *text) {
        NSLog(@"DELETE Response: %ld - %@", (long)status, text);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self testHttp];
}

@end
