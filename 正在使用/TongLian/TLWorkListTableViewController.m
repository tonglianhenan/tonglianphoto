//
//  TLWorkListViewController.m
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-29.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLWorkListTableViewController.h"

@interface TLWorkListTableViewController ()

@end

@implementation TLWorkListTableViewController

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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}
//
///*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//*/
//
///*
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}
//*/
//
///*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//}
//*/
//
///*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    switch (indexPath.row) {
        case 0:
            myDelegate.company.photoType =@"SITE";
            break;
        case 1:
            myDelegate.company.photoType =@"QUALIFICATION";
            break;
        case 2:
            myDelegate.company.photoType =@"QUALIFICATIONCOPY";
            break;
        case 3:
            myDelegate.company.photoType =@"AGREEMENT";
            break;
        case 4:
            myDelegate.company.photoType =@"HELPFARMERSGETCASH";
            break;
        case 5:
            myDelegate.company.photoType =@"CASHIERBAO";
            break;
        case 6:
            myDelegate.company.photoType =@"AGREEMENTREALNAME";
            break;
        case 7:
            myDelegate.company.photoType =@"AGREEMENTALLINPAY";
            break;
        case 8:
            myDelegate.company.photoType =@"LEADERSIGN";
            break;
        case 9:
            myDelegate.company.photoType =@"TONGLIANBAO";
        default:
            break;
    }
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    if([myDelegate.company.photoType isEqualToString:@"AGREEMENTREALNAME"]){
        TLNetTypeTableViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"netType"];
        [self.navigationController pushViewController:view animated:YES];
    }
    else{
    TLPhotoListViewController *viewcontroller =[storyboard instantiateViewControllerWithIdentifier:@"photoList"];
    [self.navigationController pushViewController:viewcontroller animated:YES];
    }
}

@end
