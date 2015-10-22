//
//  TLBusinessInfoDetail.h
//  TongLian
//
//  Created by mac on 14-11-25.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "tooles.h"
#import "ASIHttpHeaders.h"
#import "TLChangeList.h"

@interface TLBusinessInfoDetail : UIViewController

@property (nonatomic,strong)NSString *businessName;
@property (nonatomic,strong)NSString *businessInfoId;
@property (nonatomic,strong)NSString *orderNum;

@property (nonatomic,strong)IBOutlet UILabel *businessNameL;
@property (nonatomic,strong)IBOutlet UILabel *businessInfoIdL;
@property (nonatomic,strong)IBOutlet UILabel *orderNumL;


-(IBAction)change_submit:(id)sender;

@end
