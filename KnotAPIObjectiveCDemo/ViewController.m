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

    CardOnFileSwitcherSession * session = [[CardOnFileSwitcherSession alloc] initWithSessionId:@"8785d82b-c0e5-4eff-b1a9-568ea8a13742"];
    [session setPrimaryColorWithPrimaryColor:@"#000000"];
    [session setTextColorWithTextColor:@"#FFFFFF"];
    [session setCompanyNameWithCompanyName:@"Found"];
    [session openOnCardFileSwitcherWithMerchants:@[]];
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
