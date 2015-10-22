//
//  TLAddChange.h
//  TongLian
//
//  Created by mac on 14-11-25.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "tooles.h"
#import "TLBusinessInfoDetail.h"
#import "ASIHttpHeaders.h"

@interface TLAddChange : UIViewController
@property (nonatomic,strong)IBOutlet UITextField *name;
-(IBAction)button_click:(id)sender;
-(IBAction)textFieldDone:(id)sender;

@end
