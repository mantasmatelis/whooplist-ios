//
//  BeginView.m
//  Whooplist
//
//  Created by Debashis Chakraborty on 10/26/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLBeginViewController.h"
#import "WLTextFieldPair.h"
#import "WLButton.h"
#import "UIView+Additions.h"
#import "WLAppDelegate.h"
#define BULBWIDTH 218/2
#define BULBHEIGHT 218/2
#define LOGOWIDTH 356/2
#define LOGOHEIGHT 318/2
#define SIDEPADDING 70/2
#define INNERPADDING 20/2
#define FIELDPAIRHEIGHT 160/2
#define FORMHEIGHT  FIELDPAIRHEIGHT+INNERPADDING+BTNHEIGHT
#define CONTENTHEIGHT   LOGOHEIGHT+INNERPADDING+FIELDPAIRHEIGHT+INNERPADDING+BTNHEIGHT

@interface WLBeginViewController ()

@end

@implementation WLBeginViewController

UIView *loginView;
UIImageView *bulbOuter;
UIImageView *bulbInnerDim;
UIImageView *bulbInnerBright;
UIImageView *logoTitle;
UIView *logo;
WLTextFieldPair *creds;
WLButton *login;
BOOL animating = NO;
BOOL doSubmit = NO;

- (id)init
{
    self = [super init];
    if (self) {
        
        APP_DEL.mainViews[@"Begin"] = self;
        APP_DEL.currentViewMode = WL_VIEWMODE_BEGIN;
        
        self.view.backgroundColor = MAINBACKC;
//        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        NSLog(@"LOGO: %d CONTENT: %d VIEW: %f", LOGOHEIGHT, CONTENTHEIGHT, self.view.frame.size.height);
        
        //Input views
        
        loginView = [[UIView alloc] initWithFrame:CGRectMake(SIDEPADDING, self.view.frame.size.height/2-FORMHEIGHT/2, self.view.frame.size.width-SIDEPADDING*2, FORMHEIGHT)];
        [loginView addSubview:creds = [[WLTextFieldPair alloc] initWithFrame:CGRectMake(0, 0, loginView.frame.size.width, FIELDPAIRHEIGHT) andBackgroundColor:OVERLAYBGC andTextColor:OVERLAYTXTC andPadding:FIELDPADDING]];
        creds.field1.placeholder = @"Email";
        creds.field2.placeholder = @"Password";
        creds.field2.secureTextEntry = YES;
        creds.field1.returnKeyType = UIReturnKeyNext;
        creds.field2.returnKeyType = UIReturnKeyGo;
        creds.field1.autocapitalizationType = UITextAutocapitalizationTypeNone;
        creds.field2.autocapitalizationType = UITextAutocapitalizationTypeNone;
        creds.field1.autocorrectionType = UITextAutocorrectionTypeNo;
        creds.field2.autocorrectionType = UITextAutocorrectionTypeNo;
        creds.field1.delegate = creds.field2.delegate = self;
        creds.field1.keyboardType = UIKeyboardTypeEmailAddress;
        [loginView addSubview:login = [[WLButton alloc] initWithType:WLButtonGood andOrigin:CGPointMake(0, FIELDPAIRHEIGHT+INNERPADDING) andWidth:loginView.frame.size.width andText:@"log in or register"]];
        [login addTarget:self action:@selector(loginTapped) forControlEvents:UIControlEventTouchUpInside];
        loginView.alpha = 0;
        [self.view addSubview:loginView];
        
        //Logo
        
        logo = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-LOGOWIDTH/2, self.view.frame.size.height/2-LOGOHEIGHT/2, LOGOWIDTH, LOGOHEIGHT)];
        [logo addSubview:bulbOuter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"outerBulb"]]];
        bulbOuter.frame = CGRectMake(logo.frame.size.width/2-bulbOuter.frame.size.width/2, 3, bulbOuter.frame.size.width, bulbOuter.frame.size.height);
        [logo addSubview:bulbInnerDim = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"innerBulbBlue"]]];
        bulbInnerDim.frame = CGRectMake(logo.frame.size.width/2-bulbInnerDim.frame.size.width/2+6, 0, bulbInnerDim.frame.size.width, bulbInnerDim.frame.size.height);
        [logo addSubview:logoTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whooplistTitle"]]];
        logoTitle.frame = CGRectMake(0, logo.frame.size.height-logoTitle.frame.size.height, logoTitle.frame.size.width, logoTitle.frame.size.height);
        [self.view addSubview:logo];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        tap.delegate = self;
        tap.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tap];
        
        [self initialAnimation];
    }
    return self;
}
    
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGRect loginR = CGRectMake(loginView.frame.origin.x+login.frame.origin.x, loginView.frame.origin.y+login.frame.origin.y, login.frame.size.width, login.frame.size.height);
    if (touch.view == login || CGRectContainsPoint(loginR, [touch locationInView:self.view])) {
        NSLog(@"No");
        [login setHighlighted:YES];
    }
    NSLog(@"Yes");
    return YES;
}
    
-(void)loginTapped {
    doSubmit = YES;
    if ([creds.field1 isFirstResponder] || [creds.field2 isFirstResponder]) {
        [creds.field1 resignFirstResponder];
        [creds.field2 resignFirstResponder];
    } else {
        [self doLogin];
    }
}

-(void)testLogin {
    creds.field1.text = @"dev@whooplist.com";
    creds.field2.text = @"password";
    [login sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void)doLogin {
    doSubmit = NO;
    [self reverseAnimation];
    [WL_SESS setUsername:creds.field1.text];
    [WL_SESS setPassword:creds.field2.text];
    [WL_SESS doLoginRequest];
}
    
-(void)loginFailed {
    creds.field1.text = @"";
    creds.field2.text = @"";
    [self initialAnimation];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)keyboardWillShowNotification:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSNumber *number = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    double duration = [number doubleValue];
    NSNumber *number1 = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve curve = [number1 intValue];
    NSLog(@"will show with duration %f", duration);
    [self keyboardShowAnimation:duration withCurve:curve];
}

-(void)keyboardWillHideNotification:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSNumber *number = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    double duration = [number doubleValue];
    NSNumber *number1 = [info objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve curve = [number1 intValue];
    NSLog(@"will hide with duration %f", duration);
    [self keyboardHideAnimation:duration withCurve:curve];
}

-(void)initialAnimation {
    NSLog(@"%f %d", self.view.frame.size.height, CONTENTHEIGHT);
    [UIView animateWithDuration:ANIMDURATION animations:^{
        logo.transform = CGAffineTransformMakeTranslation(0, -(CONTENTHEIGHT-LOGOHEIGHT)/2);
        loginView.transform = CGAffineTransformMakeTranslation(0, logo.frame.origin.y+logo.frame.size.height+(float)INNERPADDING-loginView.frame.origin.y);
        loginView.alpha = 1;
    } completion:^(BOOL complete){
        [self testLogin];
    }];
}

-(void)reverseAnimation {
    [UIView animateWithDuration:ANIMDURATION animations:^{
        logo.transform = CGAffineTransformMakeTranslation(0, 0);
        loginView.transform = CGAffineTransformMakeTranslation(0, 0);
        loginView.alpha = 0;
    }];
}

#define SCROLLUP -150
#define LOGOSCALE 0.75

-(void)keyboardShowAnimation:(NSTimeInterval)duration withCurve:(UIViewAnimationCurve)curve {
    animating = YES;
    [UIView animateWithDuration:duration/3.0 animations:^{
        bulbOuter.alpha = bulbInnerDim.alpha = bulbInnerBright.alpha = 0.0;
    }];
    [UIView animateWithDuration:4.0*duration/5.0 delay: 1.0*duration/5.0 options: curve<<16 animations:^{
        logoTitle.transform = CGAffineTransformConcat(loginView.transform = CGAffineTransformMakeTranslation(0, -loginView.transform.ty), CGAffineTransformMakeTranslation(0, -logoTitle.frame.size.height-20));
    } completion:^(BOOL comp){
        animating = NO;
    }];
}

-(void)keyboardHideAnimation:(NSTimeInterval)duration withCurve:(UIViewAnimationCurve)curve {
    animating = YES;
    [UIView animateWithDuration:duration delay: 0 options: curve<<16 animations:^{
        bulbOuter.alpha = bulbInnerDim.alpha = bulbInnerBright.alpha = 1.0;
        loginView.transform = CGAffineTransformMakeTranslation(0, -loginView.transform.ty);
        logoTitle.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL comp){
        animating = NO;
        if (doSubmit)
            [self doLogin];
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:creds.field1])
        [creds.field2 becomeFirstResponder];
    if ([textField isEqual:creds.field2]) {
        [login sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return YES;
}

-(void)tapped:(UITapGestureRecognizer*)sender {
    CGPoint p = [sender locationInView:self.view];
    CGRect r = CGRectMake(loginView.frame.origin.x, loginView.frame.origin.y, creds.frame.size.width, creds.frame.size.height);
    if (CGRectContainsPoint(r, p))
        return;
    CGRect loginR = CGRectMake(loginView.frame.origin.x+login.frame.origin.x, loginView.frame.origin.y+login.frame.origin.y, login.frame.size.width, login.frame.size.height);
    if (CGRectContainsPoint(loginR, p)) {
        NSLog(@"Up");
        [login setHighlighted:NO];
        [login sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    [creds.field1 resignFirstResponder];
    [creds.field2 resignFirstResponder];
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
