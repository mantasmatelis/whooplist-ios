//
//  WLGlobals.h
//  whooplist
//
//  Created by Dev Chakraborty on 2/2/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#ifndef whooplist_WLGlobals_h
#define whooplist_WLGlobals_h

#define SCREEN_X        [[UIScreen mainScreen] bounds].size.width
#define SCREEN_Y        [[UIScreen mainScreen] bounds].size.height

#define         NSStringFormat(A, ...)      [NSString stringWithFormat:A, __VA_ARGS__]

#define         API_URL_STRING              @"https://api.whooplist.com"
#define         API_URL                     [NSURL URLWithString:API_URL_STRING]

#define         STR_CONCAT(A,B)             [A stringByAppendingString:B]

#import "WLAppDelegate.h"
#define APP_DEL         ((WLAppDelegate *)[[UIApplication sharedApplication] delegate])

#import "WLSession.h"

#endif
