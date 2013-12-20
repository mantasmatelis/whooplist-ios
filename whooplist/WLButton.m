//
//  WLButton.m
//  Whooplist
//
//  Created by Debashis Chakraborty on 10/27/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLButton.h"
#import "UIImage+Additions.h"
#import "UIView+Additions.h"

@implementation WLButton

- (id)initWithType:(WLButtonType)type andOrigin:(CGPoint)origin andWidth:(int)width andText:(NSString *)text {
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, width, BTNHEIGHT)];
    if (self) {
        if (type == WLButtonGood) {
            [self setBackgroundImage:[UIImage imageWithColor:GOODBTNBGC] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageWithColor:GOODBTNHLBGC] forState:UIControlStateHighlighted];
            [self setTitleColor:GOODBTNTXTC forState:UIControlStateNormal];
            [self setTitleColor:GOODBTNHLTXTC forState:UIControlStateHighlighted];
        } else if (type == WLButtonNeutral) {
            [self setBackgroundImage:[UIImage imageWithColor:NEUTBTNBGC] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageWithColor:NEUTBTNHLBGC] forState:UIControlStateHighlighted];
            [self setTitleColor:NEUTBTNTXTC forState:UIControlStateNormal];
            [self setTitleColor:NEUTBTNHLTXTC forState:UIControlStateHighlighted];
        }
        [self.titleLabel setFont:BTNFONT];
        [self setTitle:text forState:UIControlStateNormal];
        [self roundCorners:UIRectCornerAllCorners withRadius:CORNERRADIUS];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self roundCorners:UIRectCornerAllCorners withRadius:CORNERRADIUS];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
