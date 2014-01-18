//
//  WLSessionCache.h
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLRequestRecord.h"

@interface WLSessionCache : NSMutableArray

+(WLSessionCache *)sessionCache;
-(void)pushRequestRecord:(WLRequestRecord *)requestRecord;
-(WLRequestRecord *)requestRecordAtIndex:(NSUInteger)index;
-(WLRequestRecord *)lastRequestRecordWithName:(NSString *)name;

@end
