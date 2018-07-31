//
//  GXJRootViewController.m
//  GongXiangJie
//
//  Created by 爱淘包 on 2017/6/19.
//  Copyright © 2017年 GongXiangJie. All rights reserved.
//

#import "XMRootViewController.h"

@interface XMRootViewController ()

@end

@implementation XMRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupRootUI];

}

- (void)setupRootUI{
    
    //返回
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton = backButton;
    backButton.frame = CGRectMake(0, 0, 17, 44);
    backButton.contentMode = UIViewContentModeScaleAspectFill;
    backButton.clipsToBounds = YES;
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressButtonLeft) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,0, SCREEN_WIDTH-200, 44)];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    //    //右边导航栏设置方法
    //    UILabel *labelRight = [[UILabel alloc]init];
    //    labelRight.textAlignment = NSTextAlignmentCenter;
    //    labelRight.text =@"发布";
    //    labelRight.textColor = MAIN_COLOR;
    //    labelRight.font = [UIFont systemFontOfSize:14];
    //    labelRight.frame = CGRectMake(SCREEN_WIDTH-44, MC_StatusBarHeight, 44, 44);
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:labelRight];
    //    labelRight.userInteractionEnabled = YES;
    //    [labelRight addTapActionTouch:^{
    //
    //    }];
}



//返回按钮点击
- (void)pressButtonLeft{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


//将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //友盟统计-开始（全局整个项目只需要一个就可以统计了）
//    [NSString stringWithUTF8String:object_getClassName(self)]//根据父类获取子类控制器名字
    [MobClick beginLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];
//    防止关闭导航栏透明后  控制器坐标下移64
    self.extendedLayoutIncludesOpaqueBars = YES;
    
}
//将要消失
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //友盟统计-结束，（全局整个项目只需要一个就可以统计了）
    //    [NSString stringWithUTF8String:object_getClassName(self)]//根据父类获取子类控制器名字
    //关闭键盘
    [self.view endEditing:YES];
    [MobClick endLogPageView:[NSString stringWithUTF8String:object_getClassName(self)]];
}

////友盟统计
//[MobClick beginLogPageView:[NSString stringWithFormat:@"%@", self.class]];
////友盟统计
//[MobClick endLogPageView:[NSString stringWithFormat:@"%@", self.class]];

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
//iPhone底部遮挡控件,不然很难看。
if (iPhoneX) {
    UIView * iPhoneXBottonView = [[UIView alloc]init];
    iPhoneXBottonView.frame = CGRectMake(0, SCREEN_HEIGHT-MC_TabbarSafeBottomMargin, SCREEN_WIDTH, MC_TabbarSafeBottomMargin);
    iPhoneXBottonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:iPhoneXBottonView];
}
*/

/*
//不要删除，留着后面来复制
 
//创建自定义导航栏
- (void)createNav{
    
    //主导航栏
    UIView *TopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    TopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:TopView];
    
    UILabel *navTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    navTitle.text = @"拼购详情";
    navTitle.textColor = [UIColor blackColor];
    navTitle.font = [UIFont systemFontOfSize:18];
    navTitle.textAlignment = NSTextAlignmentCenter;
    [TopView addSubview:navTitle];
    
    //返回
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 20, 44, 44);
    backButton.contentMode = UIViewContentModeScaleAspectFill;
    backButton.clipsToBounds = YES;
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:backButton];
    
    //取消
     UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(SCREEN_WIDTH-44-15.0*px, 20, 44, 44);
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    [rightButton setTitleColor:MAIN_COLOR_313131 forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(pressButtonRight) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [TopView addSubview:rightButton];

    //线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [TopView addSubview:line];
    
}



//返回
-(void)backButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//右边按钮
-(void)pressButtonRight{
    
}
 
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
*/


/*
 //空白页
 @property (nonatomic,strong)UIImageView *blankPagesIcon;
 @property (nonatomic,strong)UILabel *blankPagesTitle;
 
 #pragma mark ========== 空白页 ==================
 //移除
 [self.blankPagesIcon removeFromSuperview];
 [self.blankPagesTitle removeFromSuperview];
 //打开刷新脚步
 self.tableView.mj_footer.hidden = NO;
 //控制器高度
 CGFloat controlleHeight = SCREEN_HEIGHT -64-35;
 if (self.dataSouce.count==0) {
 //图标
 self.blankPagesIcon = [[UIImageView alloc] init];
 self.blankPagesIcon.frame = CGRectMake((SCREEN_WIDTH/2 - 125.0*px), controlleHeight/2-210.0*px, 250.0*px, 273.0*px);
 self.blankPagesIcon.image = [UIImage imageNamed:@"空白页icon"];
 [self.tableView addSubview: self.blankPagesIcon];
 //标题
 self.blankPagesTitle = [[UILabel alloc]init];
 self.blankPagesTitle.frame = CGRectMake(0, CGRectGetMaxY(self.blankPagesIcon.frame)+32.0*px, SCREEN_WIDTH, 12);
 self.blankPagesTitle.text = @"暂无数据~";
 self.blankPagesTitle.textAlignment = NSTextAlignmentCenter;
 self.blankPagesTitle.font = [UIFont systemFontOfSize:12];
 self.blankPagesTitle.textColor = [UIColor colorWithHexString:@"#898989"];
 [self.tableView addSubview:self.blankPagesTitle];
 //影藏刷新脚步
 self.tableView.mj_footer.hidden = YES;
 }
 
 */


@end
