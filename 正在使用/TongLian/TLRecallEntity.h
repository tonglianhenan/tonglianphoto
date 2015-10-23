//
//  TLRecallEntity.h
//  TongLian
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLRecallEntity : NSObject<NSCopying>{
    NSString *assetsDirectory;
    NSString *sncode;
}

@property (nonatomic,strong) NSString *sncode;
@property (nonatomic,strong) NSString *employeeNo;
@property (nonatomic,strong) NSString *photoType;
@property (nonatomic,strong) NSMutableDictionary *door;
@property (nonatomic,strong) NSMutableDictionary *visitinfo;
@property (nonatomic,strong) NSMutableDictionary *retreat;

//@property (retain,nonatomic) NSString *businessName;
//@property (retain,nonatomic) NSString *bankName;
//@property (retain,nonatomic) NSString *contackPerson;
//@property (retain,nonatomic) NSString *contackPhone;
//@property (retain,nonatomic) NSString *posAddress;
//@property (retain,nonatomic) NSString *businessNum;
//@property (retain,nonatomic) NSString *endpointNum;
//@property (retain,nonatomic) NSString *endpointCount;

-(id)initWithName:(NSString *)name;
+(id)getFromFileByName:(NSString *)name;
-(void)saveToFile;
-(void)removeFromFile;
-(BOOL)savePhoto:(UIImage *)image withPhotoName:(NSString *)photoName;

@end
