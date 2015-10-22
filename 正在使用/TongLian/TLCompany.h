//
//  TLCompany.h
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-30.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLCompany : NSObject<NSCoding>{
    NSString *assetsDirectory;
    NSMutableDictionary *branch;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *assetsDirectory;

@property (nonatomic, strong) NSString *businessId;
@property (nonatomic, strong) NSString *processId;
@property (nonatomic, strong) NSString *processType;
@property (nonatomic, strong) NSString *photoType;
@property (nonatomic, strong) NSString *orderNum;
@property (nonatomic, strong) NSString *machineId;

@property (nonatomic, strong) NSMutableDictionary *branch;//分店
@property (nonatomic, strong) NSMutableDictionary *newpay;//新兴支付
@property (nonatomic, strong) NSMutableDictionary *changsuo;//场所
@property (nonatomic, strong) NSMutableDictionary *market;//受理市场
@property (nonatomic, strong) NSMutableDictionary *agricultural;//助农取款
@property (nonatomic, strong) NSMutableDictionary *cashierbao;//收银宝
@property (nonatomic, strong) NSMutableDictionary *netpay;//网络支付
@property (nonatomic, strong) NSMutableDictionary *zizhi;//资质原件
@property (nonatomic, strong) NSMutableDictionary *install;//资质复印件
@property (nonatomic, strong) NSMutableDictionary *leadersign;//领导签字
@property (nonatomic, strong) NSMutableDictionary *tonglianbao;//通联宝
@property (nonatomic, strong) NSNumber *tonglianbaoNum;
@property (nonatomic, strong) NSMutableDictionary *photoExist;//已拍照片
@property (nonatomic, strong) NSMutableDictionary *notSubmmit;//未上传图片
@property (nonatomic, strong) NSString *directSubmitTag;//收银宝，能否单户提交

- (BOOL)savePhoto:(UIImage *)image withPhotoName:(NSString *)photoName;
- (id)initWithName:(NSString *)name createdAt:(NSDate *)createdAt businessId:(NSString *)businessId processId:(NSString *)processId processType:(NSString *)processType;
-(void)initDictionary;

-(void) encodeWithCoder:(NSCoder *)encoder;
-(id) initWithCoder:(NSCoder *)decoder;
-(void)saveToFile;
-(void)removeFromFile;

+(id) getFromFileByName:(NSString *)name;
@end
