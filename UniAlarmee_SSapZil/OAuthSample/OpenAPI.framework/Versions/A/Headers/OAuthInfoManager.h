//
//  OAuthInfoManager.h
//  oauthSDK
//
//  Created by (c)Databank Systems on 2014. 3. 17..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthInfo.h"
#import "OAuthClient.h"


@interface OAuthInfoManager : NSObject

@property (nonatomic, retain) OAuthInfo *oAuthInfo;
@property (nonatomic, retain) OAuthClient *oAuthClient;
// OAuth 인증을 통하기 위한. 요구되는 3가지 정보.
@property (nonatomic, retain, setter = setClientId:) NSString *clientId;
@property (nonatomic, retain) NSString *clientSecret;
@property (nonatomic, retain) NSString *scope;
@property (nonatomic, retain) NSString *code;           // 서버로부터 받는 값

@property (nonatomic, retain) NSString *response_type;
@property (nonatomic, retain) NSString *redirect_uri;
@property (nonatomic, retain) NSString *grant_type;

@property (nonatomic, retain) NSString *error;
@property (nonatomic, retain) NSString *errorDesc;

@property (nonatomic, assign) id _target;
@property (nonatomic, assign) SEL _finishedSelector;
@property (nonatomic, assign) SEL _failedSelector;

+ (id)sharedInstance;
- (void)saveOAuthInfo;
- (void)restoreOAuthInfo;
- (void)setOAuthInfo:(OAuthInfo *)oainfo;
- (OAuthInfo *)getOAuthInfo;
- (NSDictionary *)getOAuthInfoDictionary;
- (BOOL)reissueAccessToken;
- (NSString *)getAccessTokenReissueURL;
- (NSString *)getRevokeTokenUrl;
- (void)setOAuthInfoWithJSON:(NSData *)data;
- (void)login:(id)target finished:(SEL)finishedSelcotr failed:(SEL)failedSelector;
- (void)login;
- (void)logout:(id)target finished:(SEL)finishedSelcotr failed:(SEL)failedSelector;
- (void)logout;
- (BOOL)revokeTokenToServer;
- (void)revokeTokenToServerAsynch;

// @property clientId의 Setter
- (void)setClientId:(NSString *)_clientId;

@end
