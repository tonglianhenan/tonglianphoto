//
//  TLMySendTaskList.h
//  TongLian
//
//  Created by mac on 13-10-31.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTcell.h"
#import "ASIHttpHeaders.h"
#import "tooles.h"
#import "TLDetailViewController.h"
#import "TLAppDelegate.h"

@interface TLMySendTaskList : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong)NSArray *allTasks;
@property (nonatomic,strong)NSMutableArray *selectTasks;
@property (nonatomic, retain)IBOutlet UITableView *mTableView;
@property (nonatomic, retain)IBOutlet UISearchBar *mSearchBar;
@property (nonatomic, retain)IBOutlet UISearchDisplayController *searchController;

@end
