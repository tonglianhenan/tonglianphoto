//
//  TLDcell.h
//  TongLian
//
//  Created by mac on 13-10-29.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLDcell : UITableViewCell
@property (nonatomic,strong)NSMutableArray *detail;
@property (nonatomic,strong)IBOutlet UILabel *buzhou;
@property (nonatomic,strong)IBOutlet UILabel *operater;
@property (nonatomic,strong)IBOutlet UILabel *task;
@property (nonatomic,strong)IBOutlet UILabel *start;
@property (nonatomic,strong)IBOutlet UILabel *end;
@property (nonatomic,strong)IBOutlet UILabel *remark;

@end
