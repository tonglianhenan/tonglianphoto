//
//  TLShowImageViewController.m
//  TongLian
//
//  Created by mac on 14-6-19.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLShowImageViewController.h"

@interface TLShowImageViewController ()

@end

@implementation TLShowImageViewController

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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@.png",documentDirectory,self.businessName,self.ImageName];
    [self.imageView setImage:[UIImage imageWithContentsOfFile:path]];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(tijiao)];
    self.navigationItem.rightBarButtonItem = right;

    // Do any additional setup after loading the view.
}

-(void)tijiao{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    TLCompany *myCom = myDelegate.company;
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"IOSimageUpload"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    [tooles showHUD:@"正在上传！请稍候！"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@.png",myCom.assetsDirectory,self.businessName,self.ImageName];
    NSString *namee = [NSString stringWithFormat:@"%@[%@]",self.ImageName,myDelegate.processId];
    
    [request setPostValue:self.ImageName forKey:@"tag"];
    [request setFile:path forKey:@"imageFile"];
    [request setPostValue:@"FIXASSURE" forKey:@"category"];
    [request setPostValue:self.businessId forKey:@"businessId"];
    [request setPostValue:namee forKey:@"name"];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request setTimeOutSeconds:20];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];

}
-(IBAction)submmit:(id)sender
{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    TLCompany *myCom = myDelegate.company;
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"IOSimageUpload"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    [tooles showHUD:@"正在上传！请稍候！"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@.png",myCom.assetsDirectory,self.businessName,self.ImageName];
    NSString *namee = [NSString stringWithFormat:@"%@[%@]",self.ImageName,myDelegate.processId];
    
    [request setPostValue:self.ImageName forKey:@"tag"];
    [request setFile:path forKey:@"imageFile"];
    [request setPostValue:@"FIXASSURE" forKey:@"category"];
    [request setPostValue:self.businessId forKey:@"businessId"];
    [request setPostValue:namee forKey:@"name"];
    
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
        //同步到系统
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        [dictionary setObject:@"0" forKey:self.ImageName];
        
        int num = [self getNum:myDelegate.FBPList :self.ImageName];
        [myDelegate.FBPList removeObjectAtIndex:num];

        
        [tooles MsgBox:@"上传成功！"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else{
        [tooles MsgBox:@"上传失败！请重新上传！"];
    }
    //NSLog(@"%@",loginJson);
    
}
-(int)getNum:(NSArray *)array :(NSString *)key{
    int i = 0;
    for(NSDictionary *dic in array){
        NSArray *a = [dic allKeys];
        NSString *name = [a objectAtIndex:0];
        if([name isEqualToString:key]){
            return i;
        }
        i++;
    }
    return i;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
