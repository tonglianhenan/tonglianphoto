//
//  TLImageViewController.h
//  TongLian
//
//  Created by mac on 13-9-9.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLBranch.h"
#import "ASIHttpHeaders.h"
#import "TLImage.h"
#import "tooles.h"

@interface TLImageViewController : UIViewController

@property (nonatomic,retain)IBOutlet UIImageView *imageView;
@property NSInteger index;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *name;
-(IBAction)submmit:(id)sender;
@end
