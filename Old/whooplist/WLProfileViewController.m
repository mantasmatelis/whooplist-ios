//
//  WLDashboardViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/20/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLProfileViewController.h"
#import "WLNavigationButton.h"
#import "WLAppDelegate.h"
#import "WLProfilePictureView.h"
#import "WLFollowButton.h"

@interface WLProfileViewController ()

@end

UILabel *nameLabel;
UIButton *followers;
UIButton *following;
UILabel *subtitle;
WLProfilePictureView *pp;
UIView *editHide;
UIView *editShow;

@implementation WLProfileViewController

BOOL editing = NO;

- (id)init
{
    self = [super init];
    if (self) {
        APP_DEL.mainViews[@"Dashboard"] = self;
        APP_DEL.currentViewMode = WL_VIEWMODE_DASHBOARD;
        
        self.wlNavItem.left = [WLNavigationButton menuButtonWithOffset:CGPointMake(0, 0)];
        pp = [[WLProfilePictureView alloc] initWithFrame:CGRectMake(SCREEN_X/2-WL_PP_SIZE_LARGE/2, WL_NAVBAR_HEIGHT-WL_PP_SIZE_LARGE/2, WL_PP_SIZE_LARGE, WL_PP_SIZE_LARGE)];
        [pp makeImagePicker];
        self.wlNavItem.center = pp;
        self.wlNavItem.right = [[WLNavigationButton alloc] initWithOffset:CGPointMake(0, 0) andImage:[UIImage imageNamed:@"edit"]];
        [self.wlNavItem.right addTarget:self action:@selector(toggleEditProfile) forControlEvents:UIControlEventTouchUpInside];
        
        self.isNavigationSubview = YES;
        
        // Components
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(WL_NAVBAR_BTN_MARGIN, 10+WL_PP_SIZE_LARGE/2, SCREEN_X-WL_NAVBAR_BTN_MARGIN*2, 25)];
        nameLabel.textColor = WL_MAIN_TEXT1;
        nameLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:25.0];
        nameLabel.text = WL_SESS.userData[@"Name"];
        nameLabel.textAlignment = NSTextAlignmentCenter;
//        [self.view addSubview:nameLabel];
        
        editHide = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_X, nameLabel.frame.origin.y+nameLabel.frame.size.height)];
        editHide.backgroundColor = [UIColor clearColor];
        [editHide addSubview:nameLabel];
        [self.view addSubview:editHide];
        
        subtitle = [[UILabel alloc] initWithFrame:CGRectMake(WL_NAVBAR_BTN_MARGIN, nameLabel.frame.origin.y+nameLabel.frame.size.height+5, SCREEN_X-WL_NAVBAR_BTN_MARGIN*2, 20)];
        subtitle.textColor = WL_MAIN_TEXT2;
        subtitle.font = [UIFont fontWithName:@"Roboto-Light" size:15.0];
        subtitle.text = @"DASHBOARD";
        subtitle.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:subtitle];
        
        followers = [[WLFollowButton alloc] initWithFrame:CGRectMake(WL_NAVBAR_BTN_MARGIN, subtitle.frame.origin.y+subtitle.frame.size.height+20, 145, 50)];
        [followers setTitleColor:WL_MAIN_TEXT3 forState:UIControlStateNormal];
        followers.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:15.0];
        [followers setTitle:@"N followers" forState:UIControlStateNormal];
        [self.view addSubview:followers];
        
        following = [[WLFollowButton alloc] initWithFrame:CGRectMake(followers.frame.origin.x+followers.frame.size.width+10, subtitle.frame.origin.y+subtitle.frame.size.height+20, 145, 50)];
        [following setTitleColor:WL_MAIN_TEXT3 forState:UIControlStateNormal];
        following.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:15.0];
        [following setTitle:@"N following" forState:UIControlStateNormal];
        [self.view addSubview:following];
        
        editShow = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        editShow.alpha = 0;
        editShow.userInteractionEnabled = NO;
        UILabel *subtitleEdit = [[UILabel alloc] initWithFrame:subtitle.frame];
        subtitleEdit.textColor = subtitle.textColor;
        subtitleEdit.font = subtitle.font;
        subtitleEdit.text = @"EDITING PROFILE";
        subtitleEdit.textAlignment = subtitle.textAlignment;
        [editShow addSubview:subtitleEdit];
        
        UIScrollView *editScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, followers.frame.origin.y, SCREEN_X, self.view.frame.size.height-followers.frame.origin.y)];
        [self.view addSubview:editScrollView];
        
        [self.view addSubview:editShow];
        
    }
    return self;
}

-(id)initWithUserID:(int)ID {
    if (self = [self init]) {
        
    }
    return self;
}

-(void)addUserDetail:(NSString *)key withValue:(NSString *)value {
    if ([key isEqualToString:@"Name"]) {
        nameLabel.text = value;
    } else if ([key isEqualToString:@"Picture"]) {
        [pp updateImageWithURL:[NSURL URLWithString:value]];
    }
}

-(void)toggleEditProfile {
    if (editing) {
        [UIView animateWithDuration:0.25 animations:^{
            for (UIView *view in [self.view subviews]) {
                if ([view isEqual:editShow])
                    view.alpha = 0;
                else if (![view isEqual:editHide])
                    view.alpha = 1;
            }
        }];
        [self.wlNavItem.right setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        editing = NO;
    }
    else {
        [UIView animateWithDuration:0.25 animations:^{
            for (UIView *view in [self.view subviews]) {
                if ([view isEqual:editShow])
                    view.alpha = 1;
                else if (![view isEqual:editHide])
                    view.alpha = 0;
            }
        }];
        [self.wlNavItem.right setImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
        editing = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
