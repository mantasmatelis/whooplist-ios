//
//  UIView+Additions.m
//  Whooplist
//
//  Created by Debashis Chakraborty on 10/27/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

-(void) roundCorners:(UIRectCorner)corners withRadius:(CGFloat)radius
{
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

@end
