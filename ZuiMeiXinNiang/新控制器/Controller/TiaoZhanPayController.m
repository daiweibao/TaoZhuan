//
//  TiaoZhanPayController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/5/3.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "TiaoZhanPayController.h"

@interface TiaoZhanPayController ()

@property(nonatomic,copy)NSString *  blanceMoney;//余额
@property(nonatomic,weak)UIButton * buttonPay;
@property(nonatomic,weak)UILabel * labelBalance;

@end

@implementation TiaoZhanPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"早起挑战";
    //初始化为1，默认选中第一份
    self.blanceMoney = @"0.00";
    
    [self createUI];
    
    //数据
    [self getTXLoadata];
}

//余额数据
-(void)getTXLoadata{
    [MBProgressHUD showHUDLodingStart:@"加载中..." toView:self.view];
    NSDictionary * dic = @{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:preWithdraw parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新数据
                self.blanceMoney = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"gainMoney"]];
                if ([NSString isNULL:self.blanceMoney]==NO) {
                    self.labelBalance.text = [NSString stringWithFormat:@"淘赚余额：%@元",self.blanceMoney];
                }
                
                //支付1元，判断按钮显示状态
                if (1 <= self.blanceMoney.floatValue) {
                    //可支付
                    self.buttonPay.backgroundColor =RGB_COLOR(255, 103, 43);
                    [self.buttonPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    self.buttonPay.userInteractionEnabled = YES;
                }else{
                    //不可以支付
                    self.buttonPay.backgroundColor =[UIColor grayColor];
                    [self.buttonPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    self.buttonPay.userInteractionEnabled = NO;
                }
                
                
                [MBProgressHUD hideHUDForView:self.view];//影藏加载中
            });
        }else{
            [MBProgressHUD hideHUDForView:self.view];//影藏加载中
        }
        
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view];//影藏加载中
    }];
    
}


-(void)createUI{
    UILabel * labelTitle = [[UILabel alloc]init];
    labelTitle.numberOfLines = 2;
    labelTitle.font = [UIFont systemFontOfSize:16];
    labelTitle.attributedText = [NSString getLabelLineSpace:@"支付1元参与明天6:00-8:00\n早起分钱挑战" LineSpacing:10];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelTitle];
    
    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MC_NavHeight+30);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    

    //余额展示
    UILabel * labelBalance = [[UILabel alloc]init];
    self.labelBalance = labelBalance;
    labelBalance.text = @"淘赚余额：0.00元";
    labelBalance.textAlignment = NSTextAlignmentCenter;
    labelBalance.font = [UIFont systemFontOfSize:24];
    labelBalance.textColor = [UIColor blackColor];
    [self.view addSubview:labelBalance];
    
    [labelBalance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labelTitle.mas_bottom).offset(30);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    
    //支付按钮
    UIButton * buttonPay = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonPay = buttonPay;
    [buttonPay setTitle:@"支付1元" forState:UIControlStateNormal];
    buttonPay.titleLabel.font = [UIFont systemFontOfSize:16];
    buttonPay.layer.cornerRadius = 5;
    buttonPay.backgroundColor =RGB_COLOR(255, 103, 43);
    [buttonPay addTarget:self action:@selector(ActionButtonPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonPay];
    [buttonPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labelBalance.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    
    //创建提示
    UILabel * labelTips = [[UILabel alloc]init];
    labelTips.text = @"提示：支付时将从淘赚余额扣除相应金额，余额不足无法支付";
    labelTips.textAlignment = NSTextAlignmentCenter;
    labelTips.numberOfLines = 0;
    labelTips.font = [UIFont systemFontOfSize:12];
    labelTips.textColor = MAIN_COLOR;
    [self.view addSubview:labelTips];
    
    [labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buttonPay.mas_bottom).offset(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
}


//立即支付--用户第一天首次打卡
-(void)ActionButtonPay{
    //请求数据-- self.PayNum
    //用加载中挡住，防止重复点击
    [MBProgressHUD showHUDLodingStart:@"支付中..." toView:self.view];
    self.buttonPay.userInteractionEnabled = NO;//关闭交互
    //支付
    NSDictionary *dict = @{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:playCard parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view];//影藏加载中
                self.buttonPay.userInteractionEnabled = YES;//打开交互
                //刷新余额数据
                [self getTXLoadata];
                
                //回调会刷新
                if (self.blackRefreshMoney) {
                    self.blackRefreshMoney();
                }
                
                [AlertGXJView AlertGXJAlertWithController:self Title:@"成功" Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {
                    if (index==0) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
                
            });
        }else{
            [MBProgressHUD hideHUDForView:self.view];//影藏加载中
            self.buttonPay.userInteractionEnabled = YES;//打开交互
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view];//影藏加载中
        self.buttonPay.userInteractionEnabled = YES;//打开交互
    }];
    
}


-(void)dealloc{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;

    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
