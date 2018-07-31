//
//  BigActionButton.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/8/30.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark ========== 扩大button点击范围 =================
@interface BigActionButton : UIButton
/// 1.想要放大 btn 的点击热区的范围,注意,只在 btn 的父视图范围内有效
/// 2.这个范围是按钮的整体宽度,如果需要以中心点开始计算,则需要*2

/**
*  扩大button点击范围,在父视图范围内有效 如：MAX(100,50);
*/
@property (nonatomic,assign) CGFloat clickAreaRadious;

//调用方法
//BigActionButton *tickBtn = [[BigActionButton alloc] init];
////扩大按钮的点击热区,并且保持最小50
//tickBtn.clickAreaRadious = MAX(100,50);

@end
