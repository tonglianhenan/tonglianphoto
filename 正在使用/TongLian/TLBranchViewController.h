//
//  TLBranchViewController.h
//  TongLian
//
//  Created by mac on 13-9-17.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "TLCompany.h"
#import "TLBranch.h"
#import "TLPlaceViewController.h"

@interface TLBranchViewController : UIViewController

@property (nonatomic,strong)IBOutlet UIScrollView *myScrollerView;
@property (nonatomic,strong)TLCompany *myCompany;
@property (nonatomic)NSInteger i;
@property (nonatomic)CGFloat x1;
@property (nonatomic)CGFloat x2;
@property (nonatomic)CGFloat y1;
@property (nonatomic)CGFloat y2;
@property (nonatomic)CGFloat width1;
@property (nonatomic)CGFloat width2;
@property (nonatomic)CGFloat height1;
@property (nonatomic)CGFloat height2;
@property (nonatomic)NSInteger myTag;

@property (nonatomic,retain) UIButton *myButton;

-(void)button_click:(id)sender event:(id)event;
-(void)addBranch;
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void)synchroWithName:(NSString *)name;
-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer;
@end
