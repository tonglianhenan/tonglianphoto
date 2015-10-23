//
//  TLAppDelegate.m
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-14.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLAppDelegate.h"

@implementation TLAppDelegate
@synthesize loginName,URL;
@synthesize recallURL,recallMentouURL;

//-(void) setURL:(NSString *)mURL{
//    URL = mURL;
//}
//-(NSString *)URL{
//    //广东URL
//    //return @"http://121.8.157.114:8888/control/mobile";
//    //
//    //return @"http://61.163.100.203:9999/control/mobile";
//    return @"http://10.88.0.129:8888/control/mobile";
//    //return @"http://61.163.100.203:8888/control/mobile";
//    //return @"http://10.88.1.51:8080/control/mobile";
//    //return @"http://10.88.80.10:9000/control/mobile";
//
//}
-(void) setCompanyList:(NSMutableArray *)mcompany{
    companyList = mcompany;
}
-(NSMutableArray *) companyList{
    if(companyList == nil){
        companyList = [[NSMutableArray alloc] init];
    }
    return companyList;
}

-(void) setCompany:(TLCompany *)mcompany{
    company = mcompany;
}
-(TLCompany *) company{
    if(company == nil){ 
        company= [[TLCompany alloc] init];
    }
    return company;
}

-(void) setRecall:(TLRecallEntity *)recallEntity{
    recall = recallEntity;
}

-(TLRecallEntity *)recall{
    if(recall == nil){
        recall = [[TLRecallEntity alloc]init];
    }
    return recall;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[self GetUpdate];
    
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    //开始监听，会启动一个run loop
    [self.hostReach startNotifier];
    self.flag = 0;
    //地理位置信息
    [self location];
    
    //recallURL = @"http://10.88.0.32:3080/control/mobile";
    //recallMentouURL = @"http://10.88.0.32:3080/control";
    
    recallURL = @"http://218.28.6.163:1970/control/mobile";
    recallMentouURL = @"http://218.28.6.163:1970/control";
    
    return YES;
}
-(void)location{
//    self.locationManager = [[CLLocationManager alloc]init];
//    self.locationManager.delegate = self;
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [self.locationManager startUpdatingLocation];
    
      if([CLLocationManager locationServicesEnabled]) {
          locationManager = [[CLLocationManager alloc] init];
          
          locationManager.delegate = self;
          
          //在ios 8.0下要授权
          NSLog(@"%f",[[[UIDevice currentDevice] systemVersion] floatValue]);
          if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
              NSLog(@"大于8.0");
              
              //定位服务是否可用
              BOOL enable=[CLLocationManager locationServicesEnabled];
              //是否具有定位权限
              int status=[CLLocationManager authorizationStatus];
              NSLog(@"status==%d",status);
              if(!enable || status<3){
                  //请求权限
                  [locationManager requestWhenInUseAuthorization];
              }
              
              //[self.locationManager requestWhenInUseAuthorization];  //前台定位，调用了这句,就会弹出允许框了.
              //[self.locationManager requestAlwaysAuthorization]; //在前后台定位
          }
          
          //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //控制定位精度,越高耗电量越大。

          [locationManager startUpdatingLocation];
          
      }else {        //提示用户无法进行定位操作
          [tooles MsgBox:@"无法获取定位信息"];
      }
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"location swicth，status＝＝%d",status);
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [locationManager requestWhenInUseAuthorization];
            
        }break;
        default:
        break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didupdatelocation");
    [locationManager stopUpdatingLocation];
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    
    //根据location获取详细地质
    CLGeocoder *clGeocoder = [[CLGeocoder alloc] init];
    
    [clGeocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray* placemarks, NSError* error)
     {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
         
         if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
             NSString *location = [ NSString stringWithFormat : @"地址:%@%@%@%@" ,  placemark. locality , placemark. subLocality ,placemark. thoroughfare , placemark. subThoroughfare ];
             self.address = location;
         }else{
         
             NSString *mark = placemark.description;
             NSArray *markList = [mark componentsSeparatedByString:@"@"];
             NSArray *addressList = [[markList objectAtIndex:0] componentsSeparatedByString:@","];
             NSString *s = [addressList objectAtIndex:1];
             NSLog(@"addressList==%@,s==%@",addressList,s);
             NSString *address = [s substringWithRange:NSMakeRange(6, s.length-7)];
             address = [NSString stringWithFormat:@"地址:%@",address];
             NSLog(@"定位信息:%@",address);
             self.address =address;
         }
    }];
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        [tooles MsgBox:@"locationManager error!"];
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}

//检查app是否为最新版本，750875946是app id
-(void)GetUpdate
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    NSString *nowVersion =[infoDict objectForKey:@"CFBundleShortVersionString"];
    
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=750875946"];
    NSString *file =  [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@",file);
    NSRange substr = [file rangeOfString:@"\"version\":\""];
    NSRange sub = NSMakeRange(substr.location+substr.length, 3);
    NSString *version = [file substringWithRange:sub];
    NSLog(@"nowversion==%@,getversion==%@",nowVersion,version);
    
   if([nowVersion isEqualToString:version]==NO)
    {
       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:
                             @"版本有更新:" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
        [alert show];
    }
    
}
//不是最新版本，跳转app store更新,750875946是app id
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/tonglian/id750875946?ls=1&mt=8"];
        [[UIApplication sharedApplication]openURL:url];
    }
}
//网络链接改变时会调用的方法
-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    self.isReachable = YES;
    if(self.flag == 1){
        if(status == NotReachable)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常" message:@"无法连接到网络！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            self.isReachable = NO;
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接信息" message:@"网络连接正常" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            self.isReachable = YES;
        }
    }
    self.flag = 1;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"becomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"pblist:%@",self.FBPList);
    NSMutableArray *ll = [[NSMutableArray alloc]init];
    for(NSDictionary *dic in self.FBPList){
        NSMutableDictionary *d = [[NSMutableDictionary alloc]init];
        [d setValue:@"1" forKey:[[dic allKeys] objectAtIndex:0]];
        [ll addObject:d];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/%@/FBPList.txt",documentDirectory,self.FBBusinessName];
    [ll writeToFile:path atomically:YES];
   

    NSMutableArray *list = [[NSMutableArray alloc]initWithContentsOfFile:path];
    NSLog(@"list:%@",list);

    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
