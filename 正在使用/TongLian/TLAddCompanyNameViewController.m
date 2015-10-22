//
//  TLAddCompanyNameViewController.m
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-29.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLAddCompanyNameViewController.h"

@interface TLAddCompanyNameViewController ()

@end

@implementation TLAddCompanyNameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"新商户拓展"];
	// Do any additional setup after loading the view.
}
-(IBAction)button_click:(id)sender{
    if(self.name.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"工商注册名不能为空！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        UIStoryboard *my = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TLServiceController *ser = [my instantiateViewControllerWithIdentifier:@"service"];
        [ser setName:self.name.text];
        [self.navigationController pushViewController:ser animated:YES];
    }
}
-(IBAction)textFieldDone:(id)sender{
    [sender resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
