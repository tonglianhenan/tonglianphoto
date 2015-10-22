//
//  TLReaderViewController.m
//  TongLian
//
//  Created by mac on 14-3-17.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLReaderViewController.h"

@interface TLReaderViewController ()

@end

@implementation TLReaderViewController
@synthesize resultText,resultImage,myButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    [myButton setTitle:@"" forState:UIControlStateSelected];
    return self;
}
- (IBAction) scanButtonTapped
{
    // ADD: present a barcode reader that scans from the camera feed
//    ZBarReaderViewController *reader = [ZBarReaderViewController new];
//    reader.readerDelegate = self;
//    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//    
//    ZBarImageScanner *scanner = reader.scanner;
//    // TODO: (optional) additional reader configuration here
//    
//    // EXAMPLE: disable rarely used I2/5 to improve performance
//    [scanner setSymbology: ZBAR_I25
//                   config: ZBAR_CFG_ENABLE
//                       to: 0];
//    
//    // present and release the controller
//    [self presentViewController:reader animated:YES completion:nil];
}
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        // EXAMPLE: just grab the first barcode
//        break;
//    
//    // EXAMPLE: do something useful with the barcode data
//    resultText.text = symbol.data;
//    //[myButton setTitle:@"查询" forState:UIControlStateNormal];
//    [myButton setBackgroundImage:[UIImage imageNamed:@"sumbit.png"] forState:UIControlStateNormal];
//    // EXAMPLE: do something useful with the barcode image
//    resultImage.image =
//    [info objectForKey: UIImagePickerControllerOriginalImage];
//    
//    // ADD: dismiss the controller (NB dismiss from the *reader*!)
//    [reader dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(IBAction)button_click:(id)sender{
    NSLog(@"go");
    if(resultText.text.length!=0){
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"businessVisit"];
        NSURL *myurl = [NSURL URLWithString:urlstr];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
        
        [tooles showHUD:@"请稍候！"];
        [request setPostValue:resultText.text forKey:@"sntag"];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(GetResult:)];
        [request setDidFailSelector:@selector(GetErr:)];
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
    NSArray *loginJson = [all objectForKey:@"loginJson"];
    NSLog(@"%@",loginJson);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    TLRecallTableViewController *recall =[storyboard instantiateViewControllerWithIdentifier:@"recall"];
//    [recall setList:loginJson];
//    [self.navigationController pushViewController:recall animated:YES];
//    for(NSDictionary *userMap in loginJson)
//    {
//    //开通服务
//    NSString *services = [userMap objectForKey:@"service"];
//    //受理
//    NSString *bn = [userMap objectForKey:@"bn"];
//    NSString *ben = [userMap objectForKey:@"ben"];
//    //网络
//    NSString *nn = [userMap objectForKey:@"nn"];
//    NSString *nen = [userMap objectForKey:@"nen"];
//    //新型
//    NSString *rn = [userMap objectForKey:@"rn"];
//    NSString *ren = [userMap objectForKey:@"ren"];
//    //装机地址
//    NSString *add = [userMap objectForKey:@"add"];
//    //联系人
//    NSString *con = [userMap objectForKey:@"con"];
//    //分店名
//    NSString *bname = [userMap objectForKey:@"bname"];
//    //主机
//    NSString *sntag =[userMap objectForKey:@"sntag"];
//    //商户id
//    NSString *businessid = [userMap objectForKey:@"businessid"];
//    
//    NSLog(@"service:%@",services);
//    NSLog(@"bn:%@",bn);
//    NSLog(@"ben:%@",ben);
//    NSLog(@"nn:%@",nn);
//    NSLog(@"nen:%@",nen);
//    NSLog(@"rn:%@",rn);
//    NSLog(@"ren:%@",ren);
//    NSLog(@"add:%@",add);
//    NSLog(@"con:%@",con);
//    NSLog(@"bname:%@",bname);
//    NSLog(@"sntag:%@",sntag);
//    NSLog(@"businessid:%@",businessid);
//    }
}

- (void) GetErr:(ASIHTTPRequest *)request{
    
    [tooles removeHUD];
    
    [tooles MsgBox:@"网络错误,连接不到服务器"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
