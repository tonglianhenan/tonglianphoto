//
//  TLRecallTableViewController.m
//  TongLian
//
//  Created by mac on 14-3-20.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLRecallTableViewController.h"

@interface TLRecallTableViewController ()

@end

@implementation TLRecallTableViewController

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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLRCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLRCell"];
    NSDictionary *dic = [self.list objectAtIndex:indexPath.row];
    cell.bname.text = [dic objectForKey:@"bname"];
    cell.service.text = [dic objectForKey:@"service"];
    if(![[dic objectForKey:@"add"] isKindOfClass:[NSNull class]]){
        cell.add.text =[dic objectForKey:@"add"];
    }
    else{
        cell.add.text = @"未填写";
    }
    if(![[dic objectForKey:@"con"] isKindOfClass:[NSNull class]]){
        cell.con.text =[dic objectForKey:@"con"];
    }
    else{
        cell.con.text = @"未填写";
    }
    if([dic objectForKey:@"bn"]!=nil && ![[dic objectForKey:@"bn"] isKindOfClass:[NSNull class]] ){
        cell.bn.text =[dic objectForKey:@"bn"];
    }
    else{
        cell.bn.text = @"未填写";
    }
    if([dic objectForKey:@"ben"]!=nil && ![[dic objectForKey:@"ben"] isKindOfClass:[NSNull class]] ){
        cell.ben.text =[dic objectForKey:@"ben"];
    }
    else{
        cell.ben.text = @"未填写";
    }
    if([dic objectForKey:@"nn"]!=nil && ![[dic objectForKey:@"nn"] isKindOfClass:[NSNull class]] ){
        cell.nn.text =[dic objectForKey:@"nn"];
    }
    else{
        cell.nn.text = @"未填写";
    }
    if([dic objectForKey:@"nen"]!=nil && ![[dic objectForKey:@"nen"] isKindOfClass:[NSNull class]] ){
        cell.nen.text =[dic objectForKey:@"nen"];
    }
    else{
        cell.nen.text = @"未填写";
    }
    if([dic objectForKey:@"rn"]!=nil && ![[dic objectForKey:@"rn"] isKindOfClass:[NSNull class]] ){
        cell.rn.text =[dic objectForKey:@"rn"];
    }
    else{
        cell.rn.text = @"未填写";
    }
    if([dic objectForKey:@"ren"]!=nil && ![[dic objectForKey:@"ren"] isKindOfClass:[NSNull class]] ){
        cell.ren.text =[dic objectForKey:@"ren"];
    }
    else{
        cell.ren.text = @"未填写";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.list objectAtIndex:indexPath.row];
    NSString *endpointid = [dic objectForKey:@"id"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLRecallPhotoViewController *recall =[storyboard instantiateViewControllerWithIdentifier:@"recallPhoto"];
    [recall setEndpointID:endpointid];
    [self.navigationController pushViewController:recall animated:YES];
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
