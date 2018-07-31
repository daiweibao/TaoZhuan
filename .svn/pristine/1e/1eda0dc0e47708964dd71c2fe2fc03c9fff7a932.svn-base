//
//  BalanceErrorController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/19.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "BalanceErrorController.h"
#import "PeanutServiceListController.h"

@interface BalanceErrorController ()

@end

@implementation BalanceErrorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.titleLabel.text = @"为什么余额变成负数";
    
    [self setupUI];
}

- (void)setupUI{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15,MC_NavHeight + 15, SCREEN_WIDTH-30, 1)];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    label.textColor = MAIN_COLOR;
    [self.view addSubview:label];
    label.attributedText = [NSString getLabelChangeColor:[UIColor blackColor] andFont:[UIFont systemFontOfSize:14] andString1:@"A：" andChangeString:@"存入订单全额或部分退款后，系统都会认定为无效订单，无效订单产生的收益是要从余额中扣除的，恰好你在扣除前进行了提现操作，而余额不足以抵扣无效订单的收益，才会出现余额是负数的情况。收益会保持正常计算，待每日收益冲抵负数后，会恢复正常。" andGetstring3:@""];
    [label sizeToFit];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, label.bottomY+15, SCREEN_WIDTH, 10)];
    line5.backgroundColor = MAIN_COLOR_Line_Cu;
    [self.view addSubview:line5];
    
    //客服图片
    UIImageView *ServiceView = [[UIImageView alloc]init];
    ServiceView.image = [UIImage imageNamed:@"客服漫画"];
    ServiceView.frame = CGRectMake(43, line5.bottomY+4, 95, 80);
    [self.view addSubview:ServiceView];
    
    UILabel *ServiceLabel = [[UILabel alloc]init];
    ServiceLabel.frame = CGRectMake(0, line5.bottomY+18, SCREEN_WIDTH-30, 15);
    ServiceLabel.text = @"有疑问？客服来解决";
    ServiceLabel.font = [UIFont systemFontOfSize:15];
    ServiceLabel.textAlignment = NSTextAlignmentRight;
    ServiceLabel.textColor = [UIColor blackColor];
    [self.view addSubview:ServiceLabel];
    
    UILabel *chatServiceLabel = [[UILabel alloc]init];
    chatServiceLabel.frame = CGRectMake(SCREEN_WIDTH-30-75, ServiceLabel.bottomY+10, 75, 30);
    chatServiceLabel.text = @"联系客服";
    chatServiceLabel.backgroundColor = MAIN_COLOR;
    chatServiceLabel.font = [UIFont systemFontOfSize:15];
    chatServiceLabel.textAlignment = NSTextAlignmentCenter;
    chatServiceLabel.textColor = [UIColor whiteColor];
    chatServiceLabel.layer.cornerRadius = 3;
    chatServiceLabel.clipsToBounds = YES;
    [self.view addSubview:chatServiceLabel];
    chatServiceLabel.userInteractionEnabled = YES;
    [chatServiceLabel addTapActionTouch:^{
        PeanutServiceListController *vc = [[PeanutServiceListController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, ServiceView.bottomY, SCREEN_WIDTH, SCREEN_HEIGHT)];
    footer.backgroundColor = MAIN_COLOR_Line_Cu;
    [self.view addSubview:footer];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
@end
