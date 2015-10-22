//
//  TLPhotoListViewController.m
//  TongLian
//
//  Created by mac on 13-9-26.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLPhotoListViewController.h"

@interface TLPhotoListViewController ()

@end

@implementation TLPhotoListViewController

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
    self.myScrollView.scrollEnabled = YES;
    [self.myScrollView setContentSize:CGSizeMake(320, 2000)];
    
    NSMutableDictionary *photoDictionary = [self getDictionary];
    NSArray *myArray = [self getArray];
    self.i=1;
    self.x1 = 12;
    self.x2 =20;
    self.y1 = 12;
    self.y2 = 100;
    self.width1 = 90;
    self.width2 = 60;
    self.height1 = 81;
    self.height2 = 30;
    if(self.netType !=nil){
        for(NSString *name1 in myArray)
        {
            [self.navigationItem setTitle:self.netType];
            NSString *name = [NSString stringWithFormat:@"%@-%@",self.netType,name1];
            NSObject *object = [photoDictionary objectForKey:name];
            UIButton *button= [[UIButton alloc]init];
            button.frame = CGRectMake(self.x1, self.y1, self.width1, self.height1);
            if([object isKindOfClass:[TLImage class]]){
                //转换成缩略图，减少内存压力
                TLImage *image = (TLImage *)object;
                UIImage *myImg = [UIImage imageWithContentsOfFile:[image getFromFile:name]];
                UIImage *nn;
                CGSize asize = CGSizeMake(self.width1, self.height1);
                UIGraphicsBeginImageContext(asize);
                [myImg drawInRect:CGRectMake(0, 0, self.width1, self.height1)];
                nn=UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                [button setBackgroundImage:nn forState:UIControlStateNormal];
                
            }
            else if([name1 isEqualToString:@"其他"]||[name1 isEqualToString:@"注册登记表"]||[name1 isEqualToString:@"租赁协议"])
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
            button = nil;
            label = nil;
        }
    }
    else{
        for(NSString *name in myArray)
        {
            NSObject *object = [photoDictionary objectForKey:name];
            UIButton *button= [[UIButton alloc]init];
            button.frame = CGRectMake(self.x1, self.y1, self.width1, self.height1);
            if([object isKindOfClass:[TLImage class]]){
                //转换成缩略图，减少内存压力
                TLImage *image = (TLImage *)object;
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
            button = nil;
            label = nil;
        }
    }
	// Do any additional setup after loading the view.
}
//长按删除
-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    self.myButton = (UIButton *)gestureRecognizer.view;
    self.photoName = self.myButton.titleLabel.text;
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
        self.myButton = nil;
    }
}

-(NSArray *)getArray
{
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    TLCompany *company = myDelegate.company;
    NSString *photoType = company.photoType;
    self.photoType = company.photoType;
    if([photoType isEqualToString:@"SITE"])
    {
        return [NSArray arrayWithObjects:@"门头",@"收银台",@"经营场所",@"仓库", nil];
    }
    else if([photoType isEqualToString:@"AGREEMENTALLINPAY"]){
        return [NSArray arrayWithObjects:@"协议首页",@"协议盖章页",@"注册登记表",@"结算帐户委托授权书", nil];
    }
    else if([photoType isEqualToString:@"QUALIFICATION"])
    {
        return [NSArray arrayWithObjects:@"法人身份证正面",@"法人身份证反面",@"税务登记证",@"营业执照",@"组织机构代码",@"生产许可证",@"道路运输许可证",@"行协资质",@"账户证明",@"被授权人身份证正面",@"被授权人身份证反面",@"其他", nil];
    }
    else if([photoType isEqualToString:@"QUALIFICATIONCOPY"])
    {
        return [NSArray arrayWithObjects:@"法人身份证复印件",@"税务登记证复印件",@"营业执照复印件",@"组织机构代码复印件",@"生产许可证复印件",@"道路运输许可证复印件",@"行协资质复印件",@"账户证明复印件",@"被授权人身份证复印件",@"其他", nil];
    }
    else if([photoType isEqualToString:@"HELPFARMERSGETCASH"])
    {
        return [NSArray arrayWithObjects:@"助农银行卡协议首页",@"助农银行卡协议手写页",@"助农银行卡协议盖章页",@"运营协议1",@"运营协议2",@"信息调查表1",@"信息调查表2",@"租赁协议",@"证明",@"其他", nil];
    }
    else if([photoType isEqualToString:@"CASHIERBAO"])
    {
        return [NSArray arrayWithObjects:@"信息调查表1",@"信息调查表2",@"结算账户使用委托授权书",@"结算账户设置声明",@"协议首页",@"协议盖章页",@"网络变更单",@"其他", nil];
    }

    else if([photoType isEqualToString:@"AGREEMENT"])
    {
        return [NSArray arrayWithObjects:@"协议首页",@"协议手写页",@"协议盖章页",@"信息调查表1",@"信息调查表2",@"信息调查表3",@"信息调查表4",@"补充协议",@"账户证明材料",@"租赁协议首页",@"租赁协议含租期页",@"租赁协议含租赁地址页",@"租赁协议盖章页",@"名录外市场准入说明",@"结算帐户委托授权书",@"总代合同",@"销售合同",@"其他", nil];
    }
    else if([photoType isEqualToString:@"AGREEMENTREALNAME"]){
        return [NSArray arrayWithObjects:@"协议首页",@"协议盖章页",@"注册登记表",@"账户证明材料",@"补充协议",@"结算账户委托授权书",@"租赁协议",@"其他", nil];
    }
    else if([photoType isEqualToString:@"LEADERSIGN"]){
        return [NSArray arrayWithObjects:@"优惠费率申请表",@"移动终端审批单",@"帐户设置说明",@"服务费审批单",@"上线流转单1",@"上线流转单2",@"风险评级表",@"装机申请单",@"网络支付商户非标单",@"商户调查表",@"协议合同(网络支付)",@"协议合同(新兴支付)",@"其他", nil];
    }
    else if([photoType isEqualToString:@"TONGLIANBAO"]){
        return [NSArray arrayWithObjects:@"通联宝",@"其他", nil];
    }
    else{
        return nil;
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
        return company.changsuo;
    }
    else if([photoType isEqualToString:@"AGREEMENTALLINPAY"]){
        return company.newpay;
    }
    else if([photoType isEqualToString:@"QUALIFICATION"])
    {
        return company.zizhi;
    }
    else if([photoType isEqualToString:@"QUALIFICATIONCOPY"])
    {
        return company.install;
    }
    else if([photoType isEqualToString:@"HELPFARMERSGETCASH"])
    {
        return company.agricultural;
    }
    else if([photoType isEqualToString:@"CASHIERBAO"])
    {
        return company.cashierbao;
    }
    else if([photoType isEqualToString:@"AGREEMENT"])
    {
        return company.market;
    }
    else if([photoType isEqualToString:@"AGREEMENTREALNAME"])
    {
        return company.netpay;
    }
    else if([photoType isEqualToString:@"LEADERSIGN"])
    {
        return company.leadersign;
    }
    else if([photoType isEqualToString:@"TONGLIANBAO"])
    {
        return company.tonglianbao;
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
        if(self.netType !=nil){
            NSArray *arry=[self.photoName componentsSeparatedByString:@"-"];
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            TLListInListViewController *listInList = [storyBoard instantiateViewControllerWithIdentifier:@"listInList"];
            [listInList setNetType:self.netType];
            [listInList setDictionnaryName:arry[1]];
            [self.navigationController pushViewController:listInList animated:YES];
        }
        else{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            TLListInListViewController *listInList = [storyBoard instantiateViewControllerWithIdentifier:@"listInList"];
            [listInList setNetType:self.netType];
            [listInList setDictionnaryName:self.photoName];
            [self.navigationController pushViewController:listInList animated:YES];
        }
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

    TLAppDelegate *myDelegate =(TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    
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
        [myDelegate.company setChangsuo:dic];
    }
    else if([self.photoType isEqualToString:@"AGREEMENTALLINPAY"]){
        [myDelegate.company setNewpay:dic];
    }
    else if([self.photoType isEqualToString:@"QUALIFICATION"])
    {
        [myDelegate.company setZizhi:dic];
    }
    else if([self.photoType isEqualToString:@"QUALIFICATIONCOPY"])
    {
        [myDelegate.company setInstall:dic];
    }
    else if([self.photoType isEqualToString:@"HELPFARMERSGETCASH"])
    {
        [myDelegate.company setAgricultural:dic];
    }
    else if([self.photoType isEqualToString:@"CASHIERBAO"])
    {
        [myDelegate.company setCashierbao:dic];
    }
    else if([self.photoType isEqualToString:@"AGREEMENT"])
    {
        [myDelegate.company setMarket:dic];
    }
    else if([self.photoType isEqualToString:@"AGREEMENTREALNAME"])
    {
        [myDelegate.company setNetpay:dic];
    }
    else if([self.photoType isEqualToString:@"LEADERSIGN"])
    {
        [myDelegate.company setLeadersign:dic];
    }
    else if([self.photoType isEqualToString:@"TONGLIANBAO"]){
        [myDelegate.company setTonglianbao:dic];
    }


}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
