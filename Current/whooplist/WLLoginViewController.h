//
//  WLLoginViewController.h
//  whooplist
//
//  Created by Dev Chakraborty on 2/2/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLRootViewController.h"

@interface WLLoginViewController : UIViewController <WLSessionDelegate> {
    UITextField *username;
    UITextField *password;
    UIButton *submit;
}

@end
