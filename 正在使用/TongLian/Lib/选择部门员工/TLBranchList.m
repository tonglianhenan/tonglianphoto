//
//  TLBranchList.m
//  商机转介
//
//  Created by mac on 14-10-28.
//  Copyright (c) 2014年 allinpay. All rights reserved.
//

#import "TLBranchList.h"

@interface TLBranchList ()

@end

@implementation TLBranchList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"选择员工"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.branchList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *branch = [self.branchList objectAtIndex:indexPath.row];
    NSString *branchName = [branch objectForKey:@"userLoginName"];
    
    NSString *SimpleTableIdentifier = @"branchList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             
                             SimpleTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                
                                      reuseIdentifier: SimpleTableIdentifier];
        
    }
    
    [cell.textLabel setText:branchName];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *bank = [self.branchList objectAtIndex:indexPath.row];
    self.userLoginId = [bank objectForKey:@"userLoginId"];
    NSString *name = [bank objectForKey:@"userLoginName"];
    NSString *s = [NSString stringWithFormat:@"确定将此商机转让给%@吗？",name];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:s delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert show];
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        TLCompany *myCom= myDelegate.company;
        
        [tooles showHUD:@"正在提交！请稍候！"];
        
        NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"beginnerChange"];
        NSURL *myurl = [NSURL URLWithString:urlstr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
        
        [request setPostValue:myCom.processId forKey:@"processId"];
        [request setPostValue:myDelegate.loginName forKey:@"oldUserLoginId"];
        [request setPostValue:self.userLoginId forKey:@"newUserLoginId"];
        
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(GetResult:)];
        [request setDidFailSelector:@selector(GetErr:)];
        [request setTimeOutSeconds:20];
        [request setNumberOfTimesToRetryOnTimeout:2];
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
    NSArray *androidAction = [all objectForKey:@"androidAction"];
    NSDictionary *androidMap = [androidAction objectAtIndex:0];
    NSString *result = [androidMap objectForKey:@"responseCode"];
    NSString *reason = [androidMap objectForKey:@"reason"];
    
    if([result isEqualToString:@"0"]){
        [tooles MsgBox:@"转让成功"];
        
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        [[myDelegate.companyList objectAtIndex:myDelegate.index] removeFromFile];
        [myDelegate.companyList removeObjectAtIndex:myDelegate.index];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-3] animated:YES];
        
    }else{
        [tooles MsgBox:reason];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-3] animated:YES];
    }
    
}
- (void) GetErr:(ASIHTTPRequest *)request{
    
    [tooles removeHUD];
    
    [tooles MsgBox:@"网络错误,连接不到服务器"];
}

@end
