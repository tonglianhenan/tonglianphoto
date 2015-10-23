//
//  TLRecallEntity.m
//  TongLian
//
//  Created by apple on 15/10/13.
//  Copyright (c) 2015年 BoYunSen. All rights reserved.
//

#import "TLRecallEntity.h"

@implementation TLRecallEntity

- (id)initWithName:(NSString *)name{
    self = [self init];
    self.sncode = name;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    assetsDirectory = documentDirectory;
    
    NSMutableArray *ob = [NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];
    
    _door = [[NSMutableDictionary alloc] init];
    NSMutableArray *mentou = [NSMutableArray arrayWithObjects:@"门头1",@"门头2",@"门头3", nil];
    _door = [NSMutableDictionary dictionaryWithObjects:ob forKeys:mentou];
    
    _visitinfo = [[NSMutableDictionary alloc] init];
    NSMutableArray *huifang = [NSMutableArray arrayWithObjects:@"商户回访1",@"商户回访2",@"商户回访3", nil];
    _visitinfo = [NSMutableDictionary dictionaryWithObjects:ob forKeys:huifang];

    _retreat = [[NSMutableDictionary alloc] init];
    NSMutableArray *cheji = [NSMutableArray arrayWithObjects:@"撤机单1",@"撤机单2",@"撤机单3", nil];
    _retreat = [NSMutableDictionary dictionaryWithObjects:ob forKeys:cheji];

    [self saveToFile];
    return self;
}

-(void)setAssetsDirectory:(NSString *)aassetsDirectory{
    assetsDirectory = aassetsDirectory;
}

-(NSString *)assetsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return documentDirectory;
}

+(id)getFromFileByName:(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/%@.dat",documentDirectory,name];
    TLRecallEntity *recall = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if(recall){
        return recall;
    }
    else{
        return  nil;
    }
}

-(void) saveToFile{
    NSString *path = [NSString stringWithFormat:@"%@/%@.dat",self.assetsDirectory,self.sncode];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        [fileManager removeItemAtPath:path error:nil];
    }
    
    BOOL archived = [NSKeyedArchiver archiveRootObject:self toFile:path];
    if(!archived){
        NSLog(@"NO");
    }
}

-(void)removeFromFile{
    NSString *path = [NSString stringWithFormat:@"%@/%@.dat",self.assetsDirectory,self.sncode];
    NSString *path1 = [NSString stringWithFormat:@"%@/%@",self.assetsDirectory,self.sncode];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        [fileManager removeItemAtPath:path error:nil];
    }
    if([fileManager fileExistsAtPath:path1]){
        [fileManager removeItemAtPath:path1 error:nil];
    }
}

- (BOOL)savePhoto:(UIImage *)image withPhotoName:(NSString *)photoName
{
    //存储照片到沙盒
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.png",self.assetsDirectory,photoName];
    NSData *data = UIImageJPEGRepresentation(image, 0.005);
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isCreated = [fileManager createDirectoryAtPath:self.assetsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    if (isCreated) {
        BOOL isSaved = [data writeToFile:filePath atomically:YES];
        return isSaved;
    }
    return NO;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.sncode forKey:@"sncodekey"];
    [encoder encodeObject:self.employeeNo forKey:@"employeeNokey"];
    [encoder encodeObject:self.photoType forKey:@"photoTypekey"];
    [encoder encodeObject:self.door forKey:@"doorkey"];
    [encoder encodeObject:self.visitinfo forKey:@"visitinfokey"];
    [encoder encodeObject:self.retreat forKey:@"retreatkey"];
}

-(id)initWithCoder:(NSCoder *)decoder{
    self.sncode = [decoder decodeObjectForKey:@"sncodekey"];
    self.employeeNo = [decoder decodeObjectForKey:@"employeeNokey"];
    self.photoType = [decoder decodeObjectForKey:@"photoTypekey"];
    self.door = [decoder decodeObjectForKey:@"doorkey"];
    self.visitinfo = [decoder decodeObjectForKey:@"visitinfokey"];
    self.retreat = [decoder decodeObjectForKey:@"retreatkey"];
    return self;
}



@end
