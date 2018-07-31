//
//  AppPushView.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2016/11/23.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "AppPushView.h"

//跳转网页
#import "WebViewController.h"

//花生订单列表界面
#import "PeanutOrderListController.h"
#import "PeanutServiceListController.h"
#import "GXJChatListController.h"
@interface AppPushView()

//推送过来的
@property (nonatomic,strong)NSNumber *pushId;
@property (nonatomic,copy)NSString *type;


@end

@implementation AppPushView

// 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        }
    return self;
}

/*
 alert	String	远程推送显示的内容。自带的消息会有默认显示，如果您使用的是自定义消息，需要在发送时设置。对应于 iOS 发送消息接口中的 pushContent。
 cType	String	会话类型。PR 指单聊、 DS 指讨论组、 GRP 指群组、 CS 指客服、SYS 指系统会话、 MC 指应用内公众服务、 MP 指跨应用公众服务。
 fId	String	消息发送者的用户 ID。
 oName	String	消息类型，参考融云消息类型表.消息标志；可自定义消息类型。
 tId	String	Target ID。
 appData	String	远程推送的附加信息，对应于 iOS 发送消息接口中的 pushData。
 aps =     {
 alert = "\U6f6e\U6c50:Eeeee";
 badge = 3;
 sound = "sms-received.caf";
 };
 rc =     {
 cType = PR;
 fId = 4;
 id = "";
 oName = "RC:TxtMsg";
 tId = 4;
 };
 */

//融云聊天消息跳转
-(void)getRCIMChatInfo:(NSDictionary *)userInfo{
    UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
    //进入消息列表
    if ([NSString isNULL:SESSIONID]) {
        //登陆
       
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
    }else{
        //消息列表
        GXJChatListController *  chatListVC = [[GXJChatListController alloc]init];
        [nav pushViewController:chatListVC animated:YES];
    }
    
}

//处理接收到的推送
-(void)createPushViewNotificationUserInfo:(NSDictionary *)userInfo Type:(NSString *)type{
    NSLog(@"收到推送：%@",userInfo);
    if ([NSString isNULL:userInfo[@"rc"][@"fId"]]==NO) {
        //融云远程消息推送
        if ([type isEqual:@"后台"]) {
            //收到融云聊天消息
            [self getRCIMChatInfo:userInfo];
        }
        return;
    }else if([NSString isNULL:userInfo[@"RCIMuserName"]]==NO){
        //融云本地消息推送
        if ([type isEqual:@"后台"]) {
            //收到融云聊天消息
            [self getRCIMChatInfo:userInfo];
        }
        return;
    }else if([NSString isNULL:userInfo[@"RCIMuserName"]]){
        if ([NSString isNULL:userInfo[@"type"]]) {
            //收到融云本地空消息，并且不是远程推送消息（直播过程非常频繁）
            return;
        }else{
            //收到其他远程推送不要拦截
        }
    }
#pragma mark ========== 上面是融云聊天消息推送处理=========
    
//    type是判断前后台的
    //解析字典得到推送内容
    self.pushId = userInfo[@"pushId"];
    NSString * img = userInfo[@"img"];
    self.type = userInfo[@"type"];
    NSString * title = userInfo[@"title"];
    
    //单独推送用的ID
    NSNumber * singleId = userInfo[@"oid"];
    
#pragma mark==== 接到推送广告 (另外一种弹窗)(类型16)=============
    if ([self.type isEqual:@"1"]||[self.type isEqual:@"2"]||[self.type isEqual:@"3"]||[self.type isEqual:@"4"]||[self.type isEqual:@"5"]||[self.type isEqual:@"6"]||[self.type isEqual:@"7"]||[self.type isEqual:@"8"]||[self.type isEqual:@"9"]) {
#pragma mark==== >>需要弹窗<<的推送与不需要弹窗的推送分支(集体推送)=============
        //蒙版
        UIImageView *coverImage = [[UIImageView alloc]init];
        coverImage.userInteractionEnabled = YES;
        coverImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        coverImage.image = [UIImage imageNamed:@"黑色蒙版"];
        coverImage.tag = 10050;
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:coverImage];
        
        //背景容器
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 250.0*px, SCREEN_HEIGHT/2 - 210.0*px, 500.0*px, 420.0*px)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 7;
        contentView.layer.masksToBounds = YES;
        [coverImage addSubview:contentView];
        
        //心形状图标
        UIImageView *heartImage = [[UIImageView alloc]init];
        heartImage.userInteractionEnabled = YES;
        heartImage.frame = CGRectMake(0, 0, 500.0*px, 282.0*px);
        //heartImage.image = [UIImage imageNamed:@"1元夺宝详情爱心"];
        [heartImage sd_setImageWithURL:[NSURL URLWithString:img]];
        heartImage.contentMode = UIViewContentModeScaleAspectFill;
        heartImage.clipsToBounds = YES;
        [contentView addSubview:heartImage];
        UITapGestureRecognizer *imageClick1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toSee)];
        [heartImage addGestureRecognizer:imageClick1];
        
        //在图片上的提示汉字
        UILabel * labeltitle  = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(heartImage.frame)+25.0*px,500.0*px, 15)];
        labeltitle.text = title;
        labeltitle.adjustsFontSizeToFitWidth = YES;
        labeltitle.font = [UIFont systemFontOfSize:14];
        labeltitle.textColor = [UIColor blackColor];
        labeltitle.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:labeltitle];
        
        //按钮
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, CGRectGetMaxY(labeltitle.frame), 500.0*px,420.0*px-CGRectGetMaxY(labeltitle.frame));
        [btn setImage:[UIImage imageNamed:@"推送点击查看"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(toSee) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:btn];
        
        //关闭
        UIButton * closebtn=[UIButton buttonWithType:UIButtonTypeCustom];
        closebtn.frame=CGRectMake(CGRectGetMaxX(contentView.frame)-22, SCREEN_HEIGHT/2 - 210.0*px-22, 44,44);
        [closebtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        [closebtn addTarget:self action:@selector(closePush) forControlEvents:UIControlEventTouchUpInside];
        [coverImage addSubview:closebtn];
        
    }else{
#pragma mark =============== 不需要弹窗的 ====================
        //推送前后台区分
        if ([type isEqual:@"前台"]) {
            //              NSLog(@"执行前台对应的操作,也就是手机在前端运行时收到推送的处理");
            
            //如果用户在前端运行推送就顶部状态栏提醒--JDStatusBarStyleDark 样式
            if ([NSString isNULL:title]==NO) {
                
                [JDStatusBarNotification showJDStatusBarMy:title];
            }else{
                
                 [JDStatusBarNotification showJDStatusBarMy:@"你有新的消息"];
            }
            
        }else{
            //用户之间单独推送的跳转，比如评论
            // 后台进入前台时才跳转
            //              NSLog(@"执行后台进入前台对应的操作，也就是手机从在后台收到消息时做的处理");
            //单独推送，不需要弹窗
            //push控制器
            UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
           
            //22花生订单列表界面
            if ([self.type isEqual:@"22"]) {
                
                //点击跳转我的订单界面
                if ([NSString isNULL:SESSIONID]) {
                    //登陆
                 
                    //弹窗登陆
                    [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                        
                    }];
                    
                }else{
                    //花生订单列表界面
                    PeanutOrderListController * OrderList = [[PeanutOrderListController alloc]init];
                    OrderList.hidesBottomBarWhenPushed = YES;
                    [nav pushViewController:OrderList animated:YES];
                }
            }
            
        }
    }
}

//关闭弹窗
- (void)closePush{
    UIImageView *covery = [[UIApplication sharedApplication].keyWindow.rootViewController.view viewWithTag:10050];
    [covery removeFromSuperview];
}
//点击查看
- (void)toSee{
    UIImageView *covery = [[UIApplication sharedApplication].keyWindow.rootViewController.view viewWithTag:10050];
    [covery removeFromSuperview];
    //    类型   1 长文  2文章  3 专区 4商家 5团购 6心情 7秒杀 8 话题 9试用商品 18美店详情（红人动态详情）
    //push控制器
    UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
    
}

//用户根据分享内容打开app后的跳转
-(void)getShareUseOpenAppnUrl:(NSURL *)url{
    
    //分享后点击内容打开app 根据切割后的第一个元素来判断，如果是就进来，否则不走
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        // 在这里我是自己解析的参数 据说可以用[]url query]取得参数 我没试过
        NSString *strUrl = [NSString stringWithFormat:@"%@", url];
        NSString *queryStr = [[strUrl componentsSeparatedByString:@"://data?"] lastObject];
        NSArray *queryParameters = [queryStr componentsSeparatedByString:@"&"];
        NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
        for (NSString *strCondition in queryParameters) {
            NSArray *keyValueArr = [strCondition componentsSeparatedByString:@"="];
            [paramDict setObject:[keyValueArr lastObject] forKey:[keyValueArr firstObject]];
        }
//        [DWBToast showCenterWithText:[NSString stringWithFormat:@"分享连接：%@",url] duration:100];
//        NSLog(@"分享连接：%@==解析数据：%@",url,paramDict);
        //push控制器
        UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
        
        //    秒杀分享
        NSNumber * parameterId  = paramDict[@"parameter"];
        
        if ([paramDict[@"type"] isEqual:@"1"]) {
//            SecondsKilldetailController * SecondsVC = [[SecondsKilldetailController alloc]init];
//            SecondsVC.SecondsId = parameterId;
//            SecondsVC.hidesBottomBarWhenPushed = YES;
//            [nav pushViewController:SecondsVC animated:YES];
        }else if ([paramDict[@"type"] isEqual:@"2"]) {
          
        }else if ([paramDict[@"type"] isEqual:@"3"]) {
           
            
        }else if ([paramDict[@"type"] isEqual:@"4"]) {
          
        }else if ([paramDict[@"type"] isEqual:@"5"]) {
          
           
        }else if ([paramDict[@"type"] isEqual:@"6"]) {
          
            
        }else if ([paramDict[@"type"] isEqual:@"7"]) {
          
            
            
        }else if ([paramDict[@"type"] isEqual:@"8"]) {
           
        }else if ([paramDict[@"type"] isEqual:@"9"]) {
        
            
        }else if ([paramDict[@"type"] isEqual:@"10"]) {
            //    品牌商品分享

        }else if ([paramDict[@"type"] isEqual:@"11"]) {
         
            
        }else if ([paramDict[@"type"] isEqual:@"12"]) {
         
        }else if ([paramDict[@"type"] isEqual:@"14"]) {

            
        }else if ([paramDict[@"type"] isEqual:@"15"]) {
            //15免费课程单个视频的分享
         
            
        }else if ([paramDict[@"type"] isEqual:@"16"]) {
          
            
        }else if ([paramDict[@"type"] isEqual:@"17"]) {
            //17主题详情
         
            
            
        }else if ([paramDict[@"type"] isEqual:@"18"]) {
            //18美店的分享 //美店详情
         
            
            
        }else if ([paramDict[@"type"] isEqual:@"19"]) {
//
            
            
        }else if ([paramDict[@"type"] isEqual:@"20"]) {
//

            
        }else{
            
            
        }

    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"message" message:@"地址有误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}


//3D touch
-(void)three3DTouch:(NSString*)type{
    
    //push控制器
    UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
    //方式two - type
    if ([type isEqualToString:@"topic"]) {
        //话题
        //如果没有登录，先去登录
        if (SESSIONID.length==0) {
            //登陆
          
            //弹窗登陆
            [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                
            }];
            return;
        }else{
            
          
        }
        
        
        
        
    }else if ([type isEqualToString:@"SignIn"]){
        //签到
        if (SESSIONID.length==0) {
            //登陆
          
            //弹窗登陆
            [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                
            }];
        }else{
            
        }
        
    }else if ([type isEqualToString:@"xiumeihome"]){
      
        
        
        
    }else{
        //我的消息
        if ([NSString isNULL:SESSIONID]) {
         
            //弹窗登陆
            [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                
            }];
        }else{
            //客服列表
            PeanutServiceListController  * Notfinfo = [[PeanutServiceListController alloc]init];
            Notfinfo.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:Notfinfo animated:YES];
        }
    }

    
}


#pragma mark ============== 三方启动广告点击事件 =====================
+(void)getAdsafeAction:(NSDictionary*)dict{
    if ([NSString isNULL:dict[@"startPageCode"]]) {
        //判空
        return;
    }
    //push控制器
    UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
    
//    广告类型   1 秒杀详情 2 试用详情 3专区详情 4 专栏详情 5 主题列表 6 专区列表 7 外链  8 闪屏
    if ([dict[@"startPageCode"] isEqual:@1]) {
        if ([NSString isNULL:dict[@"paramId"]]) {
            //判空,后面在判断连接
            if ([NSString isNULL:dict[@"outerUrl"]]==NO) {
                //打开外连接
                [NSString openOutUrl:dict[@"outerUrl"]];
            }
        }else{
            //1 秒杀详情
//            SecondsKilldetailController * textVC = [[SecondsKilldetailController alloc]init];
//            textVC.SecondsId = dict[@"paramId"];
//            textVC.hidesBottomBarWhenPushed = YES;
//            [nav pushViewController:textVC animated:YES];
        }
    }else if ([dict[@"startPageCode"] isEqual:@7]) {

        //打开外连接
        [NSString openOutUrl:dict[@"outerUrl"]];
    }
   //8是闪屏，不跳转
    
}

@end
