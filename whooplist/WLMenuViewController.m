//
//  WLMenuViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/13/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLMenuViewController.h"
#import "WLAppDelegate.h"
#import "UIImage+ImageEffects.h"
#import "WLMainViewController.h"

@interface WLMenuViewController ()

@end

@implementation WLMenuViewController

-(id)init {
    self = [super init];
    if (self) {
        _menuItems = [@[@{@"label": @"Dashboard"}] mutableCopy];
        APP_DEL.mainViews[@"Menu"] = self;
        self.view.backgroundColor = [UIColor whiteColor];
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        
        UIImageView *bg = [[UIImageView alloc] initWithImage:[((WLMainViewController*)APP_DEL.mainViews[@"Main"]) blurredSnapshot]];
        [self.view addSubview:bg];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
