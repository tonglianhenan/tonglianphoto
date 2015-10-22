//
//  TLChangeCell.h
//  TongLian
//
//  Created by mac on 14-11-21.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLChangeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *submit;
@property (strong, nonatomic) IBOutlet UIButton *del;
@property (strong, nonatomic) IBOutlet UIButton *task;
@property (strong, nonatomic) IBOutlet UIButton *detail;
@property (strong, nonatomic) IBOutlet UIButton *changName;

@property (strong, nonatomic) IBOutlet UILabel *businessID;
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *companyStatus;
@property (strong, nonatomic) IBOutlet UILabel *createTime;
@property (strong, nonatomic) IBOutlet UILabel *orderNum;
@property (strong, nonatomic) IBOutlet UILabel *machineId;

@end
