//
//  TLCategory.h
//  TongLian
//
//  Created by mac on 15-1-12.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLPhotoList.h"
#import "TLAppDelegate.h"
#import "TLImage.h"
#import "TLImageViewController.h"
#import "TLShowImageViewController.h"
#import "tooles.h"
#import "TLFnotSubmit.h"

@interface TLCategory : UIViewController

@property (nonatomic,strong)NSString *businessName;


@property (nonatomic)NSInteger count;
@property (nonatomic)NSInteger flag;
@property (nonatomic)NSInteger sflag;
@property (nonatomic)NSInteger myTag;

@property (nonatomic,strong)NSString *businessId;

-(IBAction)mentou_click:(id)sender;
-(IBAction)shouyintai_click:(id)sender;
-(IBAction)jinyingchangsuo_click:(id)sender;
-(IBAction)gongdanzhengmian_click:(id)sender;
-(IBAction)gongdanfanmian_click:(id)sender;
-(IBAction)qita_click:(id)sender;

-(IBAction)submit:(id)sender;

@end
