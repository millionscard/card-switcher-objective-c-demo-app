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
    [self apiCall:urlString param:dict token:token];
}


- (void)apiCall:(NSString *)Url param:(NSDictionary *)parameters token:(NSString *)token{
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
    
    NSData* data1 = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error: nil];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:data1];
    [urlRequest addValue:@"sandbox" forHTTPHeaderField:@"Environment"];
    [urlRequest addValue:@"ab86955e-22f4-49c3-97d7-369973f4cb9e" forHTTPHeaderField:@"Client-Id"];
    [urlRequest addValue:@"d1a5cde831464cd3840ccf762f63ceb7" forHTTPHeaderField:@"Client-Secret"];
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
                    CardOnFileSwitcherSession * session = [[CardOnFileSwitcherSession alloc] initWithSessionId:sessionID clientId:@"ab86955e-22f4-49c3-97d7-369973f4cb9e" environment:EnvironmentSandbox];
                    [session setPrimaryColorWithPrimaryColor:@"#000000"];
                    [session setTextColorWithTextColor:@"#FFFFFF"];
                    [session setCompanyNameWithCompanyName:@"Millions"];
                    [session openOnCardFileSwitcherWithMerchants:@[]];
                    [session setDelegateWithDelegate:self];
                }
                else {
                    CardOnFileSwitcherSession * session = [[CardOnFileSwitcherSession alloc] initWithSessionId:sessionID clientId:@"ab86955e-22f4-49c3-97d7-369973f4cb9e" environment:EnvironmentSandbox];
                    [session setPrimaryColorWithPrimaryColor:@"#000000"];
                    [session setTextColorWithTextColor:@"#FFFFFF"];
                    [session setCompanyNameWithCompanyName:@"Millions"];
                    [session openOnSubscriptionCancelerWithMerchants:@[]];
                    [session setDelegateWithDelegate:self];
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
