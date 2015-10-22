//
//  TLRegister.m
//  TongLian
//
//  Created by mac on 13-11-11.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLRegister.h"

@interface TLRegister ()

@end

@implementation TLRegister

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
    [self.psw setSecureTextEntry:YES];
    [self.psw1 setSecureTextEntry:YES];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btn_click:(id)sender{
    if(self.name.text.length == 0){
        [tooles MsgBox:@"请输入注册名！"];
        return;
    }
    if(self.psw.text.length == 0){
        [tooles MsgBox:@"请输入密码！"];
        return;
    }if (![self.psw.text isEqualToString:self.psw1.text]) {
        [tooles MsgBox:@"两次输入密码不一致！"];
        return;
    }
    
    [self.name resignFirstResponder];
    [self.psw resignFirstResponder];
    [self.psw1 resignFirstResponder];
    [tooles showHUD:@"正在注册。。。"];
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"IOSRegister"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    [request setPostValue:self.name.text forKey:@"id"];
    [request setPostValue:self.psw.text forKey:@"pwd"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setDidFailSelector:@selector(GetErr:)];
    [request startAsynchronous];
}
-(IBAction)back_click:(id)sender{
    UIStoryboard * storyboard = [ UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil ];
    TLLoginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"login" ];
    [self presentViewController:login animated:YES completion:nil];
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
    NSString *loginTag= [loginJson objectForKey:@"tag"];
    if([loginTag boolValue]){
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:nil message:@"注册成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [view show];
    }
    else{
        [tooles MsgBox:@"存在同名用户！"];
    }
 
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIStoryboard * storyboard = [ UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil ];
    TLLoginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"login" ];
    //保存用户名密码到文件
    NSArray *list = [NSArray arrayWithObjects:self.name.text,self.psw.text, nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/user.txt",documentDirectory];
    [list writeToFile:path atomically:YES];
        
    [self presentViewController:login animated:YES completion:nil];
}
- (void) GetErr:(ASIHTTPRequest *)request{
    
    [tooles removeHUD];
    
    [tooles MsgBox:@"网络错误,连接不到服务器"];
}

-(IBAction)textFieldDone:(id)sender{
    [sender resignFirstResponder];
}
@end
