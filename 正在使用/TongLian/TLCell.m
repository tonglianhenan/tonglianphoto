//
//  TLCell.m
//  TongLian
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLCell.h"

@implementation TLCell
@synthesize businessID,companyName,createTime,companyStatus;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
