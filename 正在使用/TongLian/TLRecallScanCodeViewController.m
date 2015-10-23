//
//  TLRecallScanCodeViewController.m
//  TongLian
//
//  Created by apple on 15/10/12.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import "TLRecallScanCodeViewController.h"
#import "TLRecallScanViewController.h"
#import "TLRecallInfoViewController.h"
#import "TLRecallMerchantInfoViewController.h"
#import "TLRecallEntity.h"

@interface TLRecallScanCodeViewController ()

@end

@implementation TLRecallScanCodeViewController
@synthesize employeeNo;
@synthesize snCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    if(myDelegate.employeeNo != nil){
        self.employeeNo.text = myDelegate.employeeNo;
    }
    myDelegate.employeeNo = nil;
}


- (void)passValue:(TLRecallEntity *)value
{
    self.snCode.text = value.sncode;
}


- (IBAction)scan:(id)sender
{
  
    [self scanCode];
    
}

- (void)scanCode
{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if(version >= 7.0f){
        TLRecallScanViewController *scan = [[TLRecallScanViewController alloc] init];
        scan.delegate = self;
        [self presentViewController:scan animated:YES completion:^{}];
    }else{
        [tooles MsgBox:@"请使用ios7.0以上的系统扫描"];
    }
    
}

- (IBAction)sentSN:(id)sender {
    
    if(self.employeeNo.text.length == 0){
        [tooles MsgBox:@"请输入工号"];
        return;
    }else if(self.snCode.text.length == 0){
        [tooles MsgBox:@"请扫瞄或输入SN码"];
    }else{
    [employeeNo resignFirstResponder];
    [snCode resignFirstResponder];
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    myDelegate.snCode = [self.snCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    myDelegate.employeeNo = self.employeeNo.text;
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",myDelegate.recallURL,@"businessVisitInfo"];
    NSURL *myurl = [NSURL URLWithString:urlStr];
    [tooles showHUD:@"请稍等"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    [request setPostValue:self.snCode.text forKey:@"machine"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
    }
}

- (void)GetResult:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *backJson = [all objectForKey:@"backJson"];
    NSString *code = [backJson objectForKey:@"code"];
    NSString *sn = [self.snCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([code isEqualToString:@"1000"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TLRecallInfoViewController *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"recallInfo"];
        [viewcontroller setBusinessNameValue:[backJson objectForKey:@"businessName"]];
        [viewcontroller setBankNameValue:[backJson objectForKey:@"bankName"]];
        [viewcontroller setContackPersonValue:[backJson objectForKey:@"contactPerson"]];
        [viewcontroller setContackPhoneValue:[backJson objectForKey:@"contactPhone"]];
        [viewcontroller setPosAddressValue:[backJson objectForKey:@"address"]];
        [viewcontroller setSnCodeValue:sn];
        [viewcontroller setEmployeeNoValue:self.employeeNo.text];
        TLRecallEntity *recallv = [TLRecallEntity getFromFileByName:sn];
        if(recallv == nil){
            recallv = [[TLRecallEntity alloc] initWithName:sn];
        }
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
        myDelegate.recall = recallv;
        [self.navigationController pushViewController:viewcontroller animated:YES];
    }
    if ([code isEqualToString:@"1001"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TLRecallMerchantInfoViewController *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"recallMerchantInfo"];
        [viewcontroller setEndpointCountValue:[[NSString alloc] initWithFormat:@"%@",[backJson objectForKey:@"endpointCount"]]];
        [viewcontroller setSnCodeValue:sn];
        [viewcontroller setEmployeeNoValue:self.employeeNo.text];
        [self.navigationController pushViewController:viewcontroller animated:YES];
    }
    
}

- (void)GetErr:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
}

- (IBAction)textFieldDone:(id)sender{
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
