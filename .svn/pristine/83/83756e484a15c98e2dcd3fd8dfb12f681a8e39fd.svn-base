//
//  PersonalCenterHeader.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 17/2/15.
//  Copyright © 2017年 zmxn. All rights reserved.
//

#import "MyCenterheader3_1_0.h"
#import "TodayGetMoneyController.h"//今日收益
#import "TotalGetMoneyController.h"//累计收益
#import "PeanutBalanceController.h"//余额
#import "PeanutWalletController.h"//花生钱包
#import "PeanutYearLiLvController.h"//年化利率
#import "GXJChatListController.h"
//我的资料模型
#import "MineModel.h"
//设置
#import "SetUpViewController.h"

//修改资料
#import "AdddateViewController.h"

//融云聊天
#import <RongIMLib/RongIMLib.h>


@interface MyCenterheader3_1_0()

@property (nonatomic,strong)MineModel *model;

@property(nonatomic,strong)UIImageView * headView;//头像
@property(nonatomic,strong)UIButton *nameButton;//名字

@property(nonatomic,strong)NSArray * peanutLabels;//花生钱包4个label

//下面UI的父视图
@property(nonatomic,strong)UIView * viewmySub;

//消息按钮
@property(nonatomic,weak)UIButton * buttonNotf;
//消息数量
@property(nonatomic,weak)UILabel * numChatlabel;
@property(nonatomic,weak)UILabel *myidlabel;//用户id

@end

@implementation MyCenterheader3_1_0

//215+66+10+44+85
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        [self setupUI];
        [self loadData];
        
        //修改资料后刷新资料
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"refreshHeadNotification" object:nil];

        //登陆成功后刷新
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:@"mineLoginSussce" object:nil];

        //收到消息监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRicveRCIDChatInfoMy) name:@"RicveRCIDChatInfo" object:nil];
        
        
    }
    return self;
}

//创建ui
- (void)setupUI{

    self.backgroundColor = [UIColor whiteColor];
    
    //背景图片
    UIImageView *bgView = [[UIImageView alloc]init];
    self.bgView = bgView;
    bgView.image = [UIImage imageNamed:@"个人中心头部背景3.3"];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    bgView.clipsToBounds = YES;
    if (iPhoneX) {
        bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180+(MC_StatusBarHeight-20));
    }else{
        bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);
    }
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    
    //创建设置 38 36
    UIButton *buttonSetup = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSetup.frame = CGRectMake(0, MC_StatusBarHeight, 44, 44);
    [buttonSetup setImage:[UIImage imageNamed:@"我的设置3.3"] forState:UIControlStateNormal];
    [buttonSetup addTarget:self action:@selector(ActionButtonSetUp) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonSetup];
    
    //消息
    UIButton * buttonNotf = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonNotf = buttonNotf;
    buttonNotf.frame = CGRectMake(SCREEN_WIDTH-44,MC_StatusBarHeight, 44, 44);
    [buttonNotf setImage:[UIImage imageNamed:@"我的消息3.3"] forState:UIControlStateNormal];
    [buttonNotf addTarget:self action:@selector(ActionButtonNotf) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonNotf];
    
    //消息小红点
    UILabel * numChatlabel = [[UILabel alloc]init];
    self.numChatlabel = numChatlabel;
    numChatlabel.backgroundColor = MAIN_COLOR;
    numChatlabel.frame = CGRectMake(buttonNotf.x, buttonNotf.y, 25, 25);
    numChatlabel.textColor = [UIColor whiteColor];
    numChatlabel.font  =[UIFont systemFontOfSize:14];
    numChatlabel.layer.cornerRadius = 12.5;
    numChatlabel.textAlignment = NSTextAlignmentCenter;
    numChatlabel.clipsToBounds = YES;
    numChatlabel.adjustsFontSizeToFitWidth = YES;
    numChatlabel.hidden = YES;
    [self addSubview:numChatlabel];
    
    //头像
    UIImageView *headView = [[UIImageView alloc]init];
    self.headView = headView;
    headView.frame = CGRectMake(SCREEN_WIDTH/2-34, buttonSetup.bottomY-10, 68, 68);
    headView.layer.cornerRadius = 34;
    headView.contentMode = UIViewContentModeScaleAspectFill;
    headView.clipsToBounds = YES;
    headView.layer.borderWidth = 1.5;
    headView.layer.borderColor = [UIColor whiteColor].CGColor;
    headView.userInteractionEnabled = YES;
    WeakSelf(self);
    [headView addTapActionTouch:^{
        [weakself headClick];
    }];
    [self addSubview:headView];
    
    
    //名字
    UIButton *nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nameButton = nameButton;
    [nameButton setTitle:@"--" forState:UIControlStateNormal];
//    [nameButton setImage:[UIImage imageNamed:@"我的编辑3.3"] forState:UIControlStateNormal];
    nameButton.frame = CGRectMake(0, _headView.bottomY+15, SCREEN_WIDTH, 16);
    nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [nameButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    nameButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [nameButton addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
    nameButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    //button显示图片和汉字
    [nameButton setImagePositionWithType:SSImagePositionTypeRight spacing:0];
    [self addSubview:nameButton];
    
    //创建下面的UI
    [self createActionUI];

}

//创建花生
-(void)createActionUI{
    //父视图
    UIView *viewmySub = [[UIView alloc]init];
    self.viewmySub = viewmySub;
    viewmySub.frame = CGRectMake(0, self.bgView.bottomY, SCREEN_WIDTH, 44+85);
    [self addSubview:viewmySub];
    
    //花生钱包
    UILabel * labelmyorder = [[UILabel alloc]init];
    labelmyorder.frame = CGRectMake(15, 0, SCREEN_WIDTH, 44);
    labelmyorder.text = @"淘赚钱包";
    labelmyorder.textColor = [UIColor colorWithHexString:@"#000000"];
    labelmyorder.font = [UIFont systemFontOfSize:16];
    [viewmySub addSubview:labelmyorder];
    labelmyorder.userInteractionEnabled = YES;
    [labelmyorder addTapActionTouch:^{//花生钱包
        PeanutWalletController * drawVC = [[PeanutWalletController alloc]init];
        [self.parentController.navigationController pushViewController:drawVC animated:YES];
    }];
    
    
    UIButton * sexbuttonEnter= [UIButton buttonWithType:UIButtonTypeCustom];
    sexbuttonEnter.frame = CGRectMake(SCREEN_WIDTH-80, 0, 80, 44);
    [sexbuttonEnter setTitle:@"详情" forState:UIControlStateNormal];
    [sexbuttonEnter setTitleColor:MAIN_COLOR_898989 forState:UIControlStateNormal];
    [sexbuttonEnter setImage:[UIImage imageNamed:@"进入"] forState:UIControlStateNormal];
    sexbuttonEnter.titleLabel.font  =[UIFont systemFontOfSize:15];
    [viewmySub addSubview:sexbuttonEnter];
    [sexbuttonEnter setImagePositionWithType:SSImagePositionTypeRight spacing:6];
    sexbuttonEnter.userInteractionEnabled = NO;
    
    //线1
    UIImageView * line1 = [[UIImageView alloc]init];
    line1.frame = CGRectMake(15, labelmyorder.bottomY-0.5, SCREEN_WIDTH-30, 0.5);
    [UIImage drawDashLine:line1 lineLength:4 lineSpacing:1 lineColor:MAIN_COLOR_Line_Xi];//封装的虚线创建
    [viewmySub addSubview:line1];
    
    
    NSMutableArray *tempArr = [NSMutableArray array];
    CGFloat viewW = SCREEN_WIDTH/4;
    NSArray *names = @[@"今日收钱my",@"累计收钱my",@"年利化率my",@"余额my"];
    NSArray *labels = @[@"今日收益",@"累计收益",@"年化利率",@"余额"];
    for (int i=0; i<4; i++) {
        
        UIView * bg = [[UIView alloc]initWithFrame:CGRectMake(viewW*i, line1.bottomY, viewW, 85)];
        bg.userInteractionEnabled = YES;
        bg.tag = i;
        WeakSelf(bg);
        [bg addTapActionTouch:^{
            if (weakbg.tag == 0) {//今日收益
                TodayGetMoneyController * drawVC = [[TodayGetMoneyController alloc]init];
                [self.parentController.navigationController pushViewController:drawVC animated:YES];
            }else if (weakbg.tag == 1) {//累计收益
                TotalGetMoneyController * drawVC = [[TotalGetMoneyController alloc]init];
                [self.parentController.navigationController pushViewController:drawVC animated:YES];
            }else if (weakbg.tag == 2){//年利化率
                PeanutYearLiLvController * drawVC = [[PeanutYearLiLvController alloc]init];
                UILabel *rateLabel = self.peanutLabels[2];
                drawVC.rate = rateLabel.text;
                if ([rateLabel.text containsString:@"%"]) {
                     [self.parentController.navigationController pushViewController:drawVC animated:YES];
                }
            }else{//余额
                PeanutBalanceController * drawVC = [[PeanutBalanceController alloc]init];
                [self.parentController.navigationController pushViewController:drawVC animated:YES];
            }
        }];
        [viewmySub addSubview:bg];
        
        //
        UIButton * image2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 15,viewW, 20)];
        image2.userInteractionEnabled = NO;
        [image2 setImage:[UIImage imageNamed:names[i]] forState:UIControlStateNormal];
        [bg addSubview:image2];
        
        //
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, image2.bottomY+8, viewW, 12);
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:12];
        label.text = labels[i];
        label.textAlignment = NSTextAlignmentCenter;
        [bg addSubview:label];
        
        //显示数据
        UILabel *num = [[UILabel alloc]init];
        num.frame = CGRectMake(0, label.bottomY+5, viewW, 12);
        num.textColor = MAIN_COLOR;
        num.font = [UIFont systemFontOfSize:12];
        num.text = @"";
        num.adjustsFontSizeToFitWidth = YES;
        num.textAlignment = NSTextAlignmentCenter;
        [bg addSubview:num];
        [tempArr addObject:num];
        
    }
    self.peanutLabels = tempArr.copy;

}

//加载数据(刷新)
- (void)loadData{
    
#pragma mark ================获取缓存数据（自己个人中心头部）============
    //网络请求前先读出数据，请求到数据在刷新
    id cacheJson = [XHNetworkCache cacheJsonWithURL:MINE_HOME_DATA];
    //解析
    MineModel * model = [[MineModel alloc]initWithDictionary:cacheJson error:nil];
    self.model = model;
    [self addDataload];
    
    [self dataRrlode];//加载个人资料
    
    [self getRicveRCIDChatInfoMy];//获取所有的未读消息数
    
    [self loadMoneyData];//花生钱包
    
}

//我的资料
-(void)dataRrlode{
     NSLog(@"我的用户ID：%@",USERID);
    NSDictionary * dic = @{@"sessionId":SESSIONID};
    
    [GXJAFNetworking POST:MINE_HOME_DATA parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]){
            
            MineModel * model = [[MineModel alloc]initWithDictionary:responseObject[@"userInfo"] error:nil];
            self.model = model;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //给控件添加数据
                [self addDataload];
            });
            //用户资料缓存--个人中心资料
            [NSString userInfoCacheMyuserId:responseObject[@"userInfo"][@"userId"] AndUserName:responseObject[@"userInfo"][@"nickName"] AndUserImage:responseObject[@"userInfo"][@"image"] AndUserType:responseObject[@"userInfo"][@"userType"]];
            
#pragma mark ================(异步)写入/更新缓存数据 ========
            [XHNetworkCache save_asyncJsonResponseToCacheFile:responseObject[@"userInfo"] andURL:MINE_HOME_DATA completed:^(BOOL result) {
                //if(result)  NSLog(@"(异步)写入/更新缓存数据 成功");
            }];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

//将要出现获取所有未读消息
-(void)getRicveRCIDChatInfoMy{
    
    //系统未读消息数量
    int infoNum = 0 ;
    //获取融云所有的未读消息数
    int chatNum = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    //总消息数
    int chatAllNum  = infoNum + chatNum;
    if (chatAllNum>0) {
        self.numChatlabel.hidden = NO;
        self.numChatlabel.text = [NSString stringWithFormat:@"%d",chatAllNum];
        _numChatlabel.layer.cornerRadius = 12.5;
        //两种显示方式,小于100圆角显示，大于100方形状
        CGFloat sizeNumZanWidth;
        if (chatAllNum<100) {
            sizeNumZanWidth = 25;
        }else{
            sizeNumZanWidth = [NSString sizeMyStrWith:[NSString stringWithFormat:@"%d",chatAllNum] andFontSize:14 andMineWidth:100].width+10;
        }
        _numChatlabel.frame = CGRectMake(_buttonNotf.x-sizeNumZanWidth+25, _buttonNotf.y, sizeNumZanWidth, 25);
        
    }else{
        self.numChatlabel.hidden = YES;
    }

}

//给控件添加数据
-(void)addDataload{
    
    //头像
    [self.headView sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    

    //名字
    if ([NSString isNULL:self.model.nickName]) {
        [self.nameButton setTitle:@"--" forState:UIControlStateNormal];
    }else{
        [self.nameButton setTitle:[NSString stringWithFormat:@"%@",self.model.nickName] forState:UIControlStateNormal];
    }
    //button显示图片和汉字
    [_nameButton setImagePositionWithType:SSImagePositionTypeRight spacing:0];
    
}

#pragma mark ================= 各种点击事件===========================
//设置
-(void)ActionButtonSetUp{

    //设置
    SetUpViewController * setUpVC = [[SetUpViewController alloc]init];
    setUpVC.hidesBottomBarWhenPushed = YES;
    [self.parentController.navigationController pushViewController:setUpVC animated:YES];
}

//消息
-(void)ActionButtonNotf{
    //消息
    GXJChatListController  * Notfinfo = [[GXJChatListController alloc]init];
    Notfinfo.hidesBottomBarWhenPushed = YES;
    [self.parentController.navigationController pushViewController:Notfinfo animated:YES];
}

//头像和名字点击修改资料
- (void)headClick{
    AdddateViewController * MineVC = [[AdddateViewController alloc]init];
    MineVC.hidesBottomBarWhenPushed = YES;
    [self.parentController.navigationController pushViewController:MineVC animated:YES];
}

//花生钱包
- (void)loadMoneyData{
    
    [GXJAFNetworking POST:getMoneyPackage parameters:@{@"sessionId":SESSIONID} success:^(id  _Nullable responseObject) {
        
        //                NSLog(@"获取未读消息：%@",responseObject);
        if ([responseObject[@"code"] isEqual:@"00"]) {
            //                consumeMoney = 200;
            //                dayGain = "0.0712";
            //                gainMoney = "<null>";
            //                rate = "0.13";
            //                sumGainMoney = "<null>";
            
            NSDictionary *dict = responseObject[@"result"];
            
            UILabel *label1 = self.peanutLabels[0];
            UILabel *label2 = self.peanutLabels[1];
            UILabel *label3 = self.peanutLabels[2];
            UILabel *label4 = self.peanutLabels[3];
            
            //今日收钱
            
            if ([NSString isNULL:dict[@"dayGain"]]) {
                label1.text = [NSString stringWithFormat:@"￥0.00"];
            }else{
                label1.text = [NSString stringWithFormat:@"￥%@",dict[@"dayGain"]];
            }
            
            //累计收益
            if ([NSString isNULL:dict[@"sumGainMoney"]]) {
                label2.text = [NSString stringWithFormat:@"￥0.00"];
            }else{
                label2.text = [NSString stringWithFormat:@"￥%@",dict[@"sumGainMoney"]];
            }
            
            //年化利率
            if ([NSString isNULL:dict[@"rate"]]) {
                label3.text = @"0.0%";
            }else{
                
//                if ([dict[@"rate"] containsString:@"-"]) {
//                    label3.text = @"0.0%";
//                }else{
                    label3.text = [NSString stringWithFormat:@"%@",dict[@"rate"]];
//                }
                
            }
            
            //余额
            if ([NSString isNULL:dict[@"gainMoney"]]) {
                label4.text = [NSString stringWithFormat:@"￥0.00"];
            }else{
                label4.text = [NSString stringWithFormat:@"￥%@",dict[@"gainMoney"]];
            }
            
        }
        
        
    } failure:^(NSError * _Nullable error) {
    }];
    
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"personalCentenEditImage" object:nil];
}

@end
