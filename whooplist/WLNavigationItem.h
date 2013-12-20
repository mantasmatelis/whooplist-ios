//
//  WLNavigationItem.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/20/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLNavigationButton.h"

@interface WLNavigationItem : NSObject

@property (nonatomic, retain) WLNavigationButton *left;
@property (nonatomic, retain) WLNavigationButton *right;
@property (nonatomic, retain) UIView *center;
@property (nonatomic, retain) NSArray *other;

@end
