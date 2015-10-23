//
//  TLAppDelegate.h
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-14.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLCompany.h"
#import "Reachability.h"
#import <CoreLocation/CoreLocation.h>
#import "UIImage+WaterMark.h"
#import "UIImage+Category/wiUIImage+Category.h"
#import "UIImage+Category/wiUIImageView+Category.h"
#import "tooles.h"
#import "TLRecallEntity.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface TLAppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>{
    NSMutableArray *companyList;
    TLCompany *company;
    TLRecallEntity *recall;
    NSString *loginName;
    NSString *URL;
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) Reachability *hostReach;
@property Boolean isReachable;
@property NSInteger flag;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *companyList;
@property (strong, nonatomic) TLCompany *company;
@property (strong, nonatomic) NSString *loginName;
@property (strong, nonatomic) NSString *URL;
@property (strong, nonatomic) NSString *userType;
//服务器配置
@property (strong, nonatomic) NSDictionary *ServerDic;

//装机反馈是否拍照
@property (strong, nonatomic) NSString *feedbackflag;

//装机反馈拍照列表
@property (strong, nonatomic) NSMutableArray *FBPList;

//装机反馈任务ID
@property (strong, nonatomic) NSString *processId;

//定位地址信息
@property (strong, nonatomic) NSString *address;


//装机反馈信息
@property (strong,nonatomic) NSMutableDictionary *replyDic;
//装机反馈商户名称
@property (strong,nonatomic) NSString *FBBusinessName;
//装机反馈商户Id
@property (strong,nonatomic) NSString *FBBusinessId;

//选择部门员工返回view
@property (strong,nonatomic)NSString *backView;
//删除index
@property int index;

//T+0类型，T+0或者助农取款
@property (strong,nonatomic)NSString *tType;

//商户回访
@property (strong,nonatomic)TLRecallEntity *recall;
@property (strong,nonatomic)NSString *snCode;
@property (strong,nonatomic)NSString *employeeNo;
@property (strong,nonatomic)NSString *recallURL;
@property (strong,nonatomic)NSString *recallMentouURL;

@end

