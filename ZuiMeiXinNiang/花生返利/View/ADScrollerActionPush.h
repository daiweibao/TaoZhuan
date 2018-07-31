//
//  ADScrollerActionPush.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/12.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//
//广告轮播图点击跳转封装
#import <Foundation/Foundation.h>

@interface ADScrollerActionPush : NSObject
/**
 广告轮播图点击事件封装
 
 @param controller 控制器
 @param dictScroll 数据数组
 */
+(void)AdscrollClickController:(UIViewController *)controller AndDict:(NSDictionary *)dictScroll;
@end
