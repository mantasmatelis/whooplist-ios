//
//  WLProfilePictureView.h
//  whooplist
//
//  Created by Dev Chakraborty on 12/13/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLProfilePictureView : UIButton <NSURLConnectionDataDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
    
- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)image;
- (void)updateImage:(UIImage *)image;
- (void)updateImageWithURL:(NSURL *)url;
-(void)makeImagePicker;

@end
