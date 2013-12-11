//
//  WLSession.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/11/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLSession.h"
#import "WLJSONAdditions.h"

@implementation WLSession

NSString *_username = @"";
NSString *_password = @"";

NSURLRequest *_lastReq;
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

-(void)doWLGetRequest:(NSString *)route {
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:route relativeToURL:[NSURL URLWithString:WLAPI_URL]]];
    [req setHTTPMethod:@"GET"];
    
    _conn = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    _lastReq = req;
    _lastResp = NULL;
}

-(void)doWLPostRequest:(NSString *)route withData:(NSDictionary*)data {
    NSString *jsonString = [data jsonStringWithPrettyPrint:NO];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:route relativeToURL:[NSURL URLWithString:WLAPI_URL]]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    _conn = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
    _lastReq = req;
    _lastResp = NULL;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Request: %@", [_lastReq description]);
    NSLog(@"Response: %@", [(_lastResp = response) description]);
    if (_respObj && _respAction)
        [_respObj performSelector:_respAction];
}


@end
