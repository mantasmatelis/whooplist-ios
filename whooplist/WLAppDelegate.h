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

@interface WLAppDelegate : UIResponder <UIApplicationDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) WLSession *mainSession;
@property (nonatomic, retain) NSMutableDictionary *mainViews;
@property (nonatomic) BOOL menuShowing;
-(void)openMenu;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
