//
//  WLMenuButton.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/22/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLMenuButton.h"

@implementation WLMenuButton

CGFloat oldAlpha = 0;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:frame];
        [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(WL_MARGIN_SMALL, 0, 40, 40);
    self.imageView.contentMode = UIViewContentModeCenter;
    int titleX = self.imageView.frame.origin.x+self.imageView.frame.size.width+WL_MENU_RIGHT_PADDING;
    self.titleLabel.frame = CGRectMake(titleX, 0, SCREEN_X - titleX, self.imageView.frame.size.height);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:20.0];
}

-(void)touchDown {
    oldAlpha = self.alpha;
    self.alpha = WL_MENU_ACTIVE_ALPHA;
}

-(void)touchUp {
    self.alpha = oldAlpha;
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
