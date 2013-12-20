//
//  UIImage+Additions.h
//  Whooplist
//
//  Created by Debashis Chakraborty on 10/27/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;
-(UIImage*)getPPImage;

@end
