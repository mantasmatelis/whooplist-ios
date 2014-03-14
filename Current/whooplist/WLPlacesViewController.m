//
//  WLPlacesViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 2/2/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLPlacesViewController.h"

@interface WLPlacesViewController ()

@end

@implementation WLPlacesViewController

- (id)init
{
    self = [super init];
    if (self) {
        placeCategoriesVC = [[WLPlaceCategoriesViewController alloc] initWithRoot:nil];
        [self pushViewController:placeCategoriesVC animated:NO];
    }
    return self;
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
