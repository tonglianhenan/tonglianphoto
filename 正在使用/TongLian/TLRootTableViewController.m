//
//  TLViewController.m
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-14.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLRootTableViewController.h"
#import "TLCompaniesController.h"
#import "TLCompany.h"
#import "TLAddCompanyNameViewController.h"
#import "TLWorkListTableViewController.h"
#import "TLAppDelegate.h"

//#define URL @"http://61.163.100.203:9999/control/mobile/businessSubmit";
//#define URL @"http://10.88.1.59:8080/control/mobile/businessSubmit";
//#define URL @"http://10.88.80.10:9000/control/mobile/businessSubmit";

//#define DET @"http://61.163.100.203:9999/control/mobile/taskDetail";
//#define DET @"http://10.88.1.59:8080/control/mobile/taskDetail";
//#define DET @"http://10.88.80.10:9000/control/mobile/taskDetail";

@interface TLRootTableViewController ()

@end

@implementation TLRootTableViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.companies = myDelegate.companyList;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchDisplayController.searchResultsTableView setRowHeight:128];
    self.flag = 0;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [self.companies count];
    
    if([tableView isEqual:self.searchController.searchResultsTableView]){
        return [self.select count];
    }
    else{
        return [self.companies count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TLcell"];
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
        TLCompany *companyAtIndex = [self.select objectAtIndex:indexPath.row];
        //NSString *s = [NSString stringWithFormat:@"%@",companyAtIndex.businessId];
        //cell.businessID.text = s;
        cell.companyName.text = companyAtIndex.name;
        if([companyAtIndex.processType isEqualToString:@"BUPRIMITIVE"])
        {
            cell.companyStatus.text = @"信息尚未提交";
        }
        else if([companyAtIndex.processType isEqualToString:@"CHANCEINPUT"]){
            cell.companyStatus.text = @"商机录入";
            [cell.companyStatus setTextColor:[UIColor redColor]];
        }
        else{
            cell.companyStatus.text = companyAtIndex.processType;
        }
        
        //static NSDateFormatter *formatter = nil;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat : @"yyyy-MM-dd hh:mm:ss"];
        
        cell.createTime.text = [formatter stringFromDate:(NSDate *)companyAtIndex.createdAt];
        [cell.submit addTarget:self action:@selector(btn_click:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.branch addTarget:self action:@selector(branch_click:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.task addTarget:self action:@selector(task_submit:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.detail addTarget:self action:@selector(detail_click:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.transfer addTarget:self action:@selector(transfer_click:event:) forControlEvents:UIControlEventTouchUpInside];

    }
    else{
        TLCompany *companyAtIndex = [self.companies objectAtIndex:indexPath.row];
        NSString *s = [NSString stringWithFormat:@"%@",companyAtIndex.businessId];
        cell.businessID.text = s;
        cell.companyName.text = companyAtIndex.name;
        if([companyAtIndex.processType isEqualToString:@"BUPRIMITIVE"])
        {
            cell.companyStatus.text = @"信息尚未提交";
            [cell.companyStatus setTextColor:[UIColor redColor]];
        }
        else if([companyAtIndex.processType isEqualToString:@"CHANCEINPUT"]){
            cell.companyStatus.text = @"商机录入";
            [cell.companyStatus setTextColor:[UIColor redColor]];
        }
        else{
            cell.companyStatus.text = companyAtIndex.processType;
        }
        
        //static NSDateFormatter *formatter = nil;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat : @"yyyy-MM-dd hh:mm:ss"];
        
        cell.createTime.text = [formatter stringFromDate:(NSDate *)companyAtIndex.createdAt];
        [cell.submit addTarget:self action:@selector(btn_click:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.branch addTarget:self action:@selector(branch_click:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.task addTarget:self action:@selector(task_submit:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.detail addTarget:self action:@selector(detail_click:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.transfer addTarget:self action:@selector(transfer_click:event:) forControlEvents:UIControlEventTouchUpInside];

    }
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText                               scope:(NSString*)scope {
    [self.select removeAllObjects];
    if(self.select ==nil){
        self.select = [[NSMutableArray alloc]init];
    }
    for(int i =0;i<[self.companies count];i++){
        TLCompany *dic = [self.companies objectAtIndex:i];
        if([dic.name hasPrefix:searchText]){
            [self.select addObject:dic];
        }
    }
    //    NSPredicate *resultPredicate = [NSPredicate                                      predicateWithFormat:@"SELF contains[cd] %@",                                     searchText];
    //
    //    self.selectTasks  = [self.allTasks filteredArrayUsingPredicate:resultPredicate];
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar                                                      selectedScopeButtonIndex]]];
    
    return YES;
    
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller  shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]                                 scope:[[self.searchDisplayController.searchBar scopeButtonTitles]                                       objectAtIndex:searchOption]];
    
    return YES;
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        myDelegate.company = [self.select objectAtIndex:indexPath.row];  
    }
    else{
        myDelegate.company = [self.companies objectAtIndex:indexPath.row];
    }
    [self performSegueWithIdentifier:@"workList" sender:self];
}
//添加新的商户
-(IBAction)add:(id)sender{

    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    if([myDelegate.userType isEqualToString:@"VISITOR"]){
        [tooles MsgBox:@"您没有此权限，详情请咨询系统管理员！"];
    }
    else{
        UIStoryboard *my = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
         TLAddCompanyNameViewController *add = [my instantiateViewControllerWithIdentifier:@"addcompany"];
        [self.navigationController pushViewController:add animated:YES];
    }
}
//查看及批量上传
-(void) btn_click:(id)sender event:(id)event{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    //如果搜索框的文本域为空，则说明此时的tableview为searchDisplayController.searchResultsTableView
    if(self.mSearchBar.text.length!=0){
        myDelegate.company = [self.select objectAtIndex:indexPath.row];
    }
    else{
        myDelegate.company = [self.companies objectAtIndex:indexPath.row];
    }
    UIStoryboard *my = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UITabBarController *tabBar = [my instantiateViewControllerWithIdentifier:@"tabBar"];
    [self.navigationController pushViewController:tabBar animated:YES];
}
//分店
-(void) branch_click:(id)sender event:(id)event{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    //如果搜索框的文本域为空，则说明此时的tableview为searchDisplayController.searchResultsTableView
    if(self.mSearchBar.text.length!=0){
        myDelegate.company = [self.select objectAtIndex:indexPath.row];
    }
    else{
        myDelegate.company = [self.companies objectAtIndex:indexPath.row];
    }
    //设置商户的category(photoType)为场所
    myDelegate.company.photoType = @"SITE";
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLBranchViewController *branch = [stroyboard instantiateViewControllerWithIdentifier:@"branch"];
    [self.navigationController pushViewController:branch animated:YES];
}
//提交任务
-(void) task_submit:(id)sender event:(id)event{
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    self.index = indexPath;
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    //如果搜索框的文本域为空，则说明此时的tableview为searchDisplayController.searchResultsTableView
    if(self.mSearchBar.text.length!=0){
        myDelegate.company = [self.select objectAtIndex:indexPath.row];
    }
    else{
        myDelegate.company = [self.companies objectAtIndex:indexPath.row];
    }
    if([myDelegate.company.notSubmmit count]>0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"还有已拍照片没有上传！请点击照片按钮进行提交或者去拍照处删除后再提交！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"备注" message:@"请输入备注信息：" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"完成",nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert setTag:2];
        [alert show];
    }
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if(buttonIndex == 1){
            if([alertView tag]==2){
                UITextField *txt=[alertView textFieldAtIndex:0];
                
                TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
                TLCompany *myCom= myDelegate.company;
                
                [tooles showHUD:@"正在提交！请稍候！"];
                
                NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"businessSubmit"];
                NSURL *myurl = [NSURL URLWithString:urlstr];
                ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
                
                [request setPostValue:myCom.processId forKey:@"processid"];
                [request setPostValue:myDelegate.loginName forKey:@"username"];
                [request setPostValue:txt.text forKey:@"remark"];
                
                [request setDelegate:self];
                [request setDidFinishSelector:@selector(GetResult:)];
                [request setDidFailSelector:@selector(GetErr:)];
                [request setTimeOutSeconds:20];
                [request setNumberOfTimesToRetryOnTimeout:2];
                [request startAsynchronous];

            }else if([alertView tag]==3){
                TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
                
                NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"departmentList"];
                
                NSURL *myurl = [NSURL URLWithString:urlstr];
                ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
                [tooles showHUD:@"请稍候！"];
                [request setPostValue:myDelegate.company.processId forKey:@"processId"];
                
                [request setDelegate:self];
                [request setDidFinishSelector:@selector(GetResult_departmentList:)];
                [request setDidFailSelector:@selector(GetErr:)];
                [request setTimeOutSeconds:20];
                [request setNumberOfTimesToRetryOnTimeout:2];
                [request startAsynchronous];

            }
        }
}
-(void) GetErr:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
}
-(void)GetResult:(ASIFormDataRequest *)request{
    //接受字符串集
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSDictionary *loginJson = [all objectForKey:@"loginJson"];
    NSString *result = [loginJson objectForKey:@"result"];
    if([result isEqualToString:@"success"]){
        [tooles MsgBox:@"提交成功！"];
        
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
         [[myDelegate.companyList objectAtIndex:self.index.row] removeFromFile];
        [self.companies removeObjectAtIndex:self.index.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.index] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
//查看详情
-(void) detail_click:(id)sender event:(id)event{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    //如果搜索框的文本域为空，则说明此时的tableview为searchDisplayController.searchResultsTableView
    if(self.mSearchBar.text.length!=0){
        myDelegate.company = [self.select objectAtIndex:indexPath.row];
    }
    else{
        myDelegate.company = [self.companies objectAtIndex:indexPath.row];
    }
    
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"taskDetail"];

    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    [tooles showHUD:@"请稍候！"];
    [request setPostValue:myDelegate.company.processId forKey:@"processId"];
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(DGetResult:)];
    [request setDidFailSelector:@selector(DGetErr:)];
    [request setTimeOutSeconds:20];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];
}
-(void) DGetErr:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
}
-(void) DGetResult:(ASIFormDataRequest *)request{
    //接受字符串集
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *loginJson = [all objectForKey:@"loginJson"];
    if([loginJson count]==1){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"信息尚未提交！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TLDetailViewController *detail = [stroyboard instantiateViewControllerWithIdentifier:@"TLDetail"];
        [detail setDetail:loginJson];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}
//商机转让
-(void)transfer_click:(id)sender event:(id)event{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    myDelegate.index = indexPath.row;
    //如果搜索框的文本域为空，则说明此时的tableview为searchDisplayController.searchResultsTableView
    if(self.mSearchBar.text.length!=0){
        myDelegate.company = [self.select objectAtIndex:indexPath.row];
    }
    else{
        myDelegate.company = [self.companies objectAtIndex:indexPath.row];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"商机转让" message:@"如果您有拍照信息，请提交照片信息以后再转让，以防照片遗失！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert setTag:3];
    [alert show];

}
-(void)GetResult_departmentList:(ASIFormDataRequest *)request{
    //接受字符串集
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSArray *androidAction = [all objectForKey:@"androidAction"];
    NSDictionary *androidMap = [androidAction objectAtIndex:0];
    NSString *result = [androidMap objectForKey:@"responseCode"];
    NSArray *departmentList = [androidMap objectForKey:@"departmentList"];
    
    if([result isEqualToString:@"0"]){
        
        UIStoryboard *storyboard=nil;
        
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil ];
        TLBankList *bankList = [storyboard instantiateViewControllerWithIdentifier:@"bankList" ];
        [bankList setBankList:departmentList];
        
        [self.navigationController pushViewController:bankList animated:YES];

    }
}



@end
