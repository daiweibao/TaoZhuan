//
//  AboutMyViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/2/25.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "AboutMyViewController.h"

@interface AboutMyViewController ()

@end

@implementation AboutMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"关于淘赚";
    
    //创建网页
    [self createUI];
    
}

-(void)createUI{
    //创建logo
    UIImageView * imageLogo = [[UIImageView alloc]init];
    imageLogo.image = [UIImage imageNamed:appLogoName];
    imageLogo.layer.cornerRadius = 10;
    imageLogo.clipsToBounds = YES;
    imageLogo.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageLogo];
    [imageLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MC_NavHeight+30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    //创建标题
    UILabel *labelName = [[UILabel alloc]init];
    labelName.text = @"淘赚";
    labelName.textAlignment = NSTextAlignmentCenter;
    labelName.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:labelName];
    [labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageLogo.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
         make.left.right.mas_equalTo(0);
    }];
    
    //创建版本号
    UILabel *labelVresion = [[UILabel alloc]init];
    labelVresion.text = [NSString stringWithFormat:@"版本号：%@",GET_VERSION];
    labelVresion.font = [UIFont systemFontOfSize:14];
     labelVresion.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelVresion];
    [labelVresion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labelName.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.right.mas_equalTo(0);
    }];
    
    
    //创建介绍
    UILabel * labelInfo = [[UILabel alloc]init];
    labelInfo.numberOfLines = 0;
    labelInfo.font = [UIFont systemFontOfSize:14];
    labelInfo.textColor = [UIColor blackColor];
    //设置行间距
     labelInfo.attributedText = [NSString getLabelLineSpace:@"    淘赚成立于2018年5月5日，是一家专门做淘宝电商服务的品台，用户通过在上面购买东子可以赚取利息，从而进行提现。" LineSpacing:8];
    [self.view addSubview:labelInfo];
    [labelInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labelVresion.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    
    //创建版权
    UILabel *labelCopyright = [[UILabel alloc]init];
    labelCopyright.numberOfLines = 2;
    labelCopyright.attributedText = [NSString getLabelChangeColor:[UIColor blackColor] andFont:[UIFont systemFontOfSize:12] andString1:@"版权©2018年淘赚.保留所有权利\n" andChangeString:@"爱恨的潮汐" andGetstring3:@""];
    labelCopyright.font = [UIFont systemFontOfSize:12];
    labelCopyright.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelCopyright];
    [labelCopyright mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-MC_TabbarSafeBottomMargin-40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.right.mas_equalTo(0);
    }];
    
    
    
    
    //创建分享按钮
    UIButton * buttonShare = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonShare setTitle:@"分享APP" forState:UIControlStateNormal];
    buttonShare.titleLabel.font = [UIFont systemFontOfSize:16];
    buttonShare.layer.cornerRadius = 20;
    buttonShare.backgroundColor =RGB_COLOR(255, 103, 43);
    [buttonShare addTarget:self action:@selector(ActionButtonShare) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonShare];
    [buttonShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(labelCopyright).offset(-50);
    }];
    
    
   
}



//分享--淘赚钱
-(void)ActionButtonShare{
    //分享
    UIImage * image = [UIImage imageNamed:appLogoName];
     NSString *strAppStore = AppstoreUrl;
    [ShareView share:self ShareTitle:@"淘赚，购物赚收益，打卡分现金，你值得拥有~" WithContent: [NSString stringWithFormat:@"版本:%@",GET_VERSION] ShareUrl:strAppStore shareImage:image ReporStrType:@"只分享到微信" shareType:nil completion:^(NSString *code) {
        
    }];
    

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
   
  
    
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
