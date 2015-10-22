//
//  TLPhotoExistViewController.m
//  TongLian
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLPhotoExistViewController.h"

@interface TLPhotoExistViewController ()

@end

@implementation TLPhotoExistViewController

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
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentSize:CGSizeMake(320, 2000)];
//    UIBarButtonItem *add = [[UIBarButtonItem alloc]
//                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
//                            target:self
//                            action:@selector(add)];
//    self.navigationItem.rightBarButtonItem=add;
    
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //NSString *sss = @"0";
    self.i=1;
    self.x1 = 12;
    self.x2 =20;
    self.y1 = 12;
    self.y2 = 100;
    self.width1 = 90;
    self.width2 = 60;
    self.height1 = 81;
    self.height2 = 30;
    
    NSMutableDictionary *exist = myDelegate.company.photoExist;
    for(NSString *name in [exist allKeys]){
//        NSMutableDictionary *dic = [exist objectForKey:name];
//        NSArray *array = [dic allKeys];
//        NSString *path = [array objectAtIndex:0];
//        NSString *mpath = [NSString stringWithFormat:@"%@/%@.png",path,name];
        
        NSMutableDictionary *dic = [exist objectForKey:name];
        NSArray *array = [dic allKeys];
        NSString *path = [array objectAtIndex:0];
        myDelegate.company.photoType = [dic objectForKey:path];
        
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        TLCompany *myCom = myDelegate.company;
        
        NSString *mpath = [NSString stringWithFormat:@"%@/%@/%@/%@.png",myCom.assetsDirectory,myCom.name,myCom.photoType,name];
        
        //转换成缩略图，减少内存压力
        UIButton *button= [[UIButton alloc]init];
        button.frame = CGRectMake(self.x1, self.y1, self.width1, self.height1);
        UIImage *myImg = [UIImage imageWithContentsOfFile:mpath];
        UIImage *nn;
        CGSize asize = CGSizeMake(self.width1, self.height1);
        UIGraphicsBeginImageContext(asize);
        [myImg drawInRect:CGRectMake(0, 0, self.width1, self.height1)];
        nn=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [button setBackgroundImage:nn forState:UIControlStateNormal];

        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(self.x2, self.y2, self.width2, self.height2);
        label.text = name;
        UIFont *font = [UIFont fontWithName:@"Arial" size:10];
        [label setFont:font];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        [label setNumberOfLines:0];
        label.textAlignment = NSTextAlignmentCenter;
        
        if(self.i%3==1||self.i%3==2){
            self.x1 = self.x1+103;
            self.x2 = self.x2+108;
        }
        if(self.i%3==0){
            self.y1 = self.y1+118;
            self.x1 = self.x1-206;
            
            self.y2 = self.y2+118;
            self.x2 = self.x2-216;
        }
        self.i = self.i+1;
        [self.scrollView addSubview:button];
        [self.scrollView addSubview:label];
        
    }
    if(self.i == 1){
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, 10, 250, 30);
        label.text = @"尚未拍照！";
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        [label setFont:font];
        label.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:label];
    }
   	// Do any additional setup after loading the view.
}
-(void) button_click:(id)sender event:(id)event{
    NSLog(@"ffff");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
