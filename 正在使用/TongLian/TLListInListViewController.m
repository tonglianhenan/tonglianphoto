//
//  TLListInListViewController.m
//  TongLian
//
//  Created by mac on 13-9-26.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLListInListViewController.h"

@interface TLListInListViewController ()

@end

@implementation TLListInListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.myScrollView.scrollEnabled = YES;
    [self.myScrollView setContentSize:CGSizeMake(320, 2000)];
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(add)];
    self.navigationItem.rightBarButtonItem=add;
    
    NSMutableDictionary *photoDictionary = [self getDictionary];
    NSArray *myArray = [photoDictionary allKeys];
    myArray = [myArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    self.i=1;
    self.x1 = 12;
    self.x2 =20;
    self.y1 = 12;
    self.y2 = 100;
    self.width1 = 90;
    self.width2 = 80;
    self.height1 = 81;
    self.height2 = 30;
    if(self.netType !=nil){
    for(NSString *name1 in myArray)
    {
        NSRange range = [name1 rangeOfString:@"-"];
        NSString *name=nil;
        if(range.length >0){
            name = name1;
            NSLog(@"baohan");
        }else{
            name = [NSString stringWithFormat:@"%@-%@",self.netType,name1];
        }
        NSObject *object = [photoDictionary objectForKey:name];
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
        [self.myScrollView addSubview:button];
        [self.myScrollView addSubview:label];
        
    }
    }else{
        for(NSString *name in myArray)
        {
            NSObject *object = [photoDictionary objectForKey:name];
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
            [self.myScrollView addSubview:button];
            [self.myScrollView addSubview:label];
            
        }
    }
}
-(NSMutableDictionary *)getDictionary
{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    TLCompany *company = myDelegate.company;
    NSString *photoType = company.photoType;
    self.photoType = company.photoType;
    if([photoType isEqualToString:@"SITE"])
    {
        return [company.changsuo objectForKey:self.dictionnaryName];
    }
    else if([photoType isEqualToString:@"AGREEMENTALLINPAY"]){
        return [company.newpay objectForKey:self.dictionnaryName];
    }
    else if([photoType isEqualToString:@"QUALIFICATION"])
    {
        return [company.zizhi objectForKey:self.dictionnaryName];
    }
    else if([photoType isEqualToString:@"QUALIFICATIONCOPY"])
    {
        return [company.install objectForKey:self.dictionnaryName];
    }
    else if([photoType isEqualToString:@"HELPFARMERSGETCASH"])
    {
        return [company.agricultural objectForKey:self.dictionnaryName];
    }
    else if([photoType isEqualToString:@"CASHIERBAO"])
    {
        return [company.cashierbao objectForKey:self.dictionnaryName];
    }
    else if([photoType isEqualToString:@"AGREEMENT"])
    {
        return [company.market objectForKey:self.dictionnaryName];
    }
    else if([photoType isEqualToString:@"AGREEMENTREALNAME"])
    {
        return [company.netpay objectForKey:self.dictionnaryName];
    }
    else if([photoType isEqualToString:@"LEADERSIGN"])
    {
        return [company.leadersign objectForKey:self.dictionnaryName];
    }
    else if([photoType isEqualToString:@"TONGLIANBAO"])
    {
        return [company.tonglianbao objectForKey:self.dictionnaryName];
    }

    else{
        return nil;
    }
}
-(void)button_click:(id)sender event:(id)event{
    UIButton *button = (UIButton *)sender;
    self.photoName = button.titleLabel.text;
    //照片已经存在
    if(button.tag ==0){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        TLImageViewController *imageView =[storyboard instantiateViewControllerWithIdentifier:@"imageSelect"];
        [imageView setName:button.titleLabel.text];
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
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self synchro:[info objectForKey:UIImagePickerControllerOriginalImage]];
    //\[tooles MsgBox:@"照片信息处理中，请稍后！"];
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
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@",myDelegate.company.assetsDirectory,myDelegate.company.name,self.photoType];
    TLImage *image = [[TLImage alloc]initWithPath:path];

    [image saveToFile:myImage ImageName:self.photoName photoType:self.photoType];
    
    //保存到已存在图片列表
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:self.photoType  forKey:path];
    [myDelegate.company.photoExist setObject:dic forKey:self.photoName];
    
    //保存到未上传图片列表
    [myDelegate.company.notSubmmit setObject:dic forKey:self.photoName];

    
    NSMutableDictionary *dictionary = [self getDictionary];
    [dictionary setObject:image forKey:self.photoName];
    //保存一个删除一个
    if(self.netType !=nil){
     NSArray *arry=[self.photoName componentsSeparatedByString:@"-"];
    [dictionary removeObjectForKey:arry[1]];
    }else{
        [dictionary setObject:image forKey:self.photoName];
    }
    
    [self setDictionary:dictionary];
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
-(void)setDictionary:(NSMutableDictionary *)dic
{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    if([self.photoType isEqualToString:@"SITE"])
    {
        [myDelegate.company.changsuo setObject:dic forKey:self.dictionnaryName];
    }
    else if([self.photoType isEqualToString:@"AGREEMENTALLINPAY"]){
        [myDelegate.company.newpay setObject:dic forKey:self.dictionnaryName];
    }
    else if([self.photoType isEqualToString:@"QUALIFICATION"])
    {
        [myDelegate.company.zizhi setObject:dic forKey:self.dictionnaryName];
    }
    else if([self.photoType isEqualToString:@"QUALIFICATIONCOPY"])
    {
        [myDelegate.company.install setObject:dic forKey:self.dictionnaryName];
    }
    else if([self.photoType isEqualToString:@"HELPFARMERSGETCASH"])
    {
        [myDelegate.company.agricultural setObject:dic forKey:self.dictionnaryName];
    }
    else if([self.photoType isEqualToString:@"CASHIERBAO"])
    {
        [myDelegate.company.cashierbao setObject:dic forKey:self.dictionnaryName];
    }
    else if([self.photoType isEqualToString:@"AGREEMENT"])
    {
        [myDelegate.company.market setObject:dic forKey:self.dictionnaryName];
    }
    else if([self.photoType isEqualToString:@"AGREEMENTREALNAME"]){
        [myDelegate.company.netpay setObject:dic forKey:self.dictionnaryName];
    }
    else if([self.photoType isEqualToString:@"LEADERSIGN"]){
        [myDelegate.company.leadersign setObject:dic forKey:self.dictionnaryName];
    }
    else if([self.photoType isEqualToString:@"TONGLIANBAO"]){
        [myDelegate.company.tonglianbao setObject:dic forKey:self.dictionnaryName];
    }


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
        NSMutableDictionary *dictionary = [self getDictionary];
        [dictionary setObject:@"0" forKey:self.myButton.titleLabel.text];
        [self setDictionary:dictionary];
        //从已存在照片中删除
        [myDelegate.company.photoExist removeObjectForKey:self.myButton.titleLabel.text];
        //从未上传图片列表中删除
        [myDelegate.company.notSubmmit removeObjectForKey:self.myButton.titleLabel.text];
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
//添加一张图片
-(void)add
{
    NSMutableDictionary *dictionary = [self getDictionary];
    NSString *name = self.dictionnaryName;
    if(self.netType){
        name = [NSString stringWithFormat:@"%@-%@",self.netType,name];
    }
    name = [name stringByAppendingString:[NSString stringWithFormat:@"%lu",[dictionary count]+1]];
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
    [self.myScrollView addSubview:button];
    [self.myScrollView addSubview:label];
    [self synchroWithName:name];
}
//添加一张照片同步到系统
-(void)synchroWithName:(NSString *)name{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSMutableDictionary *dictionary = [self getDictionary];
    [dictionary setObject:@"0" forKey:name];
    [self setDictionary:dictionary];
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
