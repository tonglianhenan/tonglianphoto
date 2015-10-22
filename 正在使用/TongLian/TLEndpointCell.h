//
//  TLEndpointCell.h
//  TongLian
//
//  Created by mac on 14-12-24.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLEndpointCell : UITableViewCell

@property (nonatomic,strong)IBOutlet UILabel *endpointid;
@property (nonatomic,strong)IBOutlet UILabel *endpointtype;
@property (nonatomic,strong)IBOutlet UILabel *markendpointnum;
@property (nonatomic,strong)IBOutlet UILabel *netendpointnum;
@property (nonatomic,strong)IBOutlet UILabel *newendpointnum;
@property (nonatomic,strong)IBOutlet UILabel *postTelegrame;
@property (nonatomic,strong)IBOutlet UILabel *endpointstatetype;

@property (nonatomic,strong)IBOutlet UIButton *deal;
@property (nonatomic,strong)IBOutlet UIButton *putOff;

@end
