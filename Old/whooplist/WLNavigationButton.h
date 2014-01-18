//
//  WLNavigationButton.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/20/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLNavigationButton : UIButton

- (id)initWithOffset:(CGPoint)p;
+ (WLNavigationButton *)menuButtonWithOffset:(CGPoint)p;
-(id)initWithOffset:(CGPoint)p andImage:(UIImage *)image;

@end
