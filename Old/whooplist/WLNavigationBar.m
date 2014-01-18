//
// Created by Dev Chakraborty on 12/15/2013.
// Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLNavigationBar.h"
#import "UIImage+Additions.h"
#define NAVBTN_SIZE 40

@implementation WLNavigationBar

UIButton *left;
UIButton *right;
UIView *center;

-(id)initWithHeight:(NSInteger)height {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, height);
        self.backgroundColor = WL_NAVBAR_BG;
        self.wlNavItem = [[WLNavigationItem alloc] init];
        self.clipsToBounds = NO;
    }
    return self;
}

-(void)drawWLNavItem {
    if (left) {
        [left removeFromSuperview];
        left = NULL;
    }
    if (center) {
        [center removeFromSuperview];
        center = NULL;
    }
    if (right) {
        [right removeFromSuperview];
        right = NULL;
    }
    if (self.wlNavItem.left) {
        [self addSubview:left = self.wlNavItem.left];
        left.frame = CGRectMake(WL_NAVBAR_BTN_MARGIN+left.frame.origin.x, self.frame.size.height-left.frame.size.height-WL_NAVBAR_BTN_MARGIN+left.frame.origin.y, left.frame.size.width, left.frame.size.height);
    }
    if (self.wlNavItem.center)
        [self addSubview:center = self.wlNavItem.center];
    if (self.wlNavItem.right) {
        [self addSubview:right = self.wlNavItem.right];
        right.frame = CGRectMake(self.frame.size.width-WL_NAVBAR_BTN_MARGIN-right.frame.size.width+right.frame.origin.x, self.frame.size.height-right.frame.size.height-WL_NAVBAR_BTN_MARGIN+right.frame.origin.y, right.frame.size.width, right.frame.size.height);
    }
}


@end