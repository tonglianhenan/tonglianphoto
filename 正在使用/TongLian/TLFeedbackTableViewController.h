//
//  TLFeedbackTableViewController.h
//  TongLian
//
//  Created by mac on 14-6-19.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "TLFBCell.h"
#import "tooles.h"
#import "TLFBPhotoViewController.h"
#import "TLSelectTableViewController.h"
#import "TLEndpointList.h"
#import "TLCategory.h"

@interface TLFeedbackTableViewController : UITableViewController

@property (nonatomic,retain)NSString *businessId;
@property (nonatomic,retain)NSString *businessName;
@property (nonatomic,retain)NSString *processId;
@property (nonatomic,retain)NSString *branchId;
@property (nonatomic,retain)NSString *processType;
@property (nonatomic,retain)NSString *branchName;
@property (nonatomic,retain)NSString *address;

-(IBAction)submit:(id)sender;
-(IBAction)weaning:(id)sender;


@end
