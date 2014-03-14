//
//  WLMainViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLMainViewController.h"

@interface WLMainViewController ()

@end

@implementation WLMainViewController

NSArray *viewList;

UIScrollView *populate;

WLLoginViewController *login;
WLRegisterViewController *regist;
WLProfileViewController *profileInfo;
WLFriendsViewController *friends;

-(id)init {
    if (self = [super init]) {
        login = [[WLLoginViewController alloc] init];
        regist = [[WLRegisterViewController alloc] init];
        profileInfo = [[WLProfileViewController alloc] init];
        friends = [[WLFriendsViewController alloc] init];
        
        viewList = @[
                     @{@"label": @"Login",
                       @"controller": login},
                     @{@"label": @"Register",
                       @"controller": regist},
                     @{@"label": @"Profile Info",
                       @"controller": profileInfo},
                     @{@"label": @"Friends",
                       @"controller": friends}
                     ];
        
        UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_X, 50)];
        picker.dataSource = self;
        picker.delegate = self;
        
        // Bottom border
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, picker.frame.size.height, picker.frame.size.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor blueColor].CGColor;
        [picker.layer addSublayer:bottomBorder];
        //
        
        [self.view addSubview:picker];
        
        
        populate = [[UIScrollView alloc] initWithFrame:CGRectMake(0, picker.frame.size.height, SCREEN_X, SCREEN_Y-picker.frame.size.height)];
        [self.view addSubview:populate];
        
        [self pickerView:picker didSelectRow:0 inComponent:0];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUp:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDown:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)keyboardUp:(NSNotification *)notif {
    int height = [notif.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    float time = [notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve curve = [notif.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    populate.frame = CGRectMake(populate.frame.origin.x, populate.frame.origin.y, populate.frame.size.width, populate.frame.size.height-height);
    [UIView commitAnimations];
}

-(void)keyboardDown:(NSNotification *)notif {
    int height = [notif.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    float time = [notif.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve curve = [notif.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    populate.frame = CGRectMake(populate.frame.origin.x, populate.frame.origin.y, populate.frame.size.width, populate.frame.size.height+height);
    [UIView commitAnimations];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [viewList count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    for (UIView *subview in [populate subviews])
        [subview removeFromSuperview];
    
    UIView *subview = ((UIViewController *)[[viewList objectAtIndex:row] valueForKey:@"controller"]).view;
    
    [populate addSubview:subview];
    [populate setContentSize:CGSizeMake(SCREEN_X, SCREEN_Y)];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[viewList objectAtIndex:row] valueForKey:@"label"];
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
