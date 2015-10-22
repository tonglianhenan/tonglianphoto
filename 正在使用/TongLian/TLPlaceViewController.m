//
//  TLPlaceViewController.m
//  TongLian
//
//  Created by mac on 13-9-22.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLPlaceViewController.h"

@interface TLPlaceViewController ()

@end

@implementation TLPlaceViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)click:(id)sender event:(id)event{
    UIButton *button = (UIButton *)sender;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLChangsuoViewController *changsuo = [storyboard instantiateViewControllerWithIdentifier:@"changsuo"];
    [changsuo setBranchName:self.branchName];
    [changsuo setChangsuo:button.titleLabel.text];
    [self.navigationController pushViewController:changsuo animated:YES];
}
@end
