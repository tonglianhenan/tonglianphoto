//
//  TLBankList.h
//  商机转介
//
//  Created by mac on 14-10-27.
//  Copyright (c) 2014年 allinpay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "ASIHttpHeaders.h"
#import "tooles.h"
#import "TLBranchList.h"

@interface TLBankList : UITableViewController
@property NSArray *bankList;
@property NSString *bank;
@property NSString *bankName;


@end
