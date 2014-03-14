//
//  WLSessionDelegate.h
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLSession;
@class WLRequestRecord;

@protocol WLSessionDelegate

-(void)WLSession:(WLSession*)session didProcessRequestSuccess:(WLRequestRecord *)requestRecord;
-(void)WLSession:(WLSession*)session didProcessRequestFailure:(WLRequestRecord *)requestRecord;

@end