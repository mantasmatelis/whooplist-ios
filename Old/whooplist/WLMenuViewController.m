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
#import "WLMenuButton.h"

@interface WLMenuViewController ()

@end

@implementation WLMenuViewController

NSMutableArray *buttons;

-(id)init {
    self = [super init];
    if (self) {
        APP_DEL.mainViews[@"Menu"] = self;
        
        self.view.backgroundColor = [UIColor whiteColor];
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        
        UIImageView *bg = [[UIImageView alloc] initWithImage:[((WLMainViewController*)APP_DEL.mainViews[@"Main"]) blurredSnapshot]];
        [self.view addSubview:bg];
        
        UIView *navBorder = [[UIView alloc] initWithFrame:CGRectMake(0, WL_NAVBAR_HEIGHT, SCREEN_X, 1)];
        navBorder.backgroundColor = RGBA(255.0, 255.0, 255.0, 0.4);
        [self.view addSubview:navBorder];
        
        UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 40, 40)];
        menuBtn.backgroundColor = [UIColor clearColor];
        [menuBtn setImage:[UIImage imageNamed:@"Menu"] forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:menuBtn];
        
        int menuTxtX = menuBtn.frame.origin.x+menuBtn.frame.size.width+WL_MENU_RIGHT_PADDING;
        int menuTxtSize = 30.0;
        UILabel *menuTxt = [[UILabel alloc] initWithFrame:CGRectMake(menuTxtX, menuBtn.frame.origin.y+menuBtn.frame.size.height/2-menuTxtSize/2, SCREEN_X-menuTxtX, menuTxtSize)];
        menuTxt.font = [UIFont fontWithName:@"Roboto-Bold" size:30.0];
        menuTxt.text = @"Menu";
        menuTxt.textColor = [UIColor whiteColor];
        [self.view addSubview:menuTxt];
        
        NSArray *items = WL_MENU_ITEMS;
        
        int menuItemY = WL_NAVBAR_HEIGHT + (SCREEN_Y - WL_NAVBAR_HEIGHT)/2 - (WL_MENU_ITEM_HEIGHT*[items count]+WL_MENU_ITEM_SPACE*([items count]-1))/2;
        
        buttons = [[NSMutableArray alloc] init];
        
        for (NSString *item in items) {
            NSString *fileName = [item stringByReplacingOccurrencesOfString:@" " withString:@"-"];
            WLMenuButton *menuBtn = [[WLMenuButton alloc] initWithFrame:CGRectMake(0, menuItemY, SCREEN_X, WL_MENU_ITEM_HEIGHT)];
            [menuBtn setImage:[UIImage imageNamed:fileName] forState:UIControlStateNormal];
            [menuBtn setImage:[UIImage imageNamed:fileName] forState:UIControlStateHighlighted];
            [menuBtn setTitle:item forState:UIControlStateNormal];
            menuBtn.backgroundColor = [UIColor clearColor];
            [menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.view addSubview:menuBtn];
            [buttons addObject:menuBtn];
            menuItemY += WL_MENU_ITEM_HEIGHT + WL_MENU_ITEM_SPACE;
        }
        
        switch (APP_DEL.currentViewMode) {
            case WL_VIEWMODE_DASHBOARD:
                [self setActiveIndex:0];
                break;
            case WL_VIEWMODE_NEWSFEED:
                [self setActiveIndex:1];
                break;
            case WL_VIEWMODE_PLANNER:
                [self setActiveIndex:2];
                break;
            case WL_VIEWMODE_PLACES:
                [self setActiveIndex:3];
                break;
            case WL_VIEWMODE_SETTINGS:
                [self setActiveIndex:4];
                break;
        }
    }
    return self;
}

-(void)setActiveIndex:(NSInteger)activeIndex {
    _activeIndex = activeIndex;
    for (int i = 0; i < [buttons count]; i++) {
        ((WLMenuButton*)[buttons objectAtIndex:i]).alpha = i==activeIndex ? WL_MENU_ACTIVE_ALPHA : WL_MENU_INACTIVE_ALPHA;
    }
}

-(void)close {
    [self dismissViewControllerAnimated:YES completion:^{}];
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
