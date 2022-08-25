//
//  ViewController.m
//  KnotAPIObjectiveCDemo
//
//  Created by TARIK AIT MBAREK on 18/8/2022.
//

#import "ViewController.h"
@import CardOnFileSwitcher;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CardOnFileSwitcherSession * session = [CardOnFileSwitcherSession new];
    [session createSessionWithCompletionHandler:^(NSString *sessionId) {
        NSLog(@"this is session id: %@", sessionId);
        dispatch_async(dispatch_get_main_queue(), ^{
            CardOnFileSwitcherViewController *vc = [[CardOnFileSwitcherViewController alloc] initWithSessionId:sessionId];
            [vc setOnSuccessOnSuccess:^(NSString * merchant) {
                NSLog(@"this is error: %@", merchant);
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
