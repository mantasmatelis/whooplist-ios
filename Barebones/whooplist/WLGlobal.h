//
//  WLGlobal.h
//  whooplist
//
//  Created by Dev Chakraborty on 1/11/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#ifndef whooplist_WLGlobal_h
#define whooplist_WLGlobal_h

#define         API_URL_STRING              @"https://api.whooplist.com"
#define         API_URL                     [NSURL URLWithString:API_URL_STRING]
#define         STR_CONCAT(A,B)             [A stringByAppendingString:B]
#define         NSStringFormat(A, ...)      [NSString stringWithFormat:A, __VA_ARGS__]

#define SCREEN_X        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_Y        ([UIScreen mainScreen].bounds.size.height)

#define APP_DEL         ((WLAppDelegate *)[[UIApplication sharedApplication] delegate])

#endif
