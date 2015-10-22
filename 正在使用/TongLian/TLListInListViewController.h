//
//  TLListInListViewController.h
//  TongLian
//
//  Created by mac on 13-9-26.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "TLImageViewController.h"
#import "TLImage.h"

@interface TLListInListViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)IBOutlet UIScrollView *myScrollView;
@property (nonatomic,strong)NSString *dictionnaryName;
@property (nonatomic,strong)NSString *photoType;
@property (nonatomic,strong) NSString *photoName;
@property (weak, nonatomic) UIImage *thePhoto;
@property (nonatomic,strong)NSString *netType;

@property (nonatomic)NSInteger i;
@property (nonatomic)CGFloat x1;
@property (nonatomic)CGFloat x2;
@property (nonatomic)CGFloat y1;
@property (nonatomic)CGFloat y2;
@property (nonatomic)CGFloat width1;
@property (nonatomic)CGFloat width2;
@property (nonatomic)CGFloat height1;
@property (nonatomic)CGFloat height2;
@property (nonatomic,retain) UIButton *myButton;

-(void)add;
-(void)button_click:(id)sender event:(id)event;
-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer;

@end
