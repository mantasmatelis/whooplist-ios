//
//  WLRequestRecord.h
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLRequestType.h"
#import "WLRequestDatePair.h"

@interface WLRequestRecord : NSObject

@property (nonatomic, retain) WLRequestType *requestType;
@property (nonatomic, retain) id response;
@property (nonatomic, retain) WLRequestDatePair *requestDatePair;
@property (nonatomic, retain) NSString *URL;

-(id)initWithRequestType:(WLRequestType *)requestType andResponse:(id)response andRequestDatePair:(WLRequestDatePair *)requestDatePair andURL:(NSString *)URL;
+(WLRequestRecord*)recordWithRequestType:(WLRequestType*)requestType andResponse:(id)response andRequestDatePair:(WLRequestDatePair *)requestDatePair andURL:(NSString *)URL;

@end
