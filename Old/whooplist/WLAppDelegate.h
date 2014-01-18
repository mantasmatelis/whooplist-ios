//
//  WLAppDelegate.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/6/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLSession.h"
#import "WLRequest.h"
@class WLProfilePictureView;

typedef enum {
    WL_VIEWMODE_BEGIN,
    WL_VIEWMODE_DASHBOARD,
    WL_VIEWMODE_NEWSFEED,
    WL_VIEWMODE_PLANNER,
    WL_VIEWMODE_PLACES,
    WL_VIEWMODE_SETTINGS
} WLViewMode;

@interface WLAppDelegate : UIResponder <UIApplicationDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) WLSession *mainSession;
@property (nonatomic, retain) NSMutableDictionary *mainViews;
@property (nonatomic) BOOL menuShowing;
@property (nonatomic) WLViewMode currentViewMode;
-(void)openMenu;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
