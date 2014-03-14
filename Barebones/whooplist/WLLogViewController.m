//
//  WLLogViewController.m
//  whooplist
//
//  Created by Dev Chakraborty on 1/17/2014.
//  Copyright (c) 2014 Whooplist. All rights reserved.
//

#import "WLLogViewController.h"

@interface WLLogViewController ()

@end

@implementation WLLogViewController

-(id)init {
    if (self = [super init]) {
        _labels = [[NSMutableArray alloc] init];
        _fieldHeight = 30;
        _cumulHeight = 0;
    }
    return self;
}

-(int)cumulHeight {
    _cumulHeight += _fieldHeight;
    return _cumulHeight - _fieldHeight;
}

-(void)log:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [self cumulHeight], SCREEN_X, [self fieldHeight])];
    label.text = text;
    [_labels addObject:label];
    [self.view addSubview:label];
}

-(void)clearLogs {
    for (UILabel *label in _labels) {
        [label removeFromSuperview];
        [_labels removeObject:label];
    }
    _cumulHeight = 0;
}

@end
