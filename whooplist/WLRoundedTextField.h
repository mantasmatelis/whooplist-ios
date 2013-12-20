//
//  WLRoundedTextField.h
//  Whooplist
//
//  Created by Debashis Chakraborty on 2013-10-20.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLRoundedTextField : UIView {
    UITextField *field;
}

@property (nonatomic, retain, readonly) UITextField *field;
-(NSString *)text;
- (id)initWithFrame:(CGRect)frame andBackground:(UIColor *)bgCol;

@end
