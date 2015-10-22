//
//  TLImageViewController.m
//  TongLian
//
//  Created by mac on 13-9-9.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLImageViewController.h"
#import "TLAppDelegate.h"
//#define UPLOADURL @"http://61.163.100.203:9999/control/mobile/imageUpload";
//#define UPLOADURL @"http://10.88.1.51:8080/control/mobile/imageUpload";
//#define UPLOADURL @"http://10.88.80.10:9000/control/mobile/imageUpload";
@interface TLImageViewController ()

@end

@implementation TLImageViewController
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
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    TLCompany *myCom = myDelegate.company;
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@/%@.png",myCom.assetsDirectory,myCom.name,myCom.photoType,self.name];
    NSLog(@"second mpath:%@",path);
    [self.imageView setImage:[UIImage imageWithContentsOfFile:path]];

    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(tijiao)];
    self.navigationItem.rightBarButtonItem = right;
    
    // Do any additional setup after loading the view.
}

-(void)tijiao{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    TLCompany *myCom = myDelegate.company;
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"imageUpload"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    [tooles showHUD:@"正在上传！请稍候！"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@/%@.png",myCom.assetsDirectory,myCom.name,myCom.photoType,self.name];
    NSLog(@"path==%@",path);
    NSString *pname = [NSString stringWithFormat:@"%@［%@］",self.name,myDelegate.company.processId];
    
    [request setFile:path forKey:@"imageFile"];
    [request setPostValue:myCom.businessId forKey:@"businessId"];
    [request setPostValue:myCom.photoType forKey:@"category"];
    [request setPostValue:pname forKey:@"name"];
    [request setPostValue:myDelegate.company.processId forKey:@"processId"];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request setTimeOutSeconds:20];
    [request setNumberOfTimesToRetryOnTimeout:2];
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
    NSDictionary *loginJson = [all objectForKey:@"loginJson"];
    NSLog(@"login==%@",loginJson);
    NSString *result = [loginJson objectForKey:@"result"];
    if([result isEqualToString:@"success"])
    {
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
        //从未上传图片列表中删除
        [myDelegate.company.notSubmmit removeObjectForKey:self.name];
        if([myDelegate.company.photoType isEqualToString:@"TONGLIANBAO"]){
            int num = [myDelegate.company.tonglianbaoNum intValue];
            num++;
            myDelegate.company.tonglianbaoNum = [NSNumber numberWithInt:num];
        }
        //保存至本地
        [myDelegate.company saveToFile];
        //保存至全局商户列表
        int a=0;
        for(TLCompany *company in myDelegate.companyList)
        {
            if([company.name isEqualToString:myDelegate.company.name]){
                break;
            }
            a = a+1;
        }
        [myDelegate.companyList replaceObjectAtIndex:a withObject:myDelegate.company];

        [tooles MsgBox:@"上传成功！"];
        [self.navigationController popViewControllerAnimated:YES];

    }
    else{
        [tooles MsgBox:@"上传失败！请重新上传！"];
    }
    //NSLog(@"%@",loginJson);
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
