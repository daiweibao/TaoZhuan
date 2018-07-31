//
//  MineNavigationController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/5/16.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "MineNavigationController.h"

@interface MineNavigationController ()

@end

@implementation MineNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //侧滑返回
    self.interactivePopGestureRecognizer.delegate = (id)self;
    //self.navigationBar.backgroundColor = [UIColor yellowColor];
    
     UINavigationBar *bar = [UINavigationBar appearance];
     bar.translucent =  YES ;
}


/**
 * （嗅美项目暂时不打开，加上后系统返回键会消失）可以在这个方法中拦截所有push进来的控制器,处理push后控制器底部有49高度位置点击效果无效  MDDateVC.hidesBottomBarWhenPushed = YES;
 */
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    
//    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//        //隐藏tabbar
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    
//    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
//    [super pushViewController:viewController animated:animated];
//    
//}



////初始化的方法，当前类中所有方法调用之前，调用的第一个方法
//+ (void)initialize {
//    //1 设置导航条的样式
//    //获取到当前所有显示的导航条
//    UINavigationBar *bar = [UINavigationBar appearance];
//    //设置导航条的背景图片
//    //UIBarMetricsDefault  设置横屏和竖屏显示的图片
//    //UIBarMetricsCompact  横屏显示的图片
//    [bar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:UIBarMetricsDefault];
//     [bar setShadowImage:[UIImage new]];
//    //设置标题的字体颜色
//    //[bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    //去掉导航条的半透明效果  -- 如果有透明度，控制器的view有穿透效果。如果没有透明度，控制器的view没有穿透效果
//    bar.translucent = NO;
//   
//    //2 导航按钮的样式
//   // UIBarButtonItem *item = [UIBarButtonItem appearance];
//    //设置导航按钮的文字颜色和大小
////    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
//}
//


////重写导航控制器的push方法，viewController要跳转到的控制器
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    
//    
//    //跳转之前添加后退按钮
//    [self addBackButton:viewController];
//    
//    [super pushViewController:viewController animated:YES];
//}

////1 设置自定义后退按钮
//- (void)addBackButton:(UIViewController *)viewController {
//    //设置后退的手势
//    self.interactivePopGestureRecognizer.delegate = (id)self;
//    
//    //当push的时候隐藏底部的tabBar
//    viewController.hidesBottomBarWhenPushed = YES;
//    
//    //自定义后退按钮
//    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"NavBack"] orginalImage] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
//    //固定的fixed  固定的间距
//    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    fixed.width = -10;
//    
//    viewController.navigationItem.leftBarButtonItems = @[fixed,back];
//}
//
////点击自定义回退按钮
//- (void)backClick {
//    //弹到上一个控制器
//    [self popViewControllerAnimated:YES];
//}
#pragma mark ====================== 处理屏幕旋转--UINavigationController（在用，请不要删=========================
// 是否支持自动转屏
- (BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}
// 支持哪些屏幕方向 topViewController(push)
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）visibleViewController(模态)
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//
//    //导航栏颜色
//    self.navigationBar.barTintColor = [UIColor whiteColor];
//
//    //关闭导航栏半透明
//    self.navigationBar.translucent = NO;

    //根据颜色生成一张灰色的背景图片   替换导航栏的下边的分割线
    UIImage *lineimage = [UIImage imageWithColor:MAIN_COLOR_Line_Xi size:CGSizeMake(SCREEN_WIDTH, 1)];
    [self.navigationBar setShadowImage:lineimage];

}

@end
