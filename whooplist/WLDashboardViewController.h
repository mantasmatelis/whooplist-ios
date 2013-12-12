//
//  WLDashboardViewController.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/12/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLViewController.h"

@interface WLDashboardViewController : WLViewController <UIImagePickerControllerDelegate>

@property (nonatomic, retain) IBOutlet UIButton *profilePicture;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *detailsLabel;

@end
