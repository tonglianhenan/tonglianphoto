//
//  TLReaderViewController.h
//  TongLian
//
//  Created by mac on 14-3-17.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAppDelegate.h"
#import "ASIHttpHeaders.h"
#import "tooles.h"
//#import "ZBarReaderController.h"

@interface TLReaderViewController : UIViewController
{
    UIImageView *resultImage;
    UILabel *resultText;
    UIButton *myButton;
}
@property (nonatomic, retain) IBOutlet UIImageView *resultImage;
@property (nonatomic, retain) IBOutlet UILabel *resultText;
@property (nonatomic, retain) IBOutlet UIButton *myButton;
- (IBAction) scanButtonTapped;
- (IBAction) button_click:(id)sender;
@end
