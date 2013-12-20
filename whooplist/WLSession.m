//
//  WLSession.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/11/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLSession.h"
#import "WLJSONAdditions.h"
#import "UIImage+Additions.h"
#include <math.h>

@implementation WLSession

-(id)initWithUsername:(NSString*)username andPassword:(NSString*)password {
    if (self = [super init]) {
        _username = username;
        _password = password;
        _loggedIn = NO;
    }
    return self;
}

-(WLRequest*)getWLGetRequest:(NSString *)route {
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:route relativeToURL:[NSURL URLWithString:WLAPI_URL]]];
    [req setHTTPMethod:@"GET"];
    
    return [[WLRequest alloc] initWithRequest:req];
}

-(WLRequest*)getWLPostRequest:(NSString *)route withData:(NSDictionary*)data {
    NSString *jsonString = [data jsonStringWithPrettyPrint:NO];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:route relativeToURL:[NSURL URLWithString:WLAPI_URL]]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return [[WLRequest alloc] initWithRequest:req];
}

-(WLRequest*)getLoginRequest {
    if (_username && _password)
    return [self getWLPostRequest:@"/users/login" withData:
            @{@"User": @{@"Email": _username, @"Password": _password}}
     ];
    else return NULL;
}

-(void)doLoginRequest {
    WLRequest *req = [self getLoginRequest];
    [req addTarget:self withAction:@selector(doLoginRequestCallback:)];
    [req execute];
}

-(void)doLoginRequestCallback:(WLRequest *)request {
    NSHTTPURLResponse *response = [request response];
    if (response) {
        NSLog(@"%@", [request responseBody]);
        if (response.statusCode == 200) {
            _key = [[request responseBody] jsonDictionary][@"Key"];
            _userData = [[NSMutableDictionary alloc] init];
            _userData[@"Id"] = [[request responseBody] jsonDictionary][@"UserId"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WL_Login_Success" object:nil];
        } else if (response.statusCode == 403) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WL_Login_Failure" object:nil];
        }
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WL_Login_Failure" object:nil];
    }
}

-(WLRequest*)getUserInfoRequest:(NSString *)ID {
    return [self getWLGetRequest:[NSString stringWithFormat:@"/users/%@", ID]];
}

-(WLRequest *)getLogoutRequest {
    if (![_key isEqualToString:@""])
        return [self getWLPostRequest:@"/users/logout" withData:
                @{@"Key": _key}
                ];
    else return NULL;
}

-(WLRequest *)getPPChangeRequest:(UIImage *)image {
    NSString *b64 = [UIImageJPEGRepresentation([image getPPImage], 1.0) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    b64 = [b64 stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return [self getUserChangeRequest:@{@"Picture": b64}];
}

-(WLRequest *)getUserChangeRequest:(NSDictionary *)changes {
    NSMutableDictionary *mChanges = [_userData mutableCopy];
    [mChanges addEntriesFromDictionary:changes];
    WLRequest *req = [self getWLPostRequest:@"/users" withData:@{@"User": mChanges, @"Key": _key}];
    req.expectsData = NO;
    return req;
}

-(void)doLogoutRequest {
    WLRequest *req = [self getLogoutRequest];
    [req addTarget:self withAction:@selector(doLogoutRequestCallback:)];
    [req execute];
}

-(void)doLogoutRequestCallback:(WLRequest *)request {
    _key = @"";
    NSLog(@"Logged out.");
}

-(void)doCurrentUserInfoRequest {
    WLRequest *req = [self getUserInfoRequest:_userData[@"Id"]];
    NSLog(@"%@", [req.request description]);
    [req addTarget:self withAction:@selector(doCurrentUserInfoRequestCallback:)];
    [req execute];
}

-(void)doCurrentUserInfoRequestCallback:(WLRequest *)request {
    NSLog(@"Callback");
    NSLog(@"%@", [request.response description]);
    if (request.response.statusCode == 200) {
        _userData = [[request.responseBody jsonDictionary] mutableCopy];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WL_Current_User_Retrieved" object:nil];
    }
}

-(void)doUserInfoRequest:(NSString *)ID {
    WLRequest *req = [self getUserInfoRequest:ID];
    NSLog(@"%@", [req.request description]);
    [req addTarget:self withAction:@selector(doUserInfoRequestCallback:)];
    [req execute];
}

-(void)doUserInfoRequestCallback:(WLRequest *)request {
    NSLog(@"Callback");
    NSLog(@"%@", [request.response description]);
    if (request.response.statusCode == 200) {
        NSMutableDictionary *responseDict = [[request.responseBody jsonDictionary] mutableCopy];
        if ([responseDict[@"Id"] isEqual:_userData[@"Id"]]) {
             _userData = responseDict;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WL_Current_User_Retrieved" object:nil];
        }
        else
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WL_User_Retrieved" object:nil userInfo:responseDict];
    }
}

-(void)doPPChangeRequest:(UIImage *)image {
    WLRequest *req = [self getPPChangeRequest:image];
    NSLog(@"%@", [req description]);
    [req.request setValue:@"100-continue" forHTTPHeaderField:@"Expect"];
    [req addTarget:self withAction:@selector(doUserChangeRequestCallback:)];
    [req execute];
}

-(void)doUserChangeRequest:(NSDictionary *)changes {
    WLRequest *req = [self getUserChangeRequest:changes];
    [req addTarget:self withAction:@selector(doUserChangeRequestCallback:)];
    [req execute];
}

-(void)doUserChangeRequestCallback:(WLRequest*)request {
    NSLog(@"callbck");
    NSLog(@"%d %@ %@", request.response.statusCode, [request.response description], request.responseBody);
    if (request.response.statusCode == 200)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WL_User_Changed" object:nil];
}

@end
