//
//  PrivateGetViewController.h
//  OAuthSample
//
//  Created by (c)Databank Systems on 2014. 5. 21..
//  Copyright (c) 2014년 Databank Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenAPI/APIRequest.h>

@interface PrivateGetViewController : UIViewController
{
    APIRequest *api;
    RequestBundle *reqBundle;
}

@property (nonatomic, retain) IBOutlet UITextView *tvResponse;

@end
