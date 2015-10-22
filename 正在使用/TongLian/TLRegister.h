//
//  TLRegister.h
//  TongLian
//
//  Created by mac on 13-11-11.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tooles.h"
#import "ASIHttpHeaders.h"
#import "TLAppDelegate.h"
#import "TLLoginViewController.h"

@interface TLRegister : UIViewController
@property (strong,nonatomic)IBOutlet UITextField *name;
@property (strong,nonatomic)IBOutlet UITextField *psw;
@property (strong,nonatomic)IBOutlet UITextField *psw1;

-(IBAction)btn_click:(id)sender;
@end
