//
//  WLViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/6/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLViewController.h"
#import "UIImage+ImageEffects.h"

@interface WLViewController ()

@end

@implementation WLViewController

-(id)init {
    if (self = [super init]) {
        self.wlNavItem = [[WLNavigationItem alloc] init];
        _isNavigationSubview = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_isNavigationSubview)
        self.view.frame = CGRectMake(self.view.frame.origin.x, WL_NAVBAR_HEIGHT, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - WL_NAVBAR_HEIGHT);
    self.view.backgroundColor = [UIColor clearColor];
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

-(UIImage *)blurredSnapshot
{
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, self.view.window.screen.scale);
    
    // There he is! The new API method
    [self.view drawViewHierarchyInRect:self.view.frame afterScreenUpdates:NO];
    
    // Get the snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Now apply the blur effect using Apple's UIImageEffect category
//    UIImage *blurredSnapshotImage = [snapshotImage applyLightEffect];
    
    // Or apply any other effects available in "UIImage+ImageEffects.h"
    UIImage *blurredSnapshotImage = [snapshotImage applyDarkEffect];
    // UIImage *blurredSnapshotImage = [snapshotImage applyExtraLightEffect];
    
    // Be nice and clean your mess up
    UIGraphicsEndImageContext();
    
    return blurredSnapshotImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
