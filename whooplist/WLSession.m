//
//  WLSession.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/11/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLSession.h"
#import "WLJSONAdditions.h"
#include <math.h>

@implementation WLSession

-(id)initWithUsername:(NSString*)username andPassword:(NSString*)password {
    if (self = [super init]) {
        _username = username;
        _password = password;
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
    NSLog(@"%@", [request responseBody]);
    if (response.statusCode == 200) {
        _key = [[request responseBody] jsonDictionary][@"Key"];
        _userID = [[request responseBody] jsonDictionary][@"UserId"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WL_Login_Success" object:nil];
    } else if (response.statusCode == 403) {
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

-(UIImage*)getPPImage:(UIImage*)image {
    CGSize size = CGSizeMake(image.size.width>image.size.height?image.size.height:image.size.width, image.size.width>image.size.height?image.size.height:image.size.width);
    double x = (image.size.width - size.width) / 2.0;
    double y = (image.size.height - size.height) / 2.0;
    
    CGRect cropRect = CGRectMake(x, y, size.height, size.width);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    CGSize newSize = CGSizeMake(45, 45);
    
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    imageRef = cropped.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(WLRequest *)getPPChangeRequest:(UIImage *)image {
    NSString *b64 = [UIImageJPEGRepresentation([self getPPImage:image], 1.0) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    b64 = [b64 stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return [self getUserChangeRequest:@{@"Picture": b64}];
}

-(WLRequest *)getUserChangeRequest:(NSDictionary *)changes {
    NSMutableDictionary *mChanges = [changes mutableCopy];
    mChanges[@"Email"] = _username;
    return [self getWLPostRequest:@"/users" withData:@{@"User": mChanges, @"Key": _key}];
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
    NSLog(@"ID: %@", _userID);
    if (_userID)
        [self doUserInfoRequest:_userID];
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
    if (request.response.statusCode == 200)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WL_User_Retrieved" object:nil userInfo:[request.responseBody jsonDictionary]];
}

-(void)doPPChangeRequest:(UIImage *)image {
    WLRequest *req = [self getPPChangeRequest:image];
    NSLog(@"%@", [req.request description]);
    NSLog(@"%@", [[NSString alloc] initWithData:req.request.HTTPBody encoding:NSUTF8StringEncoding]);
    [req addTarget:self withAction:@selector(doUserChangeRequestCallback:)];
    [req execute];
}

-(void)doUserChangeRequest:(NSDictionary *)changes {
    WLRequest *req = [self getUserChangeRequest:changes];
    NSLog(@"%@", [req.request description]);
    NSLog(@"%@", [[NSString alloc] initWithData:req.request.HTTPBody encoding:NSUTF8StringEncoding]);
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
