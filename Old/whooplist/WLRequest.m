//
//  WLRequest.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/11/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLRequest.h"

@implementation WLRequest

-(id)init {
    if (self = [super init])
        _expectsData = YES;
    return self;
}

-(id)initWithTarget:(id)object andAction:(SEL)action {
    if (self = [self init]) {
        _target = object;
        _action = action;
    }
    return self;
}

-(id)initWithRequest:(NSURLRequest *)request {
    if (self = [self init]) {
        _request = [request mutableCopy];
    }
    return self;
}

-(id)initWithRequest:(NSURLRequest *)request andTarget:(id)object andAction:(SEL)action {
    if (self = [self init]) {
        _request = [request mutableCopy];
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
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection Error: %@", [error localizedDescription]);
    if (_target && _action) {
        IMP imp = [_target methodForSelector:_action];
        void (*func)(id, SEL, WLRequest*) = (void*)imp;
        func(_target, _action, self);
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Connection Loaded");
    if (_target && _action) {
        IMP imp = [_target methodForSelector:_action];
        void (*func)(id, SEL, WLRequest*) = (void*)imp;
        func(_target, _action, self);
    }
}

@end
