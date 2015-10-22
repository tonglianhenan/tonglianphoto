//
//  TLEndpointList.h
//  TongLian
//
//  Created by mac on 14-12-24.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tooles.h"
#import "ASIHttpHeaders.h"
#import "TLAppDelegate.h"
#import "TLEndpointCell.h"

@interface TLEndpointList : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *mytableview;
}
@property (nonatomic,retain)IBOutlet UITableView *mytableview;
@property (nonatomic,retain)NSMutableArray *recommanderList;
@property (nonatomic,strong)NSString *state;
@property (nonatomic,strong)NSString *selectID;
@property (nonatomic,strong)NSString *branchId;
@property NSInteger currentPage;
@property NSInteger totalRecords;

@end

