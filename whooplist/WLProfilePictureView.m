//
//  WLProfilePictureView.m
//  whooplist
//
//  Created by Dev Chakraborty on 12/13/2013.
//  Copyright (c) 2013 Whooplist. All rights reserved.
//

#import "WLProfilePictureView.h"
#import <QuartzCore/QuartzCore.h>
#import "WLAppDelegate.h"
#import "UIImage+Additions.h"

@implementation WLProfilePictureView
    
UIImageView *_imageView;
NSMutableData *_downloadedData;
UIImagePickerController *_ppPicker;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WL_MAIN_LIGHT;
        self.layer.cornerRadius = self.frame.size.width/2;
        self.clipsToBounds = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[image getPPImage] forState:UIControlStateNormal];
        self.backgroundColor = WL_MAIN_LIGHT;
        self.layer.cornerRadius = self.frame.size.width/2;
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)makeImagePicker {
    _ppPicker = [[UIImagePickerController alloc] init];
    _ppPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _ppPicker.delegate = self;
    _ppPicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self addTarget:self action:@selector(selectPP:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)selectPP:(id)sender {
    if (APP_DEL.mainViews[@"Main"])
        [APP_DEL.mainViews[@"Main"] presentViewController:_ppPicker animated:YES completion:nil];
}
    
-(void)updateImage:(UIImage *)image {
    [UIView transitionWithView:self
                      duration:0.4f
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowUserInteraction
                    animations:^{
                        [self setImage:image forState:UIControlStateNormal];
                    } completion:nil];
}

-(void)updateImageWithURL:(NSURL*)url {
    _downloadedData = [[NSMutableData alloc] init];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    [conn start];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_downloadedData appendData:data];
}
    
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self updateImage:[UIImage imageWithData:_downloadedData]];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if ([picker isEqual:_ppPicker]) {
        [WL_SESS doPPChangeRequest:info[UIImagePickerControllerOriginalImage]];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end