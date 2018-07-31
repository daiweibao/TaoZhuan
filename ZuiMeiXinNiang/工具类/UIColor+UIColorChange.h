//
//  UIColor+UIColorChange.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/4/26.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColorChange)
/**
 *  带#号的十六进制颜色转换
 *
 *  @param color 带#号的颜色字符串
 *
 *  @return 颜色
 */
+ (UIColor *) colorWithHexString: (NSString *)color;


@end
