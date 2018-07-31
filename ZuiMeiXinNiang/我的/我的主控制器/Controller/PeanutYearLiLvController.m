//
//  PeanutYearRateController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/14.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "PeanutYearLiLvController.h"
#import "EzraRoundView.h"
#import "PeanutInviteFriendController.h"//分享嗅美花生
#import "PeanutRankListController.h"//排行
#import "HuaShenMoneyBarController.h"//花生返利主界面

@interface PeanutYearLiLvController ()

@property (nonatomic,strong) EzraRoundView *roundView;

@end

@implementation PeanutYearLiLvController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.titleLabel.text = @"了解年化收益";
    
    if (self.rate.length == 0) {
        [self loadMoneyData];
    }else{
        
        [self setupUI];
    }

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
            
            //年化利率
            if ([NSString isNULL:dict[@"rate"]]) {
                self.rate = @"";
            }else{
                self.rate = [NSString stringWithFormat:@"%@",dict[@"rate"]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setupUI];
            });
        }
        
    } failure:^(NSError * _Nullable error) {
    }];
    
}

- (void)setupUI{
    
    //创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.userInteractionEnabled = YES;
//    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 705-20+45);
//    adjustsScrollViewInsets_NO(scrollView, self);
    [self.view addSubview:scrollView];
    
    //去掉%
    CGFloat myper = 0.0;
    NSString *subRate;
    if ([self.rate containsString:@"%"]) {
        
        subRate = [self.rate substringWithRange:NSMakeRange(0, self.rate.length-1)];
        
        myper = [subRate doubleValue];
        
        
        if (myper > 27.0) {
            myper = 27.0;
        }
    }else{
        myper = 0.0;
    }
    //创建表盘
    EzraRoundView *roundView = [[EzraRoundView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 315)];
    self.roundView = roundView;
    roundView.myrate = self.rate;//最终显示结果（仅仅显示）
    [scrollView addSubview:roundView];
    //满值
    self.roundView.maximum = 27.0*2;
    //期望值
    self.roundView.percent = 27.0+myper;
    self.roundView.myper = [[NSString stringWithFormat:@"%f",[subRate doubleValue]] doubleValue];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.roundView.bottomY, SCREEN_WIDTH, 10)];
    line.backgroundColor = MAIN_COLOR_Line_Cu;
    [scrollView addSubview:line];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, line.bottomY, SCREEN_WIDTH, 45)];
    label.text = @"分享领收益，提升年化利率";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = MAIN_COLOR_BLACK;
    label.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:label];
    
    NSArray *imagenames = @[@"rate购购go",@"rate邀请好友",@"rate邀请排行",@"rate好友助力"];
    NSArray *mainLabels = @[@"购购go",@"邀请好友",@"邀请排行",@"好友助力"];
    NSArray *subLabels = @[@"尽情购物，消费享收益，提升利率，多买化妆品、鞋子、包包、服装等，提升更快哦",
                           @"分享给好友，好友注册登录、每次消费，都会提升你的利率",
                           @"每周排行前三的用户都会获得淘赚送出的奖励，快来占据周榜吧",
                           @"分享我的专属海报，好友助力升利率，没注册过的朋友提升的更多哦"];
    
    UIView *Lastbg;//最后一个
    
    CGFloat labelW = (SCREEN_WIDTH-30 - 130 - 15);
    
    for (int i=0; i<4; i++) {
        
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(15, label.bottomY+90*i, SCREEN_WIDTH-30, 80)];
        Lastbg = bg;
        bg.backgroundColor = [UIColor colorWithHexString:@"#fbf2ed"];
        bg.layer.cornerRadius = 4;
        bg.clipsToBounds = YES;
        bg.tag = i;
        [scrollView addSubview:bg];
        bg.userInteractionEnabled = YES;
        WeakSelf(bg);
        [bg addTapActionTouch:^{
            if (weakbg.tag == 0) {
                
                HuaShenMoneyBarController *VC= [[HuaShenMoneyBarController alloc]init];
                VC.isHaveTabbar = @"1";
                [self.navigationController pushViewController:VC animated:YES];
                
            }else if (weakbg.tag == 1) {//邀请好友
                
                if ([NSString isNULL:SESSIONID]) {
                  
                    //弹窗登陆
                    [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                        
                    }];
                    return;
                }
//                 NSLog(@"%@",peanutFriendInvit);
                PeanutInviteFriendController *VC= [[PeanutInviteFriendController alloc]init];
                [self.navigationController pushViewController:VC animated:YES];
                
            }else if (weakbg.tag == 2) {
                PeanutRankListController *VC= [[PeanutRankListController alloc]init];
                [self.navigationController pushViewController:VC animated:YES];
            }else{
                if ([NSString isNULL:SESSIONID]) {
                  
                    //弹窗登陆
                    [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                        
                    }];
                    return;
                }
                //分享
                
//                NSLog(@"%@",peanutFriendHelp);
                
                UIImage * image = [UIImage imageNamed:@"花生分享红包图"];
                [ShareView share:self ShareTitle:@"帮我助力——下淘赚，获得更多收益！" WithContent:@"淘赚，花钱如存款，收益拿不停！" ShareUrl:peanutFriendHelp shareImage:image ReporStrType:@"只分享到微信" shareType:nil completion:^(NSString *code) {
                    
                }];
                
            }
            
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 130, 80);
        [btn setImage:[UIImage imageNamed:imagenames[i]] forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
        [bg addSubview:btn];
        
        UILabel *mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(btn.rightX, 15, labelW, 15)];
        mainLabel.text = mainLabels[i];
        mainLabel.font = [UIFont systemFontOfSize:15];
        mainLabel.textColor = [UIColor colorWithHexString:@"#616161"];
        [bg addSubview:mainLabel];
        
        UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(btn.rightX, mainLabel.bottomY+12, labelW, 1)];
        subLabel.text = subLabels[i];
        subLabel.font = [UIFont systemFontOfSize:10];
        subLabel.textColor = [UIColor colorWithHexString:@"#818181"];
        subLabel.numberOfLines = 2;
        [subLabel sizeToFit];
        [bg addSubview:subLabel];
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end





