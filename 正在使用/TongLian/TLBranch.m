//
//  TLBranch.m
//  TongLian
//
//  Created by mac on 13-9-16.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLBranch.h"

@implementation TLBranch

-(id)initWithName:(NSString *)name{
    self = [self init];
    _branchName = name;
    NSArray *listOfKeys = [NSArray arrayWithObjects:@"门头",@"收银台",@"经营场所",@"仓库", nil];
    NSArray *listOfObjects = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    _place = [NSMutableDictionary dictionaryWithObjects:listOfObjects forKeys:listOfKeys];
   
    NSMutableArray *ob = [NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];
    
    NSMutableArray *mentou = [NSMutableArray arrayWithObjects:@"门头1",@"门头2",@"门头3", nil];
    NSMutableArray *shouyintai = [NSMutableArray arrayWithObjects:@"收银台1",@"收银台2",@"收银台3", nil];
    NSMutableArray *jingyingchangsuo = [NSMutableArray arrayWithObjects:@"经营场所1",@"经营场所2",@"经营场所3", nil];
    NSMutableArray *cangku = [NSMutableArray arrayWithObjects:@"仓库1",@"仓库2",@"仓库3", nil];
    
    NSMutableDictionary *mt = [NSMutableDictionary dictionaryWithObjects:ob forKeys:mentou];
    NSMutableDictionary *syt = [NSMutableDictionary dictionaryWithObjects:ob forKeys:shouyintai];
    NSMutableDictionary *jycs = [NSMutableDictionary dictionaryWithObjects:ob forKeys:jingyingchangsuo];
    NSMutableDictionary *ck = [NSMutableDictionary dictionaryWithObjects:ob forKeys:cangku];
    
    [_place setValue:mt forKey:@"门头"];
    [_place setValue:syt forKey:@"收银台"];
    [_place setValue:jycs forKey:@"经营场所"];
    [_place setValue:ck forKey:@"仓库"];
    return self;
}
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.branchName forKey:@"branchNamekey"];
    [encoder encodeObject:self.place forKey:@"placekey"];
}

-(id)initWithCoder:(NSCoder *)decoder{
    self.branchName = [decoder decodeObjectForKey:@"branchNamekey"];
    self.place = [decoder decodeObjectForKey:@"placekey"];
    return self;
}

@end
