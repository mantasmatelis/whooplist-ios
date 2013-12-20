//
//  WLNavigationItem.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/20/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLNavigationItem.h"

@implementation WLNavigationItem

-(id)initWithLeft:(WLNavigationButton *)left andRight:(WLNavigationButton *)right {
    if (self = [super init]) {
        self.left = left;
        self.right = right;
    }
    return self;
}

@end
