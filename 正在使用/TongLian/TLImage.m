//
//  TLImage.m
//  TongLian
//
//  Created by mac on 13-9-26.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLImage.h"

@implementation TLImage
-(id)initWithPath:(NSString *)path{
    self = [self init];
    _directory = path;
    
    [self location];
    return self;
}
-(void)location{
    //    self.locationManager = [[CLLocationManager alloc]init];
    //    self.locationManager.delegate = self;
    //    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //    [self.locationManager startUpdatingLocation];
    
    if([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        
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
                [self.locationManager requestWhenInUseAuthorization];
            }
            
            //[self.locationManager requestWhenInUseAuthorization];  //前台定位，调用了这句,就会弹出允许框了.
            //[self.locationManager requestAlwaysAuthorization]; //在前后台定位
        }
        
        //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; //控制定位精度,越高耗电量越大。
        
        [self.locationManager startUpdatingLocation];
        
    }else {        //提示用户无法进行定位操作
        [tooles MsgBox:@"无法获取定位信息"];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"location swicth，status＝＝%d",status);
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [self.locationManager requestWhenInUseAuthorization];
                
            }break;
        default:
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didupdatelocation");
    [self.locationManager stopUpdatingLocation];
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
-(void)saveToFile:(UIImage *)image ImageName:(NSString *)name photoType:(NSString *)type{
    
    NSData *data;
    CGSize size;
    TLAppDelegate *mydelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    if([type isEqualToString:@"SITE"]){
        NSDate *now = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZZ"];
        NSString *strDate = [formatter stringFromDate:now];
        strDate = [NSString stringWithFormat:@"时间:%@",strDate];
        if(iPhone5){
            if(mydelegate.address!=nil&&mydelegate.address.length!=0){

//                image = [image imageWithStringWaterMark:mydelegate.address atPoint:CGPointMake(200,3200) color:[UIColor redColor] font:[UIFont systemFontOfSize:100]];
//                image =[image imageWithStringWaterMark:strDate atPoint:CGPointMake(200,3400) color:[UIColor redColor] font:[UIFont systemFontOfSize:100]];
                image = [image imageWithStringWaterMark2:mydelegate.address String:strDate atX1:200 atX2:200 color:[UIColor redColor] font:[UIFont systemFontOfSize:100]];

                
            }
        }else{
            if(mydelegate.address!=nil&&mydelegate.address.length!=0){

                
                image = [image imageWithStringWaterMark2:mydelegate.address String:strDate atX1:50 atX2:50 color:[UIColor redColor] font:[UIFont systemFontOfSize:80]];
                //image = [image imageWithStringWaterMark:mydelegate.address atPoint:CGPointMake(50,2300) color:[UIColor redColor] font:[UIFont systemFontOfSize:80]];
                //image = [image imageWithStringWaterMark:strDate atPoint:CGPointMake(50,2400) color:[UIColor redColor] font:[UIFont systemFontOfSize:80]];
                
            }
        }

    }
    //如果是资质原件或者复印件宽高比设置
    if([type isEqualToString:@"QUALIFICATION"]||[type isEqualToString:@"QUALIFICATIONCOPY"]){
        
        size = CGSizeMake(1365,1024);
    
    }
    else{
        size = CGSizeMake(1024,1365);
    }
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();

    float rate = 0.8;
    data = UIImageJPEGRepresentation(scaledImage, rate);
    //照片大小限于190k
    while ([data length]>190000) {
        rate = rate -0.05;
        data = UIImageJPEGRepresentation(scaledImage, rate);
    }
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [NSString stringWithFormat:@"%@/%@.png",self.directory,name];
    if([fileManager fileExistsAtPath:path]){
        [fileManager removeItemAtPath:path error:nil];
    }
    if([fileManager createDirectoryAtPath:self.directory withIntermediateDirectories:YES attributes:nil error:&error]){
        if(![data writeToFile:path atomically:YES]){
            NSLog(@"NO");
        }
    }
}
//-(UIImage *)addText:(UIImage *)img text:(NSString *)text1
//{
//    /////注：此为后来更改，用于显示中文。zyq,2013-5-8
//    CGSize size = CGSizeMake(img.size.width, img.size.height);          //设置上下文（画布）大小
//    UIGraphicsBeginImageContext(size);                       //创建一个基于位图的上下文(context)，并将其设置为当前上下文
//    CGContextRef contextRef = UIGraphicsGetCurrentContext(); //获取当前上下文
//    
//    CGAffineTransform normalState=CGContextGetCTM(contextRef);
//    
//    
//    CGContextTranslateCTM(contextRef, 0, img.size.height);   //画布的高度
//    CGContextScaleCTM(contextRef, 1.0, -1.0);                //画布翻转
//    CGContextDrawImage(contextRef, CGRectMake(0, 0, img.size.width, img.size.height), [img CGImage]);  //在上下文种画当前图片
//    
//    CGContextConcatCTM(contextRef, normalState);
//    
//    [[UIColor redColor] set];                                //上下文种的文字属性
//    CGContextTranslateCTM(contextRef, 0, img.size.height);
//    CGContextScaleCTM(contextRef, 1.0, -1.0);
//    UIFont *font = [UIFont boldSystemFontOfSize:16];
//    [text1 drawInRect:CGRectMake(0, 0, 200, 80) withFont:font];       //此处设置文字显示的位置
//    UIImage *targetimg =UIGraphicsGetImageFromCurrentImageContext();  //从当前上下文种获取图片
//    UIGraphicsEndImageContext();                            //移除栈顶的基于当前位图的图形上下文。
//    return targetimg;
//}

//-(void)location{
//    self.locationManager = [[CLLocationManager alloc]init];
//    self.locationManager.delegate = self;
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [self.locationManager startUpdatingLocation];
//}
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    [self.locationManager stopUpdatingLocation];
//    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
//    CLLocation *currentLocation = [locations lastObject];
//    
//    
//    //根据location获取详细地质
//    CLGeocoder *clGeocoder = [[CLGeocoder alloc] init];
//    
//    [clGeocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray* placemarks, NSError* error)
//     {
//         CLPlacemark *placemark = [placemarks objectAtIndex:0];
//         NSString *mark = placemark.description;
//         NSArray *markList = [mark componentsSeparatedByString:@"@"];
//         NSArray *addressList = [[markList objectAtIndex:0] componentsSeparatedByString:@","];
//         TLAppDelegate *mydelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
//         mydelegate.address =[addressList objectAtIndex:1];
//         NSLog(@"address=%@",[addressList objectAtIndex:1]);
//     }];
//    
//    
//}
//- (void)locationManager:(CLLocationManager *)manager
//didFailWithError:(NSError *)error {
//    if (error.code == kCLErrorDenied) {
//        [tooles MsgBox:@"locationManager error!"];
//        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
//    }
//}

-(NSString *)getFromFile:(NSString *)name{
    
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
    TLCompany *myCom = myDelegate.company;
    
    NSString *path = [NSString stringWithFormat:@"%@/%@/%@/%@.png",myCom.assetsDirectory,myCom.name,myCom.photoType,name];

    //NSString *path = [NSString stringWithFormat:@"%@/%@.png",self.directory,name];
    return path;
}
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.directory forKey:@"directorykey"];
}
-(id)initWithCoder:(NSCoder *)decoder{
    self.directory = [decoder decodeObjectForKey:@"directorykey"];
    return self;
}
@end
