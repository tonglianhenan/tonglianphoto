//
//  TLRCell.m
//  TongLian
//
//  Created by mac on 14-3-20.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLRCell.h"

@implementation TLRCell

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
