//
//  TLServiceController.m
//  TongLian
//
//  Created by mac on 13-10-9.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLServiceController.h"

//#define MYURL @"http://61.163.100.203:9999/control/mobile/business";
//#define MYURL @"http://10.88.1.51:8080/control/mobile/business";
//#define MYURL @"http://10.88.80.10:9000/control/mobile/business";

@interface TLServiceController ()

@end

@implementation TLServiceController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.checkbox = [[NSMutableDictionary alloc]init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"选择服务类型"];
    UIBarButtonItem *submmit = [[UIBarButtonItem alloc]
                            initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submmit)];
    self.navigationItem.rightBarButtonItem=submmit;
    
    self.checkbox = [[NSMutableDictionary alloc]init];

    //新兴支付
    
    UICheckBoxButton *checkBoxButton1 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(20, 118, 160, 25)];
    checkBoxButton1.label.text = @"万商通联";
    [self.view addSubview:checkBoxButton1];
    [self.checkbox setObject:checkBoxButton1 forKey:@"ALLINPAY"];
    
    UICheckBoxButton *checkBoxButton2 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(200, 118, 160, 25)];
    checkBoxButton2.label.text = @"会积通";
    [self.view addSubview:checkBoxButton2];
    [self.checkbox setObject:checkBoxButton2 forKey:@"SCORECONNECT"];

    UICheckBoxButton *checkBoxButton3 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(20, 153, 160, 25)];
    checkBoxButton3.label.text = @"行业预付费卡";
    [self.view addSubview:checkBoxButton3];
    [self.checkbox setObject:checkBoxButton3 forKey:@"PREPAIDCARD"];
    
    UICheckBoxButton *checkBoxButton4 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(200, 153, 160, 25)];
    checkBoxButton4.label.text = @"互动营销";
    [self.view addSubview:checkBoxButton4];
    [self.checkbox setObject:checkBoxButton4 forKey:@"INTERACTIVEMARKETING"];
    
    //受理市场
    UICheckBoxButton *checkBoxButton5 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(20, 240, 160, 25)];
    checkBoxButton5.label.text = @"银行卡";
    [self.view addSubview:checkBoxButton5];
    [self.checkbox setObject:checkBoxButton5 forKey:@"BANKCARD"];
    
    UICheckBoxButton *checkBoxButton6 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(200, 240, 160, 25)];
    checkBoxButton6.label.text = @"电话支付";
    [self.view addSubview:checkBoxButton6];
    [self.checkbox setObject:checkBoxButton6 forKey:@"PHONEPAY"];
    
    UICheckBoxButton *checkBoxButton7 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(20, 275, 160, 25)];
    checkBoxButton7.label.text = @"订单支付";
    [self.view addSubview:checkBoxButton7];
    [self.checkbox setObject:checkBoxButton7 forKey:@"ORDERPAY"];
    
    UICheckBoxButton *checkBoxButton14 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(200, 275, 160, 25)];
    checkBoxButton14.label.text = @"助农取款";
    [self.view addSubview:checkBoxButton14];
    [self.checkbox setObject:checkBoxButton14 forKey:@"HELPDRAWMONEY"];


    //网络支付
    UICheckBoxButton *checkBoxButton8 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(20, 360, 160, 25)];
    checkBoxButton8.label.text = @"金融通";
    [self.view addSubview:checkBoxButton8];
    [self.checkbox setObject:checkBoxButton8 forKey:@"FINANCECONNECT"];
    
    UICheckBoxButton *checkBoxButton9 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(200, 360, 160, 25)];
    checkBoxButton9.label.text = @"便捷付";
    [self.view addSubview:checkBoxButton9];
    [self.checkbox setObject:checkBoxButton9 forKey:@"FASTERPAY"];
    
    UICheckBoxButton *checkBoxButton10 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(20, 395, 160, 25)];
    checkBoxButton10.label.text = @"网关支付";
    [self.view addSubview:checkBoxButton10];
    [self.checkbox setObject:checkBoxButton10 forKey:@"GATEWAYPAY"];
    
    UICheckBoxButton *checkBoxButton11 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(200, 395, 160, 25)];
    checkBoxButton11.label.text = @"帐户支付";
    [self.view addSubview:checkBoxButton11];
    [self.checkbox setObject:checkBoxButton11 forKey:@"ACCOUNTPAY"];

    UICheckBoxButton *checkBoxButton12 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(20, 430, 160, 25)];
    checkBoxButton12.label.text = @"实名转帐";
    [self.view addSubview:checkBoxButton12];
    [self.checkbox setObject:checkBoxButton12 forKey:@"REALNAME"];
    
    UICheckBoxButton *checkBoxButton13 = [[ UICheckBoxButton alloc] initWithFrame: CGRectMake(200, 430, 160, 25)];
    checkBoxButton13.label.text = @"保付通";
    [self.view addSubview:checkBoxButton13];
    [self.checkbox setObject:checkBoxButton13 forKey:@"ASSURECONNECT"];
	// Do any additional setup after loading the view.
}
-(void)submmit
{
    int flag=0;
    for(NSString *s in [self.checkbox allKeys]){
        UICheckBoxButton *button = [self.checkbox objectForKey:s];
        if(button.isChecked == YES)
        {
            if(flag == 0)
            {
                self.serviceType = s;
                flag =1;
            }
            else{
                self.serviceType = [NSString stringWithFormat:@"%@;%@",self.serviceType,s];
            }
        }
    }
    if(flag == 0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请选择服务类型！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        TLAppDelegate *myDelegate =(TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"business"];
        NSURL *myurl = [NSURL URLWithString:urlstr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
        
        [tooles showHUD:@"请稍候！正在通讯！"];
        
        [request setPostValue:self.name forKey:@"businessname"];
        [request setPostValue:self.serviceType forKey:@"servicetype"];
        [request setPostValue:myDelegate.loginName forKey:@"username"];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(GetResult:)];
        [request setDidFailSelector:@selector(GetErr:)];
        [request startAsynchronous];

    }
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
    NSLog(@"loginJson===%@",loginJson);
    NSString *businessId = [loginJson objectForKey:@"Id"];
    if([businessId integerValue] == -1){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"存在同名商户！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        NSString *processId = [loginJson objectForKey:@"processId"];
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        NSDate *now = [NSDate date];
        TLCompany *com = [[TLCompany alloc]initWithName:self.name createdAt:now businessId:businessId processId:processId processType:@"BUPRIMITIVE"];
        [myDelegate.companyList insertObject:com atIndex:0];
        [com saveToFile];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-3] animated:YES];
        //[viewController.navigationController.presentingViewController performSegueWithIdentifier:@"log" sender:viewController];
        //[self performSegueWithIdentifier:@"clist" sender:self];
    }
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
