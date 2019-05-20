//
//  PublicApiViewController.m
//  OAuthSample
//
//  Created by (c)Databank Systems on 2014. 3. 27..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import "PublicGetNonParamViewController.h"

@interface PublicGetNonParamViewController ()
- (void)initRequestBundle;
@end

@implementation PublicGetNonParamViewController

NSString *const API_PUBLIC_URL = @"/rs/exam/list";

@synthesize tvResponse;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    reqBundle = [[RequestBundle alloc] init];
    api = [[APIRequest alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initRequestBundle
{
    [reqBundle setUrl:[ESMART_URL_OAUTH_SERVER stringByAppendingString:API_PUBLIC_URL]];
    [reqBundle setHttpMethod:eSmartHttpMethodGET];
    [reqBundle setResponseType:eSmartContentTypeJSON];
}

// 동기방식 API Call
- (IBAction)requestSyncApi:(id)sender
{
    self.tvResponse.text = @"";
    
    [self initRequestBundle];
    
    ResponseMessage *result = nil;
    
    NSError *error = nil;
    result = [api request:reqBundle error:&error];
    
    if ( error ) {
        NSString *errMsg = [NSString stringWithFormat:@"에러메세지 : \n%@\n\nStatus Code : %@\n\nData : \n%@", [error localizedDescription], result.statusCode, result.resultMessage];
        [self.tvResponse setText:errMsg];
    } else {
        [self.tvResponse setText:[NSString stringWithFormat:@"Status Code : %@\n\nData : %@", result.statusCode, result.resultMessage]];
    }
    
    [result release];
}
// 비동기방식 API Call
- (IBAction)requestAsyncApi:(id)sender
{
    self.tvResponse.text = @"";
    
    [self initRequestBundle];
    
    [api setDelegate:self finished:@selector(responseSuccess:) failed:@selector(responseFailed:)];
    
    [api aSyncRequest:reqBundle];
}

- (void)responseSuccess:(NSDictionary *)result
{
    NSLog(@"responseSuccess : %@", result);
    NSString *resultString = [NSString stringWithFormat:@"Status Code : %@\n\nData : %@", [result valueForKey:ESmartAsyncResultCode], [result valueForKey:ESmartAsyncResultData]];
    self.tvResponse.text = resultString;
}

- (void)responseFailed:(NSDictionary *)result
{
    NSLog(@"responseFailed : %@", result);
    NSString *resultString = [NSString stringWithFormat:@"에러\nStatus Code : %@\n\nData : %@", [result valueForKey:ESmartAsyncResultCode], [result valueForKey:ESmartAsyncResultMessage]];
    self.tvResponse.text = resultString;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
