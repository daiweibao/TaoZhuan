//
//  JDAndTBGoodsModel.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/4.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//
//京东和淘宝商品的model-整个项目中大部分地方在用---直接从天猫淘宝获取的数据也用这个模型
#import <Foundation/Foundation.h>

@interface JDAndTBGoodsModel : NSObject

#pragma mark =============== 【京东】商品专属 S=======================
@property(nonatomic,strong)NSString * commentCount;//商品评论数，非实时，如果需要展示，请调实时接口
/*
返回图片地址(imageUrl)为相对路径，全路径格式为：
http://imgServer.360buyimg.com/size/ + imageUrl
其中imgServer为img10-14，建议平均分配
size为下列值：
n0  800*800
n1  350*350
n2  160*160
n3  130*130
n4  100*100
n5  50*50
比如下面链接
http://img10.360buyimg.com/n1/jfs/t2299/230/2253855915/284347/23e5fb2b/56fa70bdNac64bc79.jpg
获取350*350的图片
 */
@property(nonatomic,strong)NSString * imageUrl;//商品主图,注意京东商品图片需要拼接--【京东】
@property(nonatomic,strong)NSString * price;// 价格--【京东】
@property(nonatomic,strong)NSString * selfSale;// 是否自营--【京东】
@property(nonatomic,strong)NSString * skuId;//skuId,就是商品Id,根据这个参数能跳转商品详情--【京东】
@property(nonatomic,strong)NSString * wareName;//商品名称--【京东】
#pragma mark =============== 【京东】商品专属 E=======================


#pragma mark =============== 【淘宝】商品专属 S=======================
@property(nonatomic,strong)NSString * pict_url;//商品主图
@property(nonatomic,strong)NSString * title;//商品标题
@property(nonatomic,strong)NSString * zk_final_price;//商品折扣价格
@property(nonatomic,strong)NSString * reserve_price;//商品一口价格(也就是商品原价)
@property(nonatomic,strong)NSString * num_iid;//搜索出来的淘宝商品ID=
@property(nonatomic,strong)NSString * item_url;//搜索出来的淘宝商品的详情url
//下面是淘宝商品无用参数
@property(nonatomic,strong)NSString * nick;//卖家昵称
@property(nonatomic,strong)NSString * provcity;//宝贝所在地
@property(nonatomic,strong)NSString * seller_id;//卖家id
@property(nonatomic,strong)NSString * user_type;//卖家类型，0表示集市，1表示商城
@property(nonatomic,strong)NSString * volume;//30天销量
@property(nonatomic,strong)NSString * small_images;//商品小图列表
#pragma mark =============== 【淘宝】商品专属 E=======================




#pragma mark ------------------完美分割线（上面是淘宝京东SDK文档里的参数键值对） ------------------------------------

//控制器类型--发布添加商品还是其他界面的商品，发布界面必传，控制复选框的，其他界面不用传
@property(nonatomic,strong)NSString * controllerType;
//记录选中状态,发布话题选择商品时是否选中商品--自己加的参数
@property(nonatomic,assign)BOOL isSelseGoods;



#pragma mark ==========  商品公用参数--自定义参数-S ================
@property(nonatomic,strong)NSString * goodsImage;//商品封面
@property(nonatomic,strong)NSString * goodsName;//商品名字
@property(nonatomic,strong)NSString * goodsPrice;//商品现在价格
@property(nonatomic,strong)NSString * goodsOldPrice;//商品原来价格--只有淘宝商品搜索能拿到数据
@property(nonatomic,strong)NSString * goodsCounponMoney;//优惠劵面额，是一个字符串，带汉字
@property(nonatomic,strong)NSString * goodsId;//商品Id
@property(nonatomic,strong)NSString * goodsUrl;//商品详情连接
@property(nonatomic,strong)NSString * rate;//年利率，比如0.15
//商品类型--京东商品还是淘宝商品：类型: 0 淘宝 1京东 2天猫
@property(nonatomic,strong)NSString * goodsType;
#pragma mark ========== 商品公用参数--自定义参数-E ================

@end
