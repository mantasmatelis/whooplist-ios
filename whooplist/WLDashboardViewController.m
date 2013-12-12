//
//  WLDashboardViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/12/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLDashboardViewController.h"
#import "WLAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface WLDashboardViewController ()

@end

@implementation WLDashboardViewController

UIImagePickerController *ppPicker;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _profilePicture.layer.cornerRadius = _profilePicture.frame.size.width/2.0;
    _profilePicture.clipsToBounds = YES;
    [_profilePicture addTarget:self action:@selector(selectPP:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userRetrieved:) name:@"WL_User_Retrieved" object:nil];
    [WL_SESS doCurrentUserInfoRequest];
}

-(void)selectPP:(id)sender {
    ppPicker = [[UIImagePickerController alloc] init];
    ppPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ppPicker.delegate = self;
    [self presentViewController:ppPicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [WL_SESS doPPChangeRequest:info[UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)userRetrieved:(NSNotification*)notif {
    NSLog(@"User Retrieved");
    for (id key in notif.userInfo)
        [self addUserDetail:(NSString *)key withValue:notif.userInfo[key]];
}

-(void)addUserDetail:(NSString*)detail withValue:(id)value {
    if ([detail isEqualToString:@"Name"])
        _nameLabel.text = value;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
