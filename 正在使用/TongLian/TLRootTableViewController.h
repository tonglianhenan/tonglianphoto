//
//  TLViewController.h
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-14.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLCell.h"
#import "TLBranchViewController.h"
#import "ASIHttpHeaders.h"
#import "tooles.h"
#import "TLDetailViewController.h"
#import "TLAddCompanyNameViewController.h"
#import "TLBankList.h"
@class TLCompaniesController;

@interface TLRootTableViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *companies;
@property (strong, nonatomic) NSMutableArray *select;
@property (nonatomic) NSInteger flag;
@property (nonatomic) NSIndexPath *index;


-(void)btn_click:(id)sender event:(id)event;
-(void)branch_click:(id)sender event:(id)event;

@property (nonatomic, retain)IBOutlet UISearchBar *mSearchBar;
@property (nonatomic, retain)IBOutlet UISearchDisplayController *searchController;


@end
