//
//  WLSession.h
//  whooplist
//
//  Created by Dev Chakraborty on 1/11/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLRequestType.h"
#import "WLSessionDelegate.h"
#import "WLSessionCache.h"

@interface WLSession : NSObject

+(WLSession *)session;
-(void)request:(WLRequestType *)requestType withParameters:(NSDictionary *)params;
-(void)subscribeToSessionEvents:(id<WLSessionDelegate>) object;
-(void)unsubscribeFromSessionEvents:(id<WLSessionDelegate>) object;

@property (nonatomic, retain, readonly) NSMutableArray *delegates;
@property (nonatomic, retain) WLSessionCache *sessionCache;

@end