//
//  WLFriendsViewController.h
//  whooplist
//
//  Created by Dev Chakraborty on 2/20/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLFriendsViewController : UITableViewController <WLSessionDelegate> {
    NSMutableDictionary *_friends;
}

@end
