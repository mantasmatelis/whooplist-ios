//
//  WLAppDelegate.h
//  whooplist
//
//  Created by Dev Chakraborty on 2/2/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#ifndef whooplist_WLAppDelegate_h
#define whooplist_WLAppDelegate_h

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WLSession.h"
#import "WLLoginViewController.h"

@interface WLAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) WLSession *session;
@property (nonatomic, retain, readonly) CLLocation *lastLocation;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableDictionary *viewControllers;

@end

#endif