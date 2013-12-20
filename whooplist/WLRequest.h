//
//  WLRequest.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/11/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WLSession;

@interface WLRequest : NSObject <NSURLConnectionDataDelegate>

-(void)addTarget:(id)object withAction:(SEL)action;
-(id)initWithRequest:(NSURLRequest *)request;
-(id)initWithTarget:(id)object andAction:(SEL)action;
-(id)initWithRequest:(NSURLRequest *)request andTarget:(id)object andAction:(SEL)action;
-(void)execute;

@property (nonatomic, retain) NSMutableURLRequest *request;
@property (nonatomic, retain, readonly) NSHTTPURLResponse *response;
@property (nonatomic, retain, readonly) NSString *responseBody;
@property (nonatomic, retain, readonly) id target;
@property (nonatomic, readonly) SEL action;
@property (nonatomic) BOOL expectsData;

@end
