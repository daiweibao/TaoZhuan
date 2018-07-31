//
//  KeplerApiManager.h
//  KeplerApp
//  提供Kepler服务
//  Created by JD.K on 16/6/20.
//  Copyright © 2016年 JD.K. All rights reserved.
//  version 2.2.0

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 初始化成功回调 */
typedef void (^initSuccessCallback)();
/** 初始化失败回调 */
typedef void (^initFailedCallback)(NSError *error);
/**
 *  Kepler登录授权成功回调
 *
 *  @param token  登录授权成功后返回的token
 */
typedef void (^keplerLoginSuccessCallback)(NSString *token);
/** Kepler登录授权失败回调 */
typedef void (^keplerLoginFailureCallback)(NSError *error);



@interface KeplerApiManager : NSObject

/**
 分佣的 AppKey2
 */
@property (nonatomic, copy) NSString *secondAppKey;
//*********************************     通过京东APP打开链接相关参数      ************************************
/**
 是否强制使用H5打开界面 设置为YES时，打开链接时不会跳转到JD APP
 */
@property (nonatomic, assign)BOOL isOpenByH5;

/**
 当isOpenByH5为 NO 时，准备跳转到JD APP时会调用这些代码。可以把开启 Loading动画的代码放到这里
 为避免造成混乱，在关闭Kepler界面时，会置为nil。因此需要在每次打开Kepler之前单独设置。
 */
@property (nonatomic, copy) void(^startOpenJDAppBlock)();

/**
 当isOpenByH5为 NO 时，跳转JD APP准备工作完成时会调用这些代码，success为YES表示成功，可以打开JD APP，为NO时表示打开失败。
 为避免造成混乱，在关闭Kepler界面时，会置为nil。因此需要在每次打开Kepler之前单独设置。
 */
@property (nonatomic, copy) void(^finishOpenJDAppBlock)(BOOL success,NSError *error);
/**
 *  打开京东后显示的返回按钮的tagID
 **/
@property (nonatomic, copy) NSString *JDappBackTagID;
/**
 *  京东达人内容ID 关闭kepler界面时会清除 如果需要此值 再次打开需要再次设置
 **/
@property (nonatomic, copy) NSString *actId;
/**
 *  京东达人 内容渠道扩展字段 关闭kepler界面时会清除 如果需要此值 再次打开需要再次设置
 **/
@property (nonatomic, copy) NSString *ext;

/**
 打开京东超时时间设置 关闭 Kepler 界面时不会重置 默认为60
 */
@property (nonatomic, assign) NSTimeInterval openJDTimeout;
//*******************************************************************************************************



/**
 *  KeplerApiManager 单例
 *
 *  @return KeplerApiManager 单例
 */
+ (KeplerApiManager *)sharedKPService;
/**
 *  注册Kepler 服务
 *
 *  @param appKey      注册的appKey
 *  @param appSecret   注册的secretKey
 */
- (void)asyncInitSdk:(NSString *)appKey
           secretKey:(NSString *)appSecret
      sucessCallback:(initSuccessCallback)sucessCallback
      failedCallback:(initFailedCallback)failedCallback;
/**
 *  通过URL打开Kepler页面
 *
 *  @param url              页面url
 *  @param sourceController 当前显示的UIViewController
 *  @param jumpType         跳转类型(默认 push) 1代表present 2代表push
 *  @param customParams     自定义订单统计参数 不需要可以传nil
 */
- (void)openKeplerPageWithURL:(NSString *)url sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openKeplerPageWithURL:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openKeplerPageWithURL:(NSString *)url sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;

/**
 *  打开导航页
 */
- (void)openNavigationPage:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openNavigationPage:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openNavigationPage:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;
/**
 *  通过SKU打开Kepler单品页
 *
 *  @param sku              商品SKU
 */
- (void)openItemDetailWithSKU:(NSString *)sku sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openItemDetailWithSKU:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openItemDetailWithSKU:(NSString *)sku sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;

/**
 *  打开订单列表
 */
- (void)openOrderList:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openOrderList:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openOrderList:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;

/**
 *  根据搜索关键字打开搜索结果页
 *
 *  @param searchKey        搜索关键字
 */
- (void)openSearchResult:(NSString *)searchKey sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openSearchResult:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openSearchResult:(NSString *)searchKey sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;

/**
 *  打开购物车界面
 *
 */
- (void)openShoppingCart:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openShoppingCart:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openShoppingCart:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;

/**
 *  根据传入的名称打开对应的分类列表
 *  名称必须是京东支持的分类:
 @"热门分类","手机",@"家用电器",@"电脑办公","摄影数码",@"女装服饰",@"男装服饰",@"时尚鞋靴",@"内衣配件",@"运动户外",
 @"珠宝饰品",@"钟表",@"母婴用品",@"童装童鞋",@"玩具乐器",@"护肤美妆",@"清洁洗护",@"皮具箱包",@"家居家纺",@"生活用品",
 @"食品生鲜",@"酒水饮料",@"奢品礼品",@"家具建材",@"热卖品牌",@"营养保健",@"汽车用品",@"宠物专区",@"图书音像"@"情趣用品";
 也可打开导航页实时查看所支持的分类.
 */
- (void)openCategoryListWithName:(NSString *)categoryName sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType customParams:(NSString *)customParams API_DEPRECATED_WITH_REPLACEMENT("openShoppingCart:sourceController:jumpType:userInfo:", ios(7.0,11.0));

- (void)openCategoryListWithName:(NSString *)categoryName sourceController:(UIViewController *)sourceController jumpType:(NSInteger)jumpType userInfo:(NSDictionary *)userInfo;

/**
 *  添加到购物车
 *
 *  @param skuList 添加到购物车中的商品id
 *  @param numList 添加到购物车中商品数量,多个商品必须与skuList一一对应
 *  @param success 添加成功回调
 *  @param failure 添加失败回调
 */
- (void)addToCartWithSkuList:(NSArray *)skuList numList:(NSArray *)numList sourceController:(UIViewController *)sourceController success:(void(^)(void))success failure:(void(^)(NSError *))failure;
/**
 *  Kepler处理URL
 *
 *  @param url url
 *
 *  @return 处理结果
 */

- (BOOL)handleOpenURL:(NSURL*)url;

/**
 *  取消打开京东 如果打开京东APP在弱网情况下耗时过长，需要取消打开京东，可调用该方法。
 *  SDK会执行finishOpenJDAppBlock
 *  取消后不会尝试使用H5打开
 **/
- (void)cancelOpenJD;

/**
 *  M静态化检测更新
 */
- (void)checkUpdate;
/**
 *  取消授权
 */
- (void)cancelAuth;

/**
 *  设置加载进度条颜色
 */
- (void)setKeplerProgressBarColor:(UIColor *)progressBarColor;

/**
 *  Kepler登录授权
 */
- (void)keplerLoginWithViewController:(UIViewController *)viewController success:(keplerLoginSuccessCallback)successCallback failure:(keplerLoginFailureCallback)failureCallback;

/**
 *  标识曾经登录完成过，因为服务端安全逻辑，可能这个用户登录态已经失效
 */
- (BOOL)isKeplerLogin;

- (UIViewController *)openItemDetailWithSKU:(NSString *)sku userInfo:(NSDictionary *)userInfo hiddenNavigationBar:(BOOL)hidden;

- (UIViewController *)openKeplerPageWithURL:(NSString *)url userInfo:(NSDictionary *)userInfo hiddenNavigationBar:(BOOL)hidden;
@end

