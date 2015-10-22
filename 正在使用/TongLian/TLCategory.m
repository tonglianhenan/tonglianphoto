//
//  TLCategory.m
//  TongLian
//
//  Created by mac on 15-1-12.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import "TLCategory.h"

@interface TLCategory ()

@end

@implementation TLCategory

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(IBAction)mentou_click:(id)sender{
    NSString *s = @"门头";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLPhotoList *changsuo = [storyboard instantiateViewControllerWithIdentifier:@"myPhotoList"];
    [changsuo setChangsuo:s];
    [changsuo setBusinessId:self.businessId];
    [changsuo setBusinessName:self.businessName];
    [self.navigationController pushViewController:changsuo animated:YES];
    
}
-(IBAction)jinyingchangsuo_click:(id)sender{
    NSString *s = @"经营场所";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLPhotoList *changsuo = [storyboard instantiateViewControllerWithIdentifier:@"myPhotoList"];
    [changsuo setChangsuo:s];
    [changsuo setBusinessId:self.businessId];
    [changsuo setBusinessName:self.businessName];
    [self.navigationController pushViewController:changsuo animated:YES];
}
-(IBAction)shouyintai_click:(id)sender{
    NSString *s = @"收银台";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLPhotoList *changsuo = [storyboard instantiateViewControllerWithIdentifier:@"myPhotoList"];
    [changsuo setChangsuo:s];
    [changsuo setBusinessId:self.businessId];
    [changsuo setBusinessName:self.businessName];
    [self.navigationController pushViewController:changsuo animated:YES];
}
-(IBAction)gongdanzhengmian_click:(id)sender{
    NSString *s = @"工单正面";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLPhotoList *changsuo = [storyboard instantiateViewControllerWithIdentifier:@"myPhotoList"];
    [changsuo setChangsuo:s];
    [changsuo setBusinessId:self.businessId];
    [changsuo setBusinessName:self.businessName];
    [self.navigationController pushViewController:changsuo animated:YES];
}
-(IBAction)gongdanfanmian_click:(id)sender{
    NSString *s = @"工单反面";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLPhotoList *changsuo = [storyboard instantiateViewControllerWithIdentifier:@"myPhotoList"];
    [changsuo setChangsuo:s];
    [changsuo setBusinessId:self.businessId];
    [changsuo setBusinessName:self.businessName];
    [self.navigationController pushViewController:changsuo animated:YES];
}
-(IBAction)qita_click:(id)sender{
    NSString *s = @"其他";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLPhotoList *changsuo = [storyboard instantiateViewControllerWithIdentifier:@"myPhotoList"];
    [changsuo setChangsuo:s];
    [changsuo setBusinessId:self.businessId];
    [changsuo setBusinessName:self.businessName];
    [self.navigationController pushViewController:changsuo animated:YES];
}
-(IBAction)submit:(id)sender{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    TLFnotSubmit *changsuo = [storyboard instantiateViewControllerWithIdentifier:@"fnotSubmit"];
    [self.navigationController pushViewController:changsuo animated:YES];

//    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
//    NSString *s = nil;
//    if([myDelegate.FBPList count]==0){
//        s = @"所有照片都已上传或者尚未拍照";
//        [tooles MsgBox:s];
//    }else{
//        s = [NSString stringWithFormat:@"共有%d张照片尚未提交，确认全部提交？",[myDelegate.FBPList count]];
//    }
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:s delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alert show];
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"IOSimageUpload"];
        NSURL *url = [NSURL URLWithString:urlstr];
        self.sflag = [myDelegate.FBPList count];
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
        [tooles removeHUD];
        [tooles MsgBox:@"上传成功！请提交或驳回您的装机反馈任务！"];
        [self.navigationController popViewControllerAnimated:YES];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
