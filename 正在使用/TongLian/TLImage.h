//
//  TLImage.h
//  TongLian
//
//  Created by mac on 13-9-26.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "UIImage+WaterMark.h"
#import "UIImage+Category/wiUIImage+Category.h"
#import "UIImage+Category/wiUIImageView+Category.h"
#import "tooles.h"
#import "TLAppDelegate.h"

#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface TLImage : NSObject<NSCoding,CLLocationManagerDelegate>
@property (nonatomic,strong) NSString *directory;
@property (nonatomic)CLLocationManager *locationManager;
@property (nonatomic)NSString *latitude;
@property (nonatomic)NSString *longitude;
@property (nonatomic)NSString *address;
@property (nonatomic)UIImage *image;
@property (nonatomic)NSString *name;
@property (nonatomic)NSString *type;

-(id)initWithPath:(NSString *)path;
-(void)saveToFile:(UIImage *)image ImageName:(NSString *)name photoType:(NSString *)type;
-(NSString *)getFromFile:(NSString *)name;

-(void) encodeWithCoder:(NSCoder *)encoder;
-(id) initWithCoder:(NSCoder *)decoder;
@end
