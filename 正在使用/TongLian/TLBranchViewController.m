//
//  TLBranchViewController.m
//  TongLian
//
//  Created by mac on 13-9-17.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLBranchViewController.h"

@interface TLBranchViewController ()

@end

@implementation TLBranchViewController

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
    self.myScrollerView.scrollEnabled = YES;
    [self.myScrollerView setContentSize:CGSizeMake(320, 2000)];
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(addBranch)];
    self.navigationItem.rightBarButtonItem=add;
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *branachList = myDelegate.company.branch;
    NSArray *myArray = [branachList allKeys];
    myArray = [myArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];

    self.myTag = 100;
    self.i=1;
    self.x1 = 12;
    self.x2 =20;
    self.y1 = 12;
    self.y2 = 100;
    self.width1 = 90;
    self.width2 = 60;
    self.height1 = 81;
    self.height2 = 30;

    for (NSString *name in myArray) {
        UIButton *button= [[UIButton alloc]init];
        button.frame = CGRectMake(self.x1, self.y1, self.width1, self.height1);
        [button setBackgroundImage:[UIImage imageNamed:@"folder.png"] forState:UIControlStateNormal];
        button.titleLabel.text = name;
        [button addTarget:self action:@selector(button_click:event:) forControlEvents:UIControlEventTouchUpInside];
        //长按事件
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
        longPress.minimumPressDuration = 1; //定义按的时间
        [button addGestureRecognizer:longPress];
        self.myTag = self.myTag +1;
        [button setTag:self.myTag];

        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(self.x2, self.y2, self.width2, self.height2);
        label.text = name;
        self.myTag = self.myTag +1;
        [label setTag:self.myTag];
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
        [self.myScrollerView addSubview:button];
        [self.myScrollerView addSubview:label];
    }
    if(self.i == 1){
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, 10, 250, 30);
        label.text = @"点击右上角按钮添加一个分店！";
        [label setTag:1001];
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        [label setFont:font];
        label.textAlignment = NSTextAlignmentCenter;
        [self.myScrollerView addSubview:label];
    }

	// Do any additional setup after loading the view.
}
//长按删除
-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    self.myButton = (UIButton *)gestureRecognizer.view;
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:self.myButton.titleLabel.text message:@"确定删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
            [alert setTag:1];
            [alert show];
        }
}


-(void)addBranch{
    if(self.i ==1 ){
        UILabel *myLabel = (UILabel *)[self.myScrollerView viewWithTag:1001];
        [myLabel removeFromSuperview];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分店名称" message:@" " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"完成",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert setTag:2];
    [alert show];
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //删除分店处理
    if(alertView.tag == 1 && buttonIndex ==1)
    {
        //删除视图上所有元素（后边有viewDidLoad重新加载），不然tag有冲突
        for(int j=self.myTag;j>100;j=j-2)
        {
            UILabel *myLabel = (UILabel *)[self.myScrollerView viewWithTag:j];
            [myLabel removeFromSuperview];
            UIButton *myButton = (UIButton *)[self.myScrollerView viewWithTag:j-1];
            [myButton removeFromSuperview];
        }
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
        [myDelegate.company.branch removeObjectForKey:self. myButton.titleLabel.text];
        //同步到本地文件
        [myDelegate.company saveToFile];
        //同步到全局商户列表
        int a=0;
        for(TLCompany *company in myDelegate.companyList)
        {
            if([company.name isEqualToString:myDelegate.company.name]){
                break;
            }
            a = a+1;
        }
        [myDelegate.companyList replaceObjectAtIndex:a withObject:myDelegate.company];
        [self viewDidLoad];
    }
    //添加分店处理
    if(buttonIndex == 1 && alertView.tag==2)
    {
        UITextField *txt=[alertView textFieldAtIndex:0];
        UIButton *button= [[UIButton alloc]init];
        button.frame = CGRectMake(self.x1, self.y1, self.width1, self.height1);
        [button setBackgroundImage:[UIImage imageNamed:@"folder.png"] forState:UIControlStateNormal];
        button.titleLabel.text = txt.text;
        [button addTarget:self action:@selector(button_click:event:) forControlEvents:UIControlEventTouchUpInside];
        //长按事件
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
        longPress.minimumPressDuration = 1; //定义按的时间
        [button addGestureRecognizer:longPress];
        self.myTag = self.myTag+1;
        [button setTag:self.myTag];
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(self.x2, self.y2, self.width2, self.height2);
        label.text = txt.text;
        self.myTag = self.myTag+1;
        [label setTag:self.myTag];
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
        [self.myScrollerView addSubview:button];
        [self.myScrollerView addSubview:label];
        [self synchroWithName:txt.text];
    }
}

-(void)synchroWithName:(NSString *)name{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    TLBranch *branch = [[TLBranch alloc]initWithName:name];
    [myDelegate.company.branch setObject:branch forKey:branch.branchName];
    //同步到本地文件
    [myDelegate.company saveToFile];
    //同步到全局商户列表
    int a=0;
    for(TLCompany *company in myDelegate.companyList)
    {
        if([company.name isEqualToString:myDelegate.company.name]){
            break;
        }
        a = a+1;
    }
    [myDelegate.companyList replaceObjectAtIndex:a withObject:myDelegate.company];
}

-(void)button_click:(id)sender event:(id)event{
    UIButton *button = (UIButton *)sender;
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLPlaceViewController *place = [stroyboard instantiateViewControllerWithIdentifier:@"place"];
    [place setBranchName:button.titleLabel.text];
    [self.navigationController pushViewController:place animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
