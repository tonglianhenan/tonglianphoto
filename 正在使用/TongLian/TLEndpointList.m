//
//  TLEndpointList.m
//  TongLian
//
//  Created by mac on 14-12-24.
//  Copyright (c) 2014年 BoYunSen. All rights reserved.
//

#import "TLEndpointList.h"

@interface TLEndpointList ()

@end

@implementation TLEndpointList
@synthesize mytableview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mytableview.delegate = self;
    mytableview.dataSource = self;
    self.currentPage = 1;
   	// Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.recommanderList count]+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [self.recommanderList count]){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        if([self.recommanderList count]==0){
            cell.textLabel.text = @"暂时没有数据";
        }
        else if([self.recommanderList count]>19){
            cell.textLabel.text = @"查看更多";
        }
        
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
        return cell;
    }else{
        TLEndpointCell *cell = [tableView dequeueReusableCellWithIdentifier:@"endpointCell"];
        NSDictionary *dic = [self.recommanderList objectAtIndex:indexPath.row];
        if(![[dic objectForKey:@"endpointid"]isKindOfClass:[NSNull class]]){
            if([[dic objectForKey:@"endpointid"]isKindOfClass:[NSNumber class]]){
                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                NSString *num = [numberFormatter stringFromNumber:[dic objectForKey:@"endpointid"]];
                [cell.endpointid setText:num];
            }else{
                [cell.endpointid setText:[dic objectForKey:@"endpointid"]];
            }
        }
        if(![[dic objectForKey:@"endpointtype"]isKindOfClass:[NSNull class]]){
            [cell.endpointtype setText:[dic objectForKey:@"endpointtype"]];
        }
        if(![[dic objectForKey:@"markendpointnum"]isKindOfClass:[NSNull class]]){
            [cell.markendpointnum setText:[dic objectForKey:@"markendpointnum"]];
        }else{
            [cell.markendpointnum setText:@"未开通业务"];
        }
        if(![[dic objectForKey:@"netendpointnum"]isKindOfClass:[NSNull class]]){
            [cell.netendpointnum setText:[dic objectForKey:@"netendpointnum"]];
        }else{
            [cell.netendpointnum setText:@"未开通业务"];
        }
        if(![[dic objectForKey:@"newendpointnum"]isKindOfClass:[NSNull class]]){
            [cell.newendpointnum setText:[dic objectForKey:@"newendpointnum"]];
        }else{
            [cell.newendpointnum setText:@"未开通业务"];
        }
        if(![[dic objectForKey:@"postTelegrame"]isKindOfClass:[NSNull class]]&&![[dic objectForKey:@"postTelegrame"] isEqualToString:@""]&&[[dic objectForKey:@"postTelegrame"] length]!=0){
            if([[dic objectForKey:@"postTelegrame"]isKindOfClass:[NSNumber class]]){
                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                NSString *num = [numberFormatter stringFromNumber:[dic objectForKey:@"postTelegrame"]];
                [cell.postTelegrame setText:num];
            }else{
                [cell.postTelegrame setText:[dic objectForKey:@"postTelegrame"]];
            }
        }else{
            [cell.postTelegrame setText:@"未填写"];
        }
        [cell.endpointstatetype setText:[dic objectForKey:@"endpointstatetype"]];
        if([[dic objectForKey:@"endpointstatetype"] isEqualToString:@"正常"]){
            [cell.deal setTitle:@"拒装" forState:UIControlStateNormal];
            [cell.putOff setTitle:@"暂缓装机" forState:UIControlStateNormal];
        }else if(([[dic objectForKey:@"endpointstatetype"] isEqualToString:@"拒装"])){
            [cell.deal setTitle:@"取消拒装" forState:UIControlStateNormal];
            [cell.putOff setTitle:@"暂缓装机" forState:UIControlStateNormal];
        }else if([[dic objectForKey:@"endpointstatetype"] isEqualToString:@"暂缓装机"]){
            [cell.putOff setTitle:@"取消暂缓" forState:UIControlStateNormal];
            [cell.deal setTitle:@"拒装" forState:UIControlStateNormal];
        }
        
        [cell.deal addTarget:self action:@selector(deal_click:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.putOff addTarget:self action:@selector(putoff_click:event:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}
-(void) deal_click:(id)sender event:(id)event{
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:mytableview];
    NSIndexPath *indexPath = [mytableview indexPathForRowAtPoint:currentTouchPosition];
    NSDictionary *dic = [self.recommanderList objectAtIndex:indexPath.row];
    
    self.selectID = [dic objectForKey:@"endpointid"];
    NSString *message = nil;
    if([[dic objectForKey:@"endpointstatetype"] isEqualToString:@"正常"]){
        self.state = @"refuse";
        message = @"确定据装？";
    }else{
        self.state = @"notrefuse";
        message = @"取消据装？";
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:message message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

-(void) putoff_click:(id)sender event:(id)event{
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:mytableview];
    NSIndexPath *indexPath = [mytableview indexPathForRowAtPoint:currentTouchPosition];
    NSDictionary *dic = [self.recommanderList objectAtIndex:indexPath.row];
    
    self.selectID = [dic objectForKey:@"endpointid"];
    NSString *message = nil;
    if([[dic objectForKey:@"endpointstatetype"] isEqualToString:@"正常"]){
        self.state = @"putoffInstall";
        message = @"确定暂缓装机？";
    }else{
        self.state = @"cancelPutoff";
        message = @"取消暂缓装机？";
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:message message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,self.state];
        NSURL *url = [NSURL URLWithString:urlstr];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request setPostValue:self.selectID forKey:@"endpointid"];
        
        [request setDelegate:self];
        [request setDidFailSelector:@selector(GetErr:)];
        [request setDidFinishSelector:@selector(GetResult:)];
        [request setTimeOutSeconds:20];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];
    }
}
-(void) GetErr:(ASIHTTPRequest *)request{
    [tooles MsgBox:@"网络连接超时！当前网络状况差，请稍候再提交！"];
}
-(void)GetResult:(ASIFormDataRequest *)request{
    //接受字符串集
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    NSDictionary *dic = [all objectForKey:@"loginJson"];
    NSString *message = [dic objectForKey:@"result"];
    
    if([message boolValue]){
        [tooles MsgBox:@"操作成功！"];
        TLAppDelegate *myDelegate = (TLAppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *urlstr = [NSString stringWithFormat:@"%@/%@",myDelegate.URL,@"endpointList"];
        NSURL *url = [NSURL URLWithString:urlstr];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request setPostValue:self.branchId forKey:@"branchId"];
        
        [request setDelegate:self];
        [request setDidFailSelector:@selector(GetErr:)];
        [request setDidFinishSelector:@selector(GetResult2:)];
        [request setTimeOutSeconds:20];
        [request setNumberOfTimesToRetryOnTimeout:2];
        [request startAsynchronous];

    }else{
        [tooles MsgBox:message];
    }
}
-(void)GetResult2:(ASIFormDataRequest *)request{
    //接受字符串集
    NSError *error;
    NSString *str = [request responseString];
    [str UTF8String];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *all= [NSJSONSerialization JSONObjectWithData:data options:    NSJSONReadingMutableLeaves error:&error];
    self.recommanderList = [NSMutableArray arrayWithArray:[all objectForKey:@"loginJson"]];
    
    [self.mytableview reloadData];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
