//
//  TLBusinessController.m
//  TongLian
//
//  Created by mac on 13-9-11.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLBusinessController.h"
//#define LIST @"http://61.163.100.203:9999/control/mobile/myBusinessList";
//#define LIST @"http://10.88.1.59:8080/control/mobile/myBusinessList";
//#define LIST @"http://10.88.80.10:9000/control/mobile/myBusinessList";

@interface TLBusinessController ()

@end

@implementation TLBusinessController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setTitle:@"系统首页"];
    //[self.navigationController setTitle:@"系统首页"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    if(![myDelegate.loginName isEqualToString:@"guokb"]){
        [self GetUpdate];
    }
}
//检查app是否为最新版本，750875946是app id
-(void)GetUpdate
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    NSString *nowVersion =[infoDict objectForKey:@"CFBundleShortVersionString"];
    
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=750875946"];
    NSString *file =  [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@",file);
    NSRange substr = [file rangeOfString:@"\"version\":\""];
    NSRange sub = NSMakeRange(substr.location+substr.length, 3);
    NSString *version = [file substringWithRange:sub];
    NSLog(@"nowversion==%@,getversion==%@",nowVersion,version);
    
    if([nowVersion isEqualToString:version]==NO)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:
                              @"版本有更新:" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
        [alert setTag:2];
        [alert show];
    }
    
}

-(IBAction)shouyinbao:(id)sender{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    myDelegate.tType = @"SYB";
    
    [tooles showHUD:@"请稍候！"];
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"myCashierBaoList"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    [request setPostValue:myDelegate.loginName forKey:@"userLoginId"];
    [request setPostValue:@"1" forKey:@"page"];
    
    [request setPostValue:@"DESC" forKey:@"order"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult_SYB:)];
    [request setDidFailSelector:@selector(GetErrt:)];
    [request startAsynchronous];

}
-(void)GetResult_SYB:(ASIHTTPRequest *)request{
    //接受字符串集
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *loginJson = [all objectForKey:@"loginJson"];
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    [myDelegate.companyList removeAllObjects];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"loginJSOn%@",loginJson);
    for(NSDictionary *company in loginJson){
        NSString *cname = [company objectForKey:@"businessName"];
        NSNumber *process = (NSNumber *)[company objectForKey:@"processId"];
        NSLog(@"process==%@",process);
        NSString *cprocessId = [NSString stringWithFormat:@"%@",process];
        NSString *cbusinessId = [company objectForKey:@"businessId"];
        NSString *ccreatTime = [company objectForKey:@"creatTime"];
        NSDate *dateTime = [formatter dateFromString:ccreatTime];
        NSString *cprocessType = [company objectForKey:@"processType"];
        NSString *directSubmitTag = [company objectForKey:@"directSubmitTag"];
        
        TLCompany *com = [TLCompany getFromFileByName:cname];
        if(com){
            com.processType = [company objectForKey:@"processType"];
            com.processId = cprocessId;
            com.directSubmitTag = directSubmitTag;
            [myDelegate.companyList addObject:com];
        }
        else{
            com = [[TLCompany alloc]initWithName:cname createdAt:dateTime businessId:cbusinessId processId:cprocessId processType:cprocessType];
            com.directSubmitTag = directSubmitTag;
            [myDelegate.companyList addObject:com];
        }
    }
    [self performSegueWithIdentifier:@"shouyinbao" sender:self];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        if(alertView.tag == 1){
            TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            for(TLCompany *com in myDelegate.companyList){
                //删除商户对象图
                [com removeFromFile];
                //删除图片
                [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/%@",com.assetsDirectory,com.name] error:nil];
            }
            [tooles MsgBox:@"删除成功！"];
        }else if(alertView.tag == 2){
            //不是最新版本，跳转app store更新,750875946是app id
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/tonglian/id750875946?ls=1&mt=8"];
            [[UIApplication sharedApplication]openURL:url];
        
        }
        
    }
    
}

-(IBAction)button_click:(id)sender{
    [self initCompanyList];
}
-(IBAction)changList:(id)sender{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    myDelegate.tType = @"T0";
    
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
            [myDelegate.companyList addObject:com];
        }
        else{
            com = [[TLCompany alloc]initWithName:cname createdAt:dateTime businessId:cbusinessId processId:cprocessId processType:cprocessType];
            com.orderNum = orderNum;
            com.machineId = machineId;
            [myDelegate.companyList addObject:com];
        }
    }
    [self performSegueWithIdentifier:@"goChange" sender:self];
}

- (void) GetErrt:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    [tooles MsgBox:@"网络错误,连接不到服务器"];
}

-(IBAction)userRecall:(id)sender{
    //[self performSegueWithIdentifier:@"recall" sender:self];
    //UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请选择快速录入！😰" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //[alertView show];
}
-(IBAction)foward:(id)sender{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    myDelegate.tType = @"ZNQK";
    
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
    [request startAsynchronous];}
-(void)initCompanyList{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    [tooles showHUD:@"请稍候！"];
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"myBusinessList"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    [request setPostValue:myDelegate.loginName forKey:@"username"];
    [request setPostValue:@"DESC" forKey:@"order"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];

}

-(void)GetResult:(ASIHTTPRequest *)request{
    //接受字符串集
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray *loginJson = [all objectForKey:@"loginJson"];
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    [myDelegate.companyList removeAllObjects];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy-MM-dd hh:mm:ss"]; 
    for(NSDictionary *company in loginJson){
        NSString *cname = [company objectForKey:@"businessName"];
        NSString *cprocessId = [company objectForKey:@"processId"];
        NSString *cbusinessId = [company objectForKey:@"businessId"];
        NSString *ccreatTime = [company objectForKey:@"creatTime"];
        NSDate *dateTime = [formatter dateFromString:ccreatTime];
        NSString *cprocessType = [company objectForKey:@"processType"];
        TLCompany *com = [TLCompany getFromFileByName:cname];
        if(com){
            com.processType = cprocessType;
            [myDelegate.companyList addObject:com];
        }
        else{
            com = [[TLCompany alloc]initWithName:cname createdAt:dateTime businessId:cbusinessId processId:cprocessId processType:cprocessType];
            [myDelegate.companyList addObject:com];
        }
    }
    [self performSegueWithIdentifier:@"log" sender:self];
}

- (void) GetErr:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    [tooles MsgBox:@"网络错误,连接不到服务器"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
