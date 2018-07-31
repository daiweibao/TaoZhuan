//
//  AppDelegate.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 15/12/11.
//  Copyright (c) 2015年 北京嗅美科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

//友盟分享6.1
#import <UMSocialCore/UMSocialCore.h>
#import "UMessage.h"

//微信支付用到的
#import "WXApiManager.h"

//银联支付
#import "UPPaymentControl.h"

//支付宝
#import <AlipaySDK/AlipaySDK.h>

//iOS10推送
#import <UserNotifications/UserNotifications.h>

//获取手机广告ID
#import <AdSupport/AdSupport.h>

//Appdeledateview
#import "AppDelegateView.h"
//推送封装
#import "AppPushView.h"
//引导页
#import "AppGuidePageView.h"
//阿里百川SDK3.1(2017年5月9日)
#import <AlibcTradeSDK/AlibcTradeSDK.h>

//融云聊天无界面组件（包含直播，暂时不能放到pch文件里）
#import <RongIMLib/RongIMLib.h>
//京东电商SDK
#import <JDKeplerSDK/KeplerApiManager.h>
//口令搜索
#import "TBSeaechAlertView.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate,RCIMClientReceiveMessageDelegate,UITabBarControllerDelegate>

//Appdeledateview封装
@property(nonatomic,strong)AppDelegateView * appView;
//推送和分享代码封装
@property(nonatomic,strong)AppPushView * apppushView;
//引导页
@property(nonatomic,strong)AppGuidePageView * guidePageView;

@property(nonatomic,strong) MainViewController * rootVC;

@end

@implementation AppDelegate

//(2)告诉代理启动基本完成程序准备开始运行
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //(1)创建app窗口（必须放在第一位）里面包括创建引导页，
    [self createWindow];
    
    //(2)初始化各种appkey
    [self createAllAppKey:launchOptions];
    
    //(3)初始化appview各种不带界面跳转的同时触发view里面的方法数据请求
    [self appView];
    //(4)推送封装view
    [self apppushView];
    //(5)iOS 9.1 才有3D touch 和联网检测
    if (ios9_1orLater) {
        //3Dtouch
        [self ThreeDTouch];
    }
    //监听接收通知修改融云监听器-（主要是直播聊天室改了，所以还得用通知）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRCIDLibRicveMy) name:@"changeRCIDLibRicve" object:nil];

    return YES;
}

//创建appc窗口
-(void)createWindow{
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    //设置窗口颜色
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    /**
     *  添加开屏广告（不会影响appdelegate里面的业务逻辑，开屏广告初始化,见XHLaunchAdManager，2017.10.23）
     */
    
    //添加窗口
    [self.window makeKeyAndVisible];
    
    //创建引导页及推送图片(必须在创建tabbar后面，否则会崩溃)===调用封装的类==必须先创建完引导页在创建tabbar，否则有黑影
    [self.guidePageView createGuidePage:self.window andBlock:^{
        //创建tabbar界面
        MainViewController * rootVC = [[MainViewController alloc] init];
        self.rootVC = rootVC;
        rootVC.delegate = self;
        self.window.rootViewController = rootVC;
        
        //弹窗搜索--口令
        [TBSeaechAlertView AlertTBSeaechAlertWitView];

    }];

}


/**
 *  TabBarController代理,写在appAppDelegate里，首先要遵守协议：UITabBarControllerDelegate
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController.tabBarItem.title isEqualToString:@"今日收益"] || [viewController.tabBarItem.title isEqualToString:@"订单"] || [viewController.tabBarItem.title isEqualToString:@"我的"]) {
        NSString *sign = SESSIONID; //取出登陆状态(NSUserDefaults即可)
        NSInteger selectedIndex  =  0 ;
        if ([NSString isNULL:sign]) {  //未登录
            if ([viewController.tabBarItem.title isEqualToString:@"今日收益"]) {
                selectedIndex = 1;
            } else if ([viewController.tabBarItem.title isEqualToString:@"订单"]) {
                selectedIndex = 2;
            } else if ([viewController.tabBarItem.title isEqualToString:@"我的"]) {
                selectedIndex = 3;
            }
            //弹窗登陆
            [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                //登陆成功后判断选定哪一个
                _rootVC.selectedIndex = selectedIndex;
            }];
            
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}



//引导页
-(AppGuidePageView *)guidePageView{
    if (!_guidePageView) {
        _guidePageView = [[AppGuidePageView alloc]init];
    }
    return _guidePageView;
}

//懒加载view
-(AppDelegateView *)appView{
    if (!_appView) {
        _appView = [[AppDelegateView alloc]init];
    }
    return _appView;
}
//懒加载推送view
-(AppPushView *)apppushView{
    if (!_apppushView) {
        _apppushView = [[AppPushView alloc]init];
    }
    return _apppushView;
}


//创建各种AppKey
-(void)createAllAppKey:(NSDictionary *)launchOptions{

    //打开日志
    [[UMSocialManager defaultManager] openLog:NO];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMappKey];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppId appSecret:WXappSecret redirectURL:UMredirectURL];
    /*
     * 添加某一平台会加入平台下所有分享渠道，如微信：好友、朋友圈、收藏，QQ：QQ和QQ空间
     * 以下接口可移除相应平台类型的分享，如微信收藏，对应类型可在枚举中查找
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    // 设置分享到QQ互联的appID @"twWbYouCJWOpvVes"
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppId/*设置QQ平台的appID*/  appSecret:QQAppSecret redirectURL:UMredirectURL];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppId  appSecret:SinaAppSecret redirectURL:UMredirectURL];
    
    //微信支付
    [WXApi registerApp:WXAppId withDescription:@"淘赚"];
    //QQ分享及登录1105366464  1105311784

    
#pragma mark ============友盟推送===============
    [UMessage startWithAppkey:UMappKey launchOptions:launchOptions];
    //创建友盟推送
    [self UMpushMessage];
    

    
    
#pragma mark ============友盟统计（2017.3.24）===============
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    //友盟统计要写的（必填项必须填）
     UMConfigInstance.appKey = UMappKey;
    [MobClick startWithConfigure:UMConfigInstance];
    

#pragma mark =================== 阿里百川电商SDK 开始===============
    
    //最新修改2017年5月9日，记住一定要导入安全图片否则无法打开淘宝客户端（yw_1222.jpg）
    // 外部使用只能用Release环境 线上环境AlibcEnvironmentRelease
    [[AlibcTradeSDK sharedInstance] setEnv:AlibcEnvironmentRelease];
    
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    //    NSString *appKey = @"23082328";
    
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
        
    } failure:^(NSError *error) {
        
    }];
    
//#warning 初始化时候, 在log中确认 AlibcTradeSDK 资源/环境检查 , 确保配置完成
    // 开发阶段打开日志开关，方便排查错误信息(必须设置成NO关闭，屏蔽无效)
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:NO];
    
    // 配置全局的淘客参数（暂时不设置了）
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
//#warning - 改成自己的淘客ID进行测试!!!  嗅美科技：mm_121704001_0_0
    taokeParams.pid = TB_mmId;
    taokeParams.unionId = nil;
    taokeParams.subPid = nil;
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    // 设置全局的app标识，在电商模块里等同于isv_code
    [[AlibcTradeSDK sharedInstance] setISVCode:@"your_isv_code"];
    
    // 设置全局配置，是否强制使用h5
    [[AlibcTradeSDK sharedInstance] setIsForceH5:YES];
    
#pragma mark =================== 阿里百川电商SDK 结束===============

#pragma mark =============== 融云SDK ===============
    
  //初始化融云
    [[RCIMClient sharedRCIMClient] initWithAppKey:RCIMappKey];
   
    /*!
     设置IMlib的消息接收监听器
     
     @param delegate    IMLib消息接收监听器
     @param userData    用户自定义的监听器Key值，可以为nil
     
     @discussion
     设置IMLib的消息接收监听器请参考RCIMClient的setReceiveMessageDelegate:object:方法。
     
     userData为您自定义的任意数据，SDK会在回调的onReceived:left:object:方法中传入作为object参数。
     您如果有设置多个监听，会只有最终的一个监听器起作用，您可以通过该userData值区分您设置的监听器。如果不需要直接设置为nil就可以。
     
     @warning 如果您使用IMlib，可以设置并实现此Delegate监听消息接收；
     如果您使用IMKit，请使用RCIM中的receiveMessageDelegate监听消息接收，而不要使用此方法，否则会导致IMKit中无法自动更新UI！
     */
    [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:@"AppDelegateMain"];//整个项目中就设置这么一处监听就可以了
    //是否在状态栏展示聊天消息，程序启动默认展示
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isShowRCIMChatStatusBar"];
    [[NSUserDefaults standardUserDefaults] synchronize]; //保证数据存储成功
    
    
    //京东电商SDK初始化
    [[KeplerApiManager sharedKPService]asyncInitSdk:JDAPPKey secretKey:JDAPPSecret sucessCallback:^(){
    
    }failedCallback:^(NSError *error){
        
    }];
    
}

//修改了融云监听(重要，不做修改回来之后就不显示了--这个暂时不删，涉及到直播聊天室，改了监听，的改回来)
-(void)changeRCIDLibRicveMy{
    [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:@"AppDelegateMain"];
}


/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param nLeft       还剩余的未接收的消息数，left>=0
 @param object      消息监听设置的key值
 
 @discussion 如果您设置了IMlib消息监听之后，SDK在接收到消息时候会执行此方法。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 object为您在设置消息接收监听时的key值。
 */
- (void)onReceived:(RCMessage *)message left:(int)nLeft object:(id)object {
    //    NSLog(@"融云AppDelegate未接收的消息数：%d", nLeft);
    //
    if ([NSString isNULL:SESSIONID]) {
        //没有登录就不提示消息了
        return;
    }
    //   比如收到大量消息时等待left为0再刷新UI。
    if (nLeft==0) {
        
        //接收到融云聊天消息，吧消息内容发送到各个控制器【重要】
        [[NSNotificationCenter defaultCenter]postNotificationName:@"RicveRCIDChatMessageContent" object:message];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //文本消息
            NSString * contentChat = @" ";
            NSString * extraStr = @"";//携带的附加消息，群聊的时候携带群名字
            if ([message.content isMemberOfClass:[RCTextMessage class]]) {
                RCTextMessage *textMessage = (RCTextMessage *)message.content;
                contentChat = textMessage.content;
                extraStr = textMessage.extra;//群名字
            }else if ([message.content isMemberOfClass:[RCImageMessage class]]){
                RCImageMessage *imageMessage = (RCImageMessage *)message.content;
                //图片消息
                contentChat = @"[图片]";
                extraStr = imageMessage.extra;//群名字
            }else if ([message.content isMemberOfClass:[RCVoiceMessage class]]){
                RCVoiceMessage *videoMessage = (RCVoiceMessage *)message.content;
                //语音消息
                contentChat = @"[语音]";
                extraStr = videoMessage.extra;//群名字
            }else if ([message.content isMemberOfClass:[RCRichContentMessage class]]){
                //分享消息
                RCRichContentMessage *textMessage = (RCRichContentMessage *)message.content;
                contentChat = [NSString stringWithFormat:@"[连接]%@",textMessage.title];
                extraStr = textMessage.extra;//群名字
            }
            //判空,并且在状态栏展示的时候才展示
            if ([NSString isNULL:contentChat]==NO && [isShowRCIMChatStatusBar isEqual:@"YES"]) {
                
                NSString * contentShowStr;
                if ([NSString isNULL:extraStr]) {
                    //其他消息提醒
                    contentShowStr = [NSString stringWithFormat:@"%@：%@",message.content.senderUserInfo.name,contentChat];
                }else{
                    //群消息提醒
                    contentShowStr = [NSString stringWithFormat:@"「%@」%@：%@",extraStr,message.content.senderUserInfo.name,contentChat];
                }
                
                //顶部状态栏提醒(用户+内容)
                [JDStatusBarNotification showJDStatusBarMy:contentShowStr];
                
                //状态栏展示是声音震动一次
                [NSString getXTSoundAndVibration];
                
                //收到聊天消息发通知刷新首页消息小红点==不在聊天界面的时候在刷新
                [[NSNotificationCenter defaultCenter]postNotificationName:@"RicveRCIDChatInfo" object:nil];
            }
            
            
            /*
             融云 SDK 根据 iOS App 运行的特性，主要有以下三种运行状态：
             
             1、 前台状态 如字面意思，App 前台可见时 SDK 处于前台状态。此时 App 使用融云的长连接通道来收发消息.
             
             2、 后台活动状态 当 App 进入后台 2 分钟之内，SDK 处于后台活跃状态。此时 App 使用融云的长连接通道接收消息。
             
             如果您使用 IMKit ，此时 SDK 收到消息会弹出本地通知（必须实现用户信息提供者和群组信息提供者，否则将不会有本地通知提示弹出）。
             
             如果您使用 IMLib ，此时 SDK 不会弹出本地通知，如果您需要可以自己弹出本地通知提示。
             
             3、 后台暂停状态当 App 进入后台 2 分钟之后或被杀进程或被冻结，SDK 将处于后台暂停状态。此时融云的长连接通道会断开，融云 Server 会通过 APNs 将消息以远程推送的形式下发到客户端。 此状态下如果有人给该用户发送消息，融云的服务器会根据 deviceToken 和推送证书将消息发送到苹果推送服务器，苹果服务器会将该消息推送到客户端。
             
             由于本地通知和远程推送表现形式类似，不易区分，您在调试时可以通过杀进程来测试远程推送，App 刚进入后台测试本地通知。
             当 SDK 处于后台暂停状态时，App 会收到远程推送。
             */
            //发送本地通知(用户+内容)(用户切换到后台，两分钟有效)
            //判空，防止字典崩溃
            if ([NSString isNULL:message.content.senderUserInfo.name]) {
                message.content.senderUserInfo.name = @"用户";
            }
            if ([NSString isNULL:message.content.senderUserInfo.userId]) {
                //判空
                return;
            }
            if ([NSString isNULL:message.content.senderUserInfo.portraitUri]) {
                //判空
                return;
            }
            if ([NSString isNULL:contentChat]) {
                //判空
                return;
            }
            
            //下面是消息本地推送
            NSString * senderName;
            if ([NSString isNULL:extraStr]) {
                senderName = message.content.senderUserInfo.name;
            }else{
                senderName = [NSString stringWithFormat:@"「%@」%@",extraStr,message.content.senderUserInfo.name];
            }
            [self sendeNotification:message.content.senderUserInfo.name UserId:message.content.senderUserInfo.userId UserImage:message.content.senderUserInfo.portraitUri AndContent:contentChat];
        });
    }
}

#pragma mark =============本地推送==S =======================
//ios本地通知注册（推送）
-(void)LocalNotification:(UIApplication *)application{
    
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        //ios10注册方法
        // 使用 UNUserNotificationCenter 来管理通知
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //监听回调事件 代理UNUserNotificationCenterDelegate
        center.delegate = self;
        
        //iOS 10 使用以下方法注册，才能得到授权
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            // Enable or disable features based on authorization./ /根据授权启用或禁用功能。
        }];
        
    }else{
        //ios8到9的注册方式
        if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
            [application registerUserNotificationSettings:settings];
        }
        
    }
    
    
    
    
    
}

//发送本地通知
-(void)sendeNotification:(NSString *)userName UserId:(NSString*)userId UserImage:(NSString*)userInage AndContent:(NSString *)contentChat{
    
    //    获取所有的未读消息数
    int chatNum = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    
    if (chatNum < 0) {
        chatNum = 0;
    }
    
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        //iOS10
        [self sendeNotificationiOSTen:userName UserId:userId UserImage:userInage AndContent:contentChat Badge:@(chatNum)];
        
    }else{
        //iOS8、9发送本地通知
        [self sendeNotification8And9:userName UserId:userId UserImage:userInage AndContent:contentChat Badge:@(chatNum)];
        
    }
}

//iOS10发送本地通知
-(void)sendeNotificationiOSTen:(NSString *)userName UserId:(NSString*)userId UserImage:(NSString*)userInage AndContent:(NSString *)contentChat  Badge:(NSNumber*)badgeNun{
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    //    content.title = [NSString localizedUserNotificationStringForKey:userName arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:[NSString stringWithFormat:@"%@:%@",userName,contentChat] arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    //设置一些额外的信息(控制器跳转用)
    if ([NSString isNULL:userInage]) {
        userInage = @"";
    }
    if ([NSString isNULL:userId]) {
        userId = @"";
    }
    if ([NSString isNULL:userName]) {
        userName = @"";
    }
    content.userInfo = @{@"RCIMuserName":userName, @"RCIMuserId":userId,@"RCIMuserImage":userInage};
    //角标数量
    [UIApplication sharedApplication].applicationIconBadgeNumber = [badgeNun integerValue];
    // 在 设定时间 后推送本地推送
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:0.1 repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];
    
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
    
    
}

//iOS8、9发送本地通知
-(void)sendeNotification8And9:(NSString *)userName UserId:(NSString*)userId UserImage:(NSString*)userInage AndContent:(NSString *)contentChat  Badge:(NSNumber*)badgeNun{
    // 1.创建一个本地通知
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    
    // 1.1.设置通知发出的时间
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
    
    // 1.2.设置通知内容
    localNote.alertBody = [NSString stringWithFormat:@"%@:%@",userName,contentChat];
    
    // 1.3.设置锁屏时,字体下方显示的一个文字
    localNote.alertAction = userName;
    localNote.hasAction = YES;
    
    // 1.4.设置启动图片(通过通知打开的)
    localNote.alertLaunchImage = @"";
    
    // 1.5.设置通过到来的声音
    localNote.soundName = UILocalNotificationDefaultSoundName;
    
    // 1.6.设置应用图标左上角显示的数字
    localNote.applicationIconBadgeNumber = [badgeNun integerValue];
    
    // 1.7.设置一些额外的信息
    //设置一些额外的信息(控制器跳转用)
    if ([NSString isNULL:userInage]) {
        userInage = @"";
    }
    if ([NSString isNULL:userId]) {
        userId = @"";
    }
    if ([NSString isNULL:userName]) {
        userName = @"";
    }
    localNote.userInfo = @{@"RCIMuserName":userName, @"RCIMuserId":userId,@"RCIMuserImage":userInage};
    
    // 2.执行通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    
}

#pragma mark =============本地推送==E =======================




/**
 *  向服务器请求广告数据
 *
 *  @param imageData 回调imageUrl,及停留时间,跳转数据
 */
-(void)requestImageData:(void(^)(NSString *imgUrl,NSInteger duration, NSDictionary * openDict))imageData{
    //向后台请求数据
    [GXJAFNetworking POST:getstartPage parameters:nil success:^(id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([responseObject[@"code"] isEqual:@"00"]) {
                //         startPageCode  广告类型   1 秒杀详情 2 试用详情 3专区详情 4 专栏详情 5 主题列表 6 专区列表 7 外链
                if ([NSString isNULL:responseObject[@"reply"][@"imgUrl"]]==NO) {
                    imageData(responseObject[@"reply"][@"imgUrl"],4,responseObject[@"reply"]);
                }else{
                    //什么也不干
                }
            }
        });
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//3D Touch
-(void)ThreeDTouch{
    /**
     *  通过代码实现动态菜单
     *  一般情况下设置主标题、图标、type等，副标题是不设置的 - 简约原则
     *  iconWithTemplateImageName 自定义的icon
     *  iconWithType 系统的icon
     */
    
    //发布
    //系统ShortcutIcon
    UIApplicationShortcutIcon * sendTopic = [UIApplicationShortcutIcon iconWithTemplateImageName:@"编辑"];
    UIApplicationShortcutItem *itemOne = [[UIApplicationShortcutItem alloc] initWithType:@"topic" localizedTitle:@"发布帖子" localizedSubtitle:nil icon:sendTopic userInfo:nil];
    
    //签到
    
    //     UIApplicationShortcutIcon * Sign = [UIApplicationShortcutIcon iconWithTemplateImageName:@"签到有礼"];
    UIApplicationShortcutIcon * Sign = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeTask];
    UIApplicationShortcutItem * itemTwo = [[UIApplicationShortcutItem alloc] initWithType:@"SignIn" localizedTitle:@"签到" localizedSubtitle:nil icon:Sign userInfo:nil];
    
    //嗅美管家
    //系统图标
    UIApplicationShortcutIcon * xiumeiHome = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome];
    //汉字
    UIApplicationShortcutItem * itemThree = [[UIApplicationShortcutItem alloc] initWithType:@"xiumeihome" localizedTitle:@"我型衣秀" localizedSubtitle:nil icon:xiumeiHome userInfo:nil];
    
    //购物车
    //自定义ShortcutIcon
    //    UIApplicationShortcutIcon * LoveTopic = [UIApplicationShortcutIcon iconWithTemplateImageName:@"发布心情图标"];
    UIApplicationShortcutIcon * shopping = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeMail];
    UIApplicationShortcutItem * itemFoure = [[UIApplicationShortcutItem alloc] initWithType:@"shoppingCar" localizedTitle:@"我的消息" localizedSubtitle:nil icon:shopping userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[itemOne,itemTwo,itemThree,itemFoure];
}

//3D Touch菜单点击事件
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    //3D touch跳转封装
    [self.apppushView three3DTouch:shortcutItem.type];
        
    
}


//应该跟支付宝有关
-(BOOL) verify:(NSString *) resultStr {
    
    //验签证书同后台验签证书
    //此处的verify，商户需送去商户后台做验签
    return NO;
}

//三种支付方式的回调(iOS 9以上走，包含iOS10！！！！！！！！！)
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    //其他app打开嗅美时发通知，分享那边在用（iOS9）
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OtherOpenXiumei_iOS" object:url];
    
//    为了正常使用百川内置的应用跳转处理，需要调用百川SDK的方法。建议优先调用百川处理，如果百川已处理，可以直接返回YES；当然，也可以继续处理，比如记录应用跳转来源日志等。
//    以下代码不现实,会导致通过手淘授权登陆,跳回来没反应等问题
    // 新接口写法
    if (![[AlibcTradeSDK sharedInstance] application:app
                                             openURL:url
                                             options:options]) {
        //处理其他app跳转到自己的app，如果百川处理过会返回YES
    }

    
    //友盟分享和登陆6.1三方回调
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    
    //必须放在这里
    if ([url.host isEqual:@"platformId=wechat"]){
#pragma mark ====================微信分享到朋友圈后==回调 =============================
        //微信朋友圈分享后走这里==
        //        [[NSNotificationCenter defaultCenter]postNotificationName:@"WXshare" object:nil];
        
    }
    //下面是支付的回调
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
#pragma mark ====================支付宝支=回调 ==================================
        //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
        if ([url.host isEqualToString:@"safepay"]) { //支付宝支付
            
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                NSString *message = @"";
                switch([[resultDic objectForKey:@"resultStatus"] integerValue])
                {
                    case 9000:message = @"订单支付成功";break;
                    case 8000:message = @"正在处理中";break;
                    case 4000:message = @"订单支付失败";break;
                    case 6001:message = @"用户中途取消";break;
                    case 6002:message = @"网络连接错误";break;
                    default:message = @"未知错误";
                }
                
                NSString * ZFBstring;
                
                if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) { //支付成功,发送通知
                    
                    //                    NSLog(@"Appledegate支付成功的回调结果:message = %@",message);
                    ZFBstring  = @"PaySuccess";
                }else{ //支付失败,发送通知
                    ZFBstring  = @"PayFail";
                    //                    NSLog(@"Appledegate支付失败的回调结果:message = %@",message);
                }
                //发通知，把支付宝支付结果发过去
                [[NSNotificationCenter defaultCenter]postNotificationName:@"ZFBPayresul" object:ZFBstring];
                
            }];
            
        }else if([url.host isEqualToString:@"uppayresult"]){
#pragma mark ====================银联支付=回调 =============================
            //银联支付控件结果处理函数
            [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
                
                //结果code为成功时，先校验签名，校验成功后做后续处理
                NSString * YLstring ;
                if([code isEqualToString:@"success"]) {
                    YLstring =@"success";
                    //支付成功,发送通知
                    //                    NSLog(@"银联支付成功.");
                }
                else if([code isEqualToString:@"fail"]) {
                    YLstring =@"fail";
                    //交易失败,发送通知
                    //                    NSLog(@"银联交易失败.");
                }
                else if([code isEqualToString:@"cancel"]) {
                    YLstring =@"cancel";
                    
                    //                    NSLog(@"银联交易取消.");
                }
                //支付结果发过去
                [[NSNotificationCenter defaultCenter]postNotificationName:@"YLPayResults" object:YLstring];
                
                
            }];
            
        }else if([url.host isEqualToString:@"pay"]){
#pragma mark ====================微信支付=回调 =============================
            
            return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
            
        }
#pragma mark ====================分享后后点击连接打开App指定界面iOS9 =============================
        else if ([[[[NSString stringWithFormat:@"%@",url] componentsSeparatedByString:@"://"] firstObject] isEqualToString:@"xiumei"]) {
            //收到分享回调后处理跳转(封装)
            [self getShareUseOpenApp:url];
        }else{
#pragma mark ===== 处理京东登陆授权跳转逻辑(不处理京东登陆必定失败) ==============
            // SSO授权登录回调场景使用(必须调用,如果SDK接收不到授权回调信息会造成重复授权的问题).（京东--SDK）
            return  [[KeplerApiManager sharedKPService] handleOpenURL:url];
        }
        
        
    }else{
#pragma mark ============ 各种分享回调(之后要去判断用户是否分享成功)微信、 =============================
        
        
        //友盟6。0以后 result 微信比较特殊  故放在这
        if([url.host isEqualToString:@"pay"]){
#pragma mark ====================微信支付=回调 =============================
            return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
            
        }
    }
    
    
    return result;
    
}

//iOS 8 走这里！！！！！！！
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //其他app打开嗅美时发通知，分享那边在用（iOS8）
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OtherOpenXiumei_iOS" object:url];
    
    //    为了正常使用百川内置的应用跳转处理，需要调用百川SDK的方法。建议优先调用百川处理，如果百川已处理，可以直接返回YES；当然，也可以继续处理，比如记录应用跳转来源日志等。
    //    以下代码不现实,会导致通过手淘授权登陆,跳回来没反应等问题
    // 新接口写法
    if (![[AlibcTradeSDK sharedInstance] application:application
                                             openURL:url
                                   sourceApplication:sourceApplication
                                          annotation:annotation]) {
        // 处理其他app跳转到自己的app
    }
    
    //友盟分享和登陆6.1三方回调
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];

    //下面是支付的回调(分享之类的是不会走)
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
#pragma mark ====================支付宝支=回调 ==================================
        //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
        if ([url.host isEqualToString:@"safepay"]) { //支付宝支付
            
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                NSString *message = @"";
                switch([[resultDic objectForKey:@"resultStatus"] integerValue])
                {
                    case 9000:message = @"订单支付成功";break;
                    case 8000:message = @"正在处理中";break;
                    case 4000:message = @"订单支付失败";break;
                    case 6001:message = @"用户中途取消";break;
                    case 6002:message = @"网络连接错误";break;
                    default:message = @"未知错误";
                }
                
                NSString * ZFBstring;
                
                if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) { //支付成功,发送通知
                    
//                    NSLog(@"Appledegate支付成功的回调结果:message = %@",message);
                    ZFBstring  = @"PaySuccess";
                }else{ //支付失败,发送通知
                    ZFBstring  = @"PayFail";
//                    NSLog(@"Appledegate支付失败的回调结果:message = %@",message);
                }
                //发通知，把支付宝支付结果发过去
                [[NSNotificationCenter defaultCenter]postNotificationName:@"ZFBPayresul" object:ZFBstring];
                
            }];
            
        }else if([url.host isEqualToString:@"uppayresult"]){
#pragma mark ====================银联支付=回调 =============================
            //银联支付控件结果处理函数
            [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
                
                //结果code为成功时，先校验签名，校验成功后做后续处理
                NSString * YLstring ;
                if([code isEqualToString:@"success"]) {
                    YLstring =@"success";
                    //支付成功,发送通知
//                    NSLog(@"银联支付成功.");
                }
                else if([code isEqualToString:@"fail"]) {
                    YLstring =@"fail";
                    //交易失败,发送通知
//                    NSLog(@"银联交易失败.");
                }
                else if([code isEqualToString:@"cancel"]) {
                    YLstring =@"cancel";
                    
//                    NSLog(@"银联交易取消.");
                }
                //支付结果发过去
                [[NSNotificationCenter defaultCenter]postNotificationName:@"YLPayResults" object:YLstring];
                
                
            }];
            
        }else if([url.host isEqualToString:@"pay"]){
#pragma mark ====================微信支付=回调 =============================
            
            return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
            
        }else if ([url.host isEqualToString:@"platformId=wechat"]){
#pragma mark ====================微信分享到朋友圈后==回调 =============================
            //微信朋友圈分享结果
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"WXshare" object:nil];
            
        }
#pragma mark ====================分享后后点击连接打开App指定界面iOS8 =============================
        
        else if ([[[[NSString stringWithFormat:@"%@",url] componentsSeparatedByString:@"://"] firstObject] isEqualToString:@"xiumei"]) {
           
            //收到分享回调后处理跳转(封装)
            [self getShareUseOpenApp:url];
        }else{
#pragma mark ===== 处理京东登陆授权跳转逻辑(不处理京东登陆必定失败)  ==============
            // SSO授权登录回调场景使用(必须调用,如果SDK接收不到授权回调信息会造成重复授权的问题).（京东--SDK）
            return  [[KeplerApiManager sharedKPService] handleOpenURL:url];
        }
        
    }else{
#pragma mark ============ 各种分享回调(之后要去判断用户是否分享成功)微信、 =============================
         //友盟6。0以后 result 微信比较特殊  故放在这
        if([url.host isEqualToString:@"pay"]){
#pragma mark ====================微信支付=回调 =============================
            
            return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
            
        }
    }
    
       return result;

}


//用户根据分享内容打开app后的跳转
-(void)getShareUseOpenApp:(NSURL *)url{
  
    //跳转到封装的view
    [self.apppushView getShareUseOpenAppnUrl:url];
 
}

#pragma mark ============= AppDelgate的生命周期（开始） =======================
//通知方法
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appwillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
//(1)告诉代理进程启动但还没进入状态保存
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    return YES;
}
//（2）就是创建窗口那个
//(3)当应用程序将要入非活动状态执行，在此期间，应用程序不接收消息或事件，比如来电话了====进入假死（程序将要进入后台）
- (void)applicationWillResignActive:(UIApplication *)application {
    //程序将要进入后台时请求推送过来的图片做启动页
    self.guidePageView.applicationNoActive = @"程序将要进入后台时";
    self.appView.applicationNoActive = @"程序将要进入后台时";
    //关闭键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    

}
//（4）当应用程序入活动状态执行，这个刚好跟上面那个方法相反
- (void)applicationDidBecomeActive:(UIApplication *)application{
#warning 替换友盟6.1时屏蔽的
//    [UMSocialSnsService applicationDidBecomeActive];
}

//（5）当程序被推送到后台的时候调用。所以要设置后台继续运行，则在这个函数里面设置即可（程序进入后台）
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

//（6）当程序从后台将要重新回到前台时候调用，这个刚好跟上面的那个方法相反。（程序从后台启动）
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    //关闭键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //设置开关的时候，发通知去修改
    [[NSNotificationCenter defaultCenter]postNotificationName:@"APPWillEnterForeground" object:nil];
  
    //传值到Appview层去触发方法(不要删，一直在用)
    self.appView.appEnterForeground = @"程序从后台进入前台时";
    self.guidePageView.appEnterForeground =  @"程序从后台进入前台时";
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

//（7）当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

//（8）当程序载入后执行
- (void)applicationDidFinishLaunching:(UIApplication*)application{
    
    
}
#pragma mark ============= AppDelgate的生命周期（结束） =======================



#pragma mark ============= 友盟推送接收到初始化和接到通知==开始 =======================

//友盟推送
-(void)UMpushMessage{
    
    //注册通知
    [UMessage registerForRemoteNotifications];
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            
        } else {
            //点击不允许
            
        }
    }];
    
    //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.identifier = @"action1_identifier";
    action1.title=@"打开应用";
    action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
    action2.identifier = @"action2_identifier";
    action2.title=@"忽略";
    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action2.destructive = YES;
    UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
    actionCategory1.identifier = @"category1";//这组动作的唯一标示
    [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
    NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
    
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_ios10_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_ios10_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        
        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category101" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories_ios10 = [NSSet setWithObjects:category1_ios10, nil];
        [center setNotificationCategories:categories_ios10];
    }else
    {
        [UMessage registerForRemoteNotifications:categories];
    }
    
    //如果对角标，文字和声音的取舍，请用下面的方法
    //UIRemoteNotificationType types7 = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
    //UIUserNotificationType types8 = UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
    //[UMessage registerForRemoteNotifications:categories withTypesForIos7:types7 withTypesForIos8:types8];
    
    //for log
    [UMessage setLogEnabled:YES];//打印日志
    
}


//友盟推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册，模拟器不会走这个方法
    [UMessage registerDeviceToken:deviceToken];
    
    NSString * Strdevicetoken = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    //存入友盟推送的devicetoken
    [[NSUserDefaults standardUserDefaults] setObject:Strdevicetoken forKey:@"UMdeviceToken"];
    //保证存储成功
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //1debb959708aade1fff3f63ba253cced748e64580f23fdd009bf9d0583e665dc  6plus
    //e07128cdc16875f3b06622124999a0bd38c20e82cec86401e0a73928b555c41d  6plus
    //dca9a0420df5a6995edc5d124123ec1c474effd1b6d4a3f7dc17e792f0c4c141  5s
//    公司6PIUS：9b78b2c3ba1233b1839628463087c0b5cd91337e1cb63f6d23e5788b12e712e9
    
//  公司5s：  68f10b309094a482d79bd73a5f104b73334d64a77571f1385eafe82a1f1b47cc
    
   NSLog(@"*******%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                         stringByReplacingOccurrencesOfString: @">" withString: @""]
                        stringByReplacingOccurrencesOfString: @" " withString: @""]);

    
#pragma mark ========= 融云必须设置，不然收不到消息  =================
    [[RCIMClient sharedRCIMClient] setDeviceToken:Strdevicetoken];

}

//iOS9【本地推送】走这个方法，太坑了
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
//    NSLog(@"ios9本地推送：%@",notification.userInfo);
    //推送前后台区分
    if (application.applicationState == UIApplicationStateActive) {
        //应用处于前台收到本地推送不做处理
    } else if (application.applicationState == UIApplicationStateInactive) {
        // 后台进入前台时才跳转
        [self createPushNotificationUserInfo:notification.userInfo Type:@"后台"];
        
    }
    
}
//iOS10以下
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler{
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    

    //推送前后台区分
    if (application.applicationState == UIApplicationStateActive) {
        //前台
        [self createPushNotificationUserInfo:userInfo Type:@"前台"];
        
    } else if (application.applicationState == UIApplicationStateInactive) {
        // 后台进入前台时才跳转
        [self createPushNotificationUserInfo:userInfo Type:@"后台"];
        
        
    }

}

//如果App处于Background状态时，只用用户点击了通知消息时才会调用该方法；如果App处于Foreground状态，会直接调用该方法。
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
 //暂不用
}


//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
   
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
        NSDictionary * userInfo = notification.request.content.userInfo;
        [self createPushNotificationUserInfo:userInfo Type:@"前台"];

        
    }else{
        //应用处于前台时的本地推送接受
         [self createPushNotificationUserInfo:userInfo Type:@"前台"];
    }
    
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //关闭弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
        //点击通知进入应用 NSLog(@"response:%@", response);
        NSDictionary * userInfo = response.notification.request.content.userInfo;
        [self createPushNotificationUserInfo:userInfo Type:@"后台"];

        
    }else{
        //应用处于后台时的本地推送接受
        [self createPushNotificationUserInfo:userInfo Type:@"后台"];

    }
    
}


//处理接收到的推送
-(void)createPushNotificationUserInfo:(NSDictionary *)userInfo Type:(NSString *)type{
   
    //传值到view层做各种跳转
    [self.apppushView createPushViewNotificationUserInfo:userInfo Type:type];
        
    

}
#pragma mark ============= 友盟推送接收到初始化和接到通知==结束 =======================


@end
