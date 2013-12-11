//
//  WLSession.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/11/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLSession.h"

@implementation WLSession

NSString *_username = @"";
NSString *_password = @"";

NSString *_lastReq = @"";
NSURLResponse *_lastResp;

NSURLConnection *_conn;

SEL _respAction;
id _respObj;

-(id)initWithUsername:(NSString*)username andPassword:(NSString*)password {
    if (self = [super init]) {
        _username = username;
        _password = password;
    }
    return self;
}

-(void)setResponseObject:(id)object andAction:(SEL)action {
    _respObj = object;
    _respAction = action;
}

+(void)doWLGetRequest:(NSString *)route {
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:route relativeToURL:[NSURL URLWithString:WLAPI_URL]]];
    _conn = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    _lastReq = route;
    _lastResp = NULL;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"%@", [response description]);
    _lastResp = response;
    [_respObj performSelector:_respAction];
}


@end
