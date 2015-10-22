//
//  TLBusinessController.h
//  TongLian
//
//  Created by mac on 13-9-11.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHttpHeaders.h"
#import "TLAppDelegate.h"
#import "tooles.h"
#import "TLCompany.h"
#import "TLSearchViewController.h"

@interface TLBusinessController : UIViewController

-(IBAction)shouyinbao:(id)sender;
-(IBAction)button_click:(id)sender;
-(void)initCompanyList;

-(void)GetResult:(ASIHTTPRequest *)request;
-(void)GetErr:(ASIHTTPRequest *)request;
@end
