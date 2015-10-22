//
//  TLChangeList.m
//  TongLian
//
//  Created by mac on 14-11-21.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLChangeList.h"
#import "TLCompaniesController.h"
#import "TLCompany.h"
#import "TLAddCompanyNameViewController.h"
#import "TLWorkListTableViewController.h"
#import "TLAppDelegate.h"


@interface TLChangeList ()

@end

@implementation TLChangeList

- (void)awakeFromNib
{
    [super awakeFromNib];
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    if([myDelegate.tType isEqualToString:@"ZNQK"]){
        [self.navigationItem setTitle:@"助农取款列表"];
    }else if([myDelegate.tType isEqualToString:@"T0"]){
        [self.navigationController setTitle:@"变更列表"];
    }
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
    TLChangeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"changeCell"];
    
    TLCompany *companyAtIndex = [self.companies objectAtIndex:indexPath.row];
    NSString *s = [NSString stringWithFormat:@"%@",companyAtIndex.businessId];
    cell.businessID.text = s;
    cell.companyName.text = companyAtIndex.name;
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
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
        if([companyAtIndex.machineId boolValue]||![companyAtIndex.machineId isKindOfClass:[NSNull class]]){
            cell.machineId.text = companyAtIndex.machineId;
        }else{
            cell.machineId.text = @"未知";
        }
        if([companyAtIndex.orderNum boolValue]||![companyAtIndex.orderNum isKindOfClass:[NSNull class]]){
            cell.orderNum.text = companyAtIndex.orderNum;
        }else{
            cell.orderNum.text = @"未知";
        }
        
    }
    else{
        
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
        if([companyAtIndex.machineId boolValue]||![companyAtIndex.machineId isKindOfClass:[NSNull class]]){
            cell.machineId.text = companyAtIndex.machineId;
        }else{
            cell.machineId.text = @"未知";
        }
        if([companyAtIndex.orderNum boolValue]||![companyAtIndex.orderNum isKindOfClass:[NSNull class]]){
            cell.orderNum.text = companyAtIndex.orderNum;
        }else{
            cell.orderNum.text = @"未知";
        }
        
    }

    
            //static NSDateFormatter *formatter = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyy-MM-dd hh:mm:ss"];
    
    cell.createTime.text = [formatter stringFromDate:(NSDate *)companyAtIndex.createdAt];
    [cell.submit addTarget:self action:@selector(btn_click:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.del addTarget:self action:@selector(del_click:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.task addTarget:self action:@selector(task_submit:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.detail addTarget:self action:@selector(detail_click:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.changName addTarget:self action:@selector(changeName_click:event:) forControlEvents:UIControlEventTouchUpInside];

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
    if([myDelegate.tType isEqualToString:@"ZNQK"]){
        if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
            myDelegate.company = [self.select objectAtIndex:indexPath.row];
            if([myDelegate.company.processType isEqualToString:@"变更复核通过"] || [myDelegate.company.processType isEqualToString:@"助农反馈驳回"]){
                
                //装机反馈照片
                //初始化
                [self feedback_init];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                TLCategory *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"category"];
                [viewcontroller setBusinessName:myDelegate.company.name];
                [viewcontroller setBusinessId:myDelegate.company.businessId];
                [self.navigationController pushViewController:viewcontroller animated:YES];
                
                
            }else{
                [self performSegueWithIdentifier:@"workList" sender:self];
            }
        }
        else{
            myDelegate.company = [self.companies objectAtIndex:indexPath.row];
            
            if([myDelegate.company.processType isEqualToString:@"变更复核通过"] || [myDelegate.company.processType isEqualToString:@"助农反馈驳回"]){
                
                //装机反馈照片
                //初始化
                [self feedback_init];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                //    TLFBPhotoViewController *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"FBPhoto"];
                //    [viewcontroller setBusinessId:self.businessId];
                TLCategory *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"category"];
                [viewcontroller setBusinessName:myDelegate.company.name];
                [viewcontroller setBusinessId:myDelegate.company.businessId];
                [self.navigationController pushViewController:viewcontroller animated:YES];
                
            }else{
                [self performSegueWithIdentifier:@"workList" sender:self];
            }
        }
    
    }else if([myDelegate.tType isEqualToString:@"T0"]){
        if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
            myDelegate.company = [self.select objectAtIndex:indexPath.row];
            if([myDelegate.company.processType isEqualToString:@"初审通过"] || [myDelegate.company.processType isEqualToString:@"变更信息录入"]){
                
                //装机反馈照片
                //初始化
                [self feedback_init];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                TLCategory *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"category"];
                [viewcontroller setBusinessName:myDelegate.company.name];
                [viewcontroller setBusinessId:myDelegate.company.businessId];
                [self.navigationController pushViewController:viewcontroller animated:YES];
                
                
            }else{
                [self performSegueWithIdentifier:@"workList" sender:self];
            }
        }
        else{
            myDelegate.company = [self.companies objectAtIndex:indexPath.row];
            
            if([myDelegate.company.processType isEqualToString:@"初审通过"] || [myDelegate.company.processType isEqualToString:@"变更信息录入"]){
                
                
                //装机反馈照片
                //初始化
                [self feedback_init];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                //    TLFBPhotoViewController *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"FBPhoto"];
                //    [viewcontroller setBusinessId:self.businessId];
                TLCategory *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"category"];
                [viewcontroller setBusinessName:myDelegate.company.name];
                [viewcontroller setBusinessId:myDelegate.company.businessId];
                [self.navigationController pushViewController:viewcontroller animated:YES];
                
            }else{
                [self performSegueWithIdentifier:@"workList" sender:self];
            }
            
        }
        
    }
}
//初始化装机反馈
-(void) feedback_init{
    //初始化
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    [myDelegate setProcessId:myDelegate.company.processId];
    [myDelegate setFBBusinessName:myDelegate.company.name];
    [myDelegate setFBBusinessId:myDelegate.company.businessId];
    
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
}
//添加新的商户
-(IBAction)add:(id)sender{
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    if([myDelegate.userType isEqualToString:@"VISITOR"]){
        [tooles MsgBox:@"您没有此权限，详情请咨询系统管理员！"];
    }
    else{
        UIStoryboard *my = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TLAddChange *add = [my instantiateViewControllerWithIdentifier:@"addChange"];
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
//删除
-(void) del_click:(id)sender event:(id)event{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    self.index = indexPath;
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    //如果搜索框的文本域为空，则说明此时的tableview为searchDisplayController.searchResultsTableView
    if(self.mSearchBar.text.length!=0){
        myDelegate.company = [self.select objectAtIndex:indexPath.row];
    }
    else{
        myDelegate.company = [self.companies objectAtIndex:indexPath.row];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"备注" message:@"请输入备注信息：" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"完成",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert setTag:2];
    [alert show];
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
    if([myDelegate.company.processType isEqualToString:@"信息尚未提交"]||[myDelegate.company.processType isEqualToString:@"初审驳回"]|| [myDelegate.company.processType isEqualToString:@"初审通过"] || [myDelegate.company.processType isEqualToString:@"变更信息录入"]|| [myDelegate.company.processType isEqualToString:@"变更复核通过"]|| [myDelegate.company.processType isEqualToString:@"助农反馈驳回"]){
        if([myDelegate.company.notSubmmit count]>0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"还有已拍照片没有上传！请点击照片按钮进行提交或者去拍照处删除后再提交！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"备注" message:@"请输入备注信息：" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"完成",nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alert setTag:1];
            [alert show];
        }

    }else{
        [tooles MsgBox:@"审核人员处理中,暂时无法操作"];
    }
}
//修改商户名称
-(void) changeName_click:(id)sender event:(id)event{
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改商户名称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定修改",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *text = [alert textFieldAtIndex:0];
    [text setText:myDelegate.company.name];
    [alert setTag:3];
    [alert show];

    
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        
        UITextField *txt=[alertView textFieldAtIndex:0];
        
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        TLCompany *myCom= myDelegate.company;
        
        [tooles showHUD:@"正在提交！请稍候！"];
        if(alertView.tag == 1){
            NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"submitChange"];
            NSURL *myurl = [NSURL URLWithString:urlstr];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
            
            [request setPostValue:myCom.processId forKey:@"processId"];
            [request setPostValue:myDelegate.loginName forKey:@"userLoginId"];
            [request setPostValue:txt.text forKey:@"suggestion"];
            
            [request setDelegate:self];
            [request setDidFinishSelector:@selector(GetResult:)];
            [request setDidFailSelector:@selector(GetErr:)];
            [request setTimeOutSeconds:20];
            [request setNumberOfTimesToRetryOnTimeout:2];
            [request startAsynchronous];
        }else if(alertView.tag == 2){
            NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"deleteChange"];
            NSURL *myurl = [NSURL URLWithString:urlstr];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
            
            [request setPostValue:myCom.processId forKey:@"processId"];
            [request setPostValue:myDelegate.loginName forKey:@"userLoginId"];
            [request setPostValue:txt.text forKey:@"suggestion"];
            
            [request setDelegate:self];
            [request setDidFinishSelector:@selector(GetResult_delete:)];
            [request setDidFailSelector:@selector(GetErr:)];
            [request setTimeOutSeconds:20];
            [request setNumberOfTimesToRetryOnTimeout:2];
            [request startAsynchronous];

        }else if(alertView.tag == 3){
            self.registerName  = txt.text;
            NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"changeName"];
            NSURL *myurl = [NSURL URLWithString:urlstr];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
            NSLog(@"shanghuId===%@",myCom.businessId);
            
            [request setPostValue:myCom.businessId forKey:@"businessId"];
            [request setPostValue:txt.text forKey:@"registerName"];
            
            [request setDelegate:self];
            [request setDidFinishSelector:@selector(GetResult_changName:)];
            [request setDidFailSelector:@selector(GetErr:)];
            [request setTimeOutSeconds:20];
            [request setNumberOfTimesToRetryOnTimeout:2];
            [request startAsynchronous];

        }

    }
}
-(void)GetResult_changName:(ASIFormDataRequest *)request{
    //接受字符串集
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSArray *androidAction = [all objectForKey:@"androidAction"];
    NSDictionary *androidMap = [androidAction objectAtIndex:0];
    NSLog(@"map==%@",androidMap);
    NSString *result = [androidMap objectForKey:@"responseCode"];
    
    if([result isEqualToString:@"0"]){
        [tooles MsgBox:@"修改成功！"];
        
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        TLCompany *com = myDelegate.company;
        com.name = self.registerName;
        [com saveToFile];
        NSNumber *sel = [[NSNumber alloc] initWithInteger:self.index.row];
        [myDelegate.companyList replaceObjectAtIndex:[sel intValue] withObject:com];
        [self.companies replaceObjectAtIndex:[sel intValue] withObject:com];
        
        TLChangeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"changeCell"];
        cell = (TLChangeCell *)[self.tableView cellForRowAtIndexPath:self.index];
        cell.companyName.text = self.registerName;

    }else{
        NSString *reason = [androidMap objectForKey:@"reason"];
        [tooles MsgBox:reason];
    }
}

-(void)GetResult_delete:(ASIFormDataRequest *)request{
    //接受字符串集
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSArray *androidAction = [all objectForKey:@"androidAction"];
    NSDictionary *androidMap = [androidAction objectAtIndex:0];
    NSLog(@"map==%@",androidMap);
    NSString *result = [androidMap objectForKey:@"responseCode"];
    
    if([result isEqualToString:@"0"]){
        [tooles MsgBox:@"删除成功！"];
        
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        [[myDelegate.companyList objectAtIndex:self.index.row] removeFromFile];
        [self.companies removeObjectAtIndex:self.index.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.index] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else{
        NSString *message = [androidMap objectForKey:@"message"];
        [tooles MsgBox:message];
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
    NSArray *androidAction = [all objectForKey:@"androidAction"];
    NSDictionary *androidMap = [androidAction objectAtIndex:0];
    NSString *result = [androidMap objectForKey:@"responseCode"];
    
    if([result isEqualToString:@"0"]){
        [tooles MsgBox:@"提交成功！"];
        
        
        TLChangeCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"changeCell"];
         cell = (TLChangeCell *)[self.tableView cellForRowAtIndexPath:self.index];
        
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        TLCompany *companyAtIndex = [self.companies objectAtIndex:self.index.row];
        if([myDelegate.tType isEqualToString:@"ZNQK"]){
            
            if([companyAtIndex.processType isEqualToString:@"信息尚未提交"]||[companyAtIndex.processType isEqualToString:@"变更信息录入"]){
                cell.companyStatus.text = @"变更分审";
            }else if([companyAtIndex.processType isEqualToString:@"变更复核通过"] || [companyAtIndex.processType isEqualToString:@"助农反馈驳回"]){
                cell.companyStatus.text = @"助农反馈";
            }

        }else if([myDelegate.tType isEqualToString:@"T0"]){
            
            if([companyAtIndex.processType isEqualToString:@"信息尚未提交"]||[companyAtIndex.processType isEqualToString:@"初审驳回"]){
                cell.companyStatus.text = @"初审";
            }else if([companyAtIndex.processType isEqualToString:@"初审通过"] || [companyAtIndex.processType isEqualToString:@"变更信息录入"]){
                cell.companyStatus.text = @"变更分审";
            }

        }

        //TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        //[self.companies removeObjectAtIndex:self.index.row];
        //[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.index] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    NSMutableArray *loginJson = [NSMutableArray arrayWithArray:[all objectForKey:@"loginJson"]];
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

@end
