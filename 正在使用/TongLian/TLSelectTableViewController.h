//
//  TLSelectTableViewController.h
//  TongLian
//
//  Created by mac on 14-6-20.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "tooles.h"
#import "ASIHttpHeaders.h"
#import "TLRefuseType.h"

@interface TLSelectTableViewController : UITableViewController

@property (nonatomic,strong)NSString *type;
@property int num;
@property (nonatomic,strong) NSArray *personList;
@property (nonatomic,strong) NSArray *IdList;
@property (nonatomic,strong) NSString *selectt;

@end
