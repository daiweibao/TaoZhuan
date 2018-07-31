//
//  TiXianToZFBController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/14.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "TiXianToZFBController.h"
#import "BangDingZFBController.h"
#import "TiXianToZFBModel.h"
#import "TiXianRecordController.h"
#import "CXHTMLWebController.h"
@interface TiXianToZFBController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong)UITextField *textFieldMoney;
@property(nonatomic,strong)TiXianToZFBModel * model;
@end

@implementation TiXianToZFBController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[TiXianToZFBModel alloc]init];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"淘赚余额提现";
    
    //地址管理
    UIButton * buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonright.titleLabel.font = [UIFont systemFontOfSize:15];
    buttonright.frame = CGRectMake(0, 0, 44, 44);
    [buttonright setTitle:@"提现记录" forState:UIControlStateNormal];
    [buttonright setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    UIBarButtonItem * rightitem  = [[UIBarButtonItem alloc]initWithCustomView:buttonright];
    self.navigationItem.rightBarButtonItem = rightitem;
    [buttonright addTapActionTouch:^{
        
        TiXianRecordController *address = [[TiXianRecordController alloc] init];
        
        [self.navigationController pushViewController:address animated:YES];
    }];
    
     [self tableView];
    //数据
    [self getTXLoadata];
}

//得到体现数据
-(void)getTXLoadata{
     [MBProgressHUD showHUDLodingStart:@"加载中..." toView:self.view];
    NSDictionary * dic = @{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:preWithdraw parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]){
            //解析数据
            [self.model mj_setKeyValues:responseObject[@"result"]];

            dispatch_async(dispatch_get_main_queue(), ^{
               //刷新表格
                [self.tableView reloadData];
                 [MBProgressHUD hideHUDForView:self.view];//影藏加载中
            });
        }else{
             [MBProgressHUD hideHUDForView:self.view];//影藏加载中
        }
        
    } failure:^(NSError * _Nullable error) {
         [MBProgressHUD hideHUDForView:self.view];//影藏加载中
    }];
    
}


//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        //        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        //tableview拖动时收起键盘
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //去掉分割线
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
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
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_HEIGHT-MC_NavHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

//脚
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footviewother = [UIView new];
    footviewother.backgroundColor = [UIColor whiteColor];
    return footviewother;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //关闭缓存
    UITableViewCell * cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    /* 忽略点击效果 */
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView removeAllSubviews];//移除所有子视图
    [self createUI:cell];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//创建UI
-(void)createUI:(UITableViewCell*)cell{
    //1创建头部
    UIView * viewHeaderBk = [[UIView alloc]init];
    viewHeaderBk.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    viewHeaderBk.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [cell.contentView addSubview:viewHeaderBk];
    //label支付宝账号
    UILabel * labelZfbNum = [[UILabel alloc]init];
    labelZfbNum.frame = CGRectMake(30.0*px, 0, SCREEN_WIDTH-60.0*px, 30);
    labelZfbNum.font = [UIFont systemFontOfSize:11];
    labelZfbNum.textColor = MAIN_COLOR_313131;
    
    if (self.model.isBind==NO) {
        labelZfbNum.text = @"你还没有绑定支付宝";
    }else{
        
        labelZfbNum.attributedText = [NSString getLabelNOSpacingChangeColor:MAIN_COLOR andFont:[UIFont systemFontOfSize:11] andString1:@"提现到:" andChangeString:[NSString stringWithFormat:@"%@(支付宝)",self.model.alipay] andGetstring3:@""];
       
    }
    
    [viewHeaderBk addSubview:labelZfbNum];
    
    //修改按钮
    UIButton * buttonChange = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonChange.frame = CGRectMake(SCREEN_WIDTH-30.0*px-60, 0, 60, 30);
    if (self.model.isBind==NO) {
          [buttonChange setTitle:@"【去绑定】" forState:UIControlStateNormal];
    }else{
        
        [buttonChange setTitle:@"【修改】" forState:UIControlStateNormal];
    }
    [buttonChange setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    buttonChange.titleLabel.font = [UIFont systemFontOfSize:11];
     buttonChange.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [buttonChange addTarget:self action:@selector(ActionButtonChangge) forControlEvents:UIControlEventTouchUpInside];
    [viewHeaderBk addSubview:buttonChange];
    
    //提现金额
    UILabel * labelTxtitle = [[UILabel alloc]init];
    labelTxtitle.frame = CGRectMake(30.0*px, viewHeaderBk.bottomY, SCREEN_WIDTH-60.0*px, 40);
    labelTxtitle.font = [UIFont systemFontOfSize:11];
    labelTxtitle.textColor = MAIN_COLOR_313131;
    labelTxtitle.text = @"提现金额(元)";
    [cell.contentView addSubview:labelTxtitle];
    
    //人民币符号
    UILabel * labelRMBIcon = [[UILabel alloc]init];
    labelRMBIcon.frame = CGRectMake(30.0*px, labelTxtitle.bottomY, 15, 22);
    labelRMBIcon.font = [UIFont systemFontOfSize:20];
    labelRMBIcon.textColor = MAIN_COLOR_313131;
    labelRMBIcon.text = @"￥";
    [cell.contentView addSubview:labelRMBIcon];
    
    //输入框
    UITextField *textFieldMoney=[[UITextField alloc]initWithFrame:CGRectMake(labelRMBIcon.rightX+10.0*px, labelTxtitle.bottomY, SCREEN_WIDTH-labelRMBIcon.rightX-40.0*px, 32)];
    self.textFieldMoney = textFieldMoney;
    //修改占位符颜色
    [textFieldMoney setValue:[UIColor colorWithHexString:@"#b0b0b0"]forKeyPath:@"_placeholderLabel.textColor"];
    textFieldMoney.font = [UIFont systemFontOfSize:30];
    textFieldMoney.clearButtonMode = UITextFieldViewModeAlways;
    textFieldMoney.delegate = self;
    textFieldMoney.placeholder = @"请输提现金额";
    textFieldMoney.textColor = [UIColor blackColor];
    //  设置 键盘样式
    textFieldMoney.keyboardType = UIKeyboardTypeDecimalPad;
    textFieldMoney.text = @"";
    [cell.contentView addSubview:textFieldMoney];
    
    //创建一条线
    UIImageView * imageLine = [[UIImageView alloc]init];
    imageLine.frame = CGRectMake(30.0*px, textFieldMoney.bottomY+20.0*px, SCREEN_WIDTH-60.0*px, 1);
    imageLine.backgroundColor = MAIN_COLOR_Line_Xi;
    [cell.contentView addSubview:imageLine];
    
    //余额
    UILabel * labelMoneyShengYU = [[UILabel alloc]init];
    labelMoneyShengYU.frame = CGRectMake(30.0*px, imageLine.bottomY, SCREEN_WIDTH-60.0*px, 30);
    labelMoneyShengYU.font = [UIFont systemFontOfSize:11];
    labelMoneyShengYU.textColor = [UIColor grayColor];
    labelMoneyShengYU.text = [NSString stringWithFormat:@"余额：%@",self.model.gainMoney];
    [cell.contentView addSubview:labelMoneyShengYU];
    
    //申请提现
    UIButton * buttonTX = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTX.frame = CGRectMake(0, labelMoneyShengYU.bottomY + 100.0*px, SCREEN_WIDTH, 50);
    [buttonTX setImage:[UIImage imageNamed:@"申请提现"] forState:UIControlStateNormal];
    [buttonTX addTarget:self action:@selector(ActionButtonTX:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:buttonTX];
    
    //提示
//    UILabel * labelMoneyTXInfo1 = [[UILabel alloc]init];
//    labelMoneyTXInfo1.frame = CGRectMake(30.0*px, buttonTX.bottomY+10.0*px, SCREEN_WIDTH-60.0*px, 12);
//    labelMoneyTXInfo1.font = [UIFont systemFontOfSize:11];
//    labelMoneyTXInfo1.textColor = [UIColor grayColor];;
//    labelMoneyTXInfo1.text = @"提现金额需大于1元，提现申请后立即到账";
//    labelMoneyTXInfo1.textAlignment = NSTextAlignmentCenter;
//    [cell.contentView addSubview:labelMoneyTXInfo1];
//
//    UILabel * labelMoneyTXInfo2 = [[UILabel alloc]init];
//    labelMoneyTXInfo2.frame = CGRectMake(30.0*px, labelMoneyTXInfo1.bottomY+10.0*px, SCREEN_WIDTH-60.0*px, 12);
//    labelMoneyTXInfo2.font = [UIFont systemFontOfSize:11];
//    labelMoneyTXInfo2.textColor = [UIColor grayColor];;
//    labelMoneyTXInfo2.text = @"单笔提现手续费0.5元，首次提现免费";
//    labelMoneyTXInfo2.textAlignment = NSTextAlignmentCenter;
//    [cell.contentView addSubview:labelMoneyTXInfo2];
    
    //提现规则
    UIButton * buttonGuize = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonGuize setTitle:@"提现规则>" forState:UIControlStateNormal];
    [buttonGuize setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    buttonGuize.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonGuize addTarget:self action:@selector(ActionButtonGuize) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:buttonGuize];
    [buttonGuize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buttonTX.bottomY+5);
        make.centerX.mas_equalTo(cell.contentView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    
    
}

//提现规则
-(void)ActionButtonGuize{
    
    CXHTMLWebController * htmlMyVC = [[CXHTMLWebController alloc]init];
    htmlMyVC.titleNavStr = @"提现规则";
    htmlMyVC.htmlString = self.model.tip;//提现规则
    
//    htmlMyVC.htmlString = @"<h2><font face=\"verdana\">提现规则</font></h1>1.提现金额需大于1元，提现申请后立即到账。<br><br>2.单笔提现手续费0.5元，首次提现免费。<br><br>3.必须购买满三个订单后才能提现。";
    [self.navigationController pushViewController:htmlMyVC animated:YES];
}


//金额输入框限制只能一个小数点
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    UITextField *countTextField = textField;
    NSString *NumbersWithDot = @".1234567890";
    NSString *NumbersWithoutDot = @"1234567890";
    
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        
        NSCharacterSet *cs;
        
        if ([textField isEqual:countTextField]) {
            
            // 小数点在字符串中的位置 第一个数字从0位置开始
            
            NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
            
            
            
            // 判断字符串中是否有小数点
            // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
            
            // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
            
            if (dotLocation == NSNotFound ) {
                
                // -- 如果限制非第一位才能输入小数点，加上 && range.location != 0
                
                
                // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
                
                /*
                 
                 [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去
                 
                 
                 
                 在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
                 
                 */
                
                cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersWithDot] invertedSet];
                
                if (range.location >= 9) {
                    
                    NSLog(@"单笔金额不能超过亿位");
                    
                    if ([string isEqualToString:@"."] && range.location == 9) {
                        
                        return YES;
                        
                    }
                    
                    
                    
                    return NO;
                    
                }
                
            }else {
                
                cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersWithoutDot] invertedSet];
                
            }
            

            // 按cs分离出数组,数组按@""分离出字符串
            
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            
            BOOL basicTest = [string isEqualToString:filtered];
            
            if (!basicTest) {
                
                NSLog(@"只能输入数字和小数点");
                
                return NO;
                
            }

            if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
                
                NSLog(@"小数点后最多两位");
                
                return NO;
                
            }

            if (textField.text.length > 11) {
                
                return NO;
                
            }
            
        }
        
    }
    
    
    
    return YES;
    
}

//修改手机号码
-(void)ActionButtonChangge{
    
    BangDingZFBController * bdVC = [[BangDingZFBController alloc]init];
    if (self.model.isBind==YES) {
        bdVC.type = @"修改";
    }
    //传值下去
    bdVC.zhifubaoName = self.model.realName;
    bdVC.zhifubaoNum = self.model.alipay;
    bdVC.phoneNumStr = self.model.mobile;
    [bdVC setBangDingblackRefresh:^{
       //刷新数据
        [self getTXLoadata];
    }];
    [self.navigationController pushViewController:bdVC animated:YES];
}
//提现按钮
-(void)ActionButtonTX:(UIButton*)button{
     [self CloseKeyBody];
    
    if (self.model.isBind==NO) {
        [DWBToast showCenterWithText:@"绑定支付宝后才可以提现哦~"];
        return;
    }
    
    if ([NSString isNULL:self.textFieldMoney.text]) {
        [DWBToast showCenterWithText:@"提现金额不能为空~"];
        return;
    }
    //转化一下
    double money = [self.textFieldMoney.text doubleValue];
    //用加载中挡住，防止重复点击
    [MBProgressHUD showHUDLodingStart:@"加载中..." toView:self.view];
    button.userInteractionEnabled = NO;//关闭交互
//    提现金额，提现金额必须大于1
    NSDictionary *dict = @{@"sessionId":SESSIONID,@"amount":[NSString stringWithFormat:@"%.2f",money]};
    [GXJAFNetworking POST:withDrawCostGold parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view];//影藏加载中
                 button.userInteractionEnabled = YES;//打开交互
                //刷新数据
                [self getTXLoadata];
                
                //回调会刷新
                if (self.blackRefreshMoney) {
                    self.blackRefreshMoney();
                }
                
                [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:@"提现成功，请查看支付宝余额是否到账，如有疑问请联系淘赚客服" otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {
                    if (index==0) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
                
            });
        }else{
             [MBProgressHUD hideHUDForView:self.view];//影藏加载中
             button.userInteractionEnabled = YES;//打开交互
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
        }
    } failure:^(NSError * _Nullable error) {
         [MBProgressHUD hideHUDForView:self.view];//影藏加载中
         button.userInteractionEnabled = YES;//打开交互
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self CloseKeyBody];
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
