//
//  WLLogViewController.h
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLLogViewController : UIViewController

@property (nonatomic) int fieldHeight;
@property (nonatomic) int cumulHeight;
@property (nonatomic, readonly) NSMutableArray *labels;

-(int)fieldHeight;
-(int)cumulHeight;
-(void)log:(NSString *)text;
-(void)clearLogs;

@end
