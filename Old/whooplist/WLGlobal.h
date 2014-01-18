//
//  WLGlobal.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/21/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#ifndef whooplist_globals
#define whooplist_globals

//  General iOS

#define APP_DEL     ((WLAppDelegate*)[[UIApplication sharedApplication] delegate])

//  Macros

#define CONCAT(a, b)       [a stringByAppendingString:b]
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b)      RGBA(r,g,b,1.0]

//  Networking

#define WLAPI_URL   @"https://api.whooplist.com/"
#define WL_SESS     [APP_DEL mainSession]
#define WL_SUPPORTED_NOTIFS     @[@"WL_Login_Success", @"WL_Login_Failure", @"WL_User_Retrieved", @"WL_User_Changed", @"WL_Current_User_Retrieved"]

//  UI Constants

//  UI Constants // General

//  UI Constants // General // Sizes

#define SCREEN_X         [[UIScreen mainScreen] bounds].size.width
#define SCREEN_Y         [[UIScreen mainScreen] bounds].size.height
#define WL_MARGIN_SMALL 10

//  UI Constants // General // Colors

#define WL_MAIN_BG      [UIColor colorWithRed:198.0/255.0   green:222.0/255.0   blue:228.0/255.0    alpha:1.0]
#define WL_MAIN_LIGHT   [UIColor colorWithRed:219.0/255.0   green:236.0/255.0   blue:241.0/255.0    alpha:1.0]
#define WL_MAIN_TEXT1   [UIColor colorWithRed:20.0/255.0   green:67.0/255.0   blue:79.0/255.0    alpha:1.0]
#define WL_MAIN_TEXT2   [UIColor colorWithRed:105.0/255.0   green:132.0/255.0   blue:139.0/255.0    alpha:1.0]
#define WL_MAIN_TEXT3   [UIColor colorWithRed:3.0/255.0     green:171.0/255.0   blue:213.0/255.0    alpha:1.0]

//  UI Constants // Navigation

//  UI Constants // Navigation // Sizes

#define WL_NAVBAR_HEIGHT        75
#define WL_NAVBAR_BTN_HEIGHT    40
#define WL_NAVBAR_BTN_MARGIN  10

//  UI Constants // Navigation // Colors

#define WL_NAVBAR_BG    [UIColor colorWithRed:68.0/255.0    green:86.0/255.0   blue:91.0/255.0    alpha:1.0]
#define WL_NAVBAR_BTN_BG    [UIColor colorWithRed:60.0/255.0     green:76.0/255.0   blue:80.0/255.0    alpha:1.0]

//  UI Constants // Profile

#define WL_PP_SIZE_LARGE  100

//  UI Constants // Menu

#define WL_MENU_ITEMS   @[@"Dashboard", @"News Feed", @"Planner", @"Places", @"Settings"]
#define WL_MENU_ACTIVE_ALPHA    1.0
#define WL_MENU_INACTIVE_ALPHA 0.6

//  UI Constants // Menu // Sizes

#define WL_MENU_RIGHT_PADDING   10
#define WL_MENU_ITEM_HEIGHT     40
#define WL_MENU_ITEM_SPACE      0

#define WL_HL_COLOUR    [UIColor colorWithRed:3.0/255.0     green:171.0/255.0   blue:213.0/255.0    alpha:1.0]

#define PRIMARYC        [UIColor colorWithRed:31.0/255.0 green:151.0/255.0 blue:181.0/255.0 alpha:255.0/255.0]
#define SECONDARYC      [UIColor colorWithRed:100.0/255.0 green:204.0/255.0 blue:43.0/255.0 alpha:255.0/255.0]
#define SECONDARYBTNC   [UIColor colorWithRed: 78.0/255.0 green: 163.0/255.0 blue: 31.0/255.0 alpha: 255.0/255.0]
#define DARKC           [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define LIGHTC           [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2]
#define MAINBACKC       RGBA(36.0, 189.0, 211.0, 255.0)
#define BULBOUTERC      RGBA(12.0, 70.0, 84.0, 255.0)
#define BULBINNERC      RGBA(64.0, 211.0, 232.0, 255.0)
#define LIGHTTEXTC      RGBA(204.0, 245.0, 255.0, 255.0)
#define DARKTEXTC       RGBA(26.0, 117.0, 130.0)
#define OVERLAYBGC    RGBA(64.0, 211.0, 232.0, 255.0)
#define OVERLAYTXTC     RGBA(29.0, 125.0, 138.0, 255.0)
#define GOODBTNBGC      RGBA(188.0, 212.0, 113.0, 255.0)
#define GOODBTNHLBGC    RGBA(201.0, 225.0, 126.0, 255.0)
#define GOODBTNTXTC     RGBA(91.0, 102.0, 58.0, 255.0)
#define GOODBTNHLTXTC   RGBA(122.0, 134.0, 85.0, 255.0)
#define NEUTBTNBGC      RGBA(122.0, 235.0, 251.0, 255.0)
#define NEUTBTNHLBGC    RGBA(159.0, 243.0, 255.0, 255.0)
#define NEUTBTNTXTC     RGBA(24.0, 105.0, 116.0, 255.0)
#define NEUTBTNHLTXTC   RGBA(41.0, 141.0, 154.0, 255.0)
#define BOTTOMPAN_H     110
#define FIELDHEIGHT     40
#define BTNHEIGHT       40
#define FIELDFONT       [UIFont fontWithName:@"Roboto-Light" size:15.0]
#define FIELDPADDING    24/2
#define BTNFONT         [UIFont fontWithName:@"Roboto-Bold" size:15.0]
#define ANIMDURATION    0.3
#define CORNERRADIUS    5.0

#endif
