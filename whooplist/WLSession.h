//
//  WLSession.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/11/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLRequest.h"

@interface WLSession : NSObject

-(id)initWithUsername:(NSString*)username andPassword:(NSString*)password;

-(WLRequest*)getWLGetRequest:(NSString *)route;

-(WLRequest*)getWLPostRequest:(NSString *)route withData:(NSDictionary*)data;

-(WLRequest*)getLoginRequest;

-(void)doLoginRequest;

-(void)doCurrentUserInfoRequest;

-(void)doPPChangeRequest:(UIImage *)image;

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain, readonly) NSString *key;
@property (nonatomic, retain, readonly) NSString *userID;

@end