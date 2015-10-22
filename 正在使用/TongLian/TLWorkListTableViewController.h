//
//  TLWorkListViewController.h
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-29.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "TLPhotoListViewController.h"
#import "TLNetTypeTableViewController.h"
@class TLCompany;


@interface TLWorkListTableViewController : UITableViewController
@property (nonatomic,strong) TLCompany *company;

@end
