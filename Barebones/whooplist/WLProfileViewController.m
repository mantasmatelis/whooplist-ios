//
//  WLProfileViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLProfileViewController.h"

@interface WLProfileViewController ()

@end

@implementation WLProfileViewController

-(id)init {
    if (self = [super init]) {
    
        [self log:@"Not logged in."];
        
        [APP_DEL.session subscribeToSessionEvents:self];
    }
    return self;
}

-(void)WLSession:(WLSession *)session didProcessRequestSuccess:(WLRequestRecord *)requestRecord {
    if ([requestRecord.requestType.name isEqualToString:@"LoginUser"]) {
        [self clearLogs];
        [self log:@"Retrieving profile info..."];
        NSString *userID = NSStringFormat(@"%@", requestRecord.response[@"UserId"]);
        [APP_DEL.session request:[WLRequestType getUserRequestType] withParameters:@{@"UserId": userID}];
    }
    else if ([requestRecord.requestType.name isEqualToString:@"GetUser"]) {
        [self clearLogs];
        for (NSString *item in @[@"Name", @"Email", @"School"])
            [self log:STR_CONCAT(STR_CONCAT(item, @": "), [requestRecord.response valueForKey:item])];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
