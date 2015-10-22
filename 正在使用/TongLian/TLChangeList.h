//
//  TLChangeList.h
//  TongLian
//
//  Created by mac on 14-11-21.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TLCell.h"
#import "TLBranchViewController.h"
#import "ASIHttpHeaders.h"
#import "tooles.h"
#import "TLDetailViewController.h"
#import "TLAddCompanyNameViewController.h"
#import "TLAddChange.h"
#import "TLChangeCell.h"
@class TLCompaniesController;

@interface TLChangeList : UITableViewController
@property (strong, nonatomic) NSMutableArray *companies;
@property (strong, nonatomic) NSMutableArray *select;
@property (nonatomic) NSInteger flag;
@property (nonatomic) NSIndexPath *index;


-(void)btn_click:(id)sender event:(id)event;

@property (nonatomic, retain)IBOutlet UISearchBar *mSearchBar;
@property (nonatomic, retain)IBOutlet UISearchDisplayController *searchController;
@property (nonatomic, retain)IBOutlet NSString *registerName;


@end

