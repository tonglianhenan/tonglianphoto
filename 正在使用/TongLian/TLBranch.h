//
//  TLBranch.h
//  TongLian
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLBranch : NSObject<NSCoding>

@property (strong, nonatomic) NSString *branchName;
@property (strong, nonatomic) NSMutableDictionary *place;

-(id)initWithName:(NSString *)name;

-(void) encodeWithCoder:(NSCoder *)encoder;
-(id) initWithCoder:(NSCoder *)decoder;

@end
