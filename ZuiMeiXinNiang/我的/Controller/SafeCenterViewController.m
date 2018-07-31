//
//  SafeCenterViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/5/3.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "SafeCenterViewController.h"
#import "SafeTableViewCell.h"
#import "BDphoneViewController.h"
#import "BDChangeViewController.h"
#import "ChangePasswordViewController.h"
#import "FindViewController.h"

//友盟分享之绑定三方账号6.1
#import <UMSocialCore/UMSocialCore.h>

#import "AdddateViewController.h"

@interface SafeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSDictionary * dictSouce;
@end

@implementation SafeCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backButton.hidden = NO;
    self.titleLabel.text = @"账号与安全";
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
   
    [self dataRrlode];
   
}

//判断是否绑定
-(void)dataRrlode{
    
    NSDictionary * dic = @{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:isBinding parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
            self.dictSouce =  responseObject[@"mobile"];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新表格
            [self.tableView reloadData];
            
        });
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        self.automaticallyAdjustsScrollViewInsets = NO;
//        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //分割线的颜色
        [_tableView setSeparatorColor:[UIColor groupTableViewBackgroundColor]];
        [self.view addSubview:_tableView];
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
    }
    
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
       return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90.0*px;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20.0*px;
}

//脚
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
   
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * string=@"str";
     SafeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    if(cell==nil){
        cell = [[SafeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    
    if (indexPath.section==0) {
        //绑定手机
        if (indexPath.row==0) {
            cell.labelTiitle.text = @"绑定手机";
            
            
            if ([self.dictSouce[@"mobile"] length]>0) {
                cell.buttonEn.alpha = 0;
                //影藏中间四位
                NSString * tel = [self.dictSouce[@"mobile"] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                cell.labelright.text = tel;
            }
        }
    }
    
    if (indexPath.section==1) {
        //绑定微信
        if (indexPath.row==0) {
             cell.labelTiitle.text = @"绑定微信";
            if ([self.dictSouce[@"weixin"] isEqual:@1]) {
                cell.buttonEn.alpha = 0;
                cell.labelright.text = @"已绑定";
            }
        }
        //绑定qq
        if (indexPath.row==1) {
             cell.labelTiitle.text = @"绑定QQ";
            if ([self.dictSouce[@"qq"] isEqual:@1]) {
                cell.buttonEn.alpha = 0;
                cell.labelright.text = @"已绑定";
            }
        }
        //绑定微博
        if (indexPath.row==2) {
             cell.labelTiitle.text = @"绑定微博";
            if ([self.dictSouce[@"weibo"] isEqual:@1]) {
                cell.buttonEn.alpha = 0;
                cell.labelright.text = @"已绑定";
            }
        }
        //修改密码
        if (indexPath.row==3) {
             cell.labelTiitle.text = @"修改密码";
            if ([self.dictSouce[@"password"] integerValue] == 1){
                cell.labelTiitle.text = @"修改密码";
            }else{
                cell.labelTiitle.text = @"设置密码";
            }
        }
        
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        //绑定手机
        if (indexPath.row==0) {
            //友盟点击量统计
            [MobClick event:@"bangdingshouji"];
            
            
            //修改
            BDphoneViewController * bdphoneVC = [[BDphoneViewController alloc]init];
            //绑定
            BDChangeViewController * bdChangeVC = [[BDChangeViewController alloc]init];
            
            if ([self.dictSouce[@"mobile"] length]>0) {
                //有手机号码，说明绑定了
                //修改绑定
                [self.navigationController pushViewController:bdChangeVC animated:YES];


            }else{
                //没绑定
                //去绑定
                [self.navigationController pushViewController:bdphoneVC animated:YES];
            }
        
        }
    }
    
    if (indexPath.section==1) {
        //绑定微信
        if (indexPath.row==0) {
            //友盟点击量统计
            [MobClick event:@"bangdingweix"];
            //微信登陆
            [self authWithGetgetUserInfo:UMSocialPlatformType_WechatSession type:1];

        }
        //绑定qq
        if (indexPath.row==1) {
            //友盟点击量统计
            [MobClick event:@"bangdingQQ"];
            
            //qq登陆
            [self authWithGetgetUserInfo:UMSocialPlatformType_QQ type:3];

        }
        //绑定微博
        if (indexPath.row==2) {
            //友盟点击量统计
            [MobClick event:@"bangdingweibo"];
            //微博
            [self authWithGetgetUserInfo:UMSocialPlatformType_Sina type:2];
        }
        //修改密码
        if (indexPath.row==3) {
            //友盟点击量统计
            [MobClick event:@"xiugaimima"];
            
            if ([self.dictSouce[@"password"] integerValue] == 1){
                ChangePasswordViewController * changePassworld = [[ChangePasswordViewController alloc]init];
                changePassworld.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:changePassworld animated:YES];
            }else{
                FindViewController * changePassworld = [[FindViewController alloc]init];
                changePassworld.type = @"1";
                changePassworld.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:changePassworld animated:YES];
            }
           
        }
       
    }

    
    
}


//三方登陆授权和得到用户信息
-(void)authWithGetgetUserInfo:(UMSocialPlatformType)platform type:(NSInteger)type{
    //    三方登陆授权并且获取用户资料6.1适配https
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platform currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            [DWBToast showCenterWithText:@"登陆失败"];
        } else {
            UMSocialUserInfoResponse *resp = result;
            //把三方登陆得到的数据发给后台
            [self loginSuccess:resp type:type];
            
            //            // 授权信息
            //            NSLog(@"QQ uid: %@", resp.uid);
            //            NSLog(@"QQ openid: %@", resp.openid);
            //            NSLog(@"QQ accessToken: %@", resp.accessToken);
            //            NSLog(@"QQ expiration: %@", resp.expiration);
            //
            //            // 用户信息
            //            NSLog(@"QQ name: %@", resp.name);
            //            NSLog(@"QQ iconurl: %@", resp.iconurl);
            //            NSLog(@"QQ gender: %@", resp.gender);
            //
            //            // 第三方平台SDK源数据
            //            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            
        }
    }];
    
}



//得到三方资料后的操作
- (void)loginSuccess:(UMSocialUserInfoResponse*)snsAccount type:(NSInteger)type{
    NSString * openId = snsAccount.openid;
    if ([NSString isNULL:snsAccount.openid]) {
        //判空，防止崩溃
        openId = @"";
    }
    NSDictionary * dict = @{@"type":@(type),//注册类型   1微信2微博3qq
                            @"thirdId":snsAccount.uid,//第三方返回的id   uid
                            @"sessionId":SESSIONID,
                            @"openId":openId//微信三方的openid
                            };
    [GXJAFNetworking POST:myBinding parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"01"]) {
            
            //刷新数据
            [self dataRrlode];
            
            //三方绑定成功后去填写资料
            AdddateViewController * addDateVC = [[AdddateViewController alloc]init];
            addDateVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addDateVC animated:YES];
            
        }
        
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该账户已绑定其他用户" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //请求数据时时刷新
    [self dataRrlode];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}

@end
