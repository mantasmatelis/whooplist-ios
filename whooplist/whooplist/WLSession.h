//
//  WLSession.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/11/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLSession : NSObject <NSURLConnectionDataDelegate>


-(id)initWithUsername:(NSString*)username andPassword:(NSString*)password;
-(void)setResponseObject:(id)object andAction:(SEL)action;
+(void)doWLGetRequest:(NSString *)route;
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

@end