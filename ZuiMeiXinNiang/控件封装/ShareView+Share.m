//
//  ShareView+Share.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/9/8.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "ShareView+Share.h"

@implementation ShareView (Share)

+(void)share:(UIViewController *)controller ShareTitle:(NSString * )title WithContent:(NSString*)descr ShareUrl:(NSString * )url shareImage:(id)shareImage ReporStrType:(NSString *)strtype shareType:(NSString *)sharetype completion:(void (^)(NSString * code))completion{

    // 创建自定义的View
    ShareView *shareView = [[ShareView alloc] init];
    //控制器
    shareView.controller = controller;
    //标题
    shareView.shareTitle = title;
    //分享的描述
    shareView.descr =descr;
 
    //分享链接
    shareView.shareUrl = url;
    //分享的图片
    shareView.shareImage = shareImage;
    
    //小类型，传进来判断是举报还是删除（1 举报，2 删除 ，不传表示不显示）
    shareView.ReportType = strtype;
    
    //分享类型，分享文字还是图片(放在最后)
    shareView.shareType = sharetype;
    
    //坐标
    shareView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    //添加
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];

    //分享结果回调
    [shareView setShareResponse:^(NSString *stringCode) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(stringCode);
            }
        });
        
    }];

    
    
}

@end
