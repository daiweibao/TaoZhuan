//
//  PeanutWalletController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/9.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "PeanutWalletController.h"
#import "PeanutBalanceController.h"//余额明细
#import "TodayGetMoneyController.h"//今日收益
#import "TotalGetMoneyController.h"//累计收益
#import "SpendMoneyDetailController.h"//花费明细
#import "TiXianToZFBController.h"
#import "PeanutYearLiLvController.h"//年化利率


@interface PeanutWalletController ()
@property (nonatomic,strong)NSArray *labels;
@property (nonatomic,strong)UILabel *todayMoney;
@property (nonatomic,strong)UILabel *totalLabel;
@end

@implementation PeanutWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupUI];
    
    [self loadData];
}

- (void)loadData{
    
    
    [GXJAFNetworking POST:getMoneyPackage parameters:@{@"sessionId":SESSIONID} success:^(id  _Nullable responseObject) {
        
            //                NSLog(@"获取未读消息：%@",responseObject);
            if ([responseObject[@"code"] isEqual:@"00"]) {
//                consumeMoney = 200;
//                dayGain = "0.0712";
//                gainMoney = "<null>";
//                rate = "0.13";
//                sumGainMoney = "<null>";
                
                NSDictionary *dict = responseObject[@"result"];
                
                //今日收益
                if ([NSString isNULL:dict[@"dayGain"]]) {
                    self.todayMoney.text = [NSString stringWithFormat:@"￥0.00"];
                }else{
                    self.todayMoney.text = [NSString stringWithFormat:@"￥%@",dict[@"dayGain"]];
                }
                
                //累计收益
                if ([NSString isNULL:dict[@"sumGainMoney"]]) {
                    self.totalLabel.text = [NSString stringWithFormat:@"累计收益：￥0.00"];
                }else{
                    self.totalLabel.text = [NSString stringWithFormat:@"累计收益：￥%@",dict[@"sumGainMoney"] ];
                }
                
                //年化利率
                 UILabel *label1 = self.labels.firstObject;
                if ([NSString isNULL:dict[@"rate"]]) {
                    label1.text = @"0.0\%";
                }else{
                    label1.text = [NSString stringWithFormat:@"%@",dict[@"rate"]];
                }
                
                //余额
                UILabel *label2 = self.labels[1];
                if ([NSString isNULL:dict[@"gainMoney"]]) {
                    label2.text = [NSString stringWithFormat:@"￥0.00"];
                }else{
                    label2.text = [NSString stringWithFormat:@"￥%@",dict[@"gainMoney"]];
                }
                
                
                //花费总额
                UILabel *label3 = self.labels.lastObject;
                if ([NSString isNULL:dict[@"consumeMoney"]]) {
                    label3.text = [NSString stringWithFormat:@"￥0.00"];
                }else{
                    label3.text = [NSString stringWithFormat:@"￥%@",dict[@"consumeMoney"]];
                }
                
                

            }
     
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

- (void)setupUI{
    
    CGFloat headH = (290-20)+MC_StatusBarHeight;
    
    UIImageView *bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headH)];
    bg.userInteractionEnabled = YES;
    bg.image = [UIImage imageNamed:@"花生钱包背景色"];
    [self.view addSubview:bg];
    
    //钱包
    UIButton *bagImg = [UIButton buttonWithType:UIButtonTypeCustom];
    bagImg.frame = CGRectMake(35, MC_NavHeight, 117, headH-MC_NavHeight-50);
    [bagImg setImage:[UIImage imageNamed:@"花生钱包钱包"] forState:UIControlStateNormal];
    bagImg.userInteractionEnabled = NO;
    [bg addSubview:bagImg];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, MC_NavHeight+55, SCREEN_WIDTH-50, 14)];
    label1.text = @"今日收益";
    label1.textAlignment = NSTextAlignmentRight;
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:14];
    [bg addSubview:label1];
    label1.userInteractionEnabled = YES;
    [label1 addTapActionTouch:^{
        TodayGetMoneyController *vc = [[TodayGetMoneyController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, label1.bottomY+10, SCREEN_WIDTH-50, 36)];
    self.todayMoney = label2;
    label2.text = @"¥--";
    label2.textAlignment = NSTextAlignmentRight;
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:35];
    [bg addSubview:label2];
    label2.userInteractionEnabled = YES;
    [label2 addTapActionTouch:^{
        TodayGetMoneyController *vc = [[TodayGetMoneyController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, label2.bottomY+15, SCREEN_WIDTH-50, 14)];
    self.totalLabel = label3;
    label3.text = @"累计收益：¥--";
    label3.textAlignment = NSTextAlignmentRight;
    label3.textColor = [UIColor whiteColor];
    label3.font = [UIFont systemFontOfSize:14];
    [bg addSubview:label3];
    label3.userInteractionEnabled = YES;
    [label3 addTapActionTouch:^{
        TotalGetMoneyController *vc = [[TotalGetMoneyController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    //工具栏
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, headH-50, SCREEN_WIDTH, 50)];
    toolView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    [bg addSubview:toolView];
    NSMutableArray *arrTep = [NSMutableArray array];
    NSArray *titles = @[@"年化利率",@"余额",@"花费总额"];
    for (int i=0; i<3; i++) {
        UILabel *info = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/3)*i, headH-50+8, SCREEN_WIDTH/3, 14)];
        info.text = titles[i];
        info.textAlignment = NSTextAlignmentCenter;
        info.textColor = [UIColor whiteColor];
        info.font = [UIFont systemFontOfSize:14];
        [bg addSubview:info];
        info.tag = i;
        info.userInteractionEnabled = YES;
        WeakSelf(info);
        [info addTapActionTouch:^{
            if (weakinfo.tag == 0) {
//                NSLog(@"年化利率");
                 UILabel *label = self.labels.firstObject;
                PeanutYearLiLvController *vc = [[PeanutYearLiLvController alloc]init];
                vc.rate = label.text;
                if ([label.text containsString:@"%"]) {
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else if (weakinfo.tag == 1) {
                PeanutBalanceController *vc = [[PeanutBalanceController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                SpendMoneyDetailController *vc = [[SpendMoneyDetailController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }];
        
        
        UILabel *num = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/3)*i, info.bottomY+5, SCREEN_WIDTH/3, 14)];
        num.text = @"";
        [arrTep addObject:num];
        num.textAlignment = NSTextAlignmentCenter;
        num.textColor = [UIColor whiteColor];
        num.font = [UIFont systemFontOfSize:14];
        [bg addSubview:num];
        num.tag = i;
        num.userInteractionEnabled = YES;
        WeakSelf(num);
        [num addTapActionTouch:^{
            if (weaknum.tag == 0) {
                UILabel *label = self.labels.firstObject;
                PeanutYearLiLvController *vc = [[PeanutYearLiLvController alloc]init];
                vc.rate = label.text;
                if ([label.text containsString:@"%"]) {
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else if (weaknum.tag == 1) {
                PeanutBalanceController *vc = [[PeanutBalanceController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                SpendMoneyDetailController *vc = [[SpendMoneyDetailController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/3)*(i+1), headH-50+7.5, 0.5, 35)];
        line.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
        [bg addSubview:line];
    }
    self.labels = arrTep.copy;
    //返回
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, MC_StatusBarHeight, 44, 44);
    backButton.contentMode = UIViewContentModeScaleAspectFill;
    backButton.clipsToBounds = YES;
    [backButton setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressButtonLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //导航标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, MC_StatusBarHeight, SCREEN_WIDTH, 44)];
    navLabel.text = @"淘赚钱包";
    navLabel.textAlignment = NSTextAlignmentCenter;
    navLabel.textColor = [UIColor whiteColor];
    navLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:navLabel];
    
    //分割线
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, headH, SCREEN_WIDTH, 10)];
    line1.backgroundColor = MAIN_COLOR_Line_Cu;
    [self.view addSubview:line1];
    
    UILabel *offMoney = [[UILabel alloc]initWithFrame:CGRectMake(15, line1.bottomY, SCREEN_WIDTH, 44)];
    offMoney.text = @"余额明细";
    offMoney.font = [UIFont systemFontOfSize:14];
    offMoney.textColor = [UIColor blackColor];
    [self.view addSubview:offMoney];
    offMoney.userInteractionEnabled = YES;
    [offMoney addTapActionTouch:^{
        PeanutBalanceController *vc = [[PeanutBalanceController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    //进入
    UIButton * Enter1 = [UIButton buttonWithType:UIButtonTypeCustom];
    Enter1.frame = CGRectMake(SCREEN_WIDTH-44, line1.bottomY, 44, 44);
    [Enter1 setImage:[UIImage imageNamed:@"进入"] forState:UIControlStateNormal];
    Enter1.userInteractionEnabled = NO;
    [self.view addSubview:Enter1];
    
    //分割线
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(15, offMoney.bottomY, SCREEN_WIDTH, 0.5)];
    line2.backgroundColor = MAIN_COLOR_Line_Xi;
    [self.view addSubview:line2];
    
    UILabel *tixian = [[UILabel alloc]initWithFrame:CGRectMake(15, line2.bottomY, SCREEN_WIDTH, 44)];
    tixian.text = @"提现";
    tixian.font = [UIFont systemFontOfSize:14];
    tixian.textColor = [UIColor blackColor];
    [self.view addSubview:tixian];
    tixian.userInteractionEnabled = YES;
    [tixian addTapActionTouch:^{

        TiXianToZFBController * a = [[TiXianToZFBController alloc]init];
        a.hidesBottomBarWhenPushed = YES;
        [a setBlackRefreshMoney:^{
           //刷新钱包界面
             [self loadData];
        }];
        [self.navigationController pushViewController:a animated:YES];

    }];
    
    UIButton * Enter2 = [UIButton buttonWithType:UIButtonTypeCustom];
    Enter2.frame = CGRectMake(SCREEN_WIDTH-44, line2.bottomY, 44, 44);
    [Enter2 setImage:[UIImage imageNamed:@"进入"] forState:UIControlStateNormal];
    Enter2.userInteractionEnabled = NO;
    [self.view addSubview:Enter2];
    
    //分割线
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, tixian.bottomY, SCREEN_WIDTH, SCREEN_HEIGHT)];
    footer.backgroundColor = MAIN_COLOR_Line_Cu;
    [self.view addSubview:footer];
    
    //说明
    UILabel *info = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-45, SCREEN_WIDTH, 45)];
    info.text = @"点击相应模块就能查看明细";
    info.textAlignment = NSTextAlignmentCenter;
    info.textColor = MAIN_COLOR_898989;
    info.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:info];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
@end
