//
//  Global.h
//  oauthSDK
//
//  Created by (c)Databank Systems on 2014. 3. 17..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const ESMART_HEADER_ACCESS_TOKEN;
FOUNDATION_EXTERN NSString *const ESMART_HEADER_REFRESH_TOKEN;

// Authorization 요청시 전달할 파라미터 키값
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_CLIENT_ID;
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_RESPONSE_TYPE; // VALUE : code
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_SCOPE;
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_REDIRECT_URI;
// AccessToken 요청시 전달할 파라미터 키값
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_CLIENT_SECRET;
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_CODE; // 인증 Endpoint에서 받는 코드 값
// Authorization code 요청시 전달할 파라미터 키값
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_GRANT_TYPE; // VALUE : authorization_code

// Refresh Token 요청시 전달할 파라미터 키값
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_REFRESH_TOKEN;

// Revoke Token 요청시 전달할 파라미터 키값
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_TOKEN;

FOUNDATION_EXTERN NSString *const ESMART_OAUTH_END_ACCESS_TOKEN;
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_END_REFRESH_TOKEN;
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_END_EXPIRES_IN;
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_END_SCOPE;
FOUNDATION_EXTERN NSString *const ESMART_OAUTH_EXPIRES_SYSTIME;

FOUNDATION_EXTERN NSString *const ESMART_URL_OAUTH_SERVER;
FOUNDATION_EXTERN NSString *const ESMART_URL_OAUTH_AUTHEN;
FOUNDATION_EXTERN NSString *const ESMART_URL_OAUTH_ACCESS;
FOUNDATION_EXTERN NSString *const ESMART_URL_OAUTH_REVOKE;
FOUNDATION_EXTERN NSString *const ESMART_URL_OAUTH_PARAM_ENC_KEY;

// API Content Type
typedef NS_ENUM(NSUInteger, eSmartContentType)
{
    eSmartContentTypeXML,
    eSmartContentTypeJSON
};
// HttpMethod
typedef NS_ENUM(NSUInteger, eSmartHttpMethod)
{
    eSmartHttpMethodPUT,
    eSmartHttpMethodPOST,
    eSmartHttpMethodGET,
    eSmartHttpMethodDELETE
};

//TODO: 에러 타입 정의
FOUNDATION_EXTERN NSString *const ESmartError001;
FOUNDATION_EXTERN NSString *const ESmartError002;
FOUNDATION_EXTERN NSString *const ESmartError003;
FOUNDATION_EXTERN NSString *const ESmartError004;
FOUNDATION_EXTERN NSString *const ESmartError005;
FOUNDATION_EXTERN NSString *const ESmartError006;
FOUNDATION_EXTERN NSString *const ESmartError007;

//TODO: ASync 요청시 Response데이터의 키값 정의
FOUNDATION_EXTERN NSString *const ESmartAsyncResultCode;
FOUNDATION_EXTERN NSString *const ESmartAsyncResultMessage;
FOUNDATION_EXTERN NSString *const ESmartAsyncResultData;

@interface Global : NSObject

+ (NSString *)getContentType:(eSmartContentType)type;

@end

#if 0
// SSL 인증 무효화 루틴 추가
@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end
#endif
