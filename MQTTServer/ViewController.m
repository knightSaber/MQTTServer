//
//  ViewController.m
//  MQTTServer
//
//  Created by scinan on 15/10/16.
//  Copyright © 2015年 scinan. All rights reserved.
//

#import "ViewController.h"
#import "MQTTKit.h"


#define kMQTTServerHost @"iot.eclipse.org"
#define kTopic @"MQTTExample/Message"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pushMessage;
@property (nonatomic, strong) MQTTClient *client;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *clientID = [UIDevice currentDevice].identifierForVendor.UUIDString;
    
    self.client = [[MQTTClient alloc] initWithClientId:clientID];
    
//    [self.client connectToHost:kMQTTServerHost completionHandler:^(MQTTConnectionReturnCode code) {
//        if (code == ConnectionAccepted)
//        {
//            NSLog(@"服务器启动成功");
//        }
//    }];
    
//    [self.client connectWithCompletionHandler:@"cbt" andPassword:@"1223" andCallBack:^(MQTTConnectionReturnCode code) {
//        if (code == ConnectionAccepted)
//        {
//            NSLog(@"服务器启动成功");
//        }
//    }];
    
    [self.client connectToHost:kMQTTServerHost andName:@"cbt" andPassword:@"1223" completionHandler:^(MQTTConnectionReturnCode code) {
        if (code == ConnectionAccepted)
        {
            NSLog(@"服务器启动成功");
        }
    }];
    
}
- (IBAction)push:(id)sender {
    NSString* payload = self.pushMessage.text;
    [self.client publishString:payload
                       toTopic:kTopic
                       withQos:AtMostOnce
                        retain:YES
             completionHandler:nil];
    NSLog(@"推送内容：%@",payload);
}


@end
