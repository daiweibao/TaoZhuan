//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{

    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
  
    
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:17.0];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;    
    //背景颜色
     hud.color = [UIColor blackColor];
    //透明度
    hud.alpha = 0.8;
    //变大动画
    hud.animationType = MBProgressHUDAnimationZoomIn;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    //不要挡住用户其他操作
    hud.userInteractionEnabled = NO;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.5];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"bigerror.png" view:view];
}
//icon-info
#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"DWBSuccess.png" view:view];
}

#pragma mark 显示提示信息
+ (void)showInfo:(NSString *)info
{
    [self show:info icon:@"icon-info.png" view:nil];
}

#pragma mark 显示没网提示
+ (void)showNoNetwork:(NSString *)noNetwork
{
    [self show:noNetwork icon:@"DWBError.png" view:nil];
}

#pragma mark 显示一些信息==纯文字提示
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //变大动画
    hud.animationType = MBProgressHUDAnimationZoom;
    //纯文本
    hud.mode = MBProgressHUDModeText;
  
    //提示的内容detailsLabelText 多行显示 labelText 只显示一行
    hud.detailsLabelText = message;
    //字体大小
    hud.detailsLabelFont = [UIFont systemFontOfSize:17.0];
    //背景颜色
    hud.color = [UIColor blackColor];
    //透明度
    hud.alpha = 0.8;

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    //不要挡住用户其他操作
    hud.userInteractionEnabled = NO;
    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    //多少时间后影藏
    [hud hide:YES afterDelay:1.5];
    
    return hud;
}


+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

//影藏keyWindows上的
+ (void)hideHUD
{
    [self hideHUDForView:[UIApplication sharedApplication].keyWindow];
}


//展示加载中，不会自动影藏
+ (void)showHUDLodingStart:(NSString *)message toView:(UIView *)view{
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD * hudLoding = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hudLoding.animationType = MBProgressHUDAnimationZoomIn;
    //背景颜色
    hudLoding.color = [UIColor blackColor];
    //透明度
    hudLoding.alpha = 0.8;

    [hudLoding setLabelText:message];
}

//加载完成
+ (void)showHUDLodingEnd:(NSString *)message toView:(UIView *)view{
    //先影藏加载中
     if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:NO];
   //在创建加载完成
    MBProgressHUD * hudLoding = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hudLoding.animationType = MBProgressHUDAnimationZoomIn;
    hudLoding.mode = MBProgressHUDModeText;
    //背景颜色
    hudLoding.color = [UIColor blackColor];
    //透明度
    hudLoding.alpha = 0.8;
    
    hudLoding.detailsLabelText = message;
    hudLoding.detailsLabelFont = [UIFont systemFontOfSize:17.0];
    //不要挡住用户其他操作
    hudLoding.userInteractionEnabled = NO;
    
    [hudLoding hide:YES afterDelay:0.5];
    // 隐藏时候从父控件中移除
    hudLoding.removeFromSuperViewOnHide = YES;
    
   
}


@end
