//
//  TLShouyinbaoList.h
//  TongLian
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLCell.h"
#import "TLBranchViewController.h"
#import "ASIHttpHeaders.h"
#import "tooles.h"
#import "TLDetailViewController.h"
#import "TLAddCompanyNameViewController.h"
#import "TLBankList.h"
#import "TLSYBCell.h"

@interface TLShouyinbaoList : UITableViewController
@property (strong, nonatomic) NSMutableArray *companies;
@property (strong, nonatomic) NSMutableArray *select;
@property (nonatomic) NSInteger flag;
@property (nonatomic) NSIndexPath *index;
@property (nonatomic,strong) NSString *processId;

@property (nonatomic,strong) NSMutableDictionary *comment;
@property (nonatomic,strong) NSMutableDictionary *single;

@property (nonatomic,strong) NSString *singleFlag;


-(void)btn_click:(id)sender event:(id)event;
-(void)branch_click:(id)sender event:(id)event;

@property (nonatomic, retain)IBOutlet UISearchBar *mSearchBar;
@property (nonatomic, retain)IBOutlet UISearchDisplayController *searchController;


@end
