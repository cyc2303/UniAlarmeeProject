//
//  StringUtil.h
//  oauthSDK
//
//  Created by (c)Databank Systems on 2014. 3. 17..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

+(NSString *)escapedString:(NSString *)sourceStr;
+(NSString *)getValueFromQueryString:(NSString *)str Key:(NSString *)key;
+(NSString *)getQueryStringFromDictionary:(NSDictionary *)dict;

@end
