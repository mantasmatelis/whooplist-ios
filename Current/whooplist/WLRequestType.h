//
//  WLRequestType.h
//  whooplist
//
//  Created by Dev Chakraborty on 1/11/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLRequestType : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *route;
@property (nonatomic, readonly) NSString *method;
@property (nonatomic) BOOL keyRequired;

-(id)initWithName:(NSString *)name andRoute:(NSString *)route andMethod:(NSString *)method andKeyRequired:(BOOL)keyRequired;
+(WLRequestType *)requestTypeWithName:(NSString *)name;
+(WLRequestType *)loginUserRequestType;
+(WLRequestType *)logoutUserRequestType;
+(WLRequestType *)createUserRequestType;
+(WLRequestType *)getUserRequestType;
+(WLRequestType *)getUserFriendsRequestType;
+(WLRequestType *)deleteUserFriendRequestType;
+(WLRequestType *)getListTypesRequestType;
+(WLRequestType *)searchPlaceRequestType;
+(WLRequestType *)getUserListRequestType;
+(WLRequestType *)appendUserListRequestType;
+(WLRequestType *)createUserListRequestType;

@end
