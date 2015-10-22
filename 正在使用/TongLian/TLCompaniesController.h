//
//  TLCompaniesController.h
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-30.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TLCompany;
@interface TLCompaniesController : NSObject

@property (nonatomic, copy) NSMutableArray *companies;
- (NSUInteger)countOfList;
- (TLCompany *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addToListWithComany:(TLCompany *)company;
@end
