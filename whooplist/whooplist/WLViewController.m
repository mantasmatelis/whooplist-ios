//
//  WLViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/6/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLViewController.h"

@interface WLViewController ()

@end

@implementation WLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notif {
    [UIView setAnimationDuration:[notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notif.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    CGFloat h = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView beginAnimations:nil context:NULL];
    [self.resizeView setFrame:CGRectMake(self.resizeView.frame.origin.x, self.resizeView.frame.origin.y-h/2, self.resizeView.frame.size.width, self.resizeView.frame.size.height)];
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notif {
    [UIView setAnimationDuration:[notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notif.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    CGFloat h = [notif.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView beginAnimations:nil context:NULL];
    [self.resizeView setFrame:CGRectMake(self.resizeView.frame.origin.x, self.resizeView.frame.origin.y+h/2, self.resizeView.frame.size.width, self.resizeView.frame.size.height)];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
