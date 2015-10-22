//
//  TLBusinessInfoDetail.m
//  TongLian
//
//  Created by mac on 14-11-25.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLBusinessInfoDetail.h"

@interface TLBusinessInfoDetail ()

@end

@implementation TLBusinessInfoDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.businessNameL setText:self.businessName];
    [self.businessInfoIdL setText:self.businessInfoId];
    if([self.orderNum boolValue]||![self.orderNum isKindOfClass:[NSNull class]]){
        [self.orderNumL setText:self.orderNum];
    }else {
        [self.orderNumL setText:@"未找到订单号"];
    }
    // Do any additional setup after loading the view.
}
-(IBAction)change_submit:(id)sender{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [tooles showHUD:@"正在提交！请稍候！"];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"startChange"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    [request setPostValue:self.businessInfoId forKey:@"businessinfofinalId"];
    [request setPostValue:myDelegate.loginName forKey:@"userLoginId"];
    [request setPostValue:myDelegate.tType forKey:@"processType"];

    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request setTimeOutSeconds:20];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];

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
    NSString *businessProcessId = [androidMap objectForKey:@"processId"];
    NSString *message = [androidMap objectForKey:@"message"];
    if(businessProcessId){
//        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
//        NSDate *now = [NSDate date];
//        TLCompany *com = [[TLCompany alloc]initWithName:self.businessName createdAt:now businessId:self.businessInfoId processId:businessProcessId processType:@"BUPRIMITIVE"];
//        [myDelegate.companyList insertObject:com atIndex:0];
//        [com saveToFile];
//
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-3] animated:YES];
        
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        [tooles showHUD:@"请稍候！"];
        NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"changeList"];
        NSURL *myurl = [NSURL URLWithString:urlstr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
        
        [request setPostValue:myDelegate.loginName forKey:@"userLoginId"];
        [request setPostValue:myDelegate.tType forKey:@"processType"];
        [request setPostValue:@"1" forKey:@"page"];
        
        [request setPostValue:@"DESC" forKey:@"order"];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(GetResultt:)];
        [request setDidFailSelector:@selector(GetErrt:)];
        [request startAsynchronous];
        
    }
    else{
        [tooles MsgBox:message];
    }
}
-(void)GetResultt:(ASIHTTPRequest *)request{
    //接受字符串集
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *androidAction = [all objectForKey:@"androidAction"];
    NSDictionary *androidMap = [androidAction objectAtIndex:0];
    NSArray *loginJson = [androidMap objectForKey:@"businessList"];
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    [myDelegate.companyList removeAllObjects];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"loginJSOn%@",loginJson);
    for(NSDictionary *company in loginJson){
        NSString *cname = [company objectForKey:@"businessName"];
        NSString *cprocessId = [company objectForKey:@"processId"];
        NSString *cbusinessId = [company objectForKey:@"businessId"];
        NSString *ccreatTime = [company objectForKey:@"creatTime"];
        NSDate *dateTime = [formatter dateFromString:ccreatTime];
        NSString *cprocessType = [company objectForKey:@"processType"];
        NSString *orderNum = [company objectForKey:@"orderNum"];
        NSString *machineId = [company objectForKey:@"machineId"];
        
        TLCompany *com = [TLCompany getFromFileByName:cname];
        if(com){
            com.processType = [company objectForKey:@"processType"];
            com.orderNum = orderNum;
            com.machineId = machineId;
            [com saveToFile];
            [myDelegate.companyList addObject:com];
        }
        else{
            com = [[TLCompany alloc]initWithName:cname createdAt:dateTime businessId:cbusinessId processId:cprocessId processType:cprocessType];
            com.orderNum = orderNum;
            com.machineId = machineId;
            [myDelegate.companyList addObject:com];
        }
    }
    
    [self performSegueWithIdentifier:@"goChangee" sender:self];
}

- (void) GetErrt:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    [tooles MsgBox:@"网络错误,连接不到服务器"];
}


- (void)didReceiveMemoryWarning {
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
