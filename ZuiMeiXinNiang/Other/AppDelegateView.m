//
//  AppDelegateView.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2016/11/23.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "AppDelegateView.h"
//版本更新检测
#import "iVersion.h"
//评分
#import "iRate.h"
//点击状态栏回到顶部（跟趣拍SDK冲突，暂时屏蔽）
//#import "LYTopWindow.h"
//融云聊天无界面组件
#import <RongIMLib/RongIMLib.h>

//弹窗搜索
#import "TBSeaechAlertView.h"

@interface AppDelegateView()

@end

//手机联网权限检测
@import CoreTelephony;

@implementation AppDelegateView

// 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //每次启动程序都删除的数据
        [self deleteUserDefaults];
        
        //判断sessionId是否过期
        [self LoadCleanSessionId];
        
        //网络时时监听
        [self NetworkMonitoring];
        
        //清除上传的视频缓存（指定文件夹路径清理缓存）（封装）
        [NSString videoRemoField];
        
    
        if (ios9_1orLater) {
            //联网权限检测（iOS9才有）
            [self isHaveInternetQX];
        }
        
        //登陆融云
        [self loginRongCloud];
        
        
#pragma mark ============添加京东订单，通知后台去同步订单账号================
        [OpenJDGoodesDetals addJDOrderLoadAFN];
        
    }
    return self;
}



//每次启动程序都清除一些NSUserDefaults
-(void)deleteUserDefaults{
    //删者必死
    //把空的值存进去,用来清除圈子ID,初始化，防止第一次蹦
    NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
    //初始化登陆状态
    [defuaults setObject:@"" forKey:@"LoginRefresh"];
    //初始化注销状态为空
    [defuaults setObject:@"" forKey:@"cancellationMeiliao"];
    
    
    //删除用户在直播间由游客变用户的状态，用来判断登录（重要）
    [defuaults setObject:@"" forKey:@"userjoinChatroom"];

    
    

    //同步
    [defuaults synchronize];
    
}


//请求我的资料，同时判断sessionId是否过期
-(void)LoadCleanSessionId{
    
    //做一次数据请求(用来清除过期的seessid)--这里特殊暂时不调用封装的AFN
//    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
    if ([NSString isNULL:SESSIONID]==YES) {
        //第一次用手机登陆先判断如果sessionId等于null，先把他变成@""
        NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
        [defuaults setObject:@"" forKey:@"sessionId"];
        //保证数据存储成功
        [defuaults synchronize];
        return;
    }
     NSDictionary * dic=@{@"sessionId":SESSIONID};
    //调用自己的单例
    AFHTTPSessionManager * manager =  [GXJAFNetworking sharedManager];
    [manager POST:MINE_HOME_DATA parameters:dic constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([responseObject[@"code"] isEqual:@"00"]) {
      //===============【警告⚠️：这里不要存sessionId，否则必死，不要问我为什么】===================
                
                //用户资料缓存--程序每次启动缓存最新资料
                [NSString userInfoCacheMyuserId:responseObject[@"userInfo"][@"userId"] AndUserName:responseObject[@"userInfo"][@"nickName"] AndUserImage:responseObject[@"userInfo"][@"image"] AndUserType:responseObject[@"userInfo"][@"userType"]];
            }
            
            if ([responseObject[@"code"] isEqual:[NSNull null]]) {
                return ;
            }
            if ([responseObject[@"code"] isEqual:@"97"]) {
                //给他赋值为空，以清除sessionId
                 NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
                [defuaults setObject:@"" forKey:@"sessionId"];
                //保证数据存储成功
                [defuaults synchronize];
            }
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        NSLog(@"%@",error.localizedDescription);
    }];
}

//AFN网络状态时时监听（自动监听）
-(void)NetworkMonitoring{
    
    AFNetworkReachabilityManager * NetworkMon = [AFNetworkReachabilityManager sharedManager];
    // 开始监听网络
    [NetworkMon startMonitoring];
    
    //自动时时监听的
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afNetworkStatusChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
}

//AFN网络时时监听的通知事件
- (void)afNetworkStatusChanged:(NSNotification *)notifi{
    
    
    if (notifi.userInfo[@"AFNetworkingReachabilityNotificationStatusItem"] == 0) {
        //没网
        //没网等各种错误提示(把句号替换成空白)
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD showNoNetwork:@"网络已断开连接"];
        });
    }else{
        //有网什么也不干
        
    }
}


#pragma mark ============== 联网权限检测(系统会自动弹框提示无需自己弄) ============================
-(void)isHaveInternetQX{
    //检查联网权限==系统会自动弹框提示无需自己弄==iOS9以后
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
        //获取联网状态
        switch (state) {
            case kCTCellularDataRestricted:
//                NSLog(@"kCT蜂窝数据限制");
                break;
            case kCTCellularDataNotRestricted:
//                NSLog(@"kCT蜂窝数据不受限制的");
                
                break;
            case kCTCellularDataRestrictedStateUnknown:
//                NSLog(@"kCT蜂窝数据限制状态未知");
                break;
            default:
                break;
        };
    };
    
}

//程序从后台进入前台时
-(void)setAppEnterForeground:(NSString *)appEnterForeground{
    _appEnterForeground = appEnterForeground;
    if (ios9_1orLater) {
        //联网权限检测（iOS9才有）
        [self isHaveInternetQX];
    }
    
    
    //记录用户最后使用app的时间
    [AppDelegateView userEndmakeAppTime];
    
    //弹窗搜索--
    [TBSeaechAlertView AlertTBSeaechAlertWitView];
    
}
//程序将要进入后台是
-(void)setApplicationNoActive:(NSString *)applicationNoActive{
    _applicationNoActive = applicationNoActive;
  
    
    //记录用户最后使用app的时间
    [AppDelegateView userEndmakeAppTime];
    
}

//版本跟新和评分
- (void)VersionWithNewTip{
    //版本检测
    [iVersion sharedInstance].applicationBundleID = [[NSBundle mainBundle] bundleIdentifier];
    //设置提示按钮的样式
    [iVersion sharedInstance].updatePriority=iVersionUpdatePriorityDefault;
    
    
    //去appstore评分
    //是否仅仅是这个版本
    [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    //启动预览模式（测试时才用，打开后每次都会提示。上线时关闭）
    //    [iRate sharedInstance].previewMode = YES;
    
    
}


#pragma mark ================= 登陆融云-S（程序每次启动都登陆下）======================
//程序启动如果用户登陆了，就连接融云（必须连接，否则融云登陆无效）
-(void)loginRongCloud{
    if ([NSString isNULL:SESSIONID]) {
        return;
    }
    [[RCIMClient sharedRCIMClient] connectWithToken:RCIMToken success:^(NSString *userId) {
        NSLog(@"启动时融云登陆成功");
        //设置当前登录用户的资料
        RCUserInfo * user = [[RCUserInfo alloc]init];
        user.userId = USERID;
        user.portraitUri = USER_PhoneImage;
        user.name = USER_name;
        //当前登录用户的用户信息
        [RCIMClient sharedRCIMClient].currentUserInfo = user;
    } error:^(RCConnectErrorCode status) {
        NSLog(@"启动时融云登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //        tokenIncorrectBlock有两种情况：
        //        一是token错误，请您检查客户端初始化使用的AppKey和您服务器获取token使用的AppKey是否一致；
        //        二是token过期，是因为您在开发者后台设置了token过期时间，您需要请求您的服务器重新获取token并再次用新的token建立连接。
        //
        //        @warning 如果您使用IMKit，请使用此方法建立与融云服务器的连接；
        //        如果您使用IMLib，请使用RCIMClient中的同名方法建立与融云服务器的连接，而不要使用此方法。
        //
        //        在tokenIncorrectBlock的情况下，您需要请求您的服务器重新获取token并建立连接，但是注意避免无限循环，以免影响App用户体验。
        NSLog(@"token错误");
    }];
    
}

#pragma mark ================= 登陆融云-E（程序每次启动都登陆下）======================

#pragma mark =================记录登陆用户最后使用app的时间 S====================

/**
 记录登陆用户最后使用app的时间,程序启动和关闭，登录成功和退出登录都需要调用,这个接口的调用时后台判定日活的关键接
 */
+(void)userEndmakeAppTime{
    if ([NSString isNULL:SESSIONID]) {
        return;
    }
    NSDictionary * dict = @{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:recordUseDate parameters:dict success:^(id  _Nullable responseObject) {
        //        NSLog(@"记录用户使用app：%@",responseObject);
    } failure:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark =================记录登陆用户最后使用app的时间 E====================


@end
