//
//  TLFBPhotoViewController.m
//  TongLian
//
//  Created by mac on 14-6-19.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLFBPhotoViewController.h"

@interface TLFBPhotoViewController ()

@end

@implementation TLFBPhotoViewController

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
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(add)];
    self.navigationItem.rightBarButtonItem=add;
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.i=1;
    self.x1 = 12;
    self.x2 =20;
    self.y1 = 12;
    self.y2 = 100;
    self.width1 = 90;
    self.width2 = 80;
    self.height1 = 81;
    self.height2 = 30;

        for(NSDictionary *dic in myDelegate.FBPList)
        {
            NSArray *a= [dic allKeys];
            NSString *name = [a objectAtIndex:0];
            NSObject *object = [dic objectForKey:name];
            UIButton *button= [[UIButton alloc]init];
            button.frame = CGRectMake(self.x1, self.y1, self.width1, self.height1);
            if([object isKindOfClass:[TLImage class]]){
                //转换成缩略图，减少内存压力
                TLImage *image = (TLImage *)object;
                //NSLog(@"photoType====%@",self.photoType);
                //NSLog(@"image.directory===%@",image.directory);
                UIImage *myImg = [UIImage imageWithContentsOfFile:[image getFromFile:name]];
                UIImage *nn;
                CGSize asize = CGSizeMake(self.width1, self.height1);
                UIGraphicsBeginImageContext(asize);
                [myImg drawInRect:CGRectMake(0, 0, self.width1, self.height1)];
                nn=UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                [button setBackgroundImage:nn forState:UIControlStateNormal];
                
            }
            else if([object isKindOfClass:[NSMutableDictionary class]])
            {
                button.tag = 2;
                [button setBackgroundImage:[UIImage imageNamed:@"folder.png"] forState:UIControlStateNormal];
            }else
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
    CGFloat y;
    if(self.i%3==1){
        y = self.y1+180;
    }
    else{
        y = self.y1 + 236;
    }
    if(self.i>1){
        UIButton *button= [[UIButton alloc]init];
        button.frame = CGRectMake(130, y+10, 70, 40);
        [button setBackgroundImage:[UIImage imageNamed:@"提交.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(submit_click:event:) forControlEvents:UIControlEventTouchUpInside];
        self.myTag = self.myTag + 1;
        [button setTag:self.myTag];
        [self.scrollView addSubview:button];
    }


    // Do any additional setup after loading the view.
}
-(void)submit_click:(id)sender event:(id)event{
    self.flag = 0;
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"IOSimageUpload"];
    NSURL *url = [NSURL URLWithString:urlstr];
    self.sflag = [self getNum:myDelegate.FBPList];
    [tooles showHUD:@"正在上传！"];
    for(NSDictionary *dic in myDelegate.FBPList){
        NSArray *a= [dic allKeys];
        NSString *name = [a objectAtIndex:0];
        NSObject *object = [dic objectForKey:name];
        
        if([object isKindOfClass:[TLImage class]]){
            TLImage *image = (TLImage *)object;
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            NSString *namee = [NSString stringWithFormat:@"%@[%@]",name,myDelegate.processId];
            
            
            [request setPostValue:name forKey:@"tag"];
            [request setFile:[image getFromFile:name] forKey:@"imageFile"];
            [request setPostValue:@"FIXASSURE" forKey:@"category"];
            [request setPostValue:self.businessId forKey:@"businessId"];
            [request setPostValue:namee forKey:@"name"];
            
            [request setDelegate:self];
            [request setDidFailSelector:@selector(GetErr:)];
            [request setDidFinishSelector:@selector(GetResult:)];
            [request setTimeOutSeconds:20];
            [request setNumberOfTimesToRetryOnTimeout:2];
            [request startAsynchronous];
            //request = nil;
            [NSThread sleepForTimeInterval:0.5];
        }
    }
}
-(int)getNum:(NSArray *)array{
    int i=0;
    for(NSDictionary *dic in array){
        NSArray *a = [dic allKeys];
        NSString *name = [a objectAtIndex:0];
        NSObject *object = [dic objectForKey:name];
        if([object isKindOfClass:[TLImage class]]){
            i++;
        }
    }
    return i;
}

-(void) GetErr:(ASIHTTPRequest *)request{
    if(self.flag == 0)
    {
        [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
        [tooles removeHUD];
        self.flag = 1;
        return;
    }
}

-(void)GetResult:(ASIFormDataRequest *)request{
    //接受字符串集
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSDictionary *loginJson = [all objectForKey:@"loginJson"];
    NSString *tag = [loginJson objectForKey:@"tag"];
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if(tag!=nil&&tag.length!=0){
        int num = [self getNum:myDelegate.FBPList :tag];
        [myDelegate.FBPList removeObjectAtIndex:num];
    }
    
    self.sflag = self.sflag - 1;
    if(self.flag == 0 && self.sflag == 0)
    {
        myDelegate.feedbackflag =@"YES";
        UIButton *myButton = (UIButton *)[self.scrollView viewWithTag:101+2*self.count];
        [myButton removeFromSuperview];
        [tooles removeHUD];
        [tooles MsgBox:@"上传成功！请提交或驳回您的装机反馈任务！"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)button_click:(id)sender event:(id)event{
    UIButton *button = (UIButton *)sender;
    self.photoName = button.titleLabel.text;
    //照片已经存在
    if(button.tag ==0){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TLShowImageViewController *imageView =[storyboard instantiateViewControllerWithIdentifier:@"imageshow"];
        [imageView setImageName:button.titleLabel.text];
        [self.navigationController pushViewController:imageView animated:YES];
    }
    //照片不存在，调用手机相机进行拍照
    else if(button.tag == 1)
    {
        self.myButton = button;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.delegate = self;
        picker.allowsEditing = YES;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    //多张照片，即本层为文件夹，点击进入照片列表
    else if(button.tag == 2){
        
    }
}
//完成拍照响应事件
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
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
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];

    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",documentDirectory,@"feedback"];
    TLImage *image = [[TLImage alloc]initWithPath:path];
    [image saveToFile:myImage ImageName:self.photoName photoType:@"SITE"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:image forKey:self.photoName];
    
   int num = [self getNum:myDelegate.FBPList :self.photoName];
    
    //保存图片
    [myDelegate.FBPList replaceObjectAtIndex:num withObject:dic];
    
    
}
-(int)getNum:(NSArray *)array :(NSString *)key{
    int i = 0;
    for(NSDictionary *dic in array){
        NSArray *a = [dic allKeys];
        NSString *name = [a objectAtIndex:0];
        if([name isEqualToString:key]){
            break;
        }
        i++;
    }
    return i;
}
//长按删除
-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    self.myButton = (UIButton *)gestureRecognizer.view;
    if(self.myButton.tag == 0)
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
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        [dictionary setObject:@"0" forKey:self.myButton.titleLabel.text];
        
        int num = [self getNum:myDelegate.FBPList :self.photoName];
        [myDelegate.FBPList replaceObjectAtIndex:num withObject:dictionary];
        
    }
}
//添加一张图片
-(void)add
{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    if([myDelegate.FBPList count]==7){
        [tooles MsgBox:@"对不起！已达到照片最大限制！"];
        return;
    }
    NSString *name = [NSString  stringWithFormat:@"其他%d",([myDelegate.FBPList count]-1)];
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
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:@"0" forKey:name];
    [myDelegate.FBPList addObject:dictionary];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
