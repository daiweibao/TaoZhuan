//
//  RegisteredController.m
//  AiHenDeChaoXi
//
//  Created by 爱恨的潮汐 on 2018/5/25.
//  Copyright © 2018年 AiHenDeChaoXi. All rights reserved.
//

#import "RegisteredController.h"
//融云聊天无界面组件
#import <RongIMLib/RongIMLib.h>
@interface RegisteredController ()<UITextFieldDelegate>
@property (nonatomic,weak)UITextField *phoneTextField;//手机号输入框
@property (nonatomic,weak)UITextField *passwordTextField;//密码输入框
@property (nonatomic,weak)UITextField *passwordTextField2;//密码输入框
@property (nonatomic,weak)UIButton *loginButton;//登陆按钮
@end

@implementation RegisteredController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;//隐藏返回键
    self.titleLabel.text = @"用户注册";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createUI];
}

-(void)createUI{
    
    //手机号标题
    UIButton *phoneTitleBution = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneTitleBution setTitle:@"账    号" forState:UIControlStateNormal];
    [phoneTitleBution setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    phoneTitleBution.titleLabel.font = [UIFont systemFontOfSize:16];
    phoneTitleBution.userInteractionEnabled = NO;
    [self.view addSubview:phoneTitleBution];
    [phoneTitleBution mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(MC_NavHeight+50);
        make.size.mas_equalTo(CGSizeMake(75, 44));
    }];
    
    //手机号输入框
    UITextField *phoneTextField = [[UITextField alloc]init];
    self.phoneTextField = phoneTextField;
    phoneTextField.placeholder=@"  请输入账号";
    phoneTextField.font = [UIFont systemFontOfSize:16];
    phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
    phoneTextField.keyboardType = NSNumberFormatterDecimalStyle;
    phoneTextField.delegate = self;
    phoneTextField.textAlignment=NSTextAlignmentLeft;
    phoneTextField.textColor = [UIColor blackColor];
    phoneTextField.layer.borderWidth = 1;
    phoneTextField.layer.cornerRadius = 5;
    phoneTextField.clipsToBounds = YES;
    phoneTextField.layer.borderColor = MAIN_COLOR.CGColor;
    [self.view addSubview:phoneTextField];
    
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneTitleBution.mas_right).offset(10);
        make.top.mas_equalTo(phoneTitleBution);
        make.height.mas_equalTo(phoneTitleBution.mas_height);
        make.right.mas_equalTo(self.view).offset(-40);
    }];
    
    
    
    //密码标题
    UIButton *passwordTitleBution = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordTitleBution setTitle:@"密    码" forState:UIControlStateNormal];
    [passwordTitleBution setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    passwordTitleBution.titleLabel.font = [UIFont systemFontOfSize:16];
    passwordTitleBution.userInteractionEnabled = NO;
    [self.view addSubview:passwordTitleBution];
    [passwordTitleBution mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(phoneTitleBution.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(75, 44));
    }];
    
    //密码输入框
    UITextField *passwordTextField = [[UITextField alloc]init];
    self.passwordTextField = passwordTextField;
    passwordTextField.placeholder=@"  请输入密码";
    passwordTextField.font = [UIFont systemFontOfSize:16];
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField.keyboardType = NSNumberFormatterDecimalStyle;
    passwordTextField.delegate = self;
    passwordTextField.textAlignment=NSTextAlignmentLeft;
    passwordTextField.textColor = [UIColor blackColor];
    passwordTextField.layer.borderWidth = 1;
    passwordTextField.layer.cornerRadius = 5;
    passwordTextField.clipsToBounds = YES;
    passwordTextField.layer.borderColor = MAIN_COLOR.CGColor;
    [self.view addSubview:passwordTextField];
    
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordTitleBution.mas_right).offset(10);
        make.top.mas_equalTo(passwordTitleBution);
        make.height.mas_equalTo(passwordTitleBution.mas_height);
        make.right.mas_equalTo(self.view).offset(-40);
    }];
    
    
    
    //密码标题2
    UIButton *passwordTitleBution2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordTitleBution2 setTitle:@"重复密码" forState:UIControlStateNormal];
    [passwordTitleBution2 setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    passwordTitleBution2.titleLabel.font = [UIFont systemFontOfSize:16];
    passwordTitleBution2.userInteractionEnabled = NO;
    [self.view addSubview:passwordTitleBution2];
    [passwordTitleBution2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(passwordTitleBution.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(75, 44));
    }];
    
    //密码输入框2
    UITextField *passwordTextField2 = [[UITextField alloc]init];
    self.passwordTextField2 = passwordTextField2;
    passwordTextField2.placeholder=@"  请再次输入密码";
    passwordTextField2.font = [UIFont systemFontOfSize:16];
    passwordTextField2.clearButtonMode = UITextFieldViewModeAlways;
    passwordTextField2.keyboardType = NSNumberFormatterDecimalStyle;
    passwordTextField2.delegate = self;
    passwordTextField2.textAlignment=NSTextAlignmentLeft;
    passwordTextField2.textColor = [UIColor blackColor];
    passwordTextField2.layer.borderWidth = 1;
    passwordTextField2.layer.cornerRadius = 5;
    passwordTextField2.clipsToBounds = YES;
    passwordTextField2.layer.borderColor = MAIN_COLOR.CGColor;
    [self.view addSubview:passwordTextField2];
    
    [passwordTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordTitleBution2.mas_right).offset(10);
        make.top.mas_equalTo(passwordTitleBution2);
        make.height.mas_equalTo(passwordTitleBution.mas_height);
        make.right.mas_equalTo(self.view).offset(-40);
    }];
    
    
    
    
    //登陆按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton = loginButton;
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.backgroundColor = MAIN_COLOR;
    loginButton.layer.cornerRadius = 20;
    [loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordTitleBution2.mas_bottom).mas_offset(40);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(self.view).mas_offset(-40);
        make.height.mas_equalTo(40);
    }];
    
}

//注册
-(void)loginButtonClick:(UIButton*)button{
    [self.view endEditing:YES];//关闭键盘
    if ([NSString isNULL:self.phoneTextField.text]) {
        [DWBToast showCenterWithText:@"账号码不能为空"];
        return;
    }
    if ([NSString isNULL:self.passwordTextField.text]) {
        [DWBToast showCenterWithText:@"密码不能为空"];
        return;
    }
    if ([NSString isNULL:self.passwordTextField2.text]) {
        [DWBToast showCenterWithText:@"重复密码不能为空"];
        return;
    }
    //把账号存进去
    [[NSUserDefaults standardUserDefaults] setObject:self.phoneTextField.text forKey:@"MobilePhoneNumber"];
    [MBProgressHUD showHUDLodingStart:@"注册中" toView:self.view];
    //登陆
    NSDictionary * dict = @{@"userName":self.phoneTextField.text,//用户名
                            @"password1":[NSString md5:self.passwordTextField.text],//密码，md5加密
                            @"password2":[NSString md5:self.passwordTextField2.text]//密码，md5加密
                            };
    [GXJAFNetworking POST:addUser parameters:dict success:^(id  _Nullable responseObject) {
        NSLog(@"注册结果：%@",responseObject);
        if ([responseObject[@"code"] isEqual:@"00"]) {//登陆成功
            //登陆成功后的操做
            [self loginSuccessAfter:responseObject];
            
        }else{
            [MBProgressHUD hideHUDForView:self.view];//隐藏加载中
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
            
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view];//隐藏加载中
    }];
}

//登陆成功后返回00的操作
-(void)loginSuccessAfter:(id)responseObject{

    //用户资料缓存--封装
    [NSString userInfoCacheMyuserId:responseObject[@"userInfo"][@"userId"] AndUserName:responseObject[@"userInfo"][@"nickName"] AndUserImage:responseObject[@"userInfo"][@"image"] AndUserType:responseObject[@"userInfo"][@"userType"]];
    
    NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
    [defuaults setObject:responseObject[@"userInfo"][@"sessionId"] forKey:@"sessionId"];
    //保证数据存储成功
    [defuaults synchronize];
    
#pragma mark ================= 用户登陆成功后去登陆融云=====
    [self loginRongCloud];
    
    
    //登陆成功后发的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSussceAfterNotice" object:nil];
    
    [MBProgressHUD hideHUDForView:self.view];//隐藏加载中
    
    [MBProgressHUD showSuccess:@"注册成功，已为你登陆"];
    
     self.tabBarController.selectedIndex = 0;//回首页
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
        [MBProgressHUD hideHUDForView:self.view];//隐藏加载中
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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //收键盘
    [self.view endEditing:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
