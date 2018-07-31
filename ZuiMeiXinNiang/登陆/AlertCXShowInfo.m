//
//  CXShowInfoView.m
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/4/20.
//  Copyright © 2018年 AiHenDeChaoXi. All rights reserved.
//

#import "AlertCXLoginView.h"

//融云聊天无界面组件
#import <RongIMLib/RongIMLib.h>

//友盟分享之三方登陆6.1
#import <UMSocialCore/UMSocialCore.h>

#import "WebViewController.h"

#import "LoginViewController.h"

@interface AlertCXLoginView()

@property (nonatomic, weak) UIView *contentView;

@end

@implementation AlertCXLoginView

/**
 登陆弹窗
 
 @param blackHome 登陆后是佛返回首页，传nil代表不返回
 @param loginSuccess 登录成的回调
 */
+ (void)showAletCXInfoisBlackHome:(NSString*)blackHome LoginSuccess:(void (^)(void))loginSuccess{
    
    //不在keyWindow上
    UIView * viewWX = (UIView*)[[UIApplication sharedApplication].keyWindow.rootViewController.view viewWithTag:19920229];
    //移除弹框
    [viewWX removeFromSuperview];
  
   //创建
    AlertCXLoginView * alertView = [[AlertCXLoginView alloc]init];
    alertView.tag = 19920229;
    //添加 ==不在keyWindow上
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:alertView];

    [alertView setUpContentView];
    
}


//init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        //设置蒙版层背景色
        self.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.7];
        //关闭用户交互
        self.userInteractionEnabled = YES;
    }
    return self;
}

//创建UI
- (void)setUpContentView{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIView *contentView = [[UIView alloc]init];
        self.contentView = contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.masksToBounds = YES;
        contentView.layer.cornerRadius =5;
        //拦截点击事件
        contentView.clipsToBounds = YES;
        contentView.userInteractionEnabled = YES;
        //添加控件
        [self addSubview:contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(240);
        }];
        
        //创建UI
        [self createUI];
    });
}


#pragma mark ========== UI ===============
-(void)createUI{
//    com.chaoxi.huashengfanli
//   关闭
    UIButton * buttonClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonClose setImage:[UIImage imageNamed:@"登录关闭"] forState:UIControlStateNormal];
    [buttonClose addTarget:self action:@selector(pressButtonClose) forControlEvents:UIControlEventTouchUpInside];
    buttonClose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_contentView addSubview:buttonClose];
    [buttonClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(_contentView.mas_right).mas_offset(-10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    

    //添加icon
    UIButton * buttonIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonIcon.frame = CGRectMake(240/2-25, 10, 50, 50);
    //在这里判断成功还是失败
    [buttonIcon setImage:[UIImage imageNamed:appLogoName] forState:UIControlStateNormal];
     buttonIcon.imageView.layer.cornerRadius = 5;
    buttonIcon.imageView.clipsToBounds = YES;
    [_contentView addSubview:buttonIcon];
    [buttonIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_contentView.mas_centerX);
        make.top.mas_equalTo(_contentView.mas_top).mas_offset(30);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    
    //用户协议
    UILabel * labelUserXY = [[UILabel alloc]init];
    [_contentView addSubview:labelUserXY];
    labelUserXY.font = [UIFont systemFontOfSize:12];
    labelUserXY.textColor = [UIColor grayColor];
    labelUserXY.textAlignment = NSTextAlignmentCenter;
    labelUserXY.attributedText = [NSString getLabelNOSpacingChangeColor:[UIColor blueColor] andFont:[UIFont systemFontOfSize:12] andString1:@"点击登录即表示你同意" andChangeString:@"用户协议" andGetstring3:@""];
    [labelUserXY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buttonIcon.mas_bottom).offset(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    labelUserXY.userInteractionEnabled = YES;
    [labelUserXY addTapActionTouch:^{
         UINavigationController * navMy = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
        WebViewController * webView = [[WebViewController alloc]init];
        webView.strTitle = @"淘赚用户协议";
        webView.sttWebID = agreement;
        //模态带导航栏
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:webView];
        [nv setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [navMy presentViewController:nv animated:YES completion:nil];

        
    }];
    
    //微信登陆按钮
    UIButton * buttonWXLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonWXLogin.backgroundColor = MAIN_COLOR_WXBlue;
    buttonWXLogin.layer.cornerRadius = 5;
    [buttonWXLogin addTarget:self action:@selector(pressButtonWXlogin) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:buttonWXLogin];
    [buttonWXLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labelUserXY.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(_contentView.mas_centerX);
        make.height.mas_equalTo(40);
    }];
    //微信图标
    UIImageView * imageViewIcon = [[UIImageView alloc]init];
    imageViewIcon.image = [UIImage imageNamed:@"wx登陆"];
    [buttonWXLogin addSubview:imageViewIcon];
    [imageViewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buttonWXLogin).mas_offset(10);
        make.left.mas_equalTo(60);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    //汉字
    UILabel * labelWXtitle = [[UILabel alloc]init];
    [buttonWXLogin addSubview:labelWXtitle];
    labelWXtitle.text = @"微信登陆";
    labelWXtitle.textAlignment = NSTextAlignmentCenter;
    labelWXtitle.font = [UIFont systemFontOfSize:14];
    labelWXtitle.textColor = [UIColor whiteColor];
    [labelWXtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(imageViewIcon.mas_right).offset(5);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(buttonWXLogin.mas_right).mas_offset(-60);
    }];

    //手机号码登陆
    UILabel * labelPhoneLogin = [[UILabel alloc]init];
    [_contentView addSubview:labelPhoneLogin];
    NSDictionary *dic = @{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"账号登录" attributes:dic];
    labelPhoneLogin.attributedText = attribtStr;
    labelPhoneLogin.textAlignment = NSTextAlignmentCenter;
    labelPhoneLogin.font = [UIFont systemFontOfSize:16];
    labelPhoneLogin.textColor = [UIColor grayColor];
     labelPhoneLogin.userInteractionEnabled = YES;
    [labelPhoneLogin addTapActionTouch:^{
        UINavigationController * navMy = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        //模态带导航栏
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        //翻转动画
        [nv setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [navMy presentViewController:nv animated:YES completion:nil];
        //关闭弹窗
        [self pressButtonClose];
    }];
    
    [labelPhoneLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buttonWXLogin.mas_bottom).mas_offset(10);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(_contentView.mas_bottom).mas_offset(-20);
    }];
}

//关闭
-(void)pressButtonClose{
    //控件动画影藏
     [self removeFromSuperview];
}

//微信登陆
-(void)pressButtonWXlogin{
    //微信登陆
    [self authWithGetgetUserInfo:UMSocialPlatformType_WechatSession];
}


//三方登陆授权和得到用户信息
-(void)authWithGetgetUserInfo:(UMSocialPlatformType)platform{
    //    三方登陆授权并且获取用户资料6.1适配https
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platform currentViewController:nil completion:^(id result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [DWBToast showCenterWithText:@"登录失败"];
            } else {
                UMSocialUserInfoResponse *resp = result;
                //把三方登陆得到的数据发给后台
                [self loginSuccess:resp];
                
            }
        });
    }];
    
}

//三方登陆成功后做的操作,吧数据发给后台
- (void)loginSuccess:(UMSocialUserInfoResponse *)snsAccount{
    
    [MBProgressHUD showHUDLodingStart:@"登录中" toView:self];

    NSDictionary * dic=@{@"uid":snsAccount.uid,//第三方返回的id   uid
                         @"nickName":snsAccount.name,//第三方昵称
                         @"deviceType":@(1),//设备类型（0 安卓 1苹果 2 H5）
                         @"imageUrl":snsAccount.iconurl,//第三方头像连接snsAccount.iconurl
                         @"pushToken":UMdeviceToken,//友盟token
                         @"tokenType":@1,//友盟token类型   0 安卓   1 ios
                         };
    [GXJAFNetworking POST:addUser parameters:dic success:^(id  _Nullable responseObject) {
        //      isPerfectInfo  0信息没有完善
        //     isPresent   false  没有赠送优惠券   true 赠送了优惠券
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
            [MBProgressHUD hideHUDForView:self];//隐藏加载中
            [MBProgressHUD showSuccess:@"登陆成功"];
            
            //用户资料缓存--封装
            [NSString userInfoCacheMyuserId:responseObject[@"userInfo"][@"userId"] AndUserName:responseObject[@"userInfo"][@"nickName"] AndUserImage:responseObject[@"userInfo"][@"image"] AndUserType:responseObject[@"userInfo"][@"userType"]];
            
            NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
            [defuaults setObject:responseObject[@"userInfo"][@"sessionId"] forKey:@"sessionId"];
            //保证数据存储成功
            [defuaults synchronize];
            
            
            //记录用户最后使用app的时间
            [AppDelegateView userEndmakeAppTime];
            
#pragma mark ================= 用户登陆成功后去登陆融云=====
            [self loginRongCloud];
            
            
            if (self.loginRefresh) {
                self.loginRefresh();
            }
            
            //关闭弹窗
            [self pressButtonClose];
            //发通知刷新我的界面
            [[NSNotificationCenter defaultCenter]postNotificationName:@"mineLoginSussce" object:nil];
            
            
        }else{
            [MBProgressHUD hideHUDForView:self];//隐藏加载中
            [MBProgressHUD showError:@"登陆失败"];
        }
        
    } failure:^(NSError * _Nullable error) {
         [MBProgressHUD hideHUDForView:self];//隐藏加载中
    }];
    
}

#pragma mark ================= 开始登陆融云（重要）======================
//获取融云用户Token
-(void)loginRongCloud{
    NSDictionary * dict = @{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:getUserToken parameters:dict success:^(id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([responseObject[@"code"] isEqual:@"00"]) {
                //token存入本地
                NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
                //把融云Token存入本地
                [defuaults setObject:responseObject[@"token"] forKey:@"RCIMToken"];
                //是否是绑定达人   fasle 没有  true 绑定   (邀请达人的聊天的时候不获取热门问题 3.4版本)
                if ([NSString isNULL:responseObject[@"isBangDingDaren"]]==NO) {
                    [defuaults setObject:[NSString stringWithFormat:@"%@",responseObject[@"isBangDingDaren"]] forKey:@"ISBangDingTalentPeople"];
                    if ([[NSString stringWithFormat:@"%@",responseObject[@"isBangDingDaren"]] isEqual:@"1"]) {
                        //已经绑定了达人，把达人名字和头像存进去
                        //把用户名存进去
                        [defuaults setObject:responseObject[@"darenName"] forKey:@"userName"];
                        //把用户头像连接存进去
                        [defuaults setObject:responseObject[@"darenImg"] forKey:@"userPhoneImage"];
                    }
                }
                
                //保证数据存储成功
                [defuaults synchronize];
                //得到Token
                [self createUItoken:responseObject[@"token"] AndUseInfo:responseObject];
                
                //                NSLog(@"%@",USER_name);
            }
        });
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self];//隐藏加载中
    }];
}

//登陆融云界面组件
-(void)createUItoken:(NSString*)token AndUseInfo:(NSDictionary *)responseObject{
    
    [[RCIMClient sharedRCIMClient] connectWithToken:token success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        //设置当前登录用户的资料
        RCUserInfo * user = [[RCUserInfo alloc]init];
        if ([NSString isNULL:responseObject[@"isBangDingDaren"]]==NO) {
            if ([[NSString stringWithFormat:@"%@",responseObject[@"isBangDingDaren"]] isEqual:@"1"]) {
                //达人资料
                user.portraitUri = responseObject[@"darenImg"];
                user.name = responseObject[@"darenName"];
            }else{
                //用户资料
                user.portraitUri = responseObject[@"image"];
                user.name = responseObject[@"nickName"];
            }
        }
        user.userId = [NSString stringWithFormat:@"%@",responseObject[@"userId"]];
        //当前登录用户的用户信息
        [RCIMClient sharedRCIMClient].currentUserInfo = user;
        
    } error:^(RCConnectErrorCode status) {
        //        34001
        NSLog(@"登陆的错误码为:%ld", (long)status);
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


#pragma mark ================= 登陆融云结束（重要）======================


@end
