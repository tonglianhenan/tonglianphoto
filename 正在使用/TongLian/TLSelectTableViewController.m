//
//  TLSelectTableViewController.m
//  TongLian
//
//  Created by mac on 14-6-20.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLSelectTableViewController.h"

@interface TLSelectTableViewController ()

@end

@implementation TLSelectTableViewController

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
    NSString *title=[NSString stringWithFormat:@"选择%@人员",self.type];
    [self.navigationItem setTitle:title];
    
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
    return self.num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectC" forIndexPath:indexPath];
    cell.textLabel.text=[self.personList objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title=[NSString stringWithFormat:@"%@给%@吗？",self.type,[self.personList objectAtIndex:indexPath.row]];
    self.selectt = [self.IdList objectAtIndex:indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"请输入员工编号：" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"完成",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        
        UITextField *txt=[alertView textFieldAtIndex:0];
        
        NSString *t= nil;
        if([self.type isEqualToString:@"驳回"]){
            t=@"wean";
            TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
            [tooles showHUD:@"正在提交！请稍候！"];
            NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"refuseReasonType"];
            NSURL *myurl = [NSURL URLWithString:urlstr];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
            
            [request setPostValue:txt forKey:@""];
            
            [request setDelegate:self];
            [request setDidFinishSelector:@selector(GetResult_type:)];
            [request setDidFailSelector:@selector(GetErr:)];
            [request setTimeOutSeconds:20];
            [request setNumberOfTimesToRetryOnTimeout:2];
            [request startAsynchronous];

        }else{
            
            
            t=@"add";
            TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
            [tooles showHUD:@"正在提交！请稍候！"];
            NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"sumbitFromFixAssure"];
            NSURL *myurl = [NSURL URLWithString:urlstr];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
            
            [request setPostValue:t forKey:@"outcome"];
            [request setPostValue:myDelegate.loginName forKey:@"username"];
            [request setPostValue:self.selectt forKey:@"assign"];
            [request setPostValue:myDelegate.processId forKey:@"processId"];
            [request setPostValue:txt.text forKey:@"empno"];
            
            [request setDelegate:self];
            [request setDidFinishSelector:@selector(GetResult:)];
            [request setDidFailSelector:@selector(GetErr:)];
            [request setTimeOutSeconds:20];
            [request setNumberOfTimesToRetryOnTimeout:2];
            [request startAsynchronous];

        }
        
    }
}
-(void)GetResult_type:(ASIFormDataRequest *)request{
    [tooles removeHUD];
    //接受字符串集
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSArray *loginJson = [all objectForKey:@"loginJson"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLRefuseType *view = [storyboard instantiateViewControllerWithIdentifier:@"refuseType"];
    [view setPersonList:loginJson];
    [view setUsername:self.selectt];
    [self.navigationController pushViewController:view animated:YES];
}
-(void) GetErr:(ASIHTTPRequest *)request{
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
    [tooles removeHUD];
}

-(void)GetResult:(ASIFormDataRequest *)request{
    [tooles removeHUD];
    //接受字符串集
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSDictionary *loginJson = [all objectForKey:@"loginJson"];
    NSString *result = [loginJson objectForKey:@"result"];
    if([result isEqualToString:@"success"]){
        [tooles MsgBox:@"提交成功！"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *path = [NSString stringWithFormat:@"%@/%@",documentDirectory,myDelegate.FBBusinessName];
        if([fileManager fileExistsAtPath:path]){
            [fileManager removeItemAtPath:path error:nil];
        }

        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-4] animated:YES];
    }else{
        [tooles MsgBox:result];
    }
    
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
