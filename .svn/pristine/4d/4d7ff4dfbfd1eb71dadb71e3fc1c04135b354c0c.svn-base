//
//  JDAndTBAboutGoodsModel.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/6.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

//文章帖子视频相关商品模型-----后台服务器返回的数据

#import <Foundation/Foundation.h>

@interface JDAndTBAboutGoodsModel : NSObject
@property(nonatomic,strong)NSString * pict_url;//商品封面全路径
@property(nonatomic,strong)NSString * product_name;//商品名称
@property(nonatomic,strong)NSString * zk_price;//折扣价格 没有可以为空
@property(nonatomic,strong)NSString * price;//价格
@property(nonatomic,strong)NSString * skuId;//商品id
@property(nonatomic,strong)NSString * type;//类型: 0 淘宝 1京东
@property(nonatomic,strong)NSString * rate;//年利率，比如0.15
@property(nonatomic,copy)NSString * discount_coupon;//添加优惠券的面额  可能为空，是一个字符串，带汉字
@property(nonatomic,strong)NSString * taoBaoUrl;//淘宝商品url

//其他相关商品---非用户上传的商品【在用】
@property(nonatomic,strong)NSString * img;//封面--专栏文章
@property(nonatomic,strong)NSString * name;//名字--专栏文章
@property(nonatomic,strong)NSString * originPrice;//原价--专栏文章
@property(nonatomic,strong)NSString * propertyId;//服务器端存的商品Id，不是淘宝Id---专栏文章
@property(nonatomic,strong)NSString * outUrl;//淘宝商品外链 --------专栏文章
@property(nonatomic,strong)NSString * false_sale_number;//购买人数---专栏文章
//@property(nonatomic,strong)NSString * skuId;//商品id---专栏文章详情
//@property(nonatomic,strong)NSString * type;//1 专区商品  2  外链商品   3 红人----专栏文章
//@property(nonatomic,strong)NSString * outUrl;//淘宝商品url---专栏文章

//工坊相关商品
@property(nonatomic,strong)NSString * brandProductId;//商品Id
//@property(nonatomic,strong)NSString * originPrice;//原价
//@property(nonatomic,strong)NSString * false_sale_number;//购买人数
@property(nonatomic,strong)NSString * outerUrl;//商品外链--工坊
@property(nonatomic,strong)NSString * productImg;//商品封面
@property(nonatomic,strong)NSString * productName;//商品名字
@property(nonatomic,strong)NSString * productPrice;//商品价钱
@property(nonatomic,strong)NSString * productType;//商品类型  1 专区商品  2 外链商品(淘宝客商品)  3 红人店铺(现在暂时没有)---工坊
//@property(nonatomic,strong)NSString * skuId;//商品id---工坊



//免费课程，单个视频相关商品
//@property(nonatomic,strong)NSString * img;//商品封面----免费课程
//@property(nonatomic,strong)NSString * name;//商品名字
//@property(nonatomic,strong)NSString * originPrice;//原价
//@property(nonatomic,strong)NSString * price;//价格
//@property(nonatomic,strong)NSString * skuId;//淘宝商品Id
//@property(nonatomic,strong)NSString * type;//类型---1 专区商品  2  外链商品


//每日一搭相关商品 ================
//@property(nonatomic,strong)NSString * brandProductId;//商品Id---每日一搭
@property(nonatomic,strong)NSString * discountPrice;//商品价格
@property(nonatomic,strong)NSString * listImage;//商品封面图
//@property(nonatomic,strong)NSString * originPrice;//原价
//@property(nonatomic,strong)NSString * productName;//商品名字
//@property(nonatomic,strong)NSString * skuId;//商品淘宝Id
@end
