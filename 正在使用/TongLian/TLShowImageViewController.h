//
//  TLShowImageViewController.h
//  TongLian
//
//  Created by mac on 14-6-19.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHttpHeaders.h"
#import "tooles.h"
#import "TLAppDelegate.h"

@interface TLShowImageViewController : UIViewController

@property (nonatomic,retain)IBOutlet UIImageView *imageView;
@property (nonatomic,retain)NSString *ImageName;
@property (nonatomic,retain)NSString *businessName;
@property (nonatomic,strong)NSString *businessId;

@end
