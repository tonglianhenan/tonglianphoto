//
//  TLServiceController.h
//  TongLian
//
//  Created by mac on 13-10-9.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICheckBoxButton.h"
#import "ASIHttpHeaders.h"
#import "tooles.h"
#import "TLCompany.h"
#import "TLAppDelegate.h"
#import "TLRootTableViewController.h"
#import "TLBusinessController.h"

@interface TLServiceController : UIViewController
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *serviceType;
@property (nonatomic,strong)NSMutableDictionary *checkbox;

-(void)GetResult:(ASIHTTPRequest *)request;
-(void)GetErr:(ASIHTTPRequest *)request;
@end
