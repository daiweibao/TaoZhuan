//
//  BangDingZFBController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/14.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "BangDingZFBController.h"

@interface BangDingZFBController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property(nonatomic,weak)UITextField *textFieldNumber;
@property(nonatomic,weak)UITextField *textFieldName;
@end

@implementation BangDingZFBController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    if ([self.type isEqual:@"修改"]) {
          self.titleLabel.text = @"修改账户";
    }else{
        self.titleLabel.text = @"绑定账户";
    }
    
    [self tableView];
    
}



-(void)pressButtonLeft{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) style:UITableViewStyleGrouped];
        _tableView.bounces = NO;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //tableview拖动时收起键盘
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //去掉分割线
//        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //视频iOS11
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
        
        [self.view addSubview:_tableView];
        
        //点击关闭键盘
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CloseKeyBody)];
        [self.tableView addGestureRecognizer:tap];
    }
    
    return _tableView;
}
//收键盘
-(void)CloseKeyBody{
    [self.view endEditing:YES];
}
//覆盖方法(解决手势与cell点击事件冲突问题)
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

//脚
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 200;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footviewother = [[UIView alloc]init];
    footviewother.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //确定按钮
    UIButton * buttonOK = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonOK.frame = CGRectMake(30.0*px, 40.0*px, SCREEN_WIDTH-60.0*px, 44);
    [buttonOK setTitle:@"确认绑定" forState:UIControlStateNormal];
    buttonOK.backgroundColor = MAIN_COLOR;
    [buttonOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonOK.titleLabel.font = [UIFont systemFontOfSize:17];
    buttonOK.layer.cornerRadius = 5;
    [buttonOK addTarget:self action:@selector(ActionButtonOK) forControlEvents:UIControlEventTouchUpInside];
    [footviewother addSubview:buttonOK];
    
    //提示
    UILabel * labelMoneyTXInfo1 = [[UILabel alloc]init];
    labelMoneyTXInfo1.frame = CGRectMake(30.0*px, buttonOK.bottomY+10.0*px, SCREEN_WIDTH-60.0*px, 12);
    labelMoneyTXInfo1.font = [UIFont systemFontOfSize:11];
    labelMoneyTXInfo1.textColor = [UIColor grayColor];
    labelMoneyTXInfo1.text = @"一个手机号只能绑定一个账号，绑定后不可修改";
    labelMoneyTXInfo1.textAlignment = NSTextAlignmentCenter;
    [footviewother addSubview:labelMoneyTXInfo1];
    
    return footviewother;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //关闭缓存
    UITableViewCell * cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    /* 忽略点击效果 */
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView removeAllSubviews];//移除所有子视图
    
    if (indexPath.row==0) {
        //支付宝账号
        UITextField *textFieldNumber=[[UITextField alloc]initWithFrame:CGRectMake(30.0*px, 0, SCREEN_WIDTH-60.0*px, 44)];
        self.textFieldNumber = textFieldNumber;
        //修改占位符颜色
        [textFieldNumber setValue:[UIColor colorWithHexString:@"#b0b0b0"]forKeyPath:@"_placeholderLabel.textColor"];
        textFieldNumber.font = [UIFont systemFontOfSize:14];
        textFieldNumber.clearButtonMode = UITextFieldViewModeAlways;
        textFieldNumber.keyboardType = NSNumberFormatterDecimalStyle;
        textFieldNumber.delegate = self;
        if ([NSString isNULL:self.zhifubaoNum]) {
            textFieldNumber.text = @"";
        }else{
            textFieldNumber.text = [NSString stringWithFormat:@"%@",self.zhifubaoNum];
        }
        textFieldNumber.placeholder = @"请输入支付宝账号";
        textFieldNumber.textColor = [UIColor blackColor];
        [cell.contentView addSubview:textFieldNumber];
    }else{
        //名字
        UITextField *textFieldName=[[UITextField alloc]initWithFrame:CGRectMake(30.0*px, 0, SCREEN_WIDTH-60.0*px, 44)];
        self.textFieldName = textFieldName;
        //修改占位符颜色
        [textFieldName setValue:[UIColor colorWithHexString:@"#b0b0b0"]forKeyPath:@"_placeholderLabel.textColor"];
        textFieldName.font = [UIFont systemFontOfSize:14];
        textFieldName.clearButtonMode = UITextFieldViewModeAlways;
        textFieldName.delegate = self;
        textFieldName.placeholder = @"请输入真实姓名";
        textFieldName.textColor = [UIColor blackColor];
        if ([NSString isNULL:self.zhifubaoName]) {
            textFieldName.text = @"";
        }else{
            textFieldName.text = [NSString stringWithFormat:@"%@",self.zhifubaoName];
        }
        [cell.contentView addSubview:textFieldName];
    }
    
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


//确定
-(void)ActionButtonOK{
    [self.view endEditing:YES];
    if ([NSString isNULL:self.textFieldNumber.text]) {
        [DWBToast showCenterWithText:@"请输入支付宝账号"];
        return;
    }
    if ([NSString isNULL:self.textFieldName.text]) {
        [DWBToast showCenterWithText:@"请输入真实姓名"];
        return;
    }
   
    NSDictionary * dic = @{@"sessionId":SESSIONID,
                           @"alipay":self.textFieldNumber.text,
                           @"userName":self.textFieldName.text,
                           };
    [GXJAFNetworking POST:bindingAlipay parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            //回调刷新
            if (self.bangDingblackRefresh) {
                self.bangDingblackRefresh();
            }
            //成工
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:@"支付宝绑定成功" otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {
                if (index==0) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }else{
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    
    
    

}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
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
