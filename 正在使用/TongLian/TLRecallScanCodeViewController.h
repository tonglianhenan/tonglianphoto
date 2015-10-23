//
//  TLRecallScanCodeViewController.h
//  TongLian
//
//  Created by apple on 15/10/12.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "tooles.h"
#import "ASIHttpHeaders.h"
#import "TLRecallPassValueDelegate.h"


@interface TLRecallScanCodeViewController : UIViewController<TLRecallPassValueDelegate>
{
    BOOL isGetsn;
}

@property (retain,nonatomic) IBOutlet UITextField *employeeNo;
@property (retain,nonatomic) IBOutlet UITextField *snCode;


- (IBAction)scan:(id)sender;
- (IBAction)sentSN:(id)sender;
- (IBAction)textFieldDone:(id)sender;


@end
