//
//  WLSession.m
//  whooplist
//
//  Created by Dev Chakraborty on 1/11/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLSession.h"

@implementation WLSession

WLSession *mainSession;

-(id)init {
    if (self = [super init]) {
        _sessionCache = [WLSessionCache sessionCache];
        _delegates = [[NSMutableArray alloc] init];
    }
    return self;
}

+(WLSession *)session {
    return (mainSession) ? mainSession : (mainSession = [[WLSession alloc] init]);
}

-(void)request:(WLRequestType *)requestType withParameters:(NSDictionary *)params {
    NSMutableDictionary *mParams;
    if (params)
        mParams = [params mutableCopy];
    else
        mParams = [[NSMutableDictionary alloc] init];
    
    NSString *reqURL = requestType.route;
    for (NSString *key in params) {
        NSString *variable = NSStringFormat(@"%%%@%%", key);
        if ([reqURL rangeOfString:variable].location != NSNotFound) {
            reqURL = [reqURL stringByReplacingOccurrencesOfString:variable withString:[mParams valueForKey:key]];
            [mParams removeObjectForKey:key];
        }
    }
    
//    NSLog(@"%@", reqURL);
    
    NSData *data;
    
    NSString *key;
    if (requestType.keyRequired && (key = [self key]))
        mParams[@"Key"] = key;
    
    if ([mParams count] > 0)
        data = [NSJSONSerialization dataWithJSONObject:mParams options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:reqURL relativeToURL:API_URL]];
    [req setHTTPMethod:requestType.method];
    if (data)
        [req setHTTPBody:data];
    
//    NSLog(@"%@", [[NSString alloc] initWithData:[req HTTPBody] encoding:NSUTF8StringEncoding]);
    
    NSDate *requestTime = [NSDate date];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"CONNECTION ERROR: %@", [connectionError localizedDescription]);
            return;
        }
        
//        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSError *jsonErr;
        id retObj;
        if ((retObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonErr]) == nil)
            retObj = [NSNumber numberWithInt:[(NSHTTPURLResponse*)response statusCode]];
        
        NSDate *responseTime = [NSDate date];
        
        WLRequestRecord *record = [WLRequestRecord recordWithRequestType:requestType andResponse:retObj andRequestDatePair:[WLRequestDatePair requestDatePairWithRequestTime:requestTime andResponseTime:responseTime] andURL:reqURL];
        
        [_sessionCache pushRequestRecord:record];
        
//        NSLog(@"%@", [_sessionCache description]);
        if ([retObj isKindOfClass:[NSNumber class]] && [retObj integerValue] != 200) {
            for (id<WLSessionDelegate> object in _delegates)
                if ([(NSObject*)object respondsToSelector:@selector(WLSession:didProcessRequestFailure:)])
                    [object WLSession:self didProcessRequestFailure:record];
        } else {
            for (id<WLSessionDelegate> object in _delegates)
                if ([(NSObject*)object respondsToSelector:@selector(WLSession:didProcessRequestSuccess:)])
                    [object WLSession:self didProcessRequestSuccess:record];
        }
    }];
}

-(void)subscribeToSessionEvents:(id<WLSessionDelegate>) object {
    [_delegates addObject:object];
}

-(void)unsubscribeFromSessionEvents:(id<WLSessionDelegate>) object {
    [_delegates removeObject:object];
}

-(NSString *)key {
    WLRequestRecord *loginRecord = [_sessionCache lastRequestRecordWithName:@"LoginUser"];
    if (!loginRecord)
        return nil;
    return [loginRecord.response valueForKey:@"Key"];
}

-(NSNumber *)userID {
    WLRequestRecord *loginRecord = [_sessionCache lastRequestRecordWithName:@"LoginUser"];
    if (!loginRecord)
        return nil;
    return [loginRecord.response valueForKey:@"UserId"];
}

@end
