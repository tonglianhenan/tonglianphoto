//
//  TLMySubmitTaskController.m
//  TongLian
//
//  Created by mac on 13-10-30.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLMySubmitTaskController.h"

//#define URL @"http://61.163.100.203:9999/control/mobile/taskSendList";
//#define URL @"http://10.88.1.59:8080/control/mobile/taskSendList";
//#define URL @"http://10.88.80.10:9000/control/mobile/taskSendList";


@interface TLMySubmitTaskController ()

@end

@implementation TLMySubmitTaskController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setTitle:@"查询"];
    //[self.navigationController setTitle:@"查询";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(IBAction)myTask_click:(id)sender{

    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    [tooles showHUD:@"请稍侯！"];
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"taskSendList"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    [request setPostValue:myDelegate.loginName forKey:@"username"];
    
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
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLMySendTaskList *mysend= [stroyboard instantiateViewControllerWithIdentifier:@"TLMySendTaskList"];
    NSLog(@"alist==%@",loginJson);
    [mysend setAllTasks:loginJson];
    [self.navigationController pushViewController:mysend animated:YES];

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
