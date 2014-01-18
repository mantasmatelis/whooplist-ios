//
//  WLButton.h
//  Whooplist
//
//  Created by Debashis Chakraborty on 10/27/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WLButtonGood,
    WLButtonNeutral,
    WLButtonBad
} WLButtonType;

@interface WLButton : UIButton

-(id)initWithType:(WLButtonType)type andOrigin:(CGPoint)origin andWidth:(int)width andText:(NSString *)text;

@end