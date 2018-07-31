//
//  OpenJDGoodesDetals.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/11/27.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenJDGoodesDetals : NSObject
/**
 是否已经登录过京东
 
 @return YES代表登陆
 */
+(BOOL)isKeplerLoginJD;
/**
 京东授权登陆
 
 @param controller 控制器
 */
+(void)openJDLoginController:(UIViewController*)controller LoginSuccess:(void (^)(void))success;

/**
 打开京东购物车
 
 @param controller 控制器
 */
+(void)openJDShoppingCartController:(UIViewController*)controller;

/**
 JD商品SDK，通过【商品连接】打开商品详情

 @param controller 控制器
 @param JDUrl 京东商品Url
 @param goodsId 京东商品ID
 */
+(void)openJDMallDetaController:(UIViewController*)controller JDUrl:(NSString*)JDUrl JDGoodId:(NSString*)goodsId;

/**
 JD商品SDK，通过【skuId】打开商品详情 （用户搜索出来的商品用）
 
 @param controller 控制器
 @param skuId 京东商品skuId-类似商品Id
 */
+(void)openJDMallDetaWithIdController:(UIViewController*)controller JDSkuId:(NSString*)skuId;
/**
 京东商品搜索封装，传入关键词
 
 @param controller 控制器
 @param WordsStr 关键词
 */
+(void)JDSearchGoodsController:(UIViewController*)controller AndWords:(NSString*)WordsStr;
/**
 打开京东首页，url传入京东首页的网址打开的是首页【网址去浏览器里拿】
 
 @param controller 控制器
 */
+(void)JDOpenHomeGoodsController:(UIViewController*)controller;
/**
 添加京东订单，通知后台去同步京东订单
 */
+(void)addJDOrderLoadAFN;

/**
 手动刷新京东订单
 */
+(void)jdOrderLoadAFN_handRefresh;

@end
