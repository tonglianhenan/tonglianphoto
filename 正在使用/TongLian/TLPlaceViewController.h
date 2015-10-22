//
//  TLPlaceViewController.h
//  TongLian
//
//  Created by mac on 13-9-22.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "TLBranch.h"
#import "TLChangsuoViewController.h"

@interface TLPlaceViewController : UIViewController

@property (nonatomic,strong) NSString *branchName;

-(IBAction)click:(id)sender event:(id)event;
@end
