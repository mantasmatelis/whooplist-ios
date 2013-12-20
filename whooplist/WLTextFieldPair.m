//
//  WLTextFieldPair.m
//  Whooplist
//
//  Created by Debashis Chakraborty on 10/26/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLTextFieldPair.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Additions.h"

@implementation WLTextFieldPair
@synthesize field1, field2;
UIView *field1BG;
UIView *field2BG;
UIView *trans;

- (id)initWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)bCol andTextColor:(UIColor *)tCol andPadding:(int)padding
{
    self = [super initWithFrame:frame];
    if (self) {
        field1 = [[UITextField alloc] initWithFrame:CGRectMake(padding, padding, frame.size.width-2*padding, frame.size.height/2-1-2*padding)];
        field2 = [[UITextField alloc] initWithFrame:CGRectMake(padding, field1.frame.origin.y+field1.frame.size.height+2*padding+2, frame.size.width-2*padding, frame.size.height/2-1-2*padding)];
        field1BG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2-1)];
        field2BG = [[UIView alloc] initWithFrame:CGRectMake(0, field1BG.frame.origin.y+field1BG.frame.size.height+2, frame.size.width, frame.size.height/2-1)];
        field1BG.backgroundColor = field2BG.backgroundColor = bCol;
        [field1BG roundCorners:UIRectCornerTopLeft|UIRectCornerTopRight withRadius:CORNERRADIUS];
        [field2BG roundCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight withRadius:CORNERRADIUS];
        field1.textColor = field2.textColor = tCol;
        field1.font = field2.font = FIELDFONT;
        [self addSubview:field1BG];
        [self addSubview:field2BG];
        [self addSubview:field1];
        [self addSubview:field2];
        
        UIView *trans = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        trans.backgroundColor = [UIColor clearColor];
        [self addSubview:trans];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        tap.cancelsTouchesInView = YES;
        [trans addGestureRecognizer:tap];
    }
    return self;
}

-(void)tapped:(UITapGestureRecognizer*)sender {
    CGPoint loc = [sender locationInView:self];
    if (loc.y < self.frame.size.height/2.0)
    [field1 becomeFirstResponder];
    else
    [field2 becomeFirstResponder];
}

//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint p = [touch locationInView:self];
//    NSLog(@"Touch in double field view: %@", NSStringFromCGPoint(p));
//    if (p.x > 0 && p.y > 0 && p.x < self.frame.size.width && p.y < self.frame.size.height) {
//        if (p.y < self.frame.size.height/2)
//            [field1 becomeFirstResponder];
//        else
//            [field2 becomeFirstResponder];
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
