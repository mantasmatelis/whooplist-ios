//
//  WLNavigationButton.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/20/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLNavigationButton.h"
#import "WLAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation WLNavigationButton

- (id)initWithOffset:(CGPoint)p
{
    self = [super initWithFrame:CGRectMake(p.x, p.y, WL_NAVBAR_BTN_HEIGHT, WL_NAVBAR_BTN_HEIGHT)];
    if (self) {
        self.backgroundColor = WL_NAVBAR_BTN_BG;
        self.layer.cornerRadius = 5.0;
    }
    return self;
}

-(id)initWithOffset:(CGPoint)p andImage:(UIImage *)image {
    if (self = [self initWithOffset:p]) {
        [self setImage:image forState:UIControlStateNormal];
    }
    return self;
}

+(WLNavigationButton*) menuButtonWithOffset:(CGPoint)p {
    WLNavigationButton *btn = [[WLNavigationButton alloc] initWithOffset:p];
    [btn setImage:[UIImage imageNamed:@"nav"] forState:UIControlStateNormal];
    [btn addTarget:APP_DEL action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    return btn;
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
