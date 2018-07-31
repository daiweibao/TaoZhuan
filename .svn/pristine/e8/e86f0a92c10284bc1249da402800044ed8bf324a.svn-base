//
//  LoadingView.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/9/12.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

#pragma mark =========== 新的发方法 =============
//控制器
@property(nonatomic,strong)UIViewController * controller;
//是否要创建返回键
@property(nonatomic,assign)BOOL isBack;
//y坐标
@property(nonatomic,assign)CGFloat Max_Y;
//控件高度
@property(nonatomic,assign)CGFloat height;

/**
 *  新封装方法，传入起始坐标和高度，是否创建返回键 就可以
 *
 *  @param controller 控制器self
 *  @param isBack     是否要创建返回按钮
 *  @param max_Y      控件Y的最大坐标
 *  @param height     控件高度
 */
+(void)loadingView:(UIViewController*)controller isCreateBack:(BOOL)isBack viewMaxY:(CGFloat)max_Y viewHeight:(CGFloat)height;


/**
 加载失败
 */
+(void)loadingfailure;

/**
 *  移除加载中——控制器传进去+填self
 */
+(void)removeLoadingController:(UIViewController*)controller;

@end
