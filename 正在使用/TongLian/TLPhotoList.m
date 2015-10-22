//
//  TLPhotoList.m
//  TongLian
//
//  Created by mac on 15-1-12.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import "TLPhotoList.h"

@interface TLPhotoList ()

@end

@implementation TLPhotoList

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
    NSMutableDictionary *changsuo = [myDelegate.replyDic objectForKey:self.changsuo];
    
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
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentDirectory = [paths objectAtIndex:0];
            
            NSString *mpath = [NSString stringWithFormat:@"%@/%@/%@.png",documentDirectory,myDelegate.FBBusinessName,name];
            UIImage *myImg = [UIImage imageWithContentsOfFile:mpath];
          
//            TLImage *image = (TLImage *)object;
//            UIImage *myImg = [UIImage imageWithContentsOfFile:[image getFromFile:name]];
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
        TLShowImageViewController *imageView =[storyboard instantiateViewControllerWithIdentifier:@"imageshow"];
        NSString *pname = [NSString stringWithFormat:@"%@",button.titleLabel.text];
        [imageView setImageName:pname];
        [imageView setBusinessId:self.businessId];
        [imageView setBusinessName:self.businessName];
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
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        [dictionary setObject:@"0" forKey:self.myButton.titleLabel.text];
        
        int num = [self getNum:myDelegate.FBPList :self.photoName];
        [myDelegate.FBPList removeObjectAtIndex:num];
        
        //保存到回访列表
        NSMutableDictionary *dicc = [myDelegate.replyDic objectForKey:self.changsuo];
        [dicc setObject:@"0" forKey:self.photoName];
        [myDelegate.replyDic setObject:dicc forKey:self.changsuo];

    }
}
-(int)getNum:(NSArray *)array :(NSString *)key{
    int i = 0;
    for(NSDictionary *dic in array){
        NSArray *a = [dic allKeys];
        NSString *name = [a objectAtIndex:0];
        if([name isEqualToString:key]){
            return i;
        }
        i++;
    }
    return i;
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
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",documentDirectory,self.businessName];
    TLImage *image = [[TLImage alloc]initWithPath:path];
    [image saveToFile:myImage ImageName:self.photoName photoType:@"SITE"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:image forKey:self.photoName];
    
    //int num = [self getNum:myDelegate.FBPList :self.photoName];
    
    //保存图片
    [myDelegate.FBPList addObject:dic];
    //保存到回访列表
    NSMutableDictionary *dicc = [myDelegate.replyDic objectForKey:self.changsuo];
    [dicc setObject:image forKey:self.photoName];
    [myDelegate.replyDic setObject:dicc forKey:self.changsuo];

    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//添加一张图片
-(void)add
{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *dicc = [myDelegate.replyDic objectForKey:self.changsuo];
    NSString *name = self.changsuo;
    name = [name stringByAppendingString:[NSString stringWithFormat:@"%d",[dicc count]+1]];
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
//    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
//    [dictionary setObject:@"0" forKey:name];
//    [myDelegate.FBPList addObject:dictionary];
    
    NSMutableDictionary *dic = [myDelegate.replyDic objectForKey:self.changsuo];
    [dic setObject:@"0" forKey:name];
    [myDelegate.replyDic setObject:dic forKey:self.changsuo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
