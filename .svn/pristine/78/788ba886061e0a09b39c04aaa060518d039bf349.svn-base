//
//  ShareView.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/9/8.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView
//控制器
@property(nonatomic,strong)UIViewController * controller;
//标题
@property(nonatomic,copy)NSString * shareTitle;
//分享的描述
@property(nonatomic,copy)NSString * descr;
//分享链接
@property(nonatomic,copy)NSString * shareUrl;
//分享的图片
@property(nonatomic,strong)id shareImage;

//类型，传进来判断是举报还是删除，如果为空表示不显示
@property(nonatomic,strong)NSString * ReportType;
//分享类型，是纯文字、纯图片还是网页
@property(nonatomic,strong)NSString * shareType;

//分享结果回调
@property(nonatomic,copy)void (^shareResponse)( NSString * strcode);

@end
