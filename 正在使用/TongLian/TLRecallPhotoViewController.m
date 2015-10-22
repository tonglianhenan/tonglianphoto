//
//  TLRecallPhotoViewController.m
//  TongLian
//
//  Created by mac on 14-3-25.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLRecallPhotoViewController.h"

@interface TLRecallPhotoViewController ()

@end

@implementation TLRecallPhotoViewController

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

-(IBAction)button1_click:(id)sender{
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
//完成拍照响应事件
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self synchro:[info objectForKey:UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//拍照完成同步到系统
-(void)synchro:(UIImage *)myImage{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];

    
    NSString *path = [NSString stringWithFormat:@"%@/%@",documentDirectory,@"回访单"];
    self.image = [[TLImage alloc]initWithPath:path];
    [self.image saveToFile:myImage ImageName:@"回访单" photoType:@"SITE"];
    
    //转换缩略图
    UIImage *nnn;
    CGSize bsize = CGSizeMake(320, 320);
    UIGraphicsBeginImageContext(bsize);
    [myImage drawInRect:CGRectMake(0, 0, 320, 320)];
    nnn=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.myImage setImage:nnn];
    [self.myButton setBackgroundImage:[UIImage imageNamed:@"sumbit.png"] forState:UIControlStateNormal];
    
    
}

-(IBAction)button2_click:(id)sender{
    if(self.image!=nil){
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"returnVisit"];
        //NSString *urlstr = [NSString stringWithFormat:@"http://10.88.1.51:8080/control/mobile/%@",@"returnVisit"];
        NSURL *myurl = [NSURL URLWithString:urlstr];
        [tooles showHUD:@"正在上传！请稍候！"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    
        NSString *path = [NSString stringWithFormat:@"%@/%@.png",self.image.directory,@"回访单"];
    
        [request setFile:path forKey:@"imageFile"];
        //[request setPostValue:self.endpointID forKey:@"businessBranchEndpointID"];
        //[request setPostValue:@"回访单" forKey:@"name"];
        [request setPostValue:myDelegate.loginName forKey:@"userlogin"];
    
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(GetResult:)];
        [request setDidFailSelector:@selector(GetErr:)];
        [request setTimeOutSeconds:20];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
        
    }
}
-(void)GetResult:(ASIHTTPRequest *)request{
    //接受字符串集
    [tooles removeHUD];
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *loginJson = [all objectForKey:@"loginJson"];
    NSString *result = [loginJson objectForKey:@"result"];
    if([result isEqualToString:@"success"])
    {
        NSString *path1 = [NSString stringWithFormat:@"%@",self.image.directory];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:path1]){
            [fileManager removeItemAtPath:path1 error:nil];
        }

        
        [tooles MsgBox:@"上传成功！"];
        [self.navigationController popViewControllerAnimated:YES];
        //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-4] animated:YES];
        
    }
    else{
        [tooles MsgBox:@"上传失败！请重新上传！"];
    }
    //NSLog(@"%@",loginJson);
    
}

- (void) GetErr:(ASIHTTPRequest *)request{
    [tooles removeHUD];
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
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
