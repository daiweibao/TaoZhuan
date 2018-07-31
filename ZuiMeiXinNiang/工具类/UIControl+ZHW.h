//
//  UIControl+ZHW.h
//  UIButtonMutablieClick
//
//  Created by andson-zhw on 16/8/3.
//  Copyright © 2016年 andson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (ZHW)
/**
 *  [iOS]利用runtime,解决多次点击相同button,导致重复跳转的问题,指定时间内button只会响应一次，下面那条属性也必须设置，否则AppStore上线后点击不会响应了。(👎🏻警告：暂时不能用，上线AppStore后还是有问题)
 */
@property (nonatomic, assign) NSTimeInterval zhw_acceptEventInterval;//添加点击事件的间隔时间（必须设置，二者缺一不可）


/**
 是否忽略点击事件,必须设置为NO，否则AppStore上线后点击无效。
 */
@property (nonatomic, assign) BOOL zhw_ignoreEvent;//是否忽略点击事件,不响应点击事件（必须设置，二者缺一不可）

@end
