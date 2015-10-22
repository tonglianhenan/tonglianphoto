//
//  TLLoginViewController.h
//  TongLian
//
//  Created by mac on 13-9-10.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tooles.h"
#import "ASIHttpHeaders.h"
#import "TLCompany.h"
#import "TLRegister.h"
#import "NIDropDown.h"

@interface TLLoginViewController : UIViewController<NIDropDownDelegate>
{
    IBOutlet UIButton *btnSelect;
    NIDropDown *dropDown;
}

@property (retain, nonatomic) IBOutlet UIButton *btnSelect;
- (IBAction)selectClicked:(id)sender;

@property (nonatomic,retain)IBOutlet UITextField *userName;
@property (nonatomic,retain)IBOutlet UITextField *password;
@property (nonatomic,retain)NSArray *ServernameList;
@property (nonatomic,retain)NSDictionary *ServerDic;

-(IBAction)login:(id)sender;
-(IBAction)textFieldDone:(id)sender;
-(void)GetResult:(ASIHTTPRequest *)request;
-(void)GetErr:(ASIHTTPRequest *)request;

@end
