//
//  ChangePasswordViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/2/24.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "NSString+Hashing.h"
@interface ChangePasswordViewController ()
@property (nonatomic,strong) UITextField * phoneText;

@property (nonatomic,strong)  UITextField * secturyText;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createNavigationController];
    [self createUI];
    //监听键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(infoAction:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

//时时监听键盘限制手机号码输入长度为11位
- (void)infoAction:(NSNotification*)notf{
    //限制密码
    if (self.phoneText.text.length > 20) {
        self.phoneText.text = [self.phoneText.text substringToIndex:20];
    }
    
    //限制密码为6到10位
    if (self.secturyText.text.length > 20) {
        self.secturyText.text = [self.secturyText.text substringToIndex:20];
    }
}


#pragma mark 创建导航栏
-(void)createNavigationController{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(pressButtonLeft)];
    self.navigationItem.leftBarButtonItem = item;
    //设置中间标题
    UILabel *label                = [[UILabel alloc]init];
    label.frame                   = CGRectMake(100, 0, self.view.frame.size.width-200, 64);
    label.text                    = @"修改密码";
    label.textColor               = [UIColor blackColor];
    label.textAlignment           = NSTextAlignmentCenter;
    label.font                    = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
    
    UIButton * buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonRight.frame = CGRectMake(0, 0, 44, 44);
    [buttonRight setTitle:@"确定" forState:UIControlStateNormal];
    buttonRight.titleLabel.adjustsFontSizeToFitWidth = YES;
    [buttonRight setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    buttonRight.titleLabel.font = [UIFont systemFontOfSize:15];
    [buttonRight addTarget:self action:@selector(pressButtonOK:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * itemright  = [[UIBarButtonItem alloc]initWithCustomView:buttonRight];
    self.navigationItem.rightBarButtonItem = itemright;


    
}


-(void)createUI{
    //旧密码
    UILabel * labelold = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 86.0*px)];
    labelold.text = @"    旧密码";
    labelold.font = [UIFont systemFontOfSize:28.0*px];
    labelold.textColor = [UIColor colorWithHexString:@"#898989"];
    [self.view addSubview:labelold];
    
    //锁1
    UIButton * buttonlock = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonlock.frame = CGRectMake(0, CGRectGetMaxY(labelold.frame), 88.0*px, 72.0*px);
    [buttonlock setImage:[UIImage imageNamed:@"suo"] forState:UIControlStateNormal];
    buttonlock.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonlock];
    
    self.phoneText=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonlock.frame), CGRectGetMaxY(labelold.frame), SCREEN_WIDTH-CGRectGetMaxX(buttonlock.frame), 72.0*px)];
    self.phoneText.placeholder=@"请输入旧密码";
    self.phoneText.backgroundColor = [UIColor whiteColor];
    self.phoneText.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneText.textAlignment=NSTextAlignmentLeft;
    self.phoneText.secureTextEntry=YES;
    [self.view addSubview:self.phoneText];
    
    
    //新密码
    UILabel * labelold2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneText.frame), SCREEN_WIDTH, 86.0*px)];
    labelold2.text = @"    新密码";
    labelold2.font = [UIFont systemFontOfSize:28.0*px];
    labelold2.textColor = [UIColor colorWithHexString:@"#898989"];
    [self.view addSubview:labelold2];
    
    //锁2
    UIButton * buttonlock2 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonlock2.frame = CGRectMake(0, CGRectGetMaxY(labelold2.frame), 88.0*px, 72.0*px);
    [buttonlock2 setImage:[UIImage imageNamed:@"suo"] forState:UIControlStateNormal];
    buttonlock2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonlock2];

    
    
    self.secturyText=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(buttonlock.frame), CGRectGetMaxY(labelold2.frame), SCREEN_WIDTH-CGRectGetMaxX(buttonlock.frame), 72.0*px)];
    self.secturyText.placeholder=@"请输入新密码";
//    self.secturyText.clearButtonMode = UITextFieldViewModeAlways;
    self.secturyText.keyboardType = UIKeyboardTypeDefault;
    self.secturyText.backgroundColor = [UIColor whiteColor];
    self.secturyText.secureTextEntry=YES;
    self.secturyText.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:self.secturyText];
    
    //眼睛图标
    UIButton * secturylook=[UIButton buttonWithType:UIButtonTypeCustom];
    secturylook.frame=CGRectMake(SCREEN_WIDTH-46, CGRectGetMaxY(labelold2.frame), 46, 72.0*px);
    [secturylook setImage:[UIImage imageNamed:@"kejian-"] forState:UIControlStateNormal];
    [secturylook setImage:[UIImage imageNamed:@"bukejian-"] forState:UIControlStateSelected];
    [secturylook addTarget:self action:@selector(secturylook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secturylook];

    
    
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


//返回按钮
-(void)pressButtonLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

//下一步按钮点击事件
-(void)pressButtonOK:(UIButton*)button{
    
//    [self.view endEditing:YES];
    
    if (self.phoneText.text.length<6||self.phoneText.text.length>20) {
        UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入6至20位数字字母组合密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        return;
    }
    
    
    BOOL result = false;
    if ([self.secturyText.text length] >= 6 && [self.secturyText.text length] <= 20){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:self.secturyText.text];
        
        if (result==NO) {
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"新密码必须同时包含字母跟数字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
            return;
            
        }
    }
    
    
    if (self.secturyText.text.length >=6&& self.secturyText.text.length <= 20) {
#pragma mark 修改密码
        button.userInteractionEnabled = NO;
            NSString * strPassword1=[self.phoneText.text MD5Hash];
            NSString * strPassword2=[self.secturyText.text MD5Hash];
        
//        NSLog(@"%@==%@",self.phoneText.text,self.secturyText.text);
        
            NSDictionary * dic = @{@"sessionId":SESSIONID,@"oldPassword":strPassword1,@"newPassword":strPassword2};
        [GXJAFNetworking POST:Change_UsePassword parameters:dic success:^(id  _Nullable responseObject) {
            NSString * strSuccess = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            if ([strSuccess isEqual:@"00"]) {
                button.userInteractionEnabled = YES;
                if (ios8orLater) {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"恭喜你"  message:@"密码修改成功" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //发通知刷新我的资料
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshHeadNotification" object:nil];
                        //跳到首页
                        self.tabBarController.selectedIndex = 0;
                        [self.navigationController popToRootViewControllerAnimated:NO];
                        
                    }];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }else{
                    //iOS 8之前
                    UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"恭喜你" message:@"密码修改成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    aler.delegate =self;
                    aler.tag = 110;
                    [aler show];
                    
                }
                
                
            }else{
                
                button.userInteractionEnabled = YES;
                
                
                if (ios8orLater) {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"很遗憾"  message:@"密码修改失败,旧密码不正确" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        //                            [self.navigationController popToRootViewControllerAnimated:NO];
                        
                    }];
                    UIAlertAction * cantent = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    [alertController addAction:cantent];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }else{
                    //iOS 8之前
                    UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"很遗憾" message:@"密码修改失败,旧密码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                    aler.delegate = self;
                    aler.tag = 111;
                    [aler show];
                    
                    
                }
                
                
            }
        } failure:^(NSError * _Nullable error) {
           button.userInteractionEnabled = YES;
        }];

    }else{
        
        UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"可美提示" message:@"请输入6至20位数字字母组合密码" delegate:nil cancelButtonTitle:@"哦" otherButtonTitles:nil, nil];
        [aler show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //修改成功
    if (alertView.tag==110) {
        if (buttonIndex==0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    //修改失败
    if (alertView.tag==111) {
        if (buttonIndex==0) {
            
            [self.navigationController popToRootViewControllerAnimated:NO];
         }
    }
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
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
