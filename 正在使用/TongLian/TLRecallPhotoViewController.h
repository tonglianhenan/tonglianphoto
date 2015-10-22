//
//  TLRecallPhotoViewController.h
//  TongLian
//
//  Created by mac on 14-3-25.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "TLImage.h"
#import "TLImageViewController.h"

@interface TLRecallPhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (retain,nonatomic)IBOutlet UIButton *myButton;
@property (retain,nonatomic)TLImage *image;
@property (retain,nonatomic)IBOutlet UIImageView *myImage;
@property (retain,nonatomic)NSString *endpointID;

-(IBAction)button1_click:(id)sender;
-(IBAction)button2_click:(id)sender;
@end
