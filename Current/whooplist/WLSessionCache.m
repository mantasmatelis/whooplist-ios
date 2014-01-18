//
//  WLSessionCache.m
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLSessionCache.h"

@implementation WLSessionCache

NSMutableArray *_internal;

-(id)init {
    if (self = [super init]) {
        _internal = [[NSMutableArray alloc] init];
    }
    return self;
}

+(WLSessionCache *)sessionCache {
    return [[WLSessionCache alloc] init];
}

-(void)pushRequestRecord:(WLRequestRecord *)requestRecord {
    [_internal addObject:requestRecord];
}

-(WLRequestRecord *)requestRecordAtIndex:(NSUInteger)index {
    return (WLRequestRecord *)[_internal objectAtIndex:index];
}

-(WLRequestRecord *)lastRequestRecordWithName:(NSString *)name {
    for (int i = [self count]-1; i >= 0; i--)
        if ([[self requestRecordAtIndex:(NSUInteger)i].requestType.name isEqualToString:name])
            return [self requestRecordAtIndex:(NSUInteger)i];
    return nil;
}

-(id)objectAtIndex:(NSUInteger)index {
    return [self requestRecordAtIndex:index];
}

-(NSUInteger)count {
    return [_internal count];
}

-(NSString *)description {
    NSString *ret = @"<WLSessionCache:\n";
    for (WLRequestRecord *record in _internal)
        ret = STR_CONCAT(@"\t", STR_CONCAT(STR_CONCAT(ret, [[record description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"]), @"\n"));
    ret = STR_CONCAT(ret, @">");
    return ret;
}

@end
