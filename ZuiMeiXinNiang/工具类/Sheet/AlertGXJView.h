//
//  AlertGXJView.h
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/6/26.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlockAtIndex)(NSInteger index);
@interface AlertGXJView : UIView
//回调经按钮tage
@property (nonatomic, copy) ActionBlockAtIndex actionBlockAtIndex;

/**
 自己封装的共享街aleat type暂时还没用到，传0
 
 @param controller 弹窗所在控制器
 @param title 标题
 @param message 内容
 @param array 按钮
 @param width 宽度
 @param type 类型，1代表允许重复弹窗 ,2代表移除老的弹窗，展示新的弹窗（推送用）
 @param block 回调
 */
+ (void)AlertGXJAlertWithController:(UIViewController*)controller Title:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array Width:(CGFloat)width Type:(NSInteger)type handler:(ActionBlockAtIndex)block;

@end
