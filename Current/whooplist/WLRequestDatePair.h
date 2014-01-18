//
//  WLRequestDatePair.h
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLRequestDatePair : NSObject

@property (nonatomic, retain) NSDate *requestTime;
@property (nonatomic, retain) NSDate *responseTime;

-(id)initWithRequestTime:(NSDate *)requestTime andResponseTime:(NSDate *)responseTime;
+(WLRequestDatePair *)requestDatePairWithRequestTime:(NSDate *)requestTime andResponseTime:(NSDate *)responseTime;

@end
