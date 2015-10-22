//
//  TLFBPhotoViewController.h
//  TongLian
//
//  Created by mac on 14-6-19.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "TLImage.h"
#import "TLImageViewController.h"
#import "TLShowImageViewController.h"
#import "tooles.h"
#import "TLFeedbackTableViewController.h"

@interface TLFBPhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic,strong)NSString *businessId;

@property (nonatomic,strong)IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong)UIButton *myButton;
@property (nonatomic,strong)NSString *photoName;

@property (nonatomic)NSInteger count;
@property (nonatomic)NSInteger flag;
@property (nonatomic)NSInteger sflag;
@property (nonatomic)NSInteger myTag;

@property (nonatomic)NSInteger i;
@property (nonatomic)CGFloat x1;
@property (nonatomic)CGFloat x2;
@property (nonatomic)CGFloat y1;
@property (nonatomic)CGFloat y2;
@property (nonatomic)CGFloat width1;
@property (nonatomic)CGFloat width2;
@property (nonatomic)CGFloat height1;
@property (nonatomic)CGFloat height2;

@end
