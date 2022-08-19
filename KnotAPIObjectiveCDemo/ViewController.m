//
//  ViewController.m
//  KnotAPIObjectiveCDemo
//
//  Created by TARIK AIT MBAREK on 18/8/2022.
//

#import "ViewController.h"
#import "PasswordChangerSDK-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PasswordChangerSession * session = [PasswordChangerSession new];
    [session createSessionWithCompletionHandler:^(NSString *sessionId) {
        NSLog(@"this is session id: %@", sessionId);
        dispatch_async(dispatch_get_main_queue(), ^{
            PasswordChangerViewController *vc = [[PasswordChangerViewController alloc] initWithSessionId:sessionId];
            [vc setOnSuccessOnSuccess:^(NSArray<NSString *> *array) {
                NSLog(@"this is array: %@", array);
            }];
            [vc setOnErrorOnError:^(NSString *error, NSString *message) {
                NSLog(@"this is error: %@", error);
                NSLog(@"this is message: %@", message);
            }];
            [vc setOnEventOnEvent:^(NSString *event, NSString *message) {
                NSLog(@"this is event: %@", event);
                NSLog(@"this is message: %@", message);
            }];
            [vc setOnExitOnExit:^{
                NSLog(@"this is exit");
            }];
            [self presentViewController:vc animated:NO completion:nil];

        });
    }];
}


@end
