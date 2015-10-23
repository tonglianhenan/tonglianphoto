//
//  TLRecallImageViewController.m
//  TongLian
//
//  Created by apple on 15/10/18.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import "TLRecallImageViewController.h"

@interface TLRecallImageViewController ()

@end

@implementation TLRecallImageViewController


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
   
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@/%@.png",myDelegate.company.assetsDirectory,myDelegate.snCode,self.photoType,self.name];
    NSLog(@"second mpath:%@",path);
    [self.imageView setImage:[UIImage imageWithContentsOfFile:path]];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(tijiao)];
    self.navigationItem.rightBarButtonItem = right;
    
    // Do any additional setup after loading the view.
}

-(void)tijiao{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.recallURL,@"uploadAttachment"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    [tooles showHUD:@"正在上传！请稍候！"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    NSString *type = nil;
    if ([self.photoType isEqualToString:@"SITE"]) {
        type = @"DOOR";
    }else{
        type = self.photoType;
    }
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@/%@.png",myDelegate.company.assetsDirectory,myDelegate.snCode,self.photoType,self.name];
    NSLog(@"path==%@",path);
    
    [request setFile:path forKey:@"imageFile"];
    [request setPostValue:myDelegate.snCode forKey:@"machine"];
    [request setPostValue:type forKey:@"attachmentType"];
    [request setPostValue:self.name forKey:@"attachmentName"];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request setTimeOutSeconds:20];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];}

-(void)GetResult:(ASIHTTPRequest *)request{
    //接受字符串集
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *backJson = [all objectForKey:@"backJson"];
    NSString *code = [backJson objectForKey:@"code"];
    if ([code isEqualToString:@"1000"]){
        [tooles MsgBox:@"上传成功！"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [tooles MsgBox:@"上传失败！请重新上传！"];
    }
}

- (void) GetErr:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
