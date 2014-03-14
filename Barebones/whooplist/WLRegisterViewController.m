//
//  WLRegisterViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLRegisterViewController.h"

@interface WLRegisterViewController ()

@end

@implementation WLRegisterViewController {
    UITextField *email;
    UITextField *emailConfirm;
    UITextField *password;
    UITextField *passwordConfirm;
    UITextField *firstName;
    UITextField *lastName;
    UITextField *school;
    
    UIButton *reg;
    UILabel *success;
}

- (id)init
{
    if (self = [super init]) {
        
        int fieldHeight = 30;
        
        email = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_X, fieldHeight)];
        email.placeholder = @"Email";
        emailConfirm = [[UITextField alloc] initWithFrame:CGRectMake(0, fieldHeight, SCREEN_X, fieldHeight)];
        emailConfirm.placeholder = @"Confirm Email";
        password = [[UITextField alloc] initWithFrame:CGRectMake(0, fieldHeight*2, SCREEN_X, fieldHeight)];
        password.placeholder = @"Password";
        password.secureTextEntry = YES;
        passwordConfirm = [[UITextField alloc] initWithFrame:CGRectMake(0, fieldHeight*3, SCREEN_X, fieldHeight)];
        passwordConfirm.placeholder = @"Confirm Password";
        passwordConfirm.secureTextEntry = YES;
        firstName = [[UITextField alloc] initWithFrame:CGRectMake(0, fieldHeight*4, SCREEN_X, fieldHeight)];
        firstName.placeholder = @"First Name";
        lastName = [[UITextField alloc] initWithFrame:CGRectMake(0, fieldHeight*5, SCREEN_X, fieldHeight)];
        lastName.placeholder = @"Last Name";
        school = [[UITextField alloc] initWithFrame:CGRectMake(0, fieldHeight*6, SCREEN_X, fieldHeight)];
        school.placeholder = @"School";
        
        email.returnKeyType = emailConfirm.returnKeyType = password.returnKeyType = passwordConfirm.returnKeyType = firstName.returnKeyType = lastName.returnKeyType = UIReturnKeyNext;
        school.returnKeyType = UIReturnKeySend;
        
        email.autocapitalizationType = emailConfirm.autocapitalizationType = password.autocapitalizationType = passwordConfirm.autocapitalizationType = UITextAutocapitalizationTypeNone;
        firstName.autocapitalizationType = lastName.autocapitalizationType = school.autocapitalizationType = UITextAutocapitalizationTypeWords;
        email.autocorrectionType = emailConfirm.autocorrectionType = password.autocorrectionType = passwordConfirm.autocorrectionType = firstName.autocorrectionType = lastName.autocorrectionType = school.autocorrectionType = UITextAutocorrectionTypeNo;
        
        reg = [[UIButton alloc] initWithFrame:CGRectMake(0, fieldHeight*7, SCREEN_X, fieldHeight)];
        [reg setTitle:@"Register" forState:UIControlStateNormal];
        [reg setBackgroundColor:[UIColor redColor]];
        [reg addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
        
        for (UIView *field in @[email, emailConfirm, password, passwordConfirm, firstName, lastName, school, reg])
            [self.view addSubview:field];
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        [self.view addGestureRecognizer:tapGest];
        
        success = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 400, 300)];
        
        [APP_DEL.session subscribeToSessionEvents:self];
    }
    return self;
}

-(void)doRegister {
    [APP_DEL.session request:[WLRequestType createUserRequestType] withParameters:@{@"User":@{@"Email":email.text, @"Password":password.text, @"Fname": firstName.text, @"Lname": lastName.text, @"Name": STR_CONCAT(STR_CONCAT(firstName.text, @" "), lastName.text), @"School": school.text}}];
}

-(void)hideKeyboard {
    for (UITextField *field in @[email, emailConfirm, password, passwordConfirm, firstName, lastName, school])
        if ([field isFirstResponder]) {
            [field resignFirstResponder];
            return;
        }
}

-(void)WLSession:(WLSession *)session didProcessRequestSuccess:(WLRequestRecord *)requestRecord {
    if ([requestRecord.requestType.name isEqualToString:@"LoginUser"]) {
        for (UIView *field in @[email, emailConfirm, password, passwordConfirm, firstName, lastName, school, reg])
            [field removeFromSuperview];
        success.text = @"Can't register while logged in.";
        [self.view addSubview:success];
    } else if ([requestRecord.requestType.name isEqualToString:@"CreateUser"]) {
        for (UIView *field in @[email, emailConfirm, password, passwordConfirm, firstName, lastName, school, reg])
            [field removeFromSuperview];
        success.text = @"Successfully registered user.";
        [self.view addSubview:success];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
