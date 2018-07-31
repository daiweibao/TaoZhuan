//
//  SVProgressHUD+KZ.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/9/6.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "SVProgressHUD.h"
//SVP指示器（不能删）
#import "SVProgressHUD.h"

@interface SVProgressHUD (KZ)

//展示加载中，不会自动影藏(不允许用户交互)
+ (void)showSVPLodingStart:(NSString *)message;
//展示加载中，不会自动影藏(允许用户交互)
+ (void)showSVPLodingUseCanActionStart:(NSString *)message;

//加载成功
+(void)showSVPSuccess;
//HUD可以用以下方法隐藏:
//
//+ (void)dismiss;
@end
