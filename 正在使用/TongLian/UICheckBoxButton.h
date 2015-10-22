//
//  UICheckBoxButton.h
//  TongLian
//
//  Created by mac on 13-10-9.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICheckBoxButton : UIControl{
    UILabel *label;
    UIImageView *icon;
    BOOL checked;
    id delegate;
}
@property (retain, nonatomic) id delegate;
@property (retain, nonatomic) UILabel *label;
@property (retain, nonatomic) UIImageView *icon;
-(BOOL)isChecked;
-(void)setChecked: (BOOL)flag;
@end
