//
//  OpenTaobaoGoodes.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/5/9.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenTaobaoGoodes : NSObject

/**
 是否已经登录过淘宝
 
 @return YES代表登陆
 */
+(BOOL)isTaoBaoLoginTb;
/**
 淘宝授权登陆
 
 @param controller 控制器
 */
+(void)openTBLoginController:(UIViewController*)controller LoginSuccess:(void (^)(void))success;
/**
 淘宝商品SDK，通过商品连接打开商品详情
 
 @param controller 控制器
 @param taoBaoUrl 淘宝客商品Url
 @param goodsId 淘宝客商品Id
 */
+(void)openTaoboMallDetaController:(UIViewController*)controller TaoBaoUrl:(NSString*)taoBaoUrl taoBaoGoodId:(NSString*)goodsId;
/**
 淘宝商品SDK，通过Itmid打开商品详情
 
 @param controller 控制器
 @param itemId 淘宝客商平itemId
 @param goodsId 淘宝客商品Id
 */
+(void)openTaoboMallDetaController:(UIViewController*)controller TaoBaoItemId:(NSString*)itemId;


/**
 淘宝商品搜索封装，传入关键词
 
 @param controller 控制器
 @param WordsStr 关键词
 */
+(void)TBSearchGoodsController:(UIViewController*)controller AndTBWords:(NSString*)WordsStr;


/**
 淘宝商品SDK，通过Itmid、或者通过商品url打开商品详情--在自己的网页控制器中打开【只有在真正支付的时候才会触发，返回不会触发回调】
 
 @param controller 控制器
 @param itemId 淘宝客商品itemId
 @param taoBaoUrl 淘宝商品详情连接
 @param goodsType 商品类型 0是淘宝，2是天猫
 @param price 商品价格
 @param imageUrl 商品封面
 @param goodsName 商品名字
 */
+(void)openTaoboMallDetaMyWebViewController:(UIViewController*)controller TaoBaoItemId:(NSString*)itemId TaoBaoUrl:(NSString*)taoBaoUrl AndGoodsType:(NSString*)goodsType AndGoodsPrice:(NSString *)goodsPrice AndGoodsImageUrl:(NSString *)imageUrl AndGoodsName:(NSString *)goodsName;
@end

