//
//  TBGoodsWebController.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/8.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//
//用这个控制器打开淘宝商品【暂时不要乱改里面的设置】---这里只能用UIWebView，不能用WK--淘宝SDK专属
//sdk不会获取商品ID
#import <UIKit/UIKit.h>

@interface TBGoodsSDKWebController : UIViewController<UIWebViewDelegate, NSURLConnectionDelegate>

@property (strong, nonatomic) UIWebView *webView;
//导航栏标题
@property(nonatomic,strong)NSString * titleStr;
@end
