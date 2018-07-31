//
//  BDphoneViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/5/3.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "BDphoneViewController.h"

@interface BDphoneViewController ()<UITextFieldDelegate>{
    
    UIButton * loginBtn;
}

@property (nonatomic,strong) UITextField * phoneText;
@property (nonatomic,strong)  UITextField * secturyText;
@property(nonatomic,strong) UITextField * VerCode;

//定时器
@property(nonatomic,strong) NSTimer * time;

@property(nonatomic,assign) int s;

@end

@implementation BDphoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createNav];
    [self createUI];
    //创建定时器
    self.time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(everTime) userInfo:nil repeats:YES];
    [self.time setFireDate:[NSDate distantFuture]];
    
    //监听键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(infoAction:) name:UITextFieldTextDidChangeNotification object:nil];
}

//时时监听键盘限制手机号码输入长度为11位
- (void)infoAction:(NSNotification*)notf{
    //限制手机号
    if (self.phoneText.text.length > 11) {
        self.phoneText.text = [self.phoneText.text substringToIndex:11];
    }
    
    //确定键变颜色
    if (self.secturyText.text.length>0&&self.phoneText.text.length&&self.VerCode.text.length>0) {
        loginBtn.selected = YES;
        loginBtn.userInteractionEnabled = YES;
    }else{
        loginBtn.selected = NO;
        loginBtn.userInteractionEnabled = NO;
    }

    
}

-(void)createNav{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onLeftButtonClick)];
    self.navigationItem.leftBarButtonItem = item;
    //设置中间标题
    UILabel *label                = [[UILabel alloc]init];
    label.frame                   = CGRectMake(100, 0, self.view.frame.size.width-200, 64);
    label.text                    = @"绑定手机";
    label.textColor               = [UIColor blackColor];
    label.textAlignment           = NSTextAlignmentCenter;
    label.font                    = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    
    // 向上滑动屏幕收起键盘
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction)];
    // swipe只能有一个方向
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipe];
    
    // 向下滑动屏幕收起键盘
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownAction)];
    // swipe只能有一个方向
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];

    
}

-(void)onLeftButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createUI{
    //创建父视图
    UIView * loginSub = [[UIView alloc]initWithFrame:CGRectMake(0,64 + 20.0*px, SCREEN_WIDTH, 272.0*px)];
    loginSub.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginSub];
    //分割线1
    UIImageView * imageline =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 90.0*px, SCREEN_WIDTH, 2.0*px)];
    imageline.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [loginSub addSubview:imageline];
    //分割线2
    UIImageView * imageline2 =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 182.0*px, SCREEN_WIDTH, 2.0*px)];
    imageline2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [loginSub addSubview:imageline2];
    
    //标题
    NSArray * array = @[@"输入手机号",@"输入验证码",@"输入密码"];
    UILabel * labeltitle;
    for (int i= 0; i< 3; i++) {
        labeltitle  = [[UILabel alloc]initWithFrame:CGRectMake(0, 92.0*px * i, 216.0*px, 90.0*px)];
        labeltitle.text = array[i];
        labeltitle.textAlignment = NSTextAlignmentCenter;
        labeltitle.font = [UIFont systemFontOfSize:28.0*px];
        labeltitle.textColor = [UIColor colorWithHexString:@"#696969"];
        [loginSub addSubview:labeltitle];
        //竖线
        UIImageView * imagelinesh = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labeltitle.frame),25.0* px + 92.0*px * i, 2.0*px, 40.0*px)];
        imagelinesh.backgroundColor = [UIColor colorWithHexString:@"#696969"];
        [loginSub addSubview:imagelinesh];
        
    }
    
    //手机号
    self.phoneText=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labeltitle.frame)+12.0*px,0, SCREEN_WIDTH-12.0*px-CGRectGetMaxX(labeltitle.frame), 90.0*px)];
    self.phoneText.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneText.backgroundColor = [UIColor whiteColor];
    self.phoneText.delegate = self;
    self.phoneText.textColor = [UIColor colorWithHexString:@"#696969"];
    self.phoneText.textAlignment=NSTextAlignmentLeft;
    [loginSub addSubview:self.phoneText];
    
    //验证码
    self.VerCode=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labeltitle.frame)+12.0*px,92.0*px, SCREEN_WIDTH-12.0*px-CGRectGetMaxX(labeltitle.frame), 90.0*px)];
    self.VerCode.delegate = self;
//    //删除按钮
//    self.VerCode.clearButtonMode = UITextFieldViewModeAlways;
    self.VerCode.keyboardType = UIKeyboardTypeNumberPad;
    self.VerCode.delegate = self;
    self.VerCode.textAlignment=NSTextAlignmentLeft;
    self.VerCode.backgroundColor = [UIColor whiteColor];
     self.VerCode.textColor = [UIColor colorWithHexString:@"#696969"];
    [loginSub addSubview:self.VerCode];

    //发送验证码
    UIButton * senderCode=[UIButton buttonWithType:UIButtonTypeCustom];
    senderCode.frame=CGRectMake(SCREEN_WIDTH-15-92, 112.0*px, 88, 26);
    senderCode.backgroundColor = [UIColor whiteColor];
    [senderCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    senderCode.titleLabel.font = [UIFont systemFontOfSize:14];
    [senderCode setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [senderCode setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    senderCode.layer.borderWidth = 1;
    senderCode.layer.borderColor = MAIN_COLOR.CGColor;
    senderCode.layer.cornerRadius = 8;
    senderCode.tag = 46;
    
    [senderCode addTarget:self action:@selector(SenderCode:) forControlEvents:UIControlEventTouchUpInside];
    [loginSub addSubview:senderCode];
    
    
    //密码
    self.secturyText=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labeltitle.frame)+12.0*px,184.0*px, SCREEN_WIDTH-12.0*px-CGRectGetMaxX(labeltitle.frame), 90.0*px)];
    self.secturyText.delegate = self;

    self.secturyText.keyboardType = UIKeyboardTypeDefault;
    //    self.secturyText.secureTextEntry=YES;
    self.secturyText.delegate = self;
    self.secturyText.textAlignment=NSTextAlignmentLeft;
    self.secturyText.textColor = [UIColor colorWithHexString:@"#696969"];
    self.secturyText.backgroundColor = [UIColor whiteColor];
    [loginSub addSubview:self.secturyText];
    
    
    //眼睛图标
    UIButton * secturylook=[UIButton buttonWithType:UIButtonTypeCustom];
    secturylook.frame=CGRectMake(SCREEN_WIDTH-20-36, 207.0*px, 36, 22);
    [secturylook setImage:[UIImage imageNamed:@"ic-zhengyan"] forState:UIControlStateNormal];
    [secturylook setImage:[UIImage imageNamed:@"ic-biyan"] forState:UIControlStateSelected];
    [secturylook addTarget:self action:@selector(secturylook:) forControlEvents:UIControlEventTouchUpInside];
    [loginSub addSubview:secturylook];
    //确定按钮
    loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame=CGRectMake((SCREEN_WIDTH-500.0*px)/2, CGRectGetMaxY(loginSub.frame)+60.0*px, 500.0*px, 70.0*px);
     [loginBtn setBackgroundImage:[UIImage imageNamed:@"btn-queding-gary"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"btn-queding"] forState:UIControlStateSelected];
    loginBtn.userInteractionEnabled = NO;
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}


//点击查看密码
-(void)secturylook:(UIButton*)button{
    button.selected = !button.selected;
    if (button.selected) {
        self.secturyText.secureTextEntry=YES;
    }else{
        self.secturyText.secureTextEntry=NO;
    }
    
}

//定时器事件
-(void)everTime{
    UIButton * buttonTime = (UIButton *)[self.view viewWithTag:46];
    self.s--;
    [buttonTime setTitle:[NSString stringWithFormat:@"%d秒后重发",self.s] forState:UIControlStateNormal];
    if (self.s==0) {
        [self.time setFireDate:[NSDate distantFuture]];
        buttonTime.selected = NO;
        buttonTime.layer.borderColor = MAIN_COLOR.CGColor;
        [buttonTime setTitle:@"获取验证码" forState:UIControlStateNormal];
        buttonTime.userInteractionEnabled = YES;
    }
    
}


//发送验证码
-(void)SenderCode:(UIButton*)button{
      [self.view endEditing:YES];
    if (self.phoneText.text.length==0) {
        
        if (ios8orLater) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"  message:@"手机号码不能为空" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
            
        }
        
        return;
    }
    
    if (self.phoneText.text.length < 11) {
        UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入11位手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        return;
    }else{
        //调用类别方法验证手机号码
        BOOL isPhone = [NSString phoneText: self.phoneText.text];
        
        if (isPhone==YES) {
            button.selected = YES;
            button.layer.borderColor = [UIColor grayColor].CGColor;
            button.userInteractionEnabled = NO;
            //发送验证码
            NSInteger random = (NSInteger)(10000000 + (arc4random() % (99999999 - 10000000+1)));
            NSString *randomStr = [NSString stringWithFormat:@"%zd",random];
            NSString *key = @"1f496a10a5e606f2602b0a78863870e97d61856t";
            NSString *sign = [NSString sha1:[NSString stringWithFormat:@"%@%@%@@",randomStr,key,self.phoneText.text]];
            
            NSDictionary * dic = @{@"mobile":self.phoneText.text,
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
            
            //启动定时器
            [self.time setFireDate:[NSDate distantPast]];
            _s=60;
            

        }else{
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
            return;
        }
        
    }
}

//确定
-(void)login:(UIButton*)button{
     [self.view endEditing:YES];
    
    //检测手机号码
    if (self.phoneText.text.length==0) {
        UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        return;
    }
    
    if (self.phoneText.text.length < 11) {
        UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入11位手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        return;
    }else{
        //调用类别方法验证手机号码
        BOOL isPhone = [NSString phoneText: self.phoneText.text];
        
        if (isPhone==YES) {
            //手机号码正确，继续往下走
        }else{
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
            return;
        }
    }
    
    //检测密码
    if (self.secturyText.text.length==0) {
        UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        return;
    }
    
    //检测验证码
    if (self.VerCode.text.length==0) {
        UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入验证码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        return;
    }

    //MD5加密密码
     NSString * strPassword = [self.secturyText.text MD5Hash];
    NSDictionary * dic = @{@"mobile":self.phoneText.text,@"sessionId":SESSIONID,@"passWord":strPassword,@"code":self.VerCode.text};
    [GXJAFNetworking POST:Phone_Binding parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            if (ios8orLater) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"  message:@"修改成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //返回
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                
                UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [aler show];
                
            }
            
        }
        
        if ([responseObject[@"code"] isEqual:@"01"]) {
            if (ios8orLater) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"  message:@"验证码错误" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                
                UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [aler show];
                
                
            }
            
        }
        
        if ([responseObject[@"code"] isEqual:@"02"]) {
            
            if (ios8orLater) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"  message:@"请不要重复绑定" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                
                UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请不要重复绑定" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [aler show];
                
            }
            
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//关闭键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//向上滑动收键盘
-(void)swipeAction{
    //关闭键盘
     [self.view endEditing:YES];
}
//向上滑动收键盘
-(void)swipeDownAction{
    //关闭键盘
     [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@", self.class]];//("PageOne"为页面名称，可自定义)
    
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@", self.class]];
   
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
