//
//  TLCompaniesController.m
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-30.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLCompaniesController.h"
#import "TLCompany.h"
#import "TLAppDelegate.h"

@interface TLCompaniesController()
- (void) initializeDefaultList;
@end

@implementation TLCompaniesController

-(id)init {
    if (self = [super init]) {
        [self initializeDefaultList];
        return self;
    }
    return nil;
}

- (void)initializeDefaultList {
    TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication] delegate];
    [myDelegate.companyList removeAllObjects];
    NSMutableArray *companyList = [[NSMutableArray alloc] init];
    self.companies = companyList;
    TLCompany *company;
    //NSDate *today = [NSDate date];
    //company = [[TLCompany alloc] initWithName:@"BoYunSen" createdAt:today];
    TLCompany *com;
   // com = [[TLCompany alloc] initWithName:@"GKB" createdAt:today];
    [self addToListWithComany:company];
    [self addToListWithComany:com];
    [myDelegate.companyList addObject:company];
    [myDelegate.companyList addObject:com];
}

- (void)setCompanies:(NSMutableArray *)companies {
    if (_companies != companies) {
        _companies = [companies mutableCopy];
    }
}

- (NSUInteger)countOfList {
    return [self.companies count];
}

- (TLCompany *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.companies objectAtIndex:theIndex];
}

-(void)addToListWithComany:(TLCompany *)company {
    [self.companies addObject:company];
}
@end
