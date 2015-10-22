//
//  TLPhotoList.h
//  TongLian
//
//  Created by mac on 15-1-12.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "TLBranch.h"
#import "TLImageViewController.h"
#import "TLShowImageViewController.h"
#import "TLImage.h"


@interface TLPhotoList : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) NSString *businessName;
@property (nonatomic,strong) NSString *changsuo;
@property (nonatomic,strong) NSString *photoName;
@property (nonatomic,strong) NSString *businessId;

@property (nonatomic)NSInteger i;
@property (nonatomic)CGFloat x1;
@property (nonatomic)CGFloat x2;
@property (nonatomic)CGFloat y1;
@property (nonatomic)CGFloat y2;
@property (nonatomic)CGFloat width1;
@property (nonatomic)CGFloat width2;
@property (nonatomic)CGFloat height1;
@property (nonatomic)CGFloat height2;

@property (weak, nonatomic) UIImage *thePhoto;
@property (nonatomic,retain) UIButton *myButton;

-(void)add;
-(void)button_click:(id)sender event:(id)event;
-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer;
-(void)synchroWithName:(NSString *)name;


@end
