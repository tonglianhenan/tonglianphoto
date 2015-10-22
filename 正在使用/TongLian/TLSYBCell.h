//
//  TLSYBCell.h
//  TongLian
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLSYBCell : UITableViewCell

//照片
@property (strong, nonatomic) IBOutlet UIButton *submit;
//分店
@property (strong, nonatomic) IBOutlet UIButton *branch;
//商机转让
@property (strong, nonatomic) IBOutlet UIButton *transfer;
//选择
@property (strong, nonatomic) IBOutlet UIButton *task;
//查看详情
@property (strong, nonatomic) IBOutlet UIButton *detail;

@property (strong, nonatomic) IBOutlet UILabel *batchNum;
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *companyStatus;
@property (strong, nonatomic) IBOutlet UILabel *createTime;

@end
