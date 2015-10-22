//
//  TLChangsuoViewController.m
//  TongLian
//
//  Created by mac on 13-9-22.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLChangsuoViewController.h"

@interface TLChangsuoViewController ()

@end

@implementation TLChangsuoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad{
    self.scrollView.scrollEnabled = YES;
    [self.scrollView setContentSize:CGSizeMake(320, 2000)];
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(add)];
    self.navigationItem.rightBarButtonItem=add;

    
    TLAppDelegate *myDelegate =(TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *branchList = myDelegate.company.branch;
    TLBranch *branch = [branchList objectForKey:self.branchName];
    NSMutableDictionary *changsuo = [branch.place objectForKey:self.changsuo];
    
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
    
    NSArray *myArray = [changsuo allKeys];
    myArray = [myArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    for(NSString *name in myArray)
    {
        NSObject *object = [changsuo objectForKey:name];
        UIButton *button= [[UIButton alloc]init];
        button.frame = CGRectMake(self.x1, self.y1, self.width1, self.height1);
        if([object isKindOfClass:[TLImage class]]){
            //转换成缩略图，减少内存压力
            TLImage *image = (TLImage *)object;
            NSString *pname = [NSString stringWithFormat:@"%@(%@)",name,self.branchName];
            UIImage *myImg = [UIImage imageWithContentsOfFile:[image getFromFile:pname]];
            UIImage *nn;
            CGSize asize = CGSizeMake(self.width1, self.height1);
            UIGraphicsBeginImageContext(asize);
            [myImg drawInRect:CGRectMake(0, 0, self.width1, self.height1)];
            nn=UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [button setBackgroundImage:nn forState:UIControlStateNormal];
        }
        else
        {
             button.tag = 1;
            [button setBackgroundImage:[UIImage imageNamed:@"photo.png"] forState:UIControlStateNormal];
        }
        button.titleLabel.text = name;
        [button addTarget:self action:@selector(button_click:event:) forControlEvents:UIControlEventTouchUpInside];
        //长按事件
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
        longPress.minimumPressDuration = 1; //定义按的时间
        [button addGestureRecognizer:longPress];
        
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

}
//照片点击事件
-(void)button_click:(id)sender event:(id)event{
    UIButton *button = (UIButton *)sender;
    self.photoName = button.titleLabel.text;
    //照片已经存在
    if(button.tag ==0){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TLImageViewController *imageView =[storyboard instantiateViewControllerWithIdentifier:@"imageSelect"];
        NSString *pname = [NSString stringWithFormat:@"%@(%@)",button.titleLabel.text,self.branchName];
        [imageView setName:pname];
        [self.navigationController pushViewController:imageView animated:YES];
    }
    //照片不存在，调用手机相机进行拍照
    else
    {
        self.myButton = button;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.delegate = self;
        //picker.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        [self presentViewController:picker animated:YES completion:nil];

    }
}
//长按删除
-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    self.myButton = (UIButton *)gestureRecognizer.view;
    self.photoName = self.myButton.titleLabel.text;
    if(self.myButton.tag != 1)
    {
        if(gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:self.myButton.titleLabel.text message:@"确定删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
            [alert show];
        }
    }
}
//长按事件弹出框处理
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self.myButton setBackgroundImage:[UIImage imageNamed:@"photo.png"] forState:UIControlStateNormal];
        [self.myButton setTag:1];
        //同步到系统
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
        TLBranch *branch = [myDelegate.company.branch objectForKey:self.branchName];
        NSMutableDictionary *dictionary = [branch.place objectForKey:self.changsuo];
        [dictionary setValue:@"0" forKey:self.myButton.titleLabel.text];
        [branch.place setValue:dictionary forKey:self.changsuo];
        [myDelegate.company.branch setObject:branch forKey:self.branchName];
        //从已存在照片中删除
        NSString *pname = [NSString stringWithFormat:@"%@(%@)",self.myButton.titleLabel.text,self.branchName];
        [myDelegate.company.photoExist removeObjectForKey:pname];
        //从未上传图片列表中删除
        [myDelegate.company.notSubmmit removeObjectForKey:pname];
        //保存至本地
        [myDelegate.company saveToFile];
        //保存至全局商户列表
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
}

//完成拍照响应事件
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //[tooles MsgBox:@"场所照片需要一定处理时间，5秒左右！"];
    [self synchro:[info objectForKey:UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//拍照完成同步到系统
-(void)synchro:(UIImage *)myImage{
    //转换成缩略图，减少内存压力
    UIImage *nn;
    CGSize asize = CGSizeMake(self.width1, self.height1);
    UIGraphicsBeginImageContext(asize);
    [myImage drawInRect:CGRectMake(0, 0, self.width1, self.height1)];
    nn=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self.myButton setBackgroundImage:nn forState:UIControlStateNormal];
    [self.myButton setTag:0];
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",myDelegate.company.assetsDirectory,myDelegate.company.name,@"SITE"];
    TLImage *image = [[TLImage alloc]initWithPath:path];
    NSString *pname = [NSString stringWithFormat:@"%@(%@)",self.photoName,self.branchName];
    NSLog(@"1111");
    [image saveToFile:myImage ImageName:pname photoType:@"SITE"];
    //保存到已存在图片列表
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"SITE"  forKey:path];
    [myDelegate.company.photoExist setObject:dic forKey:pname];
    //保存到未上传图片列表
    [myDelegate.company.notSubmmit setObject:dic forKey:pname];
    

    TLBranch *branch = [myDelegate.company.branch objectForKey:self.branchName];
    NSMutableDictionary *dictionary = [branch.place objectForKey:self.changsuo];
    [dictionary setValue:image forKey:self.photoName];
    [branch.place setValue:dictionary forKey:self.changsuo];
    [myDelegate.company.branch setObject:branch forKey:self.branchName];
     //保存至本地
    [myDelegate.company saveToFile];
     //保存至全局商户列表
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
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//添加一张图片
-(void)add
{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    TLBranch *branch = [myDelegate.company.branch objectForKey:self.branchName];
    NSMutableDictionary *dictionary = [branch.place objectForKey:self.changsuo];
    NSString *name = self.changsuo;
    name = [name stringByAppendingString:[NSString stringWithFormat:@"%d",[dictionary count]+1]];
    UIButton *button= [[UIButton alloc]init];
    button.frame = CGRectMake(self.x1, self.y1, self.width1, self.height1);
    button.tag = 1;
    [button setBackgroundImage:[UIImage imageNamed:@"photo.png"] forState:UIControlStateNormal];
    button.titleLabel.text = name;
    [button addTarget:self action:@selector(button_click:event:) forControlEvents:UIControlEventTouchUpInside];
    //长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 1; //定义按的时间
    [button addGestureRecognizer:longPress];
    
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
    [self synchroWithName:name];
}
//添加一张照片同步到系统
-(void)synchroWithName:(NSString *)name{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    TLBranch *branch = [myDelegate.company.branch objectForKey:self.branchName];
    NSMutableDictionary *dictionary = [branch.place objectForKey:self.changsuo];
    [dictionary setObject:@"0" forKey:name];
    [branch.place setValue:dictionary forKey:self.changsuo];
    [myDelegate.company.branch setObject:branch forKey:self.branchName];
    //保存至本地
    [myDelegate.company saveToFile];
    //保存至全局商户列表
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
