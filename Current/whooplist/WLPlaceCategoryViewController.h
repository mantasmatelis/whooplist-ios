//
//  WLPlaceCategoryViewController.h
//  whooplist
//
//  Created by Dev Chakraborty on 2/2/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLPlaceCategoryViewController : UITableViewController <WLSessionDelegate> {
    NSMutableArray *places;
    NSDictionary *_listType;
    NSNumber *_userID;
}

- (id)initWithListType:(NSDictionary *)listType;
- (id)initWithListType:(NSDictionary *)listType andUserID:(NSNumber *)userID;

@end
