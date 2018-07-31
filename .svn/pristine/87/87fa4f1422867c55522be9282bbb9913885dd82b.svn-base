//
//  MainViewController.m
//  SinaWeibo
//
//  Created by user on 15/10/13.
//  Copyright © 2015年 ZT. All rights reserved.
//

#import "MainViewController.h"
//tabbar
#import "TBTabBar.h"
//导航栏
#import "MineNavigationController.h"
//花生返利
#import "HuaShenMoneyBarController.h"
//订单列表
#import "HSOrderListController.h"
//个人中心3.1.0
#import "MyCenterViewController3_1_0.h"
//我的年化率
#import "TodayEarningsController.h"
//打卡福利
#import "DaKaMainController.h"

@interface MainViewController ()

/** 之前被选中的UITabBarItem */
@property (nonatomic, strong) UITabBarItem *lastItem;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化所有控制器
    [self setUpChildVC];
    
    // 创建tabbar中间的tabbarItem
    [self setUpMidelTabbarItem];

}

#pragma mark -创建tabbar中间的tabbarItem

- (void)setUpMidelTabbarItem {
    
     TBTabBar *tabBar = [[TBTabBar alloc] init];//凸出的tabbar
//    UITabBar *tabBar = [[UITabBar alloc] init];
     // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
    
    //去掉黑线,然后替换tabbar上面那一条线,下面两个方法必须同时设置，否则无效imageWithColor是根据颜色生成图片的封装
    [tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.view.frame.size.width, .5)]];
    [tabBar setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#d1d3db"] size:CGSizeMake(self.view.frame.size.width, .5)]];
    
    
    //（3）设置其他属性
    tabBar.barTintColor = [UIColor whiteColor];//设置tabbar背景颜色
    tabBar.translucent = NO;
   
    
    // 二次点击触发刷新将默认被选中的tabBarItem保存为属性
    self.lastItem = tabBar.selectedItem;
    
    
    //中间发布按钮点击回调(屏蔽掉就就换成不突出的)
    __weak typeof(self) weakSelf = self;
    [tabBar setDidClickPublishBtn:^{
        
        //凸出按钮点击事件
        [weakSelf plusBtnClick];
        
    }];

}

#pragma mark -初始化所有控制器

- (void)setUpChildVC {
    
    //花生返利
    HuaShenMoneyBarController *fishpidVC = [[HuaShenMoneyBarController alloc] init];
    [self setChildVC:fishpidVC title:@"首页" image:@"tabbar_首页" selectedImage:@"tabbar_首页选中"];
    

    //年化率
     TodayEarningsController  * todayMoneyVC = [[TodayEarningsController alloc] init];
    [self setChildVC:todayMoneyVC title:@"今日收益" image:@"tabbar-资讯" selectedImage:@"tabbar-资讯S"];
    
    //订单
    HSOrderListController *orderVC = [[HSOrderListController alloc] init];
    [self setChildVC:orderVC title:@"订单" image:@"tabbar_订单" selectedImage:@"tabbar_订单选中"];
    
    
//        //打卡福利
//        DaKaMainController *orderVC = [[DaKaMainController alloc] init];
//        [self setChildVC:orderVC title:@"订单" image:@"tabbar_订单" selectedImage:@"tabbar_订单选中"];
    
    //我的
    MyCenterViewController3_1_0 *myVC = [[MyCenterViewController3_1_0 alloc] init];
    [self setChildVC:myVC title:@"我的" image:@"tabbar_我的" selectedImage:@"tabbar_我的选中"];
    
}

//设置子控制器
- (void) setChildVC:(UIViewController *)childVC title:(NSString *) title image:(NSString *) image selectedImage:(NSString *) selectedImage {
    
    childVC.tabBarItem.title = title;
    //设置字体属性
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = MAIN_COLOR_898989;
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    //设置字体属性(选中)
    NSMutableDictionary *dictSelect = [NSMutableDictionary dictionary];
    dictSelect[NSForegroundColorAttributeName] = [UIColor orangeColor];
    dictSelect[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    //禁用渲染
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:dictSelect forState:UIControlStateSelected];
    
    //设置图片
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //字控制器图片调整位置
    //    childVC.tabBarItem.imageInsets =  UIEdgeInsetsMake(5, 0, -5, 0);
    
    // 二次点击触发刷新将默认被选中的tabBarItem保存为属性
    self.lastItem = self.tabBar.selectedItem;
    
    //导航
    MineNavigationController *nav = [[MineNavigationController alloc] initWithRootViewController:childVC];
    //导航栏颜色
    nav.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self addChildViewController:nav];
}

//二次点击tabbar触发刷新代理方法
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    // 判断本次点击的UITabBarItem是否和上次的一样
    if (item == self.lastItem) { // 一样就发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LLTabBarDidClickNotification" object:nil userInfo:nil];
    }
    // 将这次点击的UITabBarItem赋值给属性
    self.lastItem = item;
    
}

//中间凸出tabbar点击
- (void)plusBtnClick{
    //push控制器
    MineNavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
    //打卡主界面
    DaKaMainController * voiceVC = [[DaKaMainController alloc]init];
    [nav pushViewController:voiceVC animated:NO];
    
}



#pragma mark ====================== 处理屏幕旋转--UITabBarController（在用，请不要删）=========================
-(BOOL)shouldAutorotate{
   return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}


@end
