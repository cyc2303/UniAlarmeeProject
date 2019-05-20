//
//  HttpHeader.h
//  oauthSDK
//
//  Created by (c)Databank Systems on 2014. 3. 18..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpHeader : NSObject

@property (nonatomic, retain) NSMutableDictionary* headerDic;

- (void)checkInit;
- (void)put:(NSString *)key Value:(NSString*)value;
- (NSString*)get:(NSString *)key;
- (NSMutableDictionary*)getHeader;

@end
