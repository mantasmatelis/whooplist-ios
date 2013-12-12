//
//  WLRequest.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/11/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLRequest.h"

@implementation WLRequest

-(id)initWithTarget:(id)object andAction:(SEL)action {
    if (self = [super init]) {
        _target = object;
        _action = action;
    }
    return self;
}

-(id)initWithRequest:(NSURLRequest *)request {
    if (self = [super init]) {
        _request = request;
    }
    return self;
}

-(id)initWithRequest:(NSURLRequest *)request andTarget:(id)object andAction:(SEL)action {
    if (self = [super init]) {
        _request = request;
        _target = object;
        _action = action;
    }
    return self;
}

-(void)addTarget:(id)object withAction:(SEL)action {
    _target = object;
    _action = action;
}

-(void)execute {
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
    [conn start];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _response = (NSHTTPURLResponse*)response;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    _responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (_target && _action) {
        IMP imp = [_target methodForSelector:_action];
        void (*func)(id, SEL, WLRequest*) = (void*)imp;
        func(_target, _action, self);
    }
}

@end
