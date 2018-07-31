//
//  FindOrderController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/5/7.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "FindOrderController.h"

@interface FindOrderController ()<UITextFieldDelegate>
@property (nonatomic,weak) UITextField * textFieldOrder;//订单号
@end

@implementation FindOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"手动找回订单 - 淘赚";
    
    [self createUI];
}

//创建UI
-(void)createUI{
    
    //
    UILabel *labelName = [[UILabel alloc]init];
    labelName.text = @"输入淘宝订单编号找回订单";
    labelName.textAlignment = NSTextAlignmentCenter;
    labelName.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:labelName];
    [labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MC_NavHeight+20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.right.mas_equalTo(0);
    }];
    
    //
    UILabel *labeltips = [[UILabel alloc]init];
    labeltips.text = @"tips：打开淘宝APP复制订单到输入框里，以找回~";
    labeltips.font = [UIFont systemFontOfSize:12];
    labeltips.textColor = [UIColor grayColor];
    labeltips.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labeltips];
    [labeltips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labelName.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.right.mas_equalTo(0);
    }];
    
    
    
    //手机号码输入框
    UITextField *textFieldOrder=[[UITextField alloc]init];
    self.textFieldOrder = textFieldOrder;
    textFieldOrder.placeholder=@"点此输入淘宝订单号";
    textFieldOrder.font = [UIFont systemFontOfSize:15];
    textFieldOrder.clearButtonMode = UITextFieldViewModeAlways;
    textFieldOrder.keyboardType = UIKeyboardTypeNumberPad;
    textFieldOrder.delegate = self;
    textFieldOrder.textAlignment=NSTextAlignmentLeft;
    textFieldOrder.textColor = [UIColor blackColor];
    textFieldOrder.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.textFieldOrder];
    [textFieldOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labeltips.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(44);
    }];
    
    //找回
    UIButton * buttonShare = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonShare setTitle:@"立即找回" forState:UIControlStateNormal];
    buttonShare.titleLabel.font = [UIFont systemFontOfSize:16];
    buttonShare.layer.cornerRadius = 20;
    buttonShare.backgroundColor =RGB_COLOR(255, 103, 43);
    [buttonShare addTarget:self action:@selector(ActionButtonFind) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonShare];
    [buttonShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textFieldOrder.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
    }];
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//手动找回淘宝订单
-(void)ActionButtonFind{
    if ([NSString isNULL:self.textFieldOrder.text]) {
        [DWBToast showCenterWithText:@"订单号不能为空"];
        return;
    }
    [self.view endEditing:YES];
    NSDictionary *dict = @{@"sessionId":SESSIONID,@"orderId":self.textFieldOrder.text};
    [GXJAFNetworking POST:findTaobaoOrder parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
            
                
                //发通知刷新我的订单
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyOrderList" object:nil];
                
                //提示用户
                [AlertGXJView AlertGXJAlertWithController:self Title:@"订单找回成功" Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {
                }];
                
            });
        }else{
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
        }
    } failure:^(NSError * _Nullable error) {

    }];
}






-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
