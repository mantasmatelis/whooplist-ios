//
//  WLRequestRecord.m
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLRequestRecord.h"

@implementation WLRequestRecord

-(id)initWithRequestType:(WLRequestType *)requestType andResponse:(id)response andRequestDatePair:(WLRequestDatePair *)requestDatePair {
    if (self = [super init]) {
        _requestType = requestType;
        _response = response;
        _requestDatePair = requestDatePair;
    }
    return self;
}

+(WLRequestRecord*)recordWithRequestType:(WLRequestType*)requestType andResponse:(id)response andRequestDatePair:(WLRequestDatePair *)requestDatePair {
    return [[WLRequestRecord alloc] initWithRequestType:requestType andResponse:response andRequestDatePair:requestDatePair];
}

-(NSString *)description {
    NSString *ret = @"<WLRequestRecord:\n\tRequest Time: ";
    ret = STR_CONCAT(STR_CONCAT(ret, [[_requestDatePair requestTime] description]), @"\n");
    ret = STR_CONCAT(ret, @"\tResponse Time: ");
    ret = STR_CONCAT(STR_CONCAT(ret, [[_requestDatePair responseTime] description]), @"\n");
    ret = STR_CONCAT(ret, @"\tRequest Type: ");
    ret = STR_CONCAT(STR_CONCAT(ret, [[_requestType description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"]), @"\n");
    ret = STR_CONCAT(ret, @"\tResponse: ");
    ret = STR_CONCAT(STR_CONCAT(ret, [[_response description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"]), @"\n");
    ret = STR_CONCAT(ret, @">");
    return ret;
}

@end
