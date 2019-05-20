//
//  ResponseMessage.h
//  oauthSDK
//
//  Created by (c)Databank Systems on 2014. 3. 18..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseMessage : NSObject

@property (nonatomic, retain) NSString *statusCode;
@property (nonatomic, retain) NSString *resultMessage;

@end
