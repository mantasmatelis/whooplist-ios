//
//  NSDictionary+WLJSONAdditions.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/11/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (WLJSONAdditions)
    -(NSString*) jsonStringWithPrettyPrint:(BOOL) prettyPrint;
@end

@interface NSArray (WLJSONAdditions)
    - (NSString *)jsonStringWithPrettyPrint:(BOOL)prettyPrint;
@end