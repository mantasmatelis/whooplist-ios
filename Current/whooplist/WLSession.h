//
//  WLSession.h
//  whooplist
//
//  Created by Dev Chakraborty on 1/11/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#ifndef whooplist_WLSession_h
#define whooplist_WLSession_h

#import <Foundation/Foundation.h>
#import "WLRequestType.h"
#import "WLSessionDelegate.h"
#import "WLSessionCache.h"

@interface WLSession : NSObject

+(WLSession *)session;
-(void)request:(WLRequestType *)requestType withParameters:(NSDictionary *)params;
-(void)subscribeToSessionEvents:(id<WLSessionDelegate>) object;
-(void)unsubscribeFromSessionEvents:(id<WLSessionDelegate>) object;

-(NSString *)key;
-(NSNumber *)userID;

@property (nonatomic, retain, readonly) NSMutableArray *delegates;
@property (nonatomic, retain) WLSessionCache *sessionCache;

@end

#endif