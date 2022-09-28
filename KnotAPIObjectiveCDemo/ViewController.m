//
//  ViewController.m
//  KnotAPIObjectiveCDemo
//
//  Created by TARIK AIT MBAREK on 18/8/2022.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)openCardSwitcher:(id)sender {
    CardOnFileSwitcherSession * session = [[CardOnFileSwitcherSession alloc] initWithSessionId:@"9c361eed-f86c-4db7-8adb-92caca93f8d9" clientId:@"ab86955e-22f4-49c3-97d7-369973f4cb9e" environment:EnvironmentSandbox];
    [session setPrimaryColorWithPrimaryColor:@"#000000"];
    [session setTextColorWithTextColor:@"#FFFFFF"];
    [session setCompanyNameWithCompanyName:@"Millions"];
    [session openOnCardFileSwitcherWithMerchants:@[]];
    [session setDelegateWithDelegate:self];
}
- (IBAction)openSubscriptionCanceller:(id)sender {
    CardOnFileSwitcherSession * session = [[CardOnFileSwitcherSession alloc] initWithSessionId:@"9c361eed-f86c-4db7-8adb-92caca93f8d9" clientId:@"ab86955e-22f4-49c3-97d7-369973f4cb9e" environment:EnvironmentSandbox];
    [session setPrimaryColorWithPrimaryColor:@"#000000"];
    [session setTextColorWithTextColor:@"#FFFFFF"];
    [session setCompanyNameWithCompanyName:@"Millions"];
    [session openOnSubscriptionCancelerWithMerchants:@[]];
    [session setDelegateWithDelegate:self];
}

- (void)onSuccessWithMerchant:(NSString *)merchant{
    NSLog(@"onSuccessWithMerchant %@", merchant);
}

- (void)onEventWithEvent:(NSString *)event message:(NSString *)message{
    NSLog(@"onEventWithEvent %@ %@", event, message);
}

- (void)onErrorWithError:(NSString *)error message:(NSString *)message{
    NSLog(@"onErrorWithError %@ %@", error, message);
}

- (void)onExit{
    NSLog(@"onExit");
}

- (void)onFinished{
    NSLog(@"onFinished");

}
@end
