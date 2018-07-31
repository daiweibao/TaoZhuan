//
//  DaKaMainController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/5/2.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "DaKaMainController.h"
//大转盘
#import "TurntableViewController.h"
//打卡
#import "DakaiViewController.h"
@interface DaKaMainController ()

@end

@implementation DaKaMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"打卡福利";
    
    [self createUI];
}

//创建UI
-(void)createUI{
    
    //打卡
    UIView * viewDakaSub = [[UIView alloc]init];
    viewDakaSub.backgroundColor = MAIN_COLOR_qqGreen;
    viewDakaSub.userInteractionEnabled = YES;
    WeakSelf(self);
    [viewDakaSub addTapActionTouch:^{
        //打卡
         DakaiViewController * dakaVC=[[ DakaiViewController alloc]init];
        [weakself.navigationController pushViewController:dakaVC animated:YES];
        
    }];
    [self.view addSubview:viewDakaSub];
    
    [viewDakaSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(MC_NavHeight+10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(200.0*px);
    }];
    
    //图片
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"早起挑战"];
    imageView.layer.cornerRadius = 5;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [viewDakaSub addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(viewDakaSub);
        make.size.mas_equalTo(viewDakaSub);
    }];
    
    //大转盘
    UIView * bigZPSub = [[UIView alloc]init];
    bigZPSub.userInteractionEnabled = YES;
    [bigZPSub addTapActionTouch:^{
        //大转盘
        TurntableViewController * integraVC=[[ TurntableViewController alloc]init];
        [weakself.navigationController pushViewController:integraVC animated:YES];
        
    }];
    [self.view addSubview:bigZPSub];
    [bigZPSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(viewDakaSub.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(200.0*px);
    }];
    //标题
    UIButton * buttonBig = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBig.userInteractionEnabled = NO;
    [buttonBig setBackgroundImage:[UIImage imageNamed:@"标题背景"] forState:UIControlStateNormal];
    [buttonBig setTitle:@"超级大转盘" forState:UIControlStateNormal];
    buttonBig.titleLabel.font = [UIFont systemFontOfSize:36];
    buttonBig.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [bigZPSub addSubview:buttonBig];
    [buttonBig mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(bigZPSub);
    }];
    
    
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
