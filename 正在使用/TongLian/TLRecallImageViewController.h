//
//  TLRecallImageViewController.h
//  TongLian
//
//  Created by apple on 15/10/18.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLBranch.h"
#import "ASIHttpHeaders.h"
#import "TLImage.h"
#import "tooles.h"

@interface TLRecallImageViewController : UIViewController

@property (nonatomic,retain)IBOutlet UIImageView *imageView;
@property NSInteger index;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *photoType;
@end

