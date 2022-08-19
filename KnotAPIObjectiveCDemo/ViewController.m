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
            [self presentViewController:vc animated:NO completion:nil];
        });
    }];
}


@end
