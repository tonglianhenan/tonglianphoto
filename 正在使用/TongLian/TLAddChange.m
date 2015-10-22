//
//  TLAddChange.m
//  TongLian
//
//  Created by mac on 14-11-25.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLAddChange.h"

@interface TLAddChange ()

@end

@implementation TLAddChange

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    [self.navigationItem setTitle:@"查询商户信息"];
    // Do any additional setup after loading the view.
}
-(IBAction)button_click:(id)sender{
    if(self.name.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"序列号不能为空！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        [tooles showHUD:@"正在提交！请稍候！"];
        
        NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"findByMachineId"];
        NSURL *myurl = [NSURL URLWithString:urlstr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
        
        [request setPostValue:self.name.text forKey:@"machineId"];
        [request setPostValue:myDelegate.tType forKey:@"processType"];
        
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(GetResult:)];
        [request setDidFailSelector:@selector(GetErr:)];
        [request setTimeOutSeconds:20];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
//        TLServiceController *ser = [my instantiateViewControllerWithIdentifier:@"service"];
//        [ser setName:self.name.text];
//        [self.navigationController pushViewController:ser animated:YES];
    }
}
-(void) GetErr:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
}
-(void)GetResult:(ASIFormDataRequest *)request{
    //接受字符串集
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSArray *androidAction = [all objectForKey:@"androidAction"];
    NSDictionary *androidMap = [androidAction objectAtIndex:0];
    NSString *businessName = [androidMap objectForKey:@"businessName"];
    NSString *businessInfoId = [androidMap objectForKey:@"businessinfofinalId"];
    NSString *orderNum = [androidMap objectForKey:@"orderNum"];
    
    
    UIStoryboard *my = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLBusinessInfoDetail *viewController = [my instantiateViewControllerWithIdentifier:@"businessInfoDetail"];
    [viewController setBusinessInfoId:businessInfoId];
    [viewController setBusinessName:businessName];
    [viewController setOrderNum:orderNum];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)textFieldDone:(id)sender{
    [sender resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
