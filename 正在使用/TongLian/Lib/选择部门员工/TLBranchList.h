//
//  TLBranchList.h
//  商机转介
//
//  Created by mac on 14-10-28.
//  Copyright (c) 2014年 allinpay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "ASIHttpHeaders.h"
#import "tooles.h"

@interface TLBranchList : UITableViewController
@property NSString *bank;
@property NSString *bankName;
@property NSString *branch;
@property NSString *branchName;
@property NSArray *branchList;
@property NSString *userLoginId;

@end
