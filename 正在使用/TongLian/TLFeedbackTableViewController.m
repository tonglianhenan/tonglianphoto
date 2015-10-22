//
//  TLFeedbackTableViewController.m
//  TongLian
//
//  Created by mac on 14-6-19.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLFeedbackTableViewController.h"

@interface TLFeedbackTableViewController ()

@end

@implementation TLFeedbackTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLFBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedb" forIndexPath:indexPath];
    cell.businessName.text = self.businessName;
    cell.branchName.text = self.branchName;
    cell.address.text = self.address;
    
    // Configure the cell...
    
    return cell;
}
-(IBAction)submit:(id)sender{
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *s = nil;
    if([myDelegate.FBPList count]==0){
        s = @"所有照片都已上传或者尚未拍照,确认提交任务？";
    }else{
        s = [NSString stringWithFormat:@"共有%d张照片尚未提交，确认提交任务？",[myDelegate.FBPList count]];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:s delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];

    }
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"checkForAccountUser"];
        NSURL *url = [NSURL URLWithString:urlstr];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:@"装机反馈组" forKey:@"usertype"];
        
        [request setDelegate:self];
        [request setDidFailSelector:@selector(GetErr1:)];
        [request setDidFinishSelector:@selector(GetResult1:)];
        [request setTimeOutSeconds:20];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
    }
}
-(void) GetErr1:(ASIHTTPRequest *)request{
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
}

-(void)GetResult1:(ASIFormDataRequest *)request{
    //接受字符串集
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSDictionary *loginJson = [all objectForKey:@"loginJson"];
    NSDictionary *dic = [loginJson objectForKey:@"touser"];
    NSString *type= @"提交";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLSelectTableViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"Stable"];
    [view setNum:[dic count]];
    [view setType:type];
    [view setIdList:[dic allKeys]];
    [view setPersonList:[dic allValues]];
    [self.navigationController pushViewController:view animated:YES];
}

-(IBAction)weaning:(id)sender{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"checkForAccountUser"];
    NSURL *url = [NSURL URLWithString:urlstr];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"机具下装组" forKey:@"usertype"];
    
    [request setDelegate:self];
    [request setDidFailSelector:@selector(GetErr:)];
    [request setDidFinishSelector:@selector(GetResult:)];
    [request setTimeOutSeconds:20];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];
}
-(void) GetErr:(ASIHTTPRequest *)request{
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
}

-(void)GetResult:(ASIFormDataRequest *)request{
    //接受字符串集
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSDictionary *loginJson = [all objectForKey:@"loginJson"];
    NSDictionary *dic = [loginJson objectForKey:@"touser"];
    NSString *type= @"驳回";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLSelectTableViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"Stable"];
    [view setNum:[dic count]];
    [view setType:type];
    [view setIdList:[dic allKeys]];
    [view setPersonList:[dic allValues]];
    [self.navigationController pushViewController:view animated:YES];

}
-(IBAction)endpointList_click:(id)sender{

    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"endpointList"];
    NSURL *url = [NSURL URLWithString:urlstr];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:self.branchId forKey:@"branchId"];
    
    [request setDelegate:self];
    [request setDidFailSelector:@selector(GetErr1:)];
    [request setDidFinishSelector:@selector(GetResult2:)];
    [request setTimeOutSeconds:20];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request startAsynchronous];

}
-(void)GetResult2:(ASIFormDataRequest *)request{
    //接受字符串集
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    TLEndpointList *view = [storyboard instantiateViewControllerWithIdentifier:@"endpointList"];
    [view setRecommanderList:[NSMutableArray arrayWithArray:[all objectForKey:@"loginJson"]]];
    [view setBranchId:self.branchId];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    TLFBPhotoViewController *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"FBPhoto"];
//    [viewcontroller setBusinessId:self.businessId];
    TLCategory *viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"category"];
    [viewcontroller setBusinessName:self.businessName];
    [viewcontroller setBusinessId:self.businessId];
    [self.navigationController pushViewController:viewcontroller animated:YES];
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
