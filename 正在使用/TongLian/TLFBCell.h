//
//  TLFBCell.h
//  TongLian
//
//  Created by mac on 14-6-19.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLFBCell : UITableViewCell
@property (retain,nonatomic)IBOutlet NSString *businessId;
@property (retain,nonatomic)IBOutlet UILabel *businessName;
@property (retain,nonatomic)IBOutlet NSString *processId;
@property (retain,nonatomic)IBOutlet NSString *branchId;
@property (retain,nonatomic)IBOutlet NSString *processType;
@property (retain,nonatomic)IBOutlet UILabel *branchName;
@property (retain,nonatomic)IBOutlet UILabel *address;

@end
