//
//  WLFriendsViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLFriendsViewController.h"

@interface WLFriendsViewController ()

@end

@implementation WLFriendsViewController

- (id)init
{
    if (self = [super init]) {
        [self log:@"Not logged in."];
        
        [APP_DEL.session subscribeToSessionEvents:self];
    }
    return self;
}

-(void)WLSession:(WLSession *)session didProcessRequestSuccess:(WLRequestRecord *)requestRecord {
    if ([requestRecord.requestType.name isEqualToString:@"LoginUser"]) {
        [self clearLogs];
        [self log:@"Retrieving friendship information..."];
        NSString *userID = NSStringFormat(@"%@", requestRecord.response[@"UserId"]);
        [APP_DEL.session request:[WLRequestType getUserFriendsRequestType] withParameters:@{@"UserId": userID}];
    } else if ([requestRecord.requestType.name isEqualToString:@"GetUserFriends"]) {
        [self clearLogs];
        [self log:@"Friends:"];
        if ([requestRecord.response[@"Both"] count] == 0)
            [self log:@"None :("];
        else
            for (NSDictionary *person in requestRecord.response[@"Both"])
                [self log:STR_CONCAT(STR_CONCAT(STR_CONCAT(person[@"Name"], @" ("), [person[@"Id"] stringValue]), @")")];
        [self log:@"Followers:"];
        if ([requestRecord.response[@"Followers"] count] == 0)
            [self log:@"None :("];
        else
            for (NSDictionary *person in requestRecord.response[@"Followers"])
                [self log:STR_CONCAT(STR_CONCAT(STR_CONCAT(person[@"Name"], @" ("), [person[@"Id"] stringValue]), @")")];
        [self log:@"Following:"];
        if ([requestRecord.response[@"Following"] count] == 0)
            [self log:@"None :("];
        else
            for (NSDictionary *person in requestRecord.response[@"Following"])
                [self log:STR_CONCAT(STR_CONCAT(STR_CONCAT(person[@"Name"], @" ("), [person[@"Id"] stringValue]), @")")];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
