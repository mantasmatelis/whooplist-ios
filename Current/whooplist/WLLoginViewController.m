//
//  WLLoginViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 2/2/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLLoginViewController.h"

@implementation WLLoginViewController

-(id) init {
    if (self = [super init]) {
        username = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, SCREEN_X, 50)];
        username.autocapitalizationType = UITextAutocapitalizationTypeNone;
        username.autocorrectionType = UITextAutocorrectionTypeNo;
        username.placeholder = @"Email";
        
        password = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, SCREEN_X, 50)];
        password.placeholder = @"Password";
        password.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password.autocorrectionType = UITextAutocorrectionTypeNo;
        password.secureTextEntry = YES;
        
        submit = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, SCREEN_X, 50)];
        [submit setTitle:@"Login" forState:UIControlStateNormal];
        [submit setBackgroundColor:[UIColor blueColor]];
        [submit addTarget:self action:@selector(loginTap) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:username];
        [self.view addSubview:password];
        [self.view addSubview:submit];
        
        [APP_DEL.session subscribeToSessionEvents:self];
        
        APP_DEL.viewControllers[@"Login"] = self;
    }
    return self;
}

-(void)WLSession:(WLSession *)session didProcessRequestSuccess:(WLRequestRecord *)requestRecord {
    NSLog(@"%@", requestRecord);
    if ([requestRecord.requestType.name isEqualToString:@"LoginUser"]) {
        NSLog(@"Successfully logged in.");
        (void)[[WLMenuViewController alloc] init];
        [self presentViewController:[[WLRootViewController alloc] init] animated:YES completion:nil];
    }
}

-(void)WLSession:(WLSession *)session didProcessRequestFailure:(WLRequestRecord *)requestRecord {
    if ([requestRecord.requestType.name isEqualToString:@"LoginUser"]) {
        NSLog(@"Invalid username or password.");
    }
}

-(void)loginTap {
    [APP_DEL.session request:[WLRequestType loginUserRequestType] withParameters:@{@"User": @{@"Email": username.text, @"Password": password.text}}];
}

@end
