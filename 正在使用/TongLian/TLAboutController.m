//
//  TLAboutController.m
//  TongLian
//
//  Created by mac on 13-11-7.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLAboutController.h"

@interface TLAboutController ()

@end

@implementation TLAboutController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController setTitle:@"关于"];
    //[self.navigationController setTitle:@"关于"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSString *ss = [[[NSBundle mainBundle]infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
//    NSString *s = [NSString stringWithFormat:@"(version:%@)",ss];
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    NSString *nowVersion =[infoDict objectForKey:@"CFBundleShortVersionString"];
    [self.version setText:nowVersion];
	// Do any additional setup after loading the view.
}
-(IBAction)phone:(id)sender{
    NSString *phone = @"55199806";
    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",phone];
    NSURL *url = [[NSURL alloc] initWithString:telUrl];
    [[UIApplication sharedApplication] openURL:url];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
