//
//  DakaiViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/5/2.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "DakaiViewController.h"
#import "PeanutBalanceController.h"
#import "CXHTMLWebController.h"
//我的战绩
#import "MyRecordListController.h"
#import "TiaoZhanPayController.h"
#import "DakaModel.h"
@interface DakaiViewController ()
//创建头部背景
@property(nonatomic,weak)UIImageView * imageHeader;

@property(nonatomic,weak)UIScrollView * bigScroller;
@property(nonatomic,weak)UIView * contentView;
//总钱数
@property(nonatomic,weak)UILabel *labeMoney;
//一排头像的父视图
@property(nonatomic,weak)UIView * viewSubPhone;
//我要挑战按钮
@property(nonatomic,weak)UIButton * buttonTiaozhan;
//打卡之星父视图
@property(nonatomic,weak) UIView *viewSubDakaFirst;
//成功个数
@property(nonatomic,weak)UILabel *labeSuccess;
//失败个数
@property(nonatomic,weak)UILabel *labeFail;

@property(nonatomic,strong)DakaModel * model;



@end

@implementation DakaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.model = [[DakaModel alloc]init];
    
    [self createNav];
    //金额数据
    [self loadData];
    //打卡之星
    [self loadDataDakaFirst];
    
    [self refresh];
}

// 上拉下拉刷新
- (void)refresh {
    //自己封装的MJ刷新
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.bigScroller refreshHeader:^{
        //金额数据
        [self loadData];
        //打卡之星
        [self loadDataDakaFirst];
    }];

}


//数据请求
-(void)loadData{
    
    NSDictionary * dict=@{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:getPlayCardUser parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            [self.model mj_setKeyValues:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                //添加数据
                [self addDataUI];
                
                [self.bigScroller endRefresh_DWB];
            });
        }else{
            
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
            
             [self.bigScroller endRefresh_DWB];
        }
    } failure:^(NSError * _Nullable error) {
         [self.bigScroller endRefresh_DWB];
    }];
    
}


//数据请求--打卡之星
-(void)loadDataDakaFirst{

    [GXJAFNetworking POST:getMostPlayCardInfo parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            //数据解析
            [self.model mj_setKeyValues:responseObject];
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                //添加数据
                [self addDakaFirstDataUI];
                
                [self.bigScroller endRefresh_DWB];
            });
        }else{
            
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"]?:responseObject[@"msg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
            
            [self.bigScroller endRefresh_DWB];
        }
    } failure:^(NSError * _Nullable error) {
        [self.bigScroller endRefresh_DWB];
    }];
    
}




//添加数据--总金额
-(void)addDataUI{
    //总金额
    self.labeMoney.text = self.model.count;
    
    //先移除子视图
    [self.viewSubPhone removeAllSubviews];
    //循环创建头像
    //右边最大距离
    CGFloat  imagePhoneMAX = 0;
    
    NSInteger phoneCount = self.model.result.count;
    if (self.model.result.count > 8) {
        phoneCount = 8;
    }
    //最多不能超过8个，否则显示不下
    for (int i = 0; i < phoneCount; i++) {
        UIImageView * imagePhone = [[UIImageView alloc]init];
        imagePhone.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [imagePhone sd_setImageWithURL:[NSURL URLWithString:self.model.result[i][@"image"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        imagePhone.layer.cornerRadius = 15;
        imagePhone.layer.borderWidth = 1;
        imagePhone.layer.borderColor = [UIColor whiteColor].CGColor;
        imagePhone.clipsToBounds = YES;
        imagePhone.contentMode = UIViewContentModeScaleAspectFill;
        [self.viewSubPhone addSubview:imagePhone];
        [imagePhone mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(25*i);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        
        imagePhoneMAX = 25*(i+1);
    }
    //创建省略号
    UIButton * imageMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageMore setImage:[UIImage imageNamed:@"三小白点"] forState:UIControlStateNormal];
    imageMore.userInteractionEnabled = NO;
    [self.viewSubPhone addSubview:imageMore];
    [imageMore mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(imagePhoneMAX+10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    
    //创建多少人参与
    UILabel *labeJoin = [[UILabel alloc]init];
    labeJoin.textColor = [UIColor whiteColor];
    labeJoin.font = [UIFont systemFontOfSize:14];
    labeJoin.textAlignment = NSTextAlignmentCenter;
    labeJoin.attributedText = [NSString getLabelNOSpacingChangeColor:RGB_COLOR(219, 244, 162) andFont:[UIFont systemFontOfSize:14] andString1:@"" andChangeString:self.model.count andGetstring3:@"人参与"];
    [self.viewSubPhone addSubview:labeJoin];
    [labeJoin mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(imageMore.mas_right).offset(5);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(33);
    }];
    
    //我要挑战按钮控制,是否打卡，true为打卡，false 未打卡，未传入sessionId,一律返回未打卡
    _buttonTiaozhan.userInteractionEnabled = YES;//请求到数据才打开交互
    if (self.model.canSign==YES && self.model.isPlayYestodayAndSign == NO) {
        //（1）昨日打卡了，今日在早起打卡时间范围内     （2）昨日打卡了，是今日还没有早起打卡
         [_buttonTiaozhan setTitle:@"早起打卡" forState:UIControlStateNormal];
        
    }else{
        //昨日打卡，今日错过了早起打卡，或者是不符合早起打卡要求
        
        //判断今天是否已经支付了1元了，如果支付了按钮就变灰色
        if (self.model.isPlayToday==YES) {
            //今日已打卡，按钮变灰色
             [_buttonTiaozhan setTitle:@"等待明早打卡中" forState:UIControlStateNormal];
            self.buttonTiaozhan.backgroundColor =[UIColor grayColor];
            [self.buttonTiaozhan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.buttonTiaozhan.userInteractionEnabled = NO;
        }else{
            //今日未打卡
             [_buttonTiaozhan setTitle:@"我要挑战" forState:UIControlStateNormal];
            self.buttonTiaozhan.backgroundColor =RGB_COLOR(255, 103, 43);
            [self.buttonTiaozhan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.buttonTiaozhan.userInteractionEnabled = YES;
        }
    }
    
    
    
    
}


//添加数据--打卡之星
-(void)addDakaFirstDataUI{
    
    //失败成功的个数
     _labeSuccess.attributedText = [NSString getLabelNOSpacingChangeColor:RGB_COLOR(255, 103, 43) andFont:[UIFont systemFontOfSize:14] andString1:@"成功 " andChangeString:self.model.successCount andGetstring3:@""];
    
     _labeFail.attributedText = [NSString getLabelNOSpacingChangeColor:RGB_COLOR(69, 299, 176) andFont:[UIFont systemFontOfSize:14] andString1:@"失败 " andChangeString:self.model.failCount andGetstring3:@""];
    
    [self.viewSubDakaFirst removeAllSubviews];
    NSMutableArray * ArrayFirst = [NSMutableArray array];
    NSArray * titleFirst = @[@"手气之星",@"早起之星",@"毅力之星"];
    NSArray * backGroundcoloerFirst = @[RGB_COLOR(255, 169, 99),RGB_COLOR(0, 178, 175),RGB_COLOR(0, 220, 109)];
    for (int i = 0; i< 3; i++) {
        UIView * viewSubFirst = [[UIView alloc]init];
        [self.viewSubDakaFirst addSubview:viewSubFirst];
        [ArrayFirst addObject:viewSubFirst];
        
        //创建子控件
        //头像
        UIImageView * imagePhoneFirst = [[UIImageView alloc]init];
        imagePhoneFirst.image = [UIImage imageNamed:@"默认头像"];
        imagePhoneFirst.layer.cornerRadius = 25;
        imagePhoneFirst.clipsToBounds = YES;
        [viewSubFirst addSubview:imagePhoneFirst];
        [imagePhoneFirst mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(viewSubFirst).offset(0);
            make.centerX.mas_equalTo(imagePhoneFirst.centerX);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
        //标签
        UILabel * labelLabel = [[UILabel alloc]init];
        labelLabel.text = titleFirst[i];
        labelLabel.backgroundColor = backGroundcoloerFirst[i];
        labelLabel.textColor = [UIColor whiteColor];
        labelLabel.font = [UIFont systemFontOfSize:10];
        labelLabel.textAlignment = NSTextAlignmentCenter;
        labelLabel.layer.cornerRadius = 7.5;
        labelLabel.clipsToBounds = YES;
        [viewSubFirst addSubview:labelLabel];
        [labelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(imagePhoneFirst);
            make.centerX.mas_equalTo(imagePhoneFirst.centerX);
            make.size.mas_equalTo(CGSizeMake(50, 15));
        }];
        //名字
        UILabel * labelName = [[UILabel alloc]init];
        labelName.text = @"--";
        labelName.textColor = [UIColor blackColor];
        labelName.font = [UIFont systemFontOfSize:12];
        labelName.textAlignment = NSTextAlignmentCenter;
        [viewSubFirst addSubview:labelName];
        [labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imagePhoneFirst.mas_bottom).offset(5);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(15);
        }];
        
        //金额
        UILabel * labelMoneyFires = [[UILabel alloc]init];
        labelMoneyFires.text = @"0.00元";
        labelMoneyFires.textColor = MAIN_COLOR;
        labelMoneyFires.font = [UIFont systemFontOfSize:12];
        labelMoneyFires.textAlignment = NSTextAlignmentCenter;
        [viewSubFirst addSubview:labelMoneyFires];
        [labelMoneyFires mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(labelName.mas_bottom).offset(5);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(15);
            make.bottom.mas_equalTo(viewSubFirst).offset(-10);
        }];
        
        //赋值
        if (i==0) {
            //手气之星
            [imagePhoneFirst sd_setImageWithURL:[NSURL URLWithString:self.model.gainStar.image] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            labelName.text = self.model.gainStar.nickName;
            //累计收益
            labelMoneyFires.text = [NSString stringWithFormat:@"%@元",self.model.gainStar.gainMoney];
            
    
            
        }else if (i==1){
//            早起之星
            [imagePhoneFirst sd_setImageWithURL:[NSURL URLWithString:self.model.timeStar.image] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            labelName.text = self.model.timeStar.nickName;
            //打卡时间
            labelMoneyFires.text = [NSString stringWithFormat:@"%@打卡",[NSString dateChangeStr:self.model.timeStar.time andFormat:@"HH:mm:ss"]];
            
            
        }else if (i==2){
            //魅力之星
            [imagePhoneFirst sd_setImageWithURL:[NSURL URLWithString:self.model.successStar.image] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            labelName.text = self.model.successStar.nickName;
            labelMoneyFires.text = [NSString stringWithFormat:@"累计%@次",self.model.successStar.successCount];
        }
        
        
    }
    
    //水平方向控件间隔固定等间隔
    [ArrayFirst mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:5 tailSpacing:5];
    [ArrayFirst mas_makeConstraints:^(MASConstraintMaker *make) { //数组额你不必须都是view
        make.top.mas_equalTo(0);
    }];
    
}


//创建自定义导航栏
- (void)createNav{
    //masonry布局UIScrollView，contentSize在自动布局中无效
    UIScrollView * bigScroller = [[UIScrollView alloc]init];
    self.bigScroller = bigScroller;
    adjustsScrollViewInsets_NO(bigScroller, self);//适配iOS11
    bigScroller.alwaysBounceVertical = YES; //垂直方向遇到边框是否总是反弹，必须开启，不然用masonry布局时内容填充不满屏幕就无法反弹（CollectionView、tableview也一样）
    [self.view addSubview:bigScroller];
    [bigScroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    //在利用自动布局来布局UIScrollView时,一般都会在上面添加一个UIView的子控件，来正确布局
    UIView * conrentView = [[UIView alloc]init];
//    conrentView.backgroundColor = MAIN_COLOR;
    self.contentView = conrentView;
    [self.bigScroller addSubview:conrentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bigScroller);
        // 确定containerView的宽度
        make.width.equalTo(self.bigScroller);
    }];
    
 
    //第一个控件
    UIImageView * imageHeader = [[UIImageView alloc]init];
    self.imageHeader = imageHeader;
    imageHeader.image = [UIImage imageNamed:@"打卡头部背景"];
    imageHeader.contentMode = UIViewContentModeScaleAspectFill;
    imageHeader.clipsToBounds = YES;
    imageHeader.userInteractionEnabled = YES;
    [self.contentView addSubview:imageHeader];
    [self.imageHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        //高度在下面做约束
    }];
    
    //主导航栏
    UIView *TopView = [[UIView alloc]init];
    [self.view addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(MC_NavHeight);
    }];
    
    UILabel *navTitle = [[UILabel alloc]init];
    navTitle.text = @"早起挑战";
    navTitle.textColor = [UIColor whiteColor];
    navTitle.font = [UIFont systemFontOfSize:18];
    navTitle.textAlignment = NSTextAlignmentCenter;
    [TopView addSubview:navTitle];
    [navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MC_StatusBarHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];

    
    //返回
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.contentMode = UIViewContentModeScaleAspectFill;
    backButton.clipsToBounds = YES;
    [backButton setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MC_StatusBarHeight);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    //取消
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"我的战绩" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(pressButtonRight) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [TopView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TopView).offset(MC_StatusBarHeight);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(44);
    }];
    
    //创建UI
    [self createUI];
}

-(void)createUI{
   //标题
    UILabel *labelTitle = [[UILabel alloc]init];
    labelTitle.text = @"明早6:00~8:00准时打卡可瓜分金额(元)";
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.font = [UIFont systemFontOfSize:14];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [self.imageHeader addSubview:labelTitle];
    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.imageHeader).offset(MC_NavHeight+20);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(15);
    }];
    
    //金额
    UILabel *labeMoney = [[UILabel alloc]init];
    self.labeMoney = labeMoney;
    labeMoney.textColor = [UIColor whiteColor];
    labeMoney.text = @"0";
    labeMoney.font = [UIFont systemFontOfSize:38];
    labeMoney.textAlignment = NSTextAlignmentCenter;
    [self.imageHeader addSubview:labeMoney];
    [labeMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(labelTitle.mas_bottom).offset(10);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(39);
    }];
    
    //创建头像那一排的父视图
    UIView * viewSubPhone = [[UIView alloc]init];
    self.viewSubPhone = viewSubPhone;
    [self.imageHeader addSubview:viewSubPhone];
    [viewSubPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置父控件居中
        make.top.mas_equalTo(labeMoney.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.imageHeader);
        make.height.mas_equalTo(30);
    }];
    
    //挑战规则
    UIButton * buttonGuize = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonGuize setTitle:@"挑战规则>" forState:UIControlStateNormal];
    buttonGuize.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonGuize addTarget:self action:@selector(ActionButtonGuize) forControlEvents:UIControlEventTouchUpInside];
    [self.imageHeader addSubview:buttonGuize];
    [buttonGuize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewSubPhone.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.imageHeader);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    //我要挑战按钮
    UIButton * buttonTiaozhan = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonTiaozhan = buttonTiaozhan;
    [buttonTiaozhan setTitle:@"我要挑战" forState:UIControlStateNormal];
    buttonTiaozhan.userInteractionEnabled = NO;
    buttonTiaozhan.titleLabel.font = [UIFont systemFontOfSize:16];
    buttonTiaozhan.layer.cornerRadius = 20;
    buttonTiaozhan.backgroundColor =RGB_COLOR(255, 103, 43);
    [buttonTiaozhan addTarget:self action:@selector(ActionButtonTiaozhan) forControlEvents:UIControlEventTouchUpInside];
    [self.imageHeader addSubview:buttonTiaozhan];
    [buttonTiaozhan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buttonGuize.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.imageHeader);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(self.imageHeader).offset(-200.0*px);
    }];
    
    
    //邀请好友
    UIButton * buttonInvitation = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonInvitation setTitle:@"邀请\n好友" forState:UIControlStateNormal];
    buttonInvitation.backgroundColor = RGB_COLOR(255, 155, 73);
    buttonInvitation.titleLabel.font = [UIFont systemFontOfSize:12];
    buttonInvitation.titleLabel.numberOfLines = 2;
    buttonInvitation.layer.cornerRadius = 20;
    buttonInvitation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [buttonInvitation setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];//调整字体位置
    [buttonInvitation addTarget:self action:@selector(ActionButtonInvitation) forControlEvents:UIControlEventTouchUpInside];
    [self.imageHeader addSubview:buttonInvitation];
    [buttonInvitation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(20);
        make.top.mas_equalTo(buttonTiaozhan.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(70, 40));
    }];
    
    
    
    //今日战况
    UIButton * buttonToday = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonToday setTitle:@"今日\n战况" forState:UIControlStateNormal];
    buttonToday.backgroundColor = RGB_COLOR(69, 299, 176);
    buttonToday.titleLabel.font = [UIFont systemFontOfSize:12];
    buttonToday.titleLabel.numberOfLines = 2;
    buttonToday.layer.cornerRadius = 20;
    buttonToday.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [buttonToday setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];//调整字体位置
    buttonToday.userInteractionEnabled = NO;
    [self.contentView addSubview:buttonToday];
    [buttonToday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-20);
        make.top.mas_equalTo(self.imageHeader.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(70, 40));
    }];
    
    
    
    NSMutableArray * arrayLabel = [NSMutableArray array];
    //创建成功失败
    UILabel *labeSuccess = [[UILabel alloc]init];
    self.labeSuccess = labeSuccess;
    labeSuccess.textColor = [UIColor grayColor];
    labeSuccess.font = [UIFont systemFontOfSize:14];
    labeSuccess.textAlignment = NSTextAlignmentCenter;
    labeSuccess.attributedText = [NSString getLabelNOSpacingChangeColor:RGB_COLOR(255, 103, 43) andFont:[UIFont systemFontOfSize:14] andString1:@"成功" andChangeString:@"--" andGetstring3:@""];
    [self.contentView addSubview:labeSuccess];
    [arrayLabel addObject:labeSuccess];
    
    UILabel *labeFail = [[UILabel alloc]init];
    self.labeFail = labeFail;
    labeFail.textColor = [UIColor grayColor];
    labeFail.font = [UIFont systemFontOfSize:14];
    labeFail.textAlignment = NSTextAlignmentCenter;
    labeFail.attributedText = [NSString getLabelNOSpacingChangeColor:RGB_COLOR(69, 299, 176) andFont:[UIFont systemFontOfSize:14] andString1:@"失败" andChangeString:@"--" andGetstring3:@""];
    [self.contentView addSubview:labeFail];
     [arrayLabel addObject:labeFail];
    
    //水平方向控件间隔固定等间隔
    [arrayLabel mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:40 tailSpacing:40];
    [arrayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageHeader.mas_bottom).offset(10);
        make.height.mas_equalTo(30);
    }];
    
    
    //打卡之星父视图
    UIView * viewSubDakaFirst = [[UIView alloc]init];
    self.viewSubDakaFirst =viewSubDakaFirst;
    [self.contentView addSubview:viewSubDakaFirst];
    [viewSubDakaFirst mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labeSuccess.mas_bottom).offset(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
        //约束底部
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    
}




//返回
-(void)backButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//右边按钮--我的战绩
-(void)pressButtonRight{
    if ([NSString isNULL:SESSIONID]) {
      
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
    }else{
        MyRecordListController *vc = [[MyRecordListController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//挑战规则
-(void)ActionButtonGuize{
    
    CXHTMLWebController * htmlMyVC = [[CXHTMLWebController alloc]init];
    htmlMyVC.titleNavStr = @"早起挑战";
    //html标签：<br>是换行  <h1><font face="verdana" color="red">游戏规则</font></h1>
    // <p><font size="3" face="verdana" color="red">一句话总结,赖床的人给早起的人发红包。</font></p>
//    @"<h2><font face=\"verdana\">游戏规则</font></h1>1.每天8:00~24:00付费报名参加次日的早起打卡挑战，挑战金放入早起成功奖励池。<br><br>2.次日6:00~8:00为早起打卡时间，在此时间内进入早起挑战页面签到即视为挑战成功获得随机瓜分奖励池奖金的资格。奖励金额不低于报名时支付的挑战金金额，上不设限。<br><br>3.报名后未在打卡时间内成功打卡的，视为挑战失败，挑战金不退回。<br><br>4.0:00~6:00为睡眠时间，不可以报名或打卡。<br><br>5.每天奖励金在8:00打卡时间结束后开始结算，预计当日9:00到账超级淘余额。<br><br><p><font size=\"4\" face=\"verdana\" color=\"red\">一句话总结，赖床的人给早起的人发红包。</font></p>"
    
    htmlMyVC.htmlString = self.model.ruleInfo;//挑战规则
    [self.navigationController pushViewController:htmlMyVC animated:YES];
}

//我要挑战
-(void)ActionButtonTiaozhan{
    
   //用控件上的汉字来判断状态
    if ([self.buttonTiaozhan.titleLabel.text isEqual:@"我要挑战"]) {
        
        if ([NSString isNULL:SESSIONID]) {
          
            //弹窗登陆
            [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                
            }];
        }else{
            //未打卡,用户支付1元参与挑战。
            [self ActionButtonPay];
        }
        
    }else if ([self.buttonTiaozhan.titleLabel.text isEqual:@"早起打卡"]) {
        //早起打卡，坐等分钱
         [self ActionButtonGetMoney];
        
    }else if ([self.buttonTiaozhan.titleLabel.text isEqual:@"等待明早打卡中"]) {
        
        [DWBToast showCenterWithText:@"你今日已经参与过挑战了，明早记得来打卡哦"];
    }
    
}

//邀请好友
-(void)ActionButtonInvitation{
    //创建分享的图片
    UIImage * imageShare =  [self createShareUI];
    [ShareView share:self ShareTitle:nil WithContent:nil ShareUrl:nil shareImage:imageShare ReporStrType:@"只分享到微信" shareType:@"只分享图片" completion:^(NSString *code) {

    }];
}


//用户第一天打卡支付1元--用户第一天首次打卡
-(void)ActionButtonPay{
    //请求数据-- self.PayNum
    //用加载中挡住，防止重复点击
    [MBProgressHUD showHUDLodingStart:@"支付中..." toView:self.view];
    self.buttonTiaozhan.userInteractionEnabled = NO;//关闭交互
    //支付
    NSDictionary *dict = @{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:playCard parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view];//影藏加载中
                self.buttonTiaozhan.userInteractionEnabled = YES;//打开交互
               
                //支付成功后刷新数据
                //金额数据
                [self loadData];
                //打卡之星
                [self loadDataDakaFirst];
                
                //提示用户
                [AlertGXJView AlertGXJAlertWithController:self Title:@"支付1元成功" Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {
                }];
                
            });
        }else{
            [MBProgressHUD hideHUDForView:self.view];//影藏加载中
            self.buttonTiaozhan.userInteractionEnabled = YES;//打开交互
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view];//影藏加载中
        self.buttonTiaozhan.userInteractionEnabled = YES;//打开交互
    }];
    
}




//用户第二天分钱，早起打卡，坐等分钱
-(void)ActionButtonGetMoney{
    //请求数据-- self.PayNum
    //用加载中挡住，防止重复点击
    [MBProgressHUD showHUDLodingStart:@"打卡中..." toView:self.view];
    self.buttonTiaozhan.userInteractionEnabled = NO;//关闭交互
    //支付
    NSDictionary *dict = @{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:playCardTomorrow parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view];//影藏加载中
                self.buttonTiaozhan.userInteractionEnabled = YES;//打开交互
                //刷新余额数据
                [self loadData];
                
                [AlertGXJView AlertGXJAlertWithController:self Title:@"打卡成功" Message:responseObject[@"errorMsg"] ?:responseObject[@"msg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {
                }];
                
            });
        }else{
            [MBProgressHUD hideHUDForView:self.view];//影藏加载中
            self.buttonTiaozhan.userInteractionEnabled = YES;//打开交互
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"]?:responseObject[@"msg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
        }
    } failure:^(NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view];//影藏加载中
        self.buttonTiaozhan.userInteractionEnabled = YES;//打开交互
    }];
    
}


-(void)dealloc{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
    //改变电池颜色（白色）
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //改变电池颜色（黑色）
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
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

#pragma mark =============== 创建分享UI S====================

-(UIImage*)createShareUI{
    UIView * viewShareSub = [[UIView alloc]init];
    viewShareSub.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    //背景
    UIImageView * imageBJ = [[UIImageView alloc]init];
    imageBJ.image = [UIImage imageNamed:@"打卡头部背景"];
    imageBJ.contentMode = UIViewContentModeScaleAspectFill;
    imageBJ.clipsToBounds = YES;
    imageBJ.userInteractionEnabled = YES;
    [viewShareSub addSubview:imageBJ];
    [imageBJ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(viewShareSub);
    }];
    
    //标题
    UILabel *labelTitle = [[UILabel alloc]init];
    labelTitle.text = @"明早准时打卡可瓜分金额（元）";
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.font = [UIFont systemFontOfSize:14];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [viewShareSub addSubview:labelTitle];
    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(viewShareSub).offset(MC_NavHeight+50);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(15);
    }];
    
    //金额
    UILabel *labeMoney = [[UILabel alloc]init];
    labeMoney.textColor = [UIColor whiteColor];
    labeMoney.font = [UIFont systemFontOfSize:38];
    labeMoney.text = self.model.count;
    labeMoney.textAlignment = NSTextAlignmentCenter;
    [viewShareSub addSubview:labeMoney];
    [labeMoney mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(labelTitle.mas_bottom).offset(10);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(39);
    }];
    
    //创建头像那一排的父视图
    UIView * viewSubPhoneShare = [[UIView alloc]init];
    [viewShareSub addSubview:viewSubPhoneShare];
    [viewSubPhoneShare mas_remakeConstraints:^(MASConstraintMaker *make) {
        //设置父控件居中
        make.top.mas_equalTo(labeMoney.mas_bottom).offset(10);
        make.centerX.mas_equalTo(viewShareSub);
        make.height.mas_equalTo(30);
    }];
    
    //循环创建头像
    //右边最大距离
    CGFloat  imagePhoneMAX = 0;
    
    NSInteger phoneCount = self.model.result.count;
    if (self.model.result.count > 8) {
        phoneCount = 8;
    }
    //最多不能超过8个，否则显示不下
    for (int i = 0; i < phoneCount; i++) {
        UIImageView * imagePhone = [[UIImageView alloc]init];
        imagePhone.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [imagePhone sd_setImageWithURL:[NSURL URLWithString:self.model.result[i][@"image"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        imagePhone.layer.cornerRadius = 15;
        imagePhone.layer.borderWidth = 1;
        imagePhone.layer.borderColor = [UIColor whiteColor].CGColor;
        imagePhone.clipsToBounds = YES;
        imagePhone.contentMode = UIViewContentModeScaleAspectFill;
        [viewSubPhoneShare addSubview:imagePhone];
        [imagePhone mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(25*i);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        //最大值
        imagePhoneMAX = 25*(i+1);
    }
    //创建省略号
    UIButton * imageMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageMore setImage:[UIImage imageNamed:@"三小白点"] forState:UIControlStateNormal];
    imageMore.userInteractionEnabled = NO;
    [viewSubPhoneShare addSubview:imageMore];
    [imageMore mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(imagePhoneMAX+10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    
    //创建多少人参与
    UILabel *labeJoin = [[UILabel alloc]init];
    labeJoin.textColor = [UIColor whiteColor];
    labeJoin.font = [UIFont systemFontOfSize:14];
    labeJoin.textAlignment = NSTextAlignmentCenter;
    labeJoin.attributedText = [NSString getLabelNOSpacingChangeColor:RGB_COLOR(219, 244, 162) andFont:[UIFont systemFontOfSize:14] andString1:@"" andChangeString:self.model.count andGetstring3:@"人参与"];
    [viewSubPhoneShare addSubview:labeJoin];
    [labeJoin mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(imageMore.mas_right).offset(5);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(33);
    }];
    
    
    //创建二维码
    UIImageView * imageEWM = [[UIImageView alloc]init];
    //app下载地址---二维码携带的字符串
    NSString *strAppStore = AppstoreUrl;
    UIImage * imageEWMGet = [strAppStore generateQRCodeWithSize:140 logo:[UIImage imageNamed:appLogoName]];
    dispatch_async(dispatch_get_main_queue(), ^{
        imageEWM.image = imageEWMGet;
    });
    [viewShareSub addSubview:imageEWM];
    [imageEWM mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labeJoin.mas_bottom).offset(40);
        make.centerX.mas_equalTo(viewShareSub.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(140, 140));
    }];
    
    //长按识别二维码
    UILabel *labeltips = [[UILabel alloc]init];
    labeltips.text = @"长按识别下载淘赚App\n每天赚收益吧";
    labeltips.textColor = [UIColor whiteColor];
    labeltips.numberOfLines = 2;
    labeltips.font = [UIFont systemFontOfSize:16];
    labeltips.textAlignment = NSTextAlignmentCenter;
    [viewShareSub addSubview:labeltips];
    [labeltips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(imageEWM.mas_bottom).offset(20);
        make.right.mas_equalTo(0);
    }];
    
    //截屏返回图片
    UIImage * cupImage = [UIImage captureImageFromViewLowNoSaveAndInfo:viewShareSub];
    
    [viewShareSub removeFromSuperview];//移除控件
    
    return cupImage;
    
}

#pragma mark =============== 创建分享UI E====================


@end
