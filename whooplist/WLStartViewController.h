//
//  WLStartViewController.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/6/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLViewController.h"

@interface WLStartViewController : WLViewController

-(IBAction)doLogin:(id)sender;

@property (nonatomic, retain) IBOutlet UITextField *email;
@property (nonatomic, retain) IBOutlet UITextField *pwd;

@end
