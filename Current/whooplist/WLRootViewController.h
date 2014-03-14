//
//  WLRootViewController.h
//  whooplist
//
//  Created by Dev Chakraborty on 2/2/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLPlaceCategoriesViewController.h"
#import "WLMenuViewController.h"

@interface WLRootViewController : UINavigationController {
    WLPlaceCategoriesViewController *placeCategoriesVC;
    WLMenuViewController *menuVC;
}

-(void)showMenu;

@end
