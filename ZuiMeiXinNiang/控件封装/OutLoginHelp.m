//
//  OutLoginHelp.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/11/30.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "OutLoginHelp.h"
//阿里百川电商授权登陆
#import <AlibabaAuthSDK/ALBBSDK.h>
//京东电商SDK
#import <JDKeplerSDK/KeplerApiManager.h>
#import "AppDelegateView.h"
@implementation OutLoginHelp


/**
 用户退出登录
 */
+(void)userOutLogin{
    
    
    //记录用户最后使用app的时间，在清除sessionId之前调用
    [AppDelegateView userEndmakeAppTime];
    
    //退出阿里授权登陆（这样app内购买商品就需要再次登陆了淘宝了）
    ALBBSDK *albbSDK = [ALBBSDK sharedInstance];
    [albbSDK logout];

    //退出京东登陆（这样app内购买商品就需要再次登陆了京东了）
    [[KeplerApiManager sharedKPService] cancelAuth];
    
    //给他付空值，用来清除SessionId;
    NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
    //清除sessionId
    [defuaults setObject:@"" forKey:@"sessionId"];
    //清除用户名字
    [defuaults setObject:@"" forKey:@"userId"];
    
    //记录用户注销操作
    //关注界面
    [defuaults setObject:@"cellationhome" forKey:@"cancellationHome"];
    //美聊
    [defuaults setObject:@"cellationMeiliao" forKey:@"cancellationMeiliao"];
    
    //退出登录  刷新达人界面
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshpoperView" object:nil];
    
    
}
@end
