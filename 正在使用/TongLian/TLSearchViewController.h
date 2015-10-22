//
//  TLSearchViewController.h
//  TongLian
//
//  Created by mac on 14-6-17.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "tooles.h"
#import "ASIHttpHeaders.h"
#import "TLFeedbackTableViewController.h"

@interface TLSearchViewController : UIViewController
@property (retain,nonatomic) IBOutlet UITextField *workOrder;

-(IBAction)search:(id)sender;

@end
