//
//  TLFnotSubmit.h
//  TongLian
//
//  Created by mac on 15-1-13.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TLAppDelegate.h"
#import "TLBranch.h"
#import "TLImageViewController.h"

@interface TLFnotSubmit : UIViewController

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


