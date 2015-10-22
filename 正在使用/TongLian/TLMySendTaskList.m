//
//  TLMySendTaskList.m
//  TongLian
//
//  Created by mac on 13-10-31.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLMySendTaskList.h"

//#define URL @"http://61.163.100.203:9999/control/mobile/taskSendDetail";
//#define URL @"http://10.88.1.59:8080/control/mobile/taskSendDetail";
//#define URL @"http://10.88.80.10:9000/control/mobile/taskSendDetail";

@interface TLMySendTaskList ()

@end

@implementation TLMySendTaskList

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
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.navigationController setTitle:@"已派发任务"];
    [self.searchDisplayController.searchResultsTableView setRowHeight:98];
	// Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    if([tableView isEqual:self.searchController.searchResultsTableView]){
        return [self.selectTasks count];
    }
    else{
        return [self.allTasks count];
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TLTcell *cell = [self.mTableView dequeueReusableCellWithIdentifier:@"TLTcell"];
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        NSMutableDictionary *dic = [self.selectTasks objectAtIndex:indexPath.row];
        cell.ID.text = [dic objectForKey:@"processInstanceId"];
        cell.task.text = [dic objectForKey:@"taskName"];
        cell.name.text = [dic objectForKey:@"registerName"];
    }
    else{
        
        NSMutableDictionary *dic = [self.allTasks objectAtIndex:indexPath.row];
        cell.ID.text = [dic objectForKey:@"processInstanceId"];
        NSLog(@"%d",indexPath.row);
        NSLog(@"%@",[dic objectForKey:@"processInstanceId"]);
        NSLog(@"%@",[dic objectForKey:@"registerName"]);
        NSLog(@"%@",[dic objectForKey:@"taskName"]);
        if([dic objectForKey:@"taskName"]!=nil){
            cell.task.text = [dic objectForKey:@"taskName"];
        }else{
            cell.task.text = @"数据为空";
        }
        if([dic objectForKey:@"registerName"]!=nil){
            cell.name.text = [dic objectForKey:@"registerName"];
        }else{
            cell.name.text = @"数据为空";
        }
        
    }   
    
    return cell;
        
}

- (void)filterContentForSearchText:(NSString*)searchText                               scope:(NSString*)scope {
    [self.selectTasks removeAllObjects];
    if(self.selectTasks ==nil){
        self.selectTasks = [[NSMutableArray alloc]init];
    }
    for(int i =0;i<[self.allTasks count];i++){
        NSDictionary *dic = [self.allTasks objectAtIndex:i];
        NSString *s = [dic objectForKey:@"registerName"];
        if([s hasPrefix:searchText]){
            [self.selectTasks addObject:dic];
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
//查看详情

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    [tooles showHUD:@"请稍候！"];
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"taskSendDetail"];
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
     if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
         NSMutableDictionary *dic = [self.selectTasks objectAtIndex:indexPath.row];
         [request setPostValue:[dic objectForKey:@"processInstanceId"] forKey:@"processInstanceId"];
     }else{
         NSMutableDictionary *dic = [self.allTasks objectAtIndex:indexPath.row];
         [request setPostValue:[dic objectForKey:@"processInstanceId"] forKey:@"processInstanceId"];
     }
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"信息尚未提交！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TLDetailViewController *detail = [stroyboard instantiateViewControllerWithIdentifier:@"TLDetail"];
        [detail setDetail:loginJson];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
