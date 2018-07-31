//
//  ShareView+Share.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/9/8.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "ShareView.h"

@interface ShareView (Share)

// shareType = @"只分享文字";  shareType = @"只分享图片";
/**
 *  分享+分享结果(一行代码搞定)：code 00标识成功，01表示失败  strtype:1 举报，2 删除 ，类型不传1、2就隐藏 sharetype分享类型
 *
 *  @param controller 控制器
 *  @param title      分享标题
 *  @param title      分享描述
 *  @param url        分享连接
 *  @param shareImage  分享的图片
 *  @param strtype  类型，传进来判断是举报还是删除（1 举报，2 删除 ，类型不传1、2就隐藏）
 *  @param sharetype 分享类型
 *  @param completion 分享结果回调
 */
+(void)share:(UIViewController *)controller ShareTitle:(NSString * )title WithContent:(NSString*)descr ShareUrl:(NSString * )url shareImage:(id)shareImage ReporStrType:(NSString *)strtype shareType:(NSString *)sharetype completion:(void (^)(NSString * code))completion;


@end
