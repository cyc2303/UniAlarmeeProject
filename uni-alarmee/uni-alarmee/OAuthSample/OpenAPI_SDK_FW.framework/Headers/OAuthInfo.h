//
//  OAuthInfo.h
//  oauthSDK
//
//  Created by (c)Databank Systems on 2014. 3. 17..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthInfo : NSObject

@property (nonatomic, retain) NSString *clientId;   // API를 호출할 때 요청한 앱을 구별하기 위한 값

@property (nonatomic, retain) NSString *accessToken;
@property (nonatomic, retain) NSString *refreshToken;
@property (nonatomic, retain) NSString *expiresIn;
@property (nonatomic, retain) NSString *scope;
@property (nonatomic, retain) NSString *expiresSystime;

+ (id)sharedInstance;
- (NSString *)getWholeInfo;

@end
