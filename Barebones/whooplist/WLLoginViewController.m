//
//  WLLoginViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLLoginViewController.h"

@interface WLLoginViewController ()

@end

@implementation WLLoginViewController {

    UITextField *email;
    UITextField *password;
    UIButton *login;
    UILabel *success;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    email = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_X, 30)];
    email.placeholder = @"Email";
    email.returnKeyType = UIReturnKeyNext;
    email.delegate = self;
    email.autocapitalizationType = UITextAutocapitalizationTypeNone;
    email.autocorrectionType = UITextAutocorrectionTypeNo;
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(0, 30, SCREEN_X, 30)];
    password.placeholder = @"Password";
    password.returnKeyType = UIReturnKeySend;
    password.delegate = self;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.secureTextEntry = YES;
    
    login = [[UIButton alloc] initWithFrame:CGRectMake(0, 60, SCREEN_X, 30)];
    [login setTitle:@"Login" forState:UIControlStateNormal];
    [login setBackgroundColor:[UIColor redColor]];
    [login addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    
    success = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 400, 300)];
    
    [self.view addSubview:email];
    [self.view addSubview:password];
    [self.view addSubview:login];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGest];
    
    [APP_DEL.session subscribeToSessionEvents:self];
}

-(void)WLSession:(WLSession *)session didProcessRequestSuccess:(WLRequestRecord *)requestRecord {
    if ([requestRecord.requestType.name isEqualToString:@"LoginUser"]) {
        [email removeFromSuperview];
        [password removeFromSuperview];
        [login removeFromSuperview];
        success.text = NSStringFormat(@"Logged in with UID %@", [requestRecord.response valueForKey:@"UserId"]);
        [self.view addSubview:success];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:email])
        [password becomeFirstResponder];
    else if ([textField isEqual:password]) {
        [password resignFirstResponder];
        [login sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return YES;
}

-(void)doLogin {
    NSLog(@"Email: %@", email.text);
    NSLog(@"Password: %@", password.text);
    [APP_DEL.session request:[WLRequestType loginUserRequestType] withParameters:@{@"User":@{@"Email":email.text, @"Password":password.text}}];
}

-(void)hideKeyboard {
    for (UITextField *field in @[email, password])
        if ([field isFirstResponder]) {
            [field resignFirstResponder];
            return;
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
