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

bool isFromSwicher;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onClick:(UIButton *)sender {
    if (sender.tag == 1) {
        isFromSwicher = true;
    }
    else {
        isFromSwicher = false;
    }
    [self apiCallRegister];
}

-(void)apiCallRegister{
    NSString *urlString = @"https://sample.knotapi.com/api/register";
    NSDictionary *dict = @{ @"first_name" : @"Nikunj", @"last_name" : @"Patel", @"email" : @"production@knotapi.com", @"phone_number" : @"+18024687679", @"password" : @"password", @"address1" : @"348 W 57th St", @"address2" : @"#367", @"state" : @"NY", @"city" : @"NewYork", @"postal_code" : @"10019"};
    NSString *tokenString = @"";
    [self apiCall:urlString param:dict token:tokenString];
}

-(void)apiCallCreateSession:(NSString *)token{
    NSString *urlString = @"https://sample.knotapi.com/api/knot/session";
    NSDictionary *dict = [[NSDictionary alloc] init];
    if(isFromSwicher){
        dict = @{ @"type" : @"card_switcher"};
    }else{
        dict = @{ @"type" : @"subscription_canceller"};
    }
    [self apiCall:urlString param:dict token:token];
}


- (void)apiCall:(NSString *)Url param:(NSDictionary *)parameters token:(NSString *)token{
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
    
    NSData* data1 = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error: nil];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:data1];
    if([token  isEqual: @""]){
        [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    else {
        [urlRequest addValue:[NSString stringWithFormat:@"Bearer %@",token] forHTTPHeaderField:@"Authorization"];
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
            if([token  isEqual: @""]){
                NSString *resToken = [responseDictionary objectForKey:@"token"];
                [self apiCallCreateSession:resToken];
            }
            else{
                NSString *sessionID = [responseDictionary objectForKey:@"session"];
                if (isFromSwicher == true) {
                    CardOnFileSwitcherSession * session = [[CardOnFileSwitcherSession alloc] initWithSessionId:sessionID clientId:@"3f4acb6b-a8c9-47bc-820c-b0eaf24ee771" environment:EnvironmentSandbox];
                    [session setPrimaryColorWithPrimaryColor:@"#000000"];
                    [session setTextColorWithTextColor:@"#FFFFFF"];
                    [session setCompanyNameWithCompanyName:@"Rho"];
                    
                    CardSwitcherConfiguration *cardSwitcherConfig = [[CardSwitcherConfiguration alloc] init];
                    [cardSwitcherConfig setOnSuccessOnSuccess:^(NSString *merchant) {
                        NSLog(@"CardSwitcher Merchant:- %@",merchant);
                    }];
                    [cardSwitcherConfig setOnExitOnExit:^{
                        NSLog(@"CardSwitcher onExit");
                    }];
                    [cardSwitcherConfig setOnErrorOnError:^(NSString * error, NSString * message) {
                        NSLog(@"CardSwitcher Error:- %@ Message: %@",error, message);
                    }];
                    [cardSwitcherConfig setOnEventOnEvent:^(NSString * event, NSString * message) {
                        NSLog(@"CardSwitcher Event:- %@ Merchant: %@",error, message);
                    }];
                    [cardSwitcherConfig setOnFinishedOnFinished:^{
                        NSLog(@"CardSwitcher Finished");
                    }];
                    [session setConfigurationWithConfig:cardSwitcherConfig];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [session openCardOnFileSwitcher];
                    });
                }
                else {
                    SubscriptionCancelerSession * session = [[SubscriptionCancelerSession alloc] initWithSessionId:sessionID clientId:@"3f4acb6b-a8c9-47bc-820c-b0eaf24ee771" environment:EnvironmentSandbox];
                    [session setPrimaryColorWithPrimaryColor:@"#000000"];
                    [session setTextColorWithTextColor:@"#FFFFFF"];
                    [session setCompanyNameWithCompanyName:@"Millions"];
                    [session setAmountWithAmount:true];
                    SubscriptionCancelerConfiguration *config = [[SubscriptionCancelerConfiguration alloc] init];
                    [config setOnSuccessOnSuccess:^(NSString *merchant) {
                        NSLog(@"SubscriptionCanceler onSuccess Merchant:- %@",merchant);
                    }];
                    [config setOnExitOnExit:^{
                        NSLog(@"SubscriptionCanceler onExit");
                    }];
                    [config setOnErrorOnError:^(NSString * error, NSString * message) {
                        NSLog(@"SubscriptionCanceler Error:- %@ Message: %@",error, message);
                    }];
                    [config setOnEventOnEvent:^(NSString * event, NSString * message) {
                        NSLog(@"SubscriptionCanceler Event:- %@ Merchant: %@",error, message);
                    }];
                    [config setOnFinishedOnFinished:^{
                        NSLog(@"SubscriptionCanceler Finished");
                    }];
                    [session setConfigurationWithConfiguration: config];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [session openSubscriptionCanceler];
                    });
                }
            }
        }
        else
        {
            NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

@end
