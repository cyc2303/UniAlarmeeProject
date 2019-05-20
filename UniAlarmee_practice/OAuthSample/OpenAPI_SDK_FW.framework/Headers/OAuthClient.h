//
//  OAuthClient.h
//  oauthSDK
//
//  Created by (c)Databank Systems on 2014. 3. 17..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface OAuthClient : UIViewController <UIWebViewDelegate, UIAlertViewDelegate>
{
    BOOL _sessionChecked;
    NSString *checkedURL;
}

@property (nonatomic, retain) UIWebView *loginView;
@property (nonatomic, retain) UIView *viewBlock;
@property (nonatomic, retain) UIView *bgView;

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSURLResponse *response;
@property (nonatomic, retain) NSString *result;
@property (nonatomic, assign) id _target;
@property (nonatomic, assign) SEL _finishedSelector;
@property (nonatomic, assign) SEL _failedSelector;

- (void)login:(id)target finished:(SEL)finishedSelcotr failed:(SEL)failedSelector;
- (void)closeLoginView;
- (NSString *)getOAuthorizationUrl;
- (NSString *)getOAccessTokenUrl;
//- (void)animationDidStop:(NSString *)animID finished:(BOOL)didFinish context:(void *)context;

@end
