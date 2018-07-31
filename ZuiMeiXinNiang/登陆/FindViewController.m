//
//  FindViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/1/17.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "FindViewController.h"

//融云聊天无界面组件
#import <RongIMLib/RongIMLib.h>

#import "AppDelegateView.h"

@interface FindViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIView * viewPhone;
@property (nonatomic,strong)  UITextField * phoneNumber;
@property (nonatomic,strong)  UITextField * textCode;
@property (nonatomic,strong)  UITextField * pwdCode;

@property(nonatomic,strong)UIView * viewCode;


@property(nonatomic,strong)UIView * viewPassword;

//获取验证码按钮
@property(nonatomic,strong)UIButton * buttonGetCode;
//下一步按钮
@property(nonatomic,strong)UIButton * nextBtn;


/**
 *  创建定时器
 */
@property(nonatomic,strong) NSTimer * time;

@property(nonatomic,assign) int s;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    if (self.type.length > 0) {
        self.titleLabel.text = @"设置密码";
    }else{
        self.titleLabel.text = @"填写新密码";
    }
    [self createUI];
    
    //定时器
    self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(everTime) userInfo:nil repeats:YES];
    [self.time setFireDate:[NSDate distantFuture]];

    //监听键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(infoAction:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

-(void)createUI{
    
     //手机号码父视图
    self.viewPhone=[[UIView alloc]initWithFrame:CGRectMake(36, MC_NavHeight+43, SCREEN_WIDTH-72, 66)];
    self.viewPhone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.viewPhone];
    
    UIImageView * imviewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(15, 23, 15, 20)];
    imviewIcon.image = [UIImage imageNamed:@"shouji"];
    [_viewPhone addSubview:imviewIcon];
    
    //输入手机号的框框
    self.phoneNumber=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imviewIcon.frame)+15, 0, SCREEN_WIDTH, 66)];
    self.phoneNumber.delegate = self;
    self.phoneNumber.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneNumber.keyboardType = UIKeyboardTypeDefault;
    self.phoneNumber.placeholder = @"请输入手机号";
    self.phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumber.textAlignment=NSTextAlignmentLeft;
    self.phoneNumber.font = [UIFont systemFontOfSize:16];
    [self.viewPhone addSubview:self.phoneNumber];
    
    //线1
    UIImageView * imageline1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH-72, 1)];
    imageline1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.viewPhone addSubview:imageline1];
    

    //验证码父视图
    self.viewCode = [[UIView alloc]initWithFrame:CGRectMake(36,CGRectGetMaxY(self.viewPhone.frame), SCREEN_WIDTH-72, 66)];
    [self.view addSubview:self.viewCode];
    
    UIImageView * imviewIcon2 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 24, 17, 18)];
    imviewIcon2.image = [UIImage imageNamed:@"验证码1.4.2"];
    [self.viewCode addSubview:imviewIcon2];
    
    //输入yanzhnegma的框框
    self.textCode=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imviewIcon2.frame)+15, 0, SCREEN_WIDTH/3, 66)];
    self.textCode.delegate = self;
    self.textCode.clearButtonMode = UITextFieldViewModeAlways;
    self.textCode.keyboardType = UIKeyboardTypeDefault;
    self.textCode.placeholder = @"请输入验证码";
    self.textCode.keyboardType = UIKeyboardTypeNumberPad;
    self.textCode.textAlignment=NSTextAlignmentLeft;
    self.textCode.font = [UIFont systemFontOfSize:16];
    [self.viewCode addSubview:self.textCode];
    
    //获取短信验证码按钮
    //获取验证码
    CGFloat getValidationCodeW = [NSString sizeMyStrWith:@"获取验证码" andFontSize:13 andMineWidth:SCREEN_WIDTH].width+60.0*px;
    _buttonGetCode = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonGetCode.userInteractionEnabled = NO;
    _buttonGetCode.frame = CGRectMake(SCREEN_WIDTH-72-getValidationCodeW,20, getValidationCodeW, 27);
    [_buttonGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    _buttonGetCode.titleLabel.font = [UIFont systemFontOfSize:13];
    _buttonGetCode.backgroundColor = [UIColor whiteColor];
    [_buttonGetCode setTitleColor:[UIColor colorWithHexString:@"#cbced5"] forState:UIControlStateNormal];
    _buttonGetCode.tag = 46;
    _buttonGetCode.layer.borderWidth = 1.0*px;
    _buttonGetCode.layer.borderColor = [UIColor colorWithHexString:@"#cbced5"].CGColor;
    _buttonGetCode.layer.cornerRadius = 27/2;
     _buttonGetCode.clipsToBounds = YES;
    [_buttonGetCode addTarget:self action:@selector(pressButtonGetNumber:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewCode addSubview:_buttonGetCode];
    
    //线1
    UIImageView * imageline2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH-72, 1)];
    imageline2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.viewCode addSubview:imageline2];
    
    
    
    
    
    
    
    
    
    //请输入密码
    self.viewPassword = [[UIView alloc]initWithFrame:CGRectMake(36,CGRectGetMaxY(self.viewCode.frame), SCREEN_WIDTH-72, 66)];
    [self.view addSubview:self.viewPassword];
    
    UIImageView * imviewIcon3 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 13, 16)];
    imviewIcon3.image = [UIImage imageNamed:@"suo"];
    [self.viewPassword addSubview:imviewIcon3];
    
    //输入密码的框框
    self.pwdCode=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imviewIcon3.frame)+15, 0, SCREEN_WIDTH-100, 66)];
    self.pwdCode.delegate = self;
    self.pwdCode.clearButtonMode = UITextFieldViewModeAlways;
    self.pwdCode.keyboardType = UIKeyboardTypeDefault;
    self.pwdCode.placeholder = @"请输入密码(6-20位数字或字母)";
    self.pwdCode.keyboardType = NSNumberFormatterDecimalStyle;
    self.pwdCode.textAlignment=NSTextAlignmentLeft;
    self.pwdCode.font = [UIFont systemFontOfSize:16];
    [self.viewPassword addSubview:self.pwdCode];
    
    //线1
    UIImageView * imageline3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH-72, 1)];
    imageline3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.viewPassword addSubview:imageline3];
    
    
    
    
    
    //确定按钮
    _nextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.userInteractionEnabled = NO;
    _nextBtn.frame=CGRectMake(36, CGRectGetMaxY(self.viewPassword.frame)+45, SCREEN_WIDTH-72, 40);
    _nextBtn.layer.cornerRadius = 20;
    _nextBtn.clipsToBounds = YES;
    [_nextBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_nextBtn setTitle:@"确定" forState:UIControlStateSelected];
    _nextBtn.backgroundColor = [UIColor colorWithHexString:@"#cbced5"];
    [_nextBtn addTarget:self action:@selector(Next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    
}


//获取验证码按钮
-(void)pressButtonGetNumber:(UIButton*)button{
    
    //调用类别方法验证手机号码
    BOOL isPhone = [NSString phoneText: _phoneNumber.text];
    
    if (isPhone==YES) {
        //手机号码正确，继续往下走
        
        
        //让按钮不可点击  背景色改变
        _buttonGetCode.userInteractionEnabled = NO;
        //背景颜色
        _buttonGetCode.backgroundColor = MAIN_COLOR;
        //框的颜色
        _buttonGetCode.layer.borderColor = MAIN_COLOR.CGColor;
        //字体颜色
        [_buttonGetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //发送验证码
        [self dataSenderVerificationCode];
        //创建定时器
        [self.time setFireDate:[NSDate distantPast]];
        _s=60;
        
        
    }else{
        UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        return;
    }
    
}

//定时器事件
-(void)everTime{
    self.s--;
    [_buttonGetCode setTitle:[NSString stringWithFormat:@"%ds",self.s] forState:UIControlStateNormal];
    if (self.s==0) {
        [self.time setFireDate:[NSDate distantFuture]];
        //让按钮可点击  背景色改变
        [_buttonGetCode setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
        _buttonGetCode.userInteractionEnabled = YES;
        //背景颜色
        _buttonGetCode.backgroundColor = MAIN_COLOR;
        //框的颜色
        _buttonGetCode.layer.borderColor = MAIN_COLOR.CGColor;
        //字体颜色
        [_buttonGetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }
}


//发送验证码
-(void)dataSenderVerificationCode{
    NSInteger random = (NSInteger)(10000000 + (arc4random() % (99999999 - 10000000+1)));
    NSString *randomStr = [NSString stringWithFormat:@"%zd",random];
    NSString *key = @"1f496a10a5e606f2602b0a78863870e97d61856t";
    NSString *sign = [NSString sha1:[NSString stringWithFormat:@"%@%@%@@",randomStr,key,self.phoneNumber.text]];
    
    NSDictionary * dic = @{@"mobile":self.phoneNumber.text,
                           @"sign":sign,
                           @"randStr":randomStr
                           };
    [GXJAFNetworking POST:SENDER_CODE parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
        }else{
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
 }





//下一步
-(void)Next:(UIButton*)button{
#pragma mark ==========正则表达式匹配手机号码===============
    //调用类别方法验证手机号码
    BOOL isPhone = [NSString phoneText: _phoneNumber.text];
    if (isPhone==YES) {
        //手机号码正确，继续往下走
        button.userInteractionEnabled = NO;
    }else{
        //提示
        [DWBToast showCenterWithText:@"请输入正确的手机号码"];
        return;
        
    }
    
    [MBProgressHUD showHUDLodingStart:@"加载中" toView:self.view];
    //验证手机号码是否已经被注册
    NSDictionary * dic = @{@"mobile":_phoneNumber.text};
    [GXJAFNetworking POST:verifyPhone parameters:dic success:^(id  _Nullable responseObject) {
        //手机号码没有被注册
        if ([responseObject[@"code"] isEqual:@"00"]) {
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该手机号码还没注册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
            [MBProgressHUD showHUDLodingEnd:@"加载完毕" toView:self.view];
            return;
        }else if ([responseObject[@"code"] isEqual:@"01"]) {
            //手机号码已经被注册
            //去验证验证码是否正确
            [self CodeIsOk];
        }else{
            [MBProgressHUD showHUDLodingEnd:@"操作未能完成" toView:self.view];
        }
    } failure:^(NSError * _Nullable error) {
         button.userInteractionEnabled = YES;
    }];
}

//验证码是否正确
-(void)CodeIsOk{
    NSDictionary * dic = @{@"mobile":_phoneNumber.text,@"code":self.textCode.text};
    [GXJAFNetworking POST:valideCode parameters:dic success:^(id  _Nullable responseObject) {
        //验证码错误
        if ([responseObject[@"code"] isEqual:@"01"]) {
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
            [MBProgressHUD showHUDLodingEnd:@"加载完毕" toView:self.view];
            return;
            
        }else if ([responseObject[@"code"] isEqual:@"00"]) {
            //验证码正确，继续下一步
            [self pressButtonOK];
            
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//返回按钮的点击事件
-(void)pressButtonLeft{
    [self.navigationController popViewControllerAnimated:YES];
}


//时时监听键盘限制手机号码输入长度为11位
- (void)infoAction:(NSNotification*)notf{
    
    if (self.pwdCode.text.length > 0) {
        self.nextBtn.backgroundColor = MAIN_COLOR;
        self.nextBtn.userInteractionEnabled = YES;
        
        //限制密码
        if (self.pwdCode.text.length > 20) {
            self.pwdCode.text = [self.pwdCode.text substringToIndex:20];
            [DWBToast showCenterWithText:@"密码不能超过20位"];
        }
    
    }else{
        self.nextBtn.backgroundColor = [UIColor colorWithHexString:@"#cbced5"];
         self.nextBtn.userInteractionEnabled = NO;
    }
    
    //限制手机号
    if (self.phoneNumber.text.length > 11) {
        self.phoneNumber.text = [self.phoneNumber.text substringToIndex:11];
        [DWBToast showCenterWithText:@"手机号码不能超过11位"];
    }
    if (self.phoneNumber.text.length ==11 && _s == 0) {
        //背景颜色
        _buttonGetCode.backgroundColor = MAIN_COLOR;
        //框的颜色
        _buttonGetCode.layer.borderColor = MAIN_COLOR.CGColor;
        //字体颜色
        [_buttonGetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //交互打开
        _buttonGetCode.userInteractionEnabled = YES;
    }
    

}





//刚激活输入框
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    //电话号码栏被激活
    if ([textField isEqual:self.phoneNumber]) {
        
    }
    
    //验证码栏被激活
    if ([textField isEqual:self.textCode]) {
        if (self.phoneNumber.text.length != 11) {
            [AlertViewTool AlertAlertWithTitle:@"" Message:@"请输入手机号码" otherItemArrays:@[@"确定"] viewController:self handler:^(NSInteger index) {
                [textField resignFirstResponder];
            }];
        }
    }
    
     //密码码栏被激活
    if ([textField isEqual:self.pwdCode]) {
        if (self.phoneNumber.text.length != 11 || self.textCode.text.length == 0) {
            [textField resignFirstResponder];
            if (self.phoneNumber.text.length != 11 && self.textCode.text.length != 0) {
                [AlertViewTool AlertAlertWithTitle:@"" Message:@"请输入手机号码" otherItemArrays:@[@"确定"] viewController:self handler:^(NSInteger index) {
                    
                }];
            }else if (self.phoneNumber.text.length == 11 && self.textCode.text.length == 0) {
                [AlertViewTool AlertAlertWithTitle:@"" Message:@"请输入验证码" otherItemArrays:@[@"确定"] viewController:self handler:^(NSInteger index) {
                }];
            }else{
                [AlertViewTool AlertAlertWithTitle:@"" Message:@"请输入手机号码和验证码" otherItemArrays:@[@"确定"] viewController:self handler:^(NSInteger index) {
                }];
            
            }
            
        }
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



//修改密码的请求
-(void)pressButtonOK{
    
    [self.view endEditing:YES];
    if (self.pwdCode.text.length<6||self.pwdCode.text.length>20) {
        
         [MBProgressHUD showHUDLodingEnd:@"加载完毕" toView:self.view];
       
        [DWBToast showCenterWithText:@"请输入6至20位数字字母组合密码"];
        return;
    }
    
        BOOL result = false;
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:self.pwdCode.text];
        
        if (result==NO) {
            [MBProgressHUD showHUDLodingEnd:@"加载完毕" toView:self.view];
            [DWBToast showCenterWithText:@"密码必须包含数字和字母"];
            return;
        }
    

    if (self.pwdCode.text.length >=6&& self.pwdCode.text.length <= 20) {
        
#pragma mark 开始设置新密码
        //开始请求数据发送注册信息
        NSString * strPassword1=[self.pwdCode.text MD5Hash];
        NSDictionary * dic = @{@"mobile":self.phoneNumber.text,@"code":self.textCode.text,@"newPassword":strPassword1};
        
        [GXJAFNetworking POST:Change_Password parameters:dic success:^(id  _Nullable responseObject) {
            //注册成功后提示用户
            if ([responseObject[@"code"] isEqual:@"00"]) {
                
                [MBProgressHUD showHUDLodingEnd:@"加载完毕" toView:self.view];
                
                NSString *str;
                if (self.type.length > 0) {
                    str = @"密码设置成功";
                }else{
                    str = @"密码修改成功";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"恭喜你"  message:str preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    //修改完完先登录
                    NSString * strPassword=[self.pwdCode.text MD5Hash];
                    NSDictionary * dicrrr = @{@"password":strPassword,@"mobile":self.phoneNumber.text};
                    [GXJAFNetworking POST:PHONE_LOGIN parameters:dicrrr success:^(id  _Nullable responseObject) {
                        if ([responseObject[@"code"] isEqual:@"00"]) {
#pragma mark 将用户手机号呢登陆成功后的sessionId存入数据库
                            NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
                            [defuaults setObject:responseObject[@"userInfo"][@"sessionId"] forKey:@"sessionId"];
                            //把用户ID存进去
                            [defuaults setObject:responseObject[@"userInfo"][@"userId"] forKey:@"userId"];
                            //登陆后把用户类型存进去
                            [defuaults setObject:responseObject[@"userInfo"][@"userType"] forKey:@"userType"];
                            //把用户头像连接存进去
                            [defuaults setObject:responseObject[@"userInfo"][@"image"] forKey:@"userPhoneImage"];
                            //把用户名存进去
                            [defuaults setObject:responseObject[@"userInfo"][@"nickName"] forKey:@"userName"];
                            
            
                            //发通知刷新我的资料
                            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshHeadNotification" object:nil];
#pragma mark ================= 用户登陆成功后去登陆融云=====
                            [self loginRongCloud];
                            
                         
                            //跳回我的界面
                            self.tabBarController.selectedIndex = 0;
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            
                            
                        }else{
                            [MBProgressHUD showHUDLodingEnd:@"加载完毕" toView:self.view];
                            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登录失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [aler show];
                            
                        }
                    } failure:^(NSError * _Nullable error) {
                        [MBProgressHUD showHUDLodingEnd:@"加载完毕" toView:self.view];
                        //没网等各种错误提示(把句号替换成空白)
                        UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登录失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [aler show];
                    }];
                    
                }];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];

            }else{
                [AlertViewTool AlertAlertWithTitle:@"很遗憾" Message:@"密码修改失败" otherItemArrays:@[@"确定"] viewController:self handler:nil];
                
            }
        } failure:^(NSError * _Nullable error) {
            
        }];
    }
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
                
            }
        });
    } failure:^(NSError * _Nullable error) {
        
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


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


@end
