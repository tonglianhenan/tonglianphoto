//
//  TLCell.h
//  TongLian
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLCell : UITableViewCell

//照片
@property (strong, nonatomic) IBOutlet UIButton *submit;
//分店
@property (strong, nonatomic) IBOutlet UIButton *branch;
//商机转让
@property (strong, nonatomic) IBOutlet UIButton *transfer;
@property (strong, nonatomic) IBOutlet UIButton *task;
@property (strong, nonatomic) IBOutlet UIButton *detail;

@property (strong, nonatomic) IBOutlet UILabel *businessID;
@property (strong, nonatomic) IBOutlet UILabel *companyName;
@property (strong, nonatomic) IBOutlet UILabel *companyStatus;
@property (strong, nonatomic) IBOutlet UILabel *createTime;


@end
