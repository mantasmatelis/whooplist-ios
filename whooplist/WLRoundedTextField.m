//
//  WLRoundedTextField.m
//  Whooplist
//
//  Created by Debashis Chakraborty on 2013-10-20.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLRoundedTextField.h"
#define WLRTF_MARGIN    10

@implementation WLRoundedTextField
@synthesize field;

- (id)initWithFrame:(CGRect)frame andBackground:(UIColor *)bgCol
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = bgCol;
        self.layer.cornerRadius = 5.0;
        field = [[UITextField alloc] initWithFrame:CGRectMake(WLRTF_MARGIN, WLRTF_MARGIN, frame.size.width-2*WLRTF_MARGIN, frame.size.height-2*WLRTF_MARGIN)];
        field.backgroundColor = [UIColor clearColor];
        field.font = [UIFont fontWithName:@"Roboto-Light" size:15.0];
        [self addSubview:field];
    }
    return self;
}

-(NSString *)text {
    return field.text;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.field becomeFirstResponder];
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
