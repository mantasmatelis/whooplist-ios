//
//  WLMainViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/19/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLMainViewController.h"
#import "WLNavigationBar.h"
#import "WLDashboardViewController.h"
#import "WLAppDelegate.h"

@interface WLMainViewController ()

@end

@implementation WLMainViewController

- (id)init
{
    self = [super init];
    if (self) {
        APP_DEL.mainViews[@"Main"] = self;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        WLNavigationBar *mainBar = [[WLNavigationBar alloc] initWithHeight:WL_NAVBAR_HEIGHT];
        [self.view addSubview:mainBar];
        WLDashboardViewController *db = [[WLDashboardViewController alloc] init];
        [self.view addSubview:db.view];
        mainBar.wlNavItem = db.wlNavItem;
        NSLog(@"%@", [[WLNavigationButton menuButtonWithOffset:CGPointMake(0, 0)] description]);
        [mainBar drawWLNavItem];
        self.view.backgroundColor = WL_MAIN_BG;
    }
    return self;
}

-(BOOL)prefersStatusBarHidden {
    return [APP_DEL menuShowing];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
