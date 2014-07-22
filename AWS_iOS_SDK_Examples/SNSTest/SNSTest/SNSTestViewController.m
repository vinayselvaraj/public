//
//  SNSTestViewController.m
//  SNSTest
//
//  Created by Vinay Selvaraj on 7/22/14.
//
//

#import "SNSTestViewController.h"
#import <AWSiOSSDK/SNS/AmazonSNSClient.h>

@interface SNSTestViewController ()

@end

@implementation SNSTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createSubscribePublish:(id)sender {
    
    NSLog(@"createSubscription");
    
    NSString *ACCESS_KEY_ID = @"ENTER_ACCESS_KEY_ID";
    NSString *SECRET_KEY = @"ENTER_SECRET_KEY";
    NSString *TOPIC_NAME = @"TestTopic";
    NSString *emailAddress = @"YOUREMAIL@EXAMPLE.COM";
    
    AmazonSNSClient *snsClient = [[AmazonSNSClient alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY];
    
    
    // Create Topic
    SNSCreateTopicRequest *ctr = [[SNSCreateTopicRequest alloc] initWithName:TOPIC_NAME];
    SNSCreateTopicResponse *response = [snsClient createTopic:ctr];
    SNSSetTopicAttributesRequest* st = [[SNSSetTopicAttributesRequest alloc] initWithTopicArn:response.topicArn andAttributeName:@"DisplayName" andAttributeValue:TOPIC_NAME];
    [snsClient setTopicAttributes:st];
    NSLog(@"Created SNSTopic: %@", response.topicArn);
    
    // Subscribe to Topic
    SNSSubscribeRequest *sr = [[SNSSubscribeRequest alloc] initWithTopicArn:response.topicArn andProtocol:@"email" andEndpoint:emailAddress];
    [snsClient subscribe:sr];
    
    // Publish notification
    SNSPublishRequest *pr = [[SNSPublishRequest alloc] initWithTopicArn:response.topicArn andMessage:@"Hello World!"];
    [snsClient publish:pr];
    NSLog(@"Published notification");
    
}

@end
