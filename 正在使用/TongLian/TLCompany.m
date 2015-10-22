//
//  TLCompany.m
//  TongLian
//
//  Created by Wang Xiaobo on 13-1-30.
//  Copyright (c) 2013年 BoYunSen. All rights reserved.
//

#import "TLCompany.h"

@implementation TLCompany

- (id)initWithName:(NSString *)name createdAt:(NSDate *)createdAt businessId:(NSString *)businessId processId:(NSString *)processId processType:(NSString *)processType
{
    self = [self init];
    _name = name;
    _createdAt = createdAt;
    
    _businessId = businessId;
    _processId = processId;
    _processType = processType;
    branch = [[NSMutableDictionary alloc] init];
    _tonglianbaoNum = [NSNumber numberWithInt:0];
    _directSubmitTag = @"0";
           
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //让assetsDirectory为沙盒。。／documents／公司名
    assetsDirectory = documentDirectory;
    
     //初始化新兴支付
    _newpay = [[NSMutableDictionary alloc] init];
    NSArray *newpaykeys = [NSArray arrayWithObjects:@"协议首页",@"协议盖章页",@"注册登记表",@"结算帐户委托授权书", nil];
    NSArray *newpayobjects = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    _newpay = [NSMutableDictionary dictionaryWithObjects:newpayobjects forKeys:newpaykeys];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:@"注册登记表1",@"注册登记表2",nil];
    NSMutableArray *value = [NSMutableArray arrayWithObjects:@"0",@"0",nil];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjects:value forKeys:mutableArray];
    [_newpay setValue:dic forKey:@"注册登记表"];
    
    //初始化场所
    _changsuo = [[NSMutableDictionary alloc]init];
    NSArray *changsuokeys = [NSArray arrayWithObjects:@"门头",@"收银台",@"经营场所",@"仓库", nil];
    NSArray *changsuoobjects = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    _changsuo = [NSMutableDictionary dictionaryWithObjects:changsuoobjects forKeys:changsuokeys];
    NSMutableArray *ob = [NSMutableArray arrayWithObjects:@"0",@"0",@"0", nil];
    
    NSMutableArray *mentou = [NSMutableArray arrayWithObjects:@"门头1",@"门头2",@"门头3", nil];
    NSMutableArray *shouyintai = [NSMutableArray arrayWithObjects:@"收银台1",@"收银台2",@"收银台3", nil];
    NSMutableArray *jingyingchangsuo = [NSMutableArray arrayWithObjects:@"经营场所1",@"经营场所2",@"经营场所3", nil];
    NSMutableArray *cangku = [NSMutableArray arrayWithObjects:@"仓库1",@"仓库2",@"仓库3", nil];
    
    NSMutableDictionary *mt = [NSMutableDictionary dictionaryWithObjects:ob forKeys:mentou];
    NSMutableDictionary *syt = [NSMutableDictionary dictionaryWithObjects:ob forKeys:shouyintai];
    NSMutableDictionary *jycs = [NSMutableDictionary dictionaryWithObjects:ob forKeys:jingyingchangsuo];
    NSMutableDictionary *ck = [NSMutableDictionary dictionaryWithObjects:ob forKeys:cangku];
    
    [_changsuo setObject:mt forKey:@"门头"];
    [_changsuo setObject:syt forKey:@"收银台"];
    [_changsuo setObject:jycs forKey:@"经营场所"];
    [_changsuo setObject:ck forKey:@"仓库"];

    //初始化受理市场
    _market = [[NSMutableDictionary alloc] init];
    NSArray *marketkeys = [NSArray arrayWithObjects:@"协议首页",@"协议手写页",@"协议盖章页",@"信息调查表1",@"信息调查表2",@"信息调查表3",@"信息调查表4",@"补充协议",@"账户证明材料",@"租赁协议首页",@"租赁协议含租期页",@"租赁协议含租赁地址页",@"租赁协议盖章页",@"名录外市场准入说明",@"结算帐户委托授权书",@"总代合同",@"销售合同",@"其他", nil];
    NSArray *marketobjects = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    _market = [NSMutableDictionary dictionaryWithObjects:marketobjects forKeys:marketkeys];
    
    NSMutableArray *marketob = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    NSMutableArray *xinxidiaochabiao = [NSMutableArray arrayWithObjects:@"信息调查表31",@"信息调查表32",@"信息调查表33",@"信息调查表34",nil];
    NSMutableArray *buchongxieyi = [NSMutableArray arrayWithObjects:@"补充协议1",@"补充协议2",@"补充协议3",@"补充协议4",nil];
    NSMutableArray *jiesuanweituo = [NSMutableArray arrayWithObjects:@"结算帐户委托授权书1",@"结算帐户委托授权书2",@"结算帐户委托授权书3",@"结算帐户委托授权书4", nil];
    NSMutableArray *zongdaihetong = [NSMutableArray arrayWithObjects:@"总代合同1",@"总代合同2",@"总代合同3",@"总代合同4", nil];
    NSMutableArray *xiaoshouhetong = [NSMutableArray arrayWithObjects:@"销售合同1",@"销售合同2",@"销售合同3",@"销售合同4", nil];
    NSMutableArray *qita = [NSMutableArray arrayWithObjects:@"其他1",@"其他2",@"其他3",@"其他4", nil];
    
    NSMutableDictionary *xxdcb = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:xinxidiaochabiao];
    NSMutableDictionary *bcxy = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:buchongxieyi];
    NSMutableDictionary *jswt = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:jiesuanweituo];
    NSMutableDictionary *zdht = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:zongdaihetong];
    NSMutableDictionary *xsht = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:xiaoshouhetong];
    NSMutableDictionary *qt = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:qita];
    
    [_market setObject:xxdcb forKey:@"信息调查表3"];
    [_market setObject:bcxy forKey:@"补充协议"];
    [_market setObject:jswt forKey:@"结算帐户委托授权书"];
    [_market setObject:zdht forKey:@"总代合同"];
    [_market setObject:xsht forKey:@"销售合同"];
    [_market setObject:qt forKey:@"其他"];
    
    //初始化助农取款
    _agricultural = [[NSMutableDictionary alloc]init];
    NSArray *agriculturalkeys = [NSArray arrayWithObjects:@"助农银行卡协议首页",@"助农银行卡协议手写页",@"助农银行卡协议盖章页",@"运营协议1",@"运营协议2",@"信息调查表1",@"信息调查表2",@"租赁协议",@"证明",@"其他", nil];
    NSArray *agriculturalobjects = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    _agricultural = [NSMutableDictionary dictionaryWithObjects:agriculturalobjects forKeys:agriculturalkeys];
    
    NSMutableArray *agriculturalkeyszulin = [NSMutableArray arrayWithObjects:@"租赁协议1",@"租赁协议2",@"租赁协议3",@"租赁协议4",nil];
    NSMutableArray *agriculturalqita = [NSMutableArray arrayWithObjects:@"其他1",@"其他2",@"其他3",@"其他4", nil];
    
    NSMutableDictionary *agzulin = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:agriculturalkeyszulin];
    NSMutableDictionary *agqita = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:agriculturalqita];
    
    [_agricultural setObject:agzulin forKey:@"租赁协议"];
    [_agricultural setObject:agqita forKey:@"其他"];
    
    
    //初始化收银宝
    _cashierbao = [[NSMutableDictionary alloc]init];
    NSArray *cashierbaokeys = [NSArray arrayWithObjects:@"信息调查表1",@"信息调查表2",@"结算账户使用委托授权书",@"结算账户设置声明",@"协议首页",@"协议盖章页",@"网络变更单",@"其他", nil];
    NSArray *cashierbaoobjects = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    _cashierbao= [NSMutableDictionary dictionaryWithObjects:cashierbaoobjects  forKeys:cashierbaokeys];
    
    NSMutableArray *cashierbaoqita = [NSMutableArray arrayWithObjects:@"其他1",@"其他2",@"其他3",@"其他4", nil];
    
    NSMutableDictionary *cbqita = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:cashierbaoqita];
    

    [_cashierbao setObject:cbqita forKey:@"其他"];



    
    //初始化资质原件
    _zizhi = [[NSMutableDictionary alloc]init];
    
    NSArray *zizhikeys = [NSArray arrayWithObjects:@"法人身份证正面",@"法人身份证反面",@"税务登记证",@"营业执照",@"组织机构代码",@"生产许可证",@"道路运输许可证",@"行协资质",@"账户证明",@"被授权人身份证正面",@"被授权人身份证反面",@"其他", nil];
    NSArray *zizhiobjects = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    _zizhi = [NSMutableDictionary dictionaryWithObjects:zizhiobjects forKeys:zizhikeys];
    
    NSMutableArray *shuiwudengji = [NSMutableArray arrayWithObjects:@"税务登记证1",@"税务登记证2",@"税务登记证3",@"税务登记证4",nil];
    NSMutableArray *hangxiezizhi = [NSMutableArray arrayWithObjects:@"行协资质1",@"行协资质2",@"行协资质3",@"行协资质4",nil];
    NSMutableArray *qita1 = [NSMutableArray arrayWithObjects:@"其他1",@"其他2",@"其他3",@"其他4", nil];
    NSMutableDictionary *qt1 = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:qita1];
    NSMutableDictionary *swdj = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:shuiwudengji];
    NSMutableDictionary *hxzz = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:hangxiezizhi];
    
    [_zizhi setObject:swdj forKey:@"税务登记证"];
    [_zizhi setObject:hxzz forKey:@"行协资质"];
    [_zizhi setObject:qt1 forKey:@"其他"];

    //初始化资质复印件
    _install = [[NSMutableDictionary alloc]init];
    
    NSArray *installkeys = [NSArray arrayWithObjects:@"法人身份证复印件",@"税务登记证复印件",@"营业执照复印件",@"组织机构代码复印件",@"生产许可证复印件",@"道路运输许可证复印件",@"行协资质复印件",@"账户证明复印件",@"被授权人身份证复印件",@"其他", nil];
    NSArray *installobjects = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    _install = [NSMutableDictionary dictionaryWithObjects:installobjects forKeys:installkeys];
    
    NSMutableArray *shuiwudengjif = [NSMutableArray arrayWithObjects:@"税务登记证1",@"税务登记证2",@"税务登记证3",@"税务登记证4",nil];
    NSMutableArray *hangxiezizhif = [NSMutableArray arrayWithObjects:@"行协资质1",@"行协资质2",@"行协资质3",@"行协资质4",nil];
    NSMutableArray *qita2 = [NSMutableArray arrayWithObjects:@"其他1",@"其他2",@"其他3",@"其他4", nil];
    NSMutableDictionary *qt2 = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:qita2];

    NSMutableDictionary *swdjf = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:shuiwudengjif];
    NSMutableDictionary *hxzzf = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:hangxiezizhif];
    
    [_install setObject:swdjf forKey:@"税务登记证复印件"];
    [_install setObject:hxzzf forKey:@"行协资质复印件"];
    [_install setObject:qt2 forKey:@"其他"];

    //初始化网络支付
    _netpay = [[NSMutableDictionary alloc] init];
    NSArray *netpaykeys = [NSArray arrayWithObjects:@"协议首页",@"协议盖章页",@"注册登记表",@"账户证明材料",@"补充协议",@"结算账户委托授权书",@"租赁协议",@"其他", nil];
    NSArray *netpayobjects = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    _netpay = [NSMutableDictionary dictionaryWithObjects:netpayobjects forKeys:netpaykeys];
    
    NSMutableArray *zhucedengji = [NSMutableArray arrayWithObjects:@"注册登记表1",@"注册登记表2",@"注册登记表3",@"注册登记表4",nil];
    NSMutableArray *zulinxieyi = [NSMutableArray arrayWithObjects:@"租赁协议1",@"租赁协议2",@"租赁协议3",@"租赁协议4", nil];
    NSMutableArray *qita3 = [NSMutableArray arrayWithObjects:@"其他1",@"其他2",@"其他3",@"其他4", nil];
    NSMutableDictionary *qt3 = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:qita3];
    NSMutableDictionary *zcdj = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:zhucedengji];
    NSMutableDictionary *zlxy = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:zulinxieyi];
        
    [_netpay setObject:zcdj forKey:@"注册登记表"];
    [_netpay setObject:zlxy forKey:@"租赁协议"];
    [_netpay setObject:qt3 forKey:@"其他"];

    //领导签字初始化
    _leadersign = [[NSMutableDictionary alloc]init];
    
    NSArray *leadersignkeys = [NSArray arrayWithObjects:@"优惠费率申请表",@"移动终端审批单",@"帐户设置说明",@"服务费审批单",@"上线流转单1",@"上线流转单2",@"风险评级表",@"装机申请单",@"网络支付商户非标单",@"商户调查表",@"协议合同(网络支付)",@"协议合同(新兴支付)",@"其他", nil];
    NSArray *leadersignobjects = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    _leadersign = [NSMutableDictionary dictionaryWithObjects:leadersignobjects forKeys:leadersignkeys];
    
    NSMutableArray *xieyihetongw = [NSMutableArray arrayWithObjects:@"协议合同(网络支付)1",@"协议合同(网络支付)2",@"协议合同(网络支付)3",@"协议合同(网络支付)4",nil];
    NSMutableArray *xieyihetongx = [NSMutableArray arrayWithObjects:@"协议合同(新兴支付)1",@"协议合同(新兴支付)2",@"协议合同(新兴支付)3",@"协议合同(新兴支付)4",nil];
    NSMutableArray *qita4 = [NSMutableArray arrayWithObjects:@"其他1",@"其他2",@"其他3",@"其他4", nil];
    NSMutableDictionary *qt4 = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:qita4];

    NSMutableDictionary *xyhtw = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:xieyihetongw];
    NSMutableDictionary *xyhtx = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:xieyihetongx];
    
    [_leadersign setObject:xyhtw forKey:@"协议合同(网络支付)"];
    [_leadersign setObject:xyhtx forKey:@"协议合同(新兴支付)"];
    [_leadersign setObject:qt4 forKey:@"其他"];

    
    //初始化通联宝
    _tonglianbao = [[NSMutableDictionary alloc]init];
    
    NSArray *tonglianbaokeys = [NSArray arrayWithObjects:@"通联宝",@"其他", nil];
    NSArray *tonglianbaoobjects = [NSArray arrayWithObjects:@"0",@"0", nil];
    _tonglianbao = [NSMutableDictionary dictionaryWithObjects:tonglianbaoobjects forKeys:tonglianbaokeys];
    
    NSMutableArray *tonglianbao = [NSMutableArray arrayWithObjects:@"通联宝1",@"通联宝2",@"通联宝3",@"通联宝4",nil];
    NSMutableDictionary *tlb = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:tonglianbao];
    
    NSMutableArray *qita5 = [NSMutableArray arrayWithObjects:@"其他1",@"其他2",@"其他3",@"其他4", nil];
    NSMutableDictionary *qt5 = [NSMutableDictionary dictionaryWithObjects:marketob forKeys:qita5];
    
    
    [_tonglianbao setObject:tlb forKey:@"通联宝"];
    [_tonglianbao setObject:qt5 forKey:@"其他"];

    
    //初始化已存在图片，默认为空
    self.photoExist = [[NSMutableDictionary alloc]init];
    
    //初始化未上传照片
    self.notSubmmit = [[NSMutableDictionary alloc]init];
    
    //保存到本地
    [self saveToFile];
    return self;
}
-(void) saveToFile{
    NSString *path = [NSString stringWithFormat:@"%@/%@.dat",self.assetsDirectory,self.name];
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
    NSString *path = [NSString stringWithFormat:@"%@/%@.dat",self.assetsDirectory,self.name];
    NSString *path1 = [NSString stringWithFormat:@"%@/%@",self.assetsDirectory,self.name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        [fileManager removeItemAtPath:path error:nil];
    }
    if([fileManager fileExistsAtPath:path1]){
        [fileManager removeItemAtPath:path1 error:nil];
    }

}
+(id) getFromFileByName:(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/%@.dat",documentDirectory,name];
    TLCompany *com = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if(com){
        return com;
    }
    else{
        return  nil;
    }
}

- (BOOL)savePhoto:(UIImage *)image withPhotoName:(NSString *)photoName
{
    //存储照片到沙盒
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.png",self.assetsDirectory,photoName];
    //NSLog(@"directory:%@",self.assetsDirectory);
    NSData *data = UIImageJPEGRepresentation(image, 0.005);
    //NSData *data = UIImagePNGRepresentation(image);
    //double length = data.length/1024;
    //NSLog(@"lentgh:%f",length);
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isCreated = [fileManager createDirectoryAtPath:self.assetsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    if (isCreated) {
        BOOL isSaved = [data writeToFile:filePath atomically:YES];
        return isSaved;
    }
    return NO;
}
-(void)initDictionary{
    //初始化新兴支付部分照片
    NSString *newpay = [self.assetsDirectory stringByAppendingPathComponent:@"新兴支付"];
    if([[NSFileManager defaultManager]fileExistsAtPath:newpay]){
        for(NSString *key in [self.newpay allKeys]){
            //注册登记表可以有多张照片，这是须按名字将存在的照片保存到全局变量中
            if([key isEqualToString:@"注册登记表"]){
                NSMutableArray *array = [self.newpay objectForKey:key];
                for(NSString *test in array){
                    NSString *temp = [NSString stringWithFormat:@"%@/%@.png",newpay,test];
                    if([[NSFileManager defaultManager] fileExistsAtPath:temp]){
                        NSData *data = [NSData dataWithContentsOfFile:temp];
                        UIImage *image = [[UIImage alloc] initWithData:data];
                        [array replaceObjectAtIndex:[array indexOfObject:test] withObject:image];
                    }
                }
                [self.newpay setValue:array forKey:key];
            }
            //除了注册登记表，都为单张图片，直接放入对应位置即可
            else{
                NSString *temp = [NSString stringWithFormat:@"%@/%@.png",newpay,key];
                if([[NSFileManager defaultManager] fileExistsAtPath:temp]){
                    NSData *data = [NSData dataWithContentsOfFile:temp];
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    [self.newpay setValue:image forKey:key];
                }
            }
        }
    }
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.name forKey:@"namekey"];
    [encoder encodeObject:self.createdAt forKey:@"createAtkey"];
    [encoder encodeObject:self.assetsDirectory forKey:@"assetsDirectorykey"];
    [encoder encodeObject:self.businessId forKey:@"businessIdkey"];
    [encoder encodeObject:self.processId forKey:@"processIdkey"];
    [encoder encodeObject:self.processType forKey:@"processTypekey"];
    [encoder encodeObject:self.newpay forKey:@"newpaykey"];
    [encoder encodeObject:self.branch forKey:@"branchkey"];
    [encoder encodeObject:self.photoType forKey:@"photoTypekey"];
    [encoder encodeObject:self.changsuo forKey:@"changsuotypekey"];
    [encoder encodeObject:self.market forKey:@"marketkey"];
    [encoder encodeObject:self.agricultural forKey:@"agricultural"];
    [encoder encodeObject:self.cashierbao forKey:@"cashierbaokey"];
    [encoder encodeObject:self.netpay forKey:@"netpaykey"];
    [encoder encodeObject:self.zizhi forKey:@"zizhikey"];
    [encoder encodeObject:self.install forKey:@"installkey"];
    [encoder encodeObject:self.leadersign forKey:@"leadersignkey"];
    [encoder encodeObject:self.photoExist forKey:@"photoExistkey"];
    [encoder encodeObject:self.notSubmmit forKey:@"notSubmmitkey"];
    [encoder encodeObject:self.orderNum forKey:@"orderNumkey"];
    [encoder encodeObject:self.machineId forKey:@"machineIdkey"];
    [encoder encodeObject:self.tonglianbao forKey:@"tonglianbaokey"];
    [encoder encodeObject:self.tonglianbaoNum forKey:@"tonglianbaoNumkey"];
    [encoder encodeObject:self.directSubmitTag forKey:@"directSubmitTagkey"];
}

-(id) initWithCoder:(NSCoder *)decoder{
    self.name = [decoder decodeObjectForKey:@"namekey"];
    self.createdAt = [decoder decodeObjectForKey:@"createAtkey"];
    self.assetsDirectory = [decoder decodeObjectForKey:@"assetsDirectorykey"];
    self.businessId = [decoder decodeObjectForKey:@"businessIdkey"];
    self.processId = [decoder decodeObjectForKey:@"processIdkey"];
    self.processType = [decoder decodeObjectForKey:@"processTypekey"];
    self.newpay = [decoder decodeObjectForKey:@"newpaykey"];
    self.branch = [decoder decodeObjectForKey:@"branchkey"];
    self.photoType = [decoder decodeObjectForKey:@"photoTypekey"];
    self.changsuo = [decoder decodeObjectForKey:@"changsuotypekey"];
    self.market = [decoder decodeObjectForKey:@"marketkey"];
    self.agricultural = [decoder decodeObjectForKey:@"agricultural"];
    self.cashierbao = [decoder decodeObjectForKey:@"cashierbaokey"];
    self.netpay = [decoder decodeObjectForKey:@"netpaykey"];
    self.zizhi = [decoder decodeObjectForKey:@"zizhikey"];
    self.install = [decoder decodeObjectForKey:@"installkey"];
    self.leadersign = [decoder decodeObjectForKey:@"leadersignkey"];
    self.photoExist = [decoder decodeObjectForKey:@"photoExistkey"];
    self.notSubmmit = [decoder decodeObjectForKey:@"notSubmmitkey"];
    self.orderNum = [decoder decodeObjectForKey:@"orderNumkey"];
    self.machineId = [decoder decodeObjectForKey:@"machineIdkey"];
    self.tonglianbao = [decoder decodeObjectForKey:@"tonglianbaokey"];
    self.tonglianbaoNum = [decoder decodeObjectForKey:@"tonglianbaoNumkey"];
    self.directSubmitTag = [decoder decodeObjectForKey:@"directSubmitTagkey"];
    return self;
}
-(void)setBranch:(NSMutableDictionary *)abranch{
    branch = abranch;
}
-(NSMutableDictionary *)branch{
    if(branch==nil){
        branch = [[NSMutableDictionary alloc]init];
    }
    return branch;
}
-(void)setAssetsDirectory:(NSString *)aassetsDirectory{
    assetsDirectory = aassetsDirectory;
}
-(NSString *)assetsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return documentDirectory;
}

@end
