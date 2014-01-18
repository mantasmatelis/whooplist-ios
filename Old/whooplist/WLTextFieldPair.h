//
//  WLTextFieldPair.h
//  Whooplist
//
//  Created by Debashis Chakraborty on 10/26/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLTextFieldPair : UIView

@property (nonatomic, retain, readonly) UITextField *field1;
@property (nonatomic, retain, readonly) UITextField *field2;

-(id)initWithFrame:(CGRect)frame andBackgroundColor:(UIColor *)bCol andTextColor:(UIColor *)tCol andPadding:(int)padding;

@end
