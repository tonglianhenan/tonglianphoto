//
//  TLSearchViewController.m
//  TongLian
//
//  Created by mac on 14-6-17.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLSearchViewController.h"

@interface TLSearchViewController ()

@end

@implementation TLSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)search:(id)sender{
    if(self.workOrder.text.length == 0){
        [tooles MsgBox:@"请输入工单号！"];
        return;
    }
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    
   
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"checkForFeedBack"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    [tooles showHUD:@"请稍候！"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
    [request setPostValue:self.workOrder.text forKey:@"executionid"];
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
    NSDictionary *loginJson = [all objectForKey:@"loginJson"];
    NSNumber *businessId = [loginJson objectForKey:@"businessId"];
    //装机反馈Id纪录
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    [myDelegate setProcessId:[loginJson objectForKey:@"processId"]];
    [myDelegate setFBBusinessName:[loginJson objectForKey:@"businessName"]];
    [myDelegate setFBBusinessId:[loginJson objectForKey:@"businessId"]];
    
    if([businessId intValue]==-1){
        [tooles MsgBox:@"输入的工单号有误，请确认后重新输入！"];
    }
    else{
        
        
        //初始化装机反馈尚未拍照标志
        [myDelegate setFeedbackflag:@"no"];
        if(myDelegate.FBPList == nil){
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentDirectory = [paths objectAtIndex:0];
            NSString *path = [NSString stringWithFormat:@"%@/%@/FBPList.txt",documentDirectory,myDelegate.FBBusinessName];
            NSMutableArray *list = [[NSMutableArray alloc]initWithContentsOfFile:path];
            
            NSLog(@"path:%@",path);
            if([list count]==0){
                NSLog(@"list count==0");
                myDelegate.FBPList = [[NSMutableArray alloc]init];
            }else{
                myDelegate.FBPList = list;
            }
        }
        
        //if(myDelegate.replyDic==nil){
            //初始化装机反馈信息列表
        NSMutableDictionary *changsuo = [[NSMutableDictionary alloc]init];
        NSArray *changsuokeys = [NSArray arrayWithObjects:@"门头",@"收银台",@"经营场所",@"工单正面",@"工单反面",@"其他", nil];
        NSArray *changsuoobjects = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
        changsuo = [NSMutableDictionary dictionaryWithObjects:changsuoobjects forKeys:changsuokeys];
        NSMutableArray *ob = [NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];
        
        NSMutableArray *mentou = [NSMutableArray arrayWithObjects:@"门头1",@"门头2",@"门头3", nil];
        NSMutableArray *shouyintai = [NSMutableArray arrayWithObjects:@"收银台1",@"收银台2",@"收银台3", nil];
        NSMutableArray *jingyingchangsuo = [NSMutableArray arrayWithObjects:@"经营场所1",@"经营场所2",@"经营场所3", nil];
        NSMutableArray *cangku = [NSMutableArray arrayWithObjects:@"工单正面1",@"工单正面2",@"工单正面3", nil];
        NSMutableArray *gongdanfanmian = [NSMutableArray arrayWithObjects:@"工单反面1",@"工单反面2",@"工单反面3", nil];
        NSMutableArray *qita = [NSMutableArray arrayWithObjects:@"其他1",@"其他2",@"其他3", nil];
        
        
        NSMutableDictionary *mt = [NSMutableDictionary dictionaryWithObjects:ob forKeys:mentou];
        NSMutableDictionary *syt = [NSMutableDictionary dictionaryWithObjects:ob forKeys:shouyintai];
        NSMutableDictionary *jycs = [NSMutableDictionary dictionaryWithObjects:ob forKeys:jingyingchangsuo];
        NSMutableDictionary *ck = [NSMutableDictionary dictionaryWithObjects:ob forKeys:cangku];
        NSMutableDictionary *gdfm = [NSMutableDictionary dictionaryWithObjects:ob forKeys:gongdanfanmian];
        NSMutableDictionary *qt = [NSMutableDictionary dictionaryWithObjects:ob forKeys:qita];
        
        
        [changsuo setObject:mt forKey:@"门头"];
        [changsuo setObject:syt forKey:@"收银台"];
        [changsuo setObject:jycs forKey:@"经营场所"];
        [changsuo setObject:ck forKey:@"工单正面"];
        [changsuo setObject:gdfm forKey:@"工单反面"];
        [changsuo setObject:qt forKey:@"其他"];
        [myDelegate setReplyDic:changsuo];
        //}

        
        NSLog(@"loginJSon===%@",loginJson);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TLFeedbackTableViewController *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"feedback"];
        [viewcontroller setBusinessId:[loginJson objectForKey:@"businessId"]];
        [viewcontroller setBusinessName:[loginJson objectForKey:@"businessName"]];
        [viewcontroller setProcessId:[loginJson objectForKey:@"processId"]];
        [viewcontroller setBranchId:[loginJson objectForKey:@"branchId"]];
        [viewcontroller setProcessType:[loginJson objectForKey:@"processType"]];
        [viewcontroller setBranchName:[loginJson objectForKey:@"branchName"]];
        [viewcontroller setAddress:[loginJson objectForKey:@"address"]];
        [self.navigationController pushViewController:viewcontroller animated:YES];
        
    }
    
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)textFieldDone:(id)sender{
    [sender resignFirstResponder];
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
