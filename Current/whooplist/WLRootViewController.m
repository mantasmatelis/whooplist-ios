//
//  WLRootViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 2/2/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLRootViewController.h"

@interface WLRootViewController ()

@end

@implementation WLRootViewController

- (id)init
{
    if (self = [super init]) {
        placeCategoriesVC = [[WLPlaceCategoriesViewController alloc] initWithRoot:nil];
//        menuVC = [[WLMenuViewController alloc] init];
//        [self.view addSubview:placesVC.view];
        [self pushViewController:placeCategoriesVC animated:YES];
        APP_DEL.viewControllers[@"Root"] = self;
    }
    return self;
}

-(void)showMenu {
    UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:APP_DEL.viewControllers[@"Menu"]];
    [self presentModalViewController:menuNav animated:YES];
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
