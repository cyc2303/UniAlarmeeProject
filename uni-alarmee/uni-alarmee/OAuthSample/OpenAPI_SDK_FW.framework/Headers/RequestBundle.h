//
//  RequestBundle.h
//  oauthSDK
//
//  Created by (c)Databank Systems on 2014. 3. 18..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

@interface RequestBundle : NSObject

/***
 * Request시에 기본으로 실리는 데이터들.<br>
 * app id 및 oauth 정보가 실리게된다.
 */
@property (nonatomic, retain) NSDictionary *header;
/***
 * OPEN API URL
 */
@property (nonatomic, retain) NSString *url;
/***
 * PathParam , QueryString, FormEncoded(Key, Value)
 */
@property (nonatomic, retain) NSDictionary *parameters;
/***
 * ContentBody부분에 삽입되는 데이터(XML JSON FORM ~), RequestType과 일치해야함.
 */
@property (nonatomic, retain) NSString *payload;
/***
 * File Upload시에 사용
 */
@property (nonatomic, retain) NSString *uploadFilePath;
/***
 * File Upload Key에 사용
 */
@property (nonatomic, retain) NSString *uploadFileKey;
/***
 * put post get delete
 */
@property eSmartHttpMethod httpMethod;
/***
 * Request시에 Payload에 실리는 Content Type
 */
@property eSmartContentType requestType;
/***
 * Response Content Type
 */
@property eSmartContentType responseType;

- (void)setAppId:(NSString *)appId;

@end

