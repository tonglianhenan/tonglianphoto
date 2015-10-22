//
//  TLLoginViewController.m
//  TongLian
//
//  Created by mac on 13-9-10.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLLoginViewController.h"
#import "TLAppDelegate.h"
#import "TLBusinessController.h"
//#define URL @"http://61.163.100.203:9999/control/mobile/loginJson";
//#define URL @"http://10.88.1.59:8080/control/mobile/loginJson";
//#define URL @"http://10.88.80.10:9000/control/mobile/loginJson";

@interface TLLoginViewController ()

@end

@implementation TLLoginViewController
@synthesize userName,password,btnSelect,ServernameList;
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
    [password setSecureTextEntry:YES];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/user.txt",documentDirectory];
    NSArray *list = [[NSArray alloc]initWithContentsOfFile:path];
    if([list count]!=0){
        [self.userName setText:[list objectAtIndex:0]];
        [self.password setText:[list objectAtIndex:1]];
        if([list count]==3){
            [btnSelect setTitle:[list objectAtIndex:2] forState:UIControlStateNormal];
            //[btnSelect.titleLabel setText:[list objectAtIndex:2]];
        }
    }
    
    btnSelect.layer.borderWidth = 1;
    btnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    btnSelect.layer.cornerRadius = 10;
    //获取服务器列表
    NSString *urlstr = @"http://61.163.100.203:8889/control/mobile/getAllServerAdress";
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult1:)];
    [request setDidFailSelector:@selector(GetErr1:)];
    [request startAsynchronous];

	// Do any additional setup after loading the view.
}

-(void)GetResult1:(ASIHTTPRequest *)request{
    //接受字符串集
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *lloginJson = [all objectForKey:@"lloginJson"];
    //NSDictionary *loginJson = [all objectForKey:@"loginJson"];
    ServernameList = [lloginJson allKeys];
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    [myDelegate setServerDic:lloginJson];
}

- (void) GetErr1:(ASIHTTPRequest *)request{
    
    [tooles removeHUD];
    
    [tooles MsgBox:@"网络错误,连接不到服务器"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)selectClicked:(id)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithArray:ServernameList];
    if(dropDown == nil) {
        CGFloat f = 170;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    //[dropDown release];
    dropDown = nil;
}

-(IBAction)login:(id)sender{
    if(userName.text.length==0||password.text.length==0){
        [tooles MsgBox:@"用户名或密码不能为空"];
        return;
    }
    //保存用户名密码到文件
    NSArray *list = [NSArray arrayWithObjects:userName.text,password.text,btnSelect.titleLabel.text, nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/user.txt",documentDirectory];
    [list writeToFile:path atomically:YES];
    
    [userName resignFirstResponder];
    [password resignFirstResponder];
    [tooles showHUD:@"正在登录。。。。"];
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
     NSString *address = [myDelegate.ServerDic objectForKey:btnSelect.titleLabel.text];
    if(address==nil){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请选择一下服务器😓" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    [myDelegate setURL:address];

    
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"IOSloginJson"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    [request setPostValue:userName.text forKey:@"id"];
    [request setPostValue:password.text forKey:@"pwd"];
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
    NSDictionary *loginJson = [all objectForKey:@"loginJson"];
    //NSDictionary *lloginJson = [all objectForKey:@"lloginJson"];
    
    NSString *loginTag= [loginJson objectForKey:@"loginTag"];
    
    NSString *userType = [loginJson objectForKey:@"userType"];
    if(![loginTag boolValue]){
        NSString *message = [loginJson objectForKey:@"message"];
        [tooles MsgBox:message];
        return;
    }
    else{
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        myDelegate.loginName = self.userName.text;
        myDelegate.userType = userType;
        UIStoryboard * storyboard = [ UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil ];
        UINavigationController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"navigation" ];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    [tooles removeHUD];
    
    [tooles MsgBox:@"网络错误,连接不到服务器"];
}
-(void)show:(NSString *)ss{
    NSLog(@"sss==%@",ss);
}
-(IBAction)register_click:(id)sender{
    UIStoryboard * storyboard = [ UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil ];
    TLRegister *viewController = [storyboard instantiateViewControllerWithIdentifier:@"register" ];
    [self presentViewController:viewController animated:YES completion:nil];
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
