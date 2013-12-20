//
//  WLViewController.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/6/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLNavigationItem.h"

@interface WLViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UIView *resizeView;
@property (nonatomic, retain) WLNavigationItem *wlNavItem;
@property (nonatomic) BOOL isNavigationSubview;

-(UIImage *)blurredSnapshot;

@end
