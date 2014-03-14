//
//  WLRequestDatePair.m
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLRequestDatePair.h"

@implementation WLRequestDatePair

-(id)initWithRequestTime:(NSDate *)requestTime andResponseTime:(NSDate *)responseTime {
    if (self = [super init]) {
        _requestTime = requestTime;
        _responseTime = responseTime;
    }
    return self;
}

+(WLRequestDatePair *)requestDatePairWithRequestTime:(NSDate *)requestTime andResponseTime:(NSDate *)responseTime {
    return [[WLRequestDatePair alloc] initWithRequestTime:requestTime andResponseTime:responseTime];
}

@end
