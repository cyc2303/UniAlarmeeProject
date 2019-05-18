//
//  ViewController.m
//  OAuthSample
//
//  Created by (c)Databank Systems on 2014. 3. 20..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import "ViewController.h"
#import <OpenAPI/OAuthInfoManager.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    OAuthInfoManager *oInfoMgr = [OAuthInfoManager sharedInstance];
    // OAuthInfo 설정
    // Client ID는 반드시 설정해야 API요청이 가능함.

    
    [oInfoMgr setClientId:@"557fa82c9492fe2527744c944670e55f"];
    [oInfoMgr setClientSecret:@"21a5252251b209d20ee0568b29cce1"];
    [oInfoMgr setScope:@"35"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OAuthLogin:(id)sender
{
    [[OAuthInfoManager sharedInstance] login:self finished:@selector(didFinishLogin) failed:@selector(didFailedLogin)];
}

- (IBAction)OAuthLogout:(id)sender
{
    [[OAuthInfoManager sharedInstance] logout:self finished:@selector(didFinishLogout) failed:@selector(didFailedLogout)];
}

- (void)didFinishLogin
{
    NSLog(@"로그인 성공");
    OAuthInfo *oInfo = [[OAuthInfoManager sharedInstance] oAuthInfo];
    NSLog(@"%@", [oInfo getWholeInfo]);
}

- (void)didFailedLogin
{
    NSLog(@"로그인 실패");
    OAuthInfo *oInfo = [[OAuthInfoManager sharedInstance] oAuthInfo];
    NSLog(@"%@", [oInfo getWholeInfo]);
}

- (void)didFinishLogout
{
    NSLog(@"로그아웃 성공");
    OAuthInfo *oInfo = [[OAuthInfoManager sharedInstance] oAuthInfo];
    NSLog(@"%@", [oInfo getWholeInfo]);
}

- (void)didFailedLogout
{
    NSLog(@"로그아웃 실패");
    OAuthInfo *oInfo = [[OAuthInfoManager sharedInstance] oAuthInfo];
    NSLog(@"%@", [oInfo getWholeInfo]);
}

@end
