//
//  WLPlacesViewController.h
//  whooplist
//
//  Created by Dev Chakraborty on 2/2/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLPlaceCategoriesViewController : UITableViewController <WLSessionDelegate> {
    NSMutableArray *categories;
    NSArray *_response;
    NSNumber *_userID;
}

@property (nonatomic, retain) NSNumber *root;
- (id)initWithRoot:(NSNumber *)root;
- (id)initWithRoot:(NSNumber *)root andUserID:(NSNumber *)userID;

@end
