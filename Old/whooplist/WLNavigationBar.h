//
// Created by Dev Chakraborty on 12/15/2013.
// Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLNavigationItem.h"

@interface WLNavigationBar : UIView

-(id)initWithHeight:(NSInteger)height;

@property (nonatomic) WLNavigationItem *wlNavItem;
-(void)drawWLNavItem;
@end