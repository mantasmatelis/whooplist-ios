//
//  WLRequestType.m
//  whooplist
//
//  Created by Dev Chakraborty on 1/11/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLRequestType.h"

@implementation WLRequestType

static NSArray *allTypes;

-(id)initWithName:(NSString *)name andRoute:(NSString *)route andMethod:(NSString *)method andKeyRequired:(BOOL)keyRequired {
    if (self = [super init]) {
        _name = name;
        _route = route;
        _method = method;
        _keyRequired = keyRequired;
    }
    return self;
}

+(void)initialize {
    [super initialize];
    
    // All routes defined here
    
    allTypes = @[
                 [[WLRequestType alloc] initWithName:@"Ping" andRoute:@"/ping" andMethod:@"GET" andKeyRequired:NO],
                 
                 /* User Routes */
                 [[WLRequestType alloc] initWithName:@"LoginUser" andRoute:@"/users/login" andMethod:@"POST" andKeyRequired:NO],
                 [[WLRequestType alloc] initWithName:@"LogoutUser" andRoute:@"/users/logout" andMethod:@"POST" andKeyRequired:YES],
                 [[WLRequestType alloc] initWithName:@"ExistsUser" andRoute:@"/user/exists/%Email%" andMethod:@"GET" andKeyRequired:NO],
                 [[WLRequestType alloc] initWithName:@"UpdateUser" andRoute:@"/users" andMethod:@"POST" andKeyRequired:NO],
                 [[WLRequestType alloc] initWithName:@"GetUser" andRoute:@"/users/%UserId%" andMethod:@"GET" andKeyRequired:NO],
                 [[WLRequestType alloc] initWithName:@"CreateUser" andRoute:@"/users" andMethod:@"PUT" andKeyRequired:NO],
                 
                 /* User List Routes */
                 [[WLRequestType alloc] initWithName:@"GetUserLists" andRoute:@"/users/%UserId%/lists" andMethod:@"GET" andKeyRequired:NO],
                 [[WLRequestType alloc] initWithName:@"GetUserList" andRoute:@"/users/%UserId%/lists/%ListId%" andMethod:@"GET" andKeyRequired:NO],
                 [[WLRequestType alloc] initWithName:@"CreateUserList" andRoute:@"/users/lists/%ListId%" andMethod:@"POST" andKeyRequired:YES],
                 [[WLRequestType alloc] initWithName:@"AppendUserList" andRoute:@"/users/lists/%ListId%/append/%PlaceId%" andMethod:@"POST" andKeyRequired:YES],
                 
                 [[WLRequestType alloc] initWithName:@"GetUserFriends" andRoute:@"/users/%UserId%/friends" andMethod:@"GET" andKeyRequired:NO],
                 [[WLRequestType alloc] initWithName:@"AddUserFriend" andRoute:@"/users/friends/%OtherId%" andMethod:@"PUT" andKeyRequired:YES],
                 [[WLRequestType alloc] initWithName:@"DeleteUserFriend" andRoute:@"/users/friends/%OtherId%" andMethod:@"DELETE" andKeyRequired:YES],
                 
                 [[WLRequestType alloc] initWithName:@"SuggestUserFriends" andRoute:@"/users/friends/suggestions" andMethod:@"GET" andKeyRequired:NO],
                 [[WLRequestType alloc] initWithName:@"ContactsUserFriends" andRoute:@"/users/friends/suggestions/contacts" andMethod:@"GET" andKeyRequired:NO],
                 [[WLRequestType alloc] initWithName:@"NetworkUserFriends" andRoute:@"/users/friends/suggestions/network" andMethod:@"GET" andKeyRequired:NO],
                 
                 /* Possible List Routes */
                 [[WLRequestType alloc] initWithName:@"GetListTypes" andRoute:@"/listTypes" andMethod:@"GET" andKeyRequired:NO],
                 
                 /* Whooplist Routes */
                 [[WLRequestType alloc] initWithName:@"GetWlCoordinate" andRoute:@"/whooplist/%ListId%/coordinate/%Lat%/%Long%/%Radius%/%Page%" andMethod:@"GET" andKeyRequired:NO],
                 
                 /* Newsfeed Routes */
                 [[WLRequestType alloc] initWithName:@"GetNewsfeedOlder" andRoute:@"/feed/older/%Lat%/%Long%/%Radius%/%EarliestId%" andMethod:@"GET" andKeyRequired:YES],
                 [[WLRequestType alloc] initWithName:@"GetNewsfeedUpdate" andRoute:@"/feed/%Lat%/%Long%/%Radius%/%EarliestId%" andMethod:@"GET" andKeyRequired:YES],
                 [[WLRequestType alloc] initWithName:@"GetNewsfeedNew" andRoute:@"/feed/%Lat%/%Long%/%Radius%" andMethod:@"GET" andKeyRequired:YES],
                 
                 /* Place Routes */
                 [[WLRequestType alloc] initWithName:@"SearchPlaceString" andRoute:@"/places/search/%ListId%/%Lat%/%Long%/%Radius%/%Page%/%SearchString%" andMethod:@"GET" andKeyRequired:NO],
                 [[WLRequestType alloc] initWithName:@"SearchPlace" andRoute:@"/places/search/%ListId%/%Lat%/%Long%/%Radius%/%Page%" andMethod:@"GET" andKeyRequired:NO],
                 [[WLRequestType alloc] initWithName:@"GetPlace" andRoute:@"/places/%PlaceId%" andMethod:@"GET" andKeyRequired:NO]
                 
                 ];
}

+(WLRequestType *)requestTypeWithName:(NSString *)name {
    for (WLRequestType *reqType in allTypes) {
        if ([reqType.name isEqualToString:name])
            return reqType;
    }
    return nil;
}

+(WLRequestType *)loginUserRequestType {
    return [WLRequestType requestTypeWithName:@"LoginUser"];
}

+(WLRequestType *)logoutUserRequestType {
    return [WLRequestType requestTypeWithName:@"LogoutUser"];
}

+(WLRequestType *)createUserRequestType {
    return [WLRequestType requestTypeWithName:@"CreateUser"];
}

+(WLRequestType *)getUserRequestType {
    return [WLRequestType requestTypeWithName:@"GetUser"];
}

+(WLRequestType *)getUserFriendsRequestType {
    return [WLRequestType requestTypeWithName:@"GetUserFriends"];
}

+(WLRequestType *)deleteUserFriendRequestType {
    return [WLRequestType requestTypeWithName:@"DeleteUserFriend"];
}

+(WLRequestType *)getListTypesRequestType {
    return [WLRequestType requestTypeWithName:@"GetListTypes"];
}

+(WLRequestType *)searchPlaceRequestType {
    return [WLRequestType requestTypeWithName:@"SearchPlace"];
}

+(WLRequestType *)getUserListRequestType {
    return [WLRequestType requestTypeWithName:@"GetUserList"];
}

+(WLRequestType *)appendUserListRequestType {
    return [WLRequestType requestTypeWithName:@"AppendUserList"];
}

+(WLRequestType *)createUserListRequestType {
    return [WLRequestType requestTypeWithName:@"CreateUserList"];
}

-(NSString *)description {
    NSString *ret = @"<WLRequestType:\n";
    ret = STR_CONCAT(ret, @"\tName: ");
    ret = STR_CONCAT(STR_CONCAT(ret, _name), @"\n");
    ret = STR_CONCAT(ret, @"\tRoute: ");
    ret = STR_CONCAT(STR_CONCAT(ret, _route), @"\n");
    ret = STR_CONCAT(ret, @"\tMethod: ");
    ret = STR_CONCAT(STR_CONCAT(ret, _method), @"\n");
    ret = STR_CONCAT(ret, @">");
    return ret;
}

@end
