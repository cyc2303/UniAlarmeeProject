//
//  APIRequest.h
//  oauthSDK
//
//  Created by (c)Databank Systems on 2014. 3. 18..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBundle.h"
#import "ResponseMessage.h"
#import "HttpHeader.h"
#import "Global.h"

@interface APIRequest : NSObject

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSURLResponse *response;
@property (nonatomic, retain) NSString *result;
@property (nonatomic, retain) HttpHeader *httpHeader;

@property (nonatomic, assign) id _target;
@property (nonatomic, assign) SEL _finishedSelector;
@property (nonatomic, assign) SEL _failedSelector;

- (void)setHeader:(NSString *)swapKey err:(NSError **)error;

- (NSString *)urlConverter:(RequestBundle *)requestBundle;
- (ResponseMessage *)request:(RequestBundle *)requestBundle error:(NSError **)error;
- (ResponseMessage *)request:(RequestBundle *)requestBundle HTTPMethod:(eSmartHttpMethod)httpMethod error:(NSError **)error;
- (ResponseMessage *)request:(RequestBundle *)requestBundle URL:(NSString*)url HTTPMethod:(eSmartHttpMethod)httpMethod error:(NSError **)error;

- (void)aSyncRequest:(RequestBundle *)requestBundle;
- (void)aSyncRequest:(RequestBundle *)requestBundle HTTPMethod:(eSmartHttpMethod)httpMethod ;
- (void)aSyncRequest:(RequestBundle *)requestBundle URL:(NSString*)url HTTPMethod:(eSmartHttpMethod)httpMethod ;
- (void)setDelegate:(id)target finished:(SEL)finishedSelcotr failed:(SEL)failedSelector;

@end
