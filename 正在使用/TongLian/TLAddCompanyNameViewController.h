//
//  TLAddCompanyNameViewController.h
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-29.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLServiceController.h"

@interface TLAddCompanyNameViewController : UIViewController
@property (nonatomic,strong)IBOutlet UITextField *name;
-(IBAction)button_click:(id)sender;
-(IBAction)textFieldDone:(id)sender;
@end
