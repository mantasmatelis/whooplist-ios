//
//  WLStartViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/6/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLStartViewController.h"
#import "WLAppDelegate.h"

@interface WLStartViewController ()

@end

@implementation WLStartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.email resignFirstResponder];
    [self.pwd resignFirstResponder];
    [super touchesEnded:touches withEvent:event];
}

-(void)observeLogin {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"WL_Login_Success" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailure) name:@"WL_Login_Failure" object:nil];
}

-(void)ignoreLogin {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WL_Login_Success" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WL_Login_Failure" object:nil];
}

-(IBAction)doLogin:(id)sender {
    [self.email resignFirstResponder];
    [self.pwd resignFirstResponder];
    [WL_SESS setUsername:self.email.text];
    [WL_SESS setPassword:self.pwd.text];
    [self observeLogin];
    [WL_SESS doLoginRequest];
}

-(void)loginSuccess {
    NSLog(@"Login success.");
    [self ignoreLogin];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WLStoryMain" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)loginFailure {
    NSLog(@"Login failure.");
    [self ignoreLogin];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
