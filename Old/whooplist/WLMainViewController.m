//
//  WLMainViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/19/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLMainViewController.h"
#import "WLNavigationBar.h"
#import "WLProfileViewController.h"
#import "WLAppDelegate.h"
#import "WLProfilePictureView.h"

@interface WLMainViewController ()

@end

@implementation WLMainViewController

WLNavigationBar *mainBar;

- (id)init
{
    self = [super init];
    if (self) {
        APP_DEL.mainViews[@"Main"] = self;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        mainBar = [[WLNavigationBar alloc] initWithHeight:WL_NAVBAR_HEIGHT];
        [self.view addSubview:mainBar];
        WLProfileViewController *db = [[WLProfileViewController alloc] init];
        [self.view addSubview:db.view];
        mainBar.wlNavItem = db.wlNavItem;
        NSLog(@"%@", [[WLNavigationButton menuButtonWithOffset:CGPointMake(0, 0)] description]);
        [mainBar drawWLNavItem];
        self.view.backgroundColor = WL_MAIN_BG;
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([mainBar.wlNavItem.center class] == [WLProfilePictureView class]) {
        WLProfilePictureView *pp = (WLProfilePictureView*)mainBar.wlNavItem.center;
        CGPoint center = pp.center;
        CGFloat rad = pp.frame.size.width/2;
        CGPoint touch = [[touches anyObject] locationInView:mainBar];
        CGFloat dist = sqrtf(powf(touch.x - center.x, 2) + powf(touch.y - center.y, 2));
        if (dist < rad)
            [pp selectPP:pp];
    }
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
