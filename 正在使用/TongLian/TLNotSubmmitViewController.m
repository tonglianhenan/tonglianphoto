//
//  TLNotSubmmitViewController.m
//  TongLian
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLNotSubmmitViewController.h"

//#define UPLOADURL @"http://61.163.100.203:9999/control/mobile/IOSimageUpload";
//#define UPLOADURL @"http://10.88.1.51:8080/control/mobile/IOSimageUpload";
//#define UPLOADURL @"http://10.88.80.10:9000/control/mobile/IOSimageUpload";

@interface TLNotSubmmitViewController ()

@end

@implementation TLNotSubmmitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentSize:CGSizeMake(320, 2000)];
//    UIBarButtonItem *add = [[UIBarButtonItem alloc]
//                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
//                            target:self
//                            action:@selector(add)];
//    self.navigationItem.rightBarButtonItem=add;
    
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //NSString *sss = @"0";
    self.myTag = 100;
    self.i=1;
    self.x1 = 12;
    self.x2 =20;
    self.y1 = 12;
    self.y2 = 100;
    self.width1 = 90;
    self.width2 = 60;
    self.height1 = 81;
    self.height2 = 30;
    
    NSMutableDictionary *notSubmmit = myDelegate.company.notSubmmit;
    for(NSString *name in [notSubmmit allKeys]){
//        NSMutableDictionary *dic = [notSubmmit objectForKey:name];
//        NSArray *array = [dic allKeys];
//        NSString *path = [array objectAtIndex:0];
//        NSString *mpath = [NSString stringWithFormat:@"%@/%@.png",path,name];
        
        NSMutableDictionary *dic = [notSubmmit objectForKey:name];
        NSArray *array = [dic allKeys];
        NSString *path = [array objectAtIndex:0];
        myDelegate.company.photoType = [dic objectForKey:path];
        
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        TLCompany *myCom = myDelegate.company;
        
        NSString *mpath = [NSString stringWithFormat:@"%@/%@/%@/%@.png",myCom.assetsDirectory,myCom.name,myCom.photoType,name];
        NSLog(@"first mpath:%@",mpath);

        //转换成缩略图，减少内存压力
        UIButton *button= [[UIButton alloc]init];
        button.frame = CGRectMake(self.x1, self.y1, self.width1, self.height1);
        UIImage *myImg = [UIImage imageWithContentsOfFile:mpath];
        UIImage *nn;
        CGSize asize = CGSizeMake(self.width1, self.height1);
        UIGraphicsBeginImageContext(asize);
        [myImg drawInRect:CGRectMake(0, 0, self.width1, self.height1)];
        nn=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [button setBackgroundImage:nn forState:UIControlStateNormal];
        self.myTag = self.myTag + 1;
        [button setTag:self.myTag];
        //点击事件
        button.titleLabel.text = name;
        [button addTarget:self action:@selector(btn_click:event:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(self.x2, self.y2, self.width2, self.height2);
        label.text = name;
        UIFont *font = [UIFont fontWithName:@"Arial" size:10];
        [label setFont:font];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        [label setNumberOfLines:0];
        label.textAlignment = NSTextAlignmentCenter;
        self.myTag = self.myTag + 1;
        [label setTag:self.myTag];
        
        if(self.i%3==1||self.i%3==2){
            self.x1 = self.x1+103;
            self.x2 = self.x2+108;
        }
        if(self.i%3==0){
            self.y1 = self.y1+118;
            self.x1 = self.x1-206;
            
            self.y2 = self.y2+118;
            self.x2 = self.x2-216;
        }
        self.i = self.i+1;
        [self.scrollView addSubview:button];
        [self.scrollView addSubview:label];

    }
    CGFloat y;
    if(self.i%3==1){
       y = self.y1;
    }
    else{
        y = self.y1 + 118;
    }
    if(self.i>1){
        UIButton *button= [[UIButton alloc]init];
        button.frame = CGRectMake(130, y+10, 70, 40);
        [button setBackgroundImage:[UIImage imageNamed:@"提交.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(button_click:event:) forControlEvents:UIControlEventTouchUpInside];
        self.myTag = self.myTag + 1;
        [button setTag:self.myTag];
        [self.scrollView addSubview:button];
    }
    else{
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, 10, 250, 30);
        label.text = @"所有照片已上传或者尚未拍照！";
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        [label setFont:font];
        label.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:label];

    }
	// Do any additional setup after loading the view.
}
//查看详情
-(void) btn_click:(id)sender event:(id)event{
    UIButton *button = (UIButton *)sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLImageViewController *imageView =[storyboard instantiateViewControllerWithIdentifier:@"imageSelect"];
    [imageView setName:button.titleLabel.text];
    
     TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *notSubmmit = myDelegate.company.notSubmmit;
    NSMutableDictionary *dic = [notSubmmit objectForKey:button.titleLabel.text];
    NSArray *array = [dic allKeys];
    NSString *path = [array objectAtIndex:0];
    myDelegate.company.photoType = [dic objectForKey:path];
    
    UIButton *myButton = (UIButton *)[self.scrollView viewWithTag:self.myTag];
    [myButton removeFromSuperview];
    for(int j=self.myTag-1;j>100;j=j-2)
    {
        UILabel *myLabel = (UILabel *)[self.scrollView viewWithTag:j];
        [myLabel removeFromSuperview];
        UIButton *myButton = (UIButton *)[self.scrollView viewWithTag:j-1];
        [myButton removeFromSuperview];
    }

    
    [self.navigationController pushViewController:imageView animated:YES];
    
}
//批量提交
-(void) button_click:(id)sender event:(id)event{
    self.flag = 0;
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];

    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"IOSimageUpload"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    NSMutableDictionary *dic;
    NSArray *array;
    NSString *path;
    NSString *category;
    NSInteger mytag = 99;
    [tooles showHUD:@"正在上传！请稍候！"];
    TLCompany *mycom = myDelegate.company;
    NSMutableDictionary *exist = myDelegate.company.notSubmmit;
    self.sflag = (int)[exist count];
    self.count = (int)[exist count];
    for (NSString * name in[exist allKeys]) {
        NSRange range = [name rangeOfString:@"通联宝"];
        if(range.length>0){
            int num = [myDelegate.company.tonglianbaoNum intValue];
            num++;
            myDelegate.company.tonglianbaoNum = [NSNumber numberWithInt:num];
        }
        dic = [exist objectForKey:name];
        array = [dic allKeys];
        path = [array objectAtIndex:0];
        category = [dic objectForKey:path];
        NSString *mpath = [NSString stringWithFormat:@"%@/%@.png",path,name];
        mytag = mytag + 2;
        NSString *pname = [NSString stringWithFormat:@"%@［%@］",name,myDelegate.company.processId];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
        [request setFile:mpath forKey:@"imageFile"];
        [request setPostValue:mycom.businessId forKey:@"businessId"];
        [request setPostValue:category forKey:@"category"];
        [request setPostValue:pname forKey:@"name"];
        [request setPostValue:myDelegate.company.processId forKey:@"processId"];
        [request setPostValue:[NSString stringWithFormat:@"%ld",(long)mytag] forKey:@"tag"];
                
        [request setDelegate:self];
        [request setDidFailSelector:@selector(GetErr:)];
        [request setDidFinishSelector:@selector(GetResult:)];
        [request setTimeOutSeconds:20];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
        //request = nil;
    }
    [myDelegate.company saveToFile];
}
-(void) GetErr:(ASIHTTPRequest *)request{
    if(self.flag == 0)
    {
        [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
        [tooles removeHUD];
        self.flag = 1;
        return;
    }
}

-(void)GetResult:(ASIFormDataRequest *)request{
    //接受字符串集
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSDictionary *loginJson = [all objectForKey:@"loginJson"];
    NSString *tag = [loginJson objectForKey:@"tag"];
    NSInteger  t = [tag integerValue];
    if([loginJson isKindOfClass:[NSNull class]]){
        return;
    }
    UILabel *myLabel = (UILabel *)[self.scrollView viewWithTag:t+1];
    [myLabel removeFromSuperview];
    UIButton *myButton = (UIButton *)[self.scrollView viewWithTag:t];
    NSString *name = myButton.titleLabel.text;
    [myButton removeFromSuperview];
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //从未上传图片列表中删除
    [myDelegate.company.notSubmmit removeObjectForKey:name];
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
    
    self.sflag = self.sflag - 1;
    if(self.flag == 0 && self.sflag == 0)
    {
        UIButton *myButton = (UIButton *)[self.scrollView viewWithTag:101+2*self.count];
        [myButton removeFromSuperview];
        [tooles removeHUD];
        [tooles MsgBox:@"上传成功！"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
