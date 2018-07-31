//
//  OpenJDGoodesDetals.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/11/27.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "OpenJDGoodesDetals.h"
#import <JDKeplerSDK/KeplerApiManager.h>
#import "TBAndJDGoodsWebController.h"
@implementation OpenJDGoodesDetals


/**
 是否已经登录过京东

 @return YES代表登陆
 */
+(BOOL)isKeplerLoginJD{
   return  [[KeplerApiManager sharedKPService] isKeplerLogin];
}


/**
 京东授权登陆

 @param controller 控制器
 */
+(void)openJDLoginController:(UIViewController*)controller LoginSuccess:(void (^)(void))success{
    /**
     *  Kepler登录授权
     */
    [[KeplerApiManager sharedKPService] keplerLoginWithViewController:controller success:^(NSString *token) {
//        NSLog(@"京东登陆后返回的token：%@",token);
        //登陆成功回调
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        
    }];
}


/**
 打开京东购物车

 @param controller 控制器
 */
+(void)openJDShoppingCartController:(UIViewController*)controller{
    //先登录了才能购买
    if ([NSString isNULL:SESSIONID]) {
       
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
        return;
    }
    //设置加载进度条颜色
    [[KeplerApiManager sharedKPService] setKeplerProgressBarColor:MAIN_COLOR];
    [[KeplerApiManager sharedKPService] openShoppingCart:controller jumpType:2 customParams:USERID];
}

/**
 JD商品SDK，打开商品详情--根据url
 
 @param controller 控制器
 @param JDUrl 京东商品Url
 @param goodsId 京东商品ID
 */
+(void)openJDMallDetaController:(UIViewController*)controller JDUrl:(NSString*)JDUrl JDGoodId:(NSString*)goodsId{
    /**
     *  通过URL打开Kepler页面
     *
     *  @param url              页面url
     *  @param sourceController 当前显示的UIViewController
     *  @param jumpType         跳转类型(默认 push) 1代表present 2代表push
     *  @param customParams     自定义订单统计参数 不需要可以传nil
     */
   
    //必须判空，否则失败
    if ([NSString isNULL:JDUrl]) {
        [DWBToast showCenterWithText:@"京东商品连接为空"];
        return;
    }
    
     UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
    if ([controller isEqual:[UIApplication sharedApplication].keyWindow.rootViewController]) {
        //传入导航才能push
        controller  = nav;
    }
    
    //先登录了才能购买
    if ([NSString isNULL:SESSIONID]) {
       
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
        return;
    }
    
    //影藏tabbar(必须放在起调SDK之前，否则无效，导航栏可以放在后面)
    controller.tabBarController.tabBar.hidden = YES;
    controller.hidesBottomBarWhenPushed = YES;
    //设置加载进度条颜色
    [[KeplerApiManager sharedKPService] setKeplerProgressBarColor:MAIN_COLOR];
    //传入用户ID，后台统计是哪一个用户下单的。
     [[KeplerApiManager sharedKPService] openKeplerPageWithURL:JDUrl sourceController:controller jumpType:2 customParams:USERID];
    //打开导航栏，不然跳转过去没导航栏(放在后面，必须强制H5打开购买)
    [controller.navigationController setNavigationBarHidden:NO animated:NO];
    //存入京东打开状态，待会返回来的时候去通知后台同步数据
    [OpenJDGoodesDetals addJdorderUserDefauls];
}


/**
 JD商品SDK，打开商品详情--根据ID（用户搜索出来的商品用）--现在换成打开网页
 
 @param controller 控制器
 @param skuId 京东商品skuId-类似商品Id
 */
+(void)openJDMallDetaWithIdController:(UIViewController*)controller JDSkuId:(NSString*)skuId{
    /**
     *  通过SKU打开Kepler单品页
     *
     *  @param sku              商品SKU
     *  @param sourceController 当前显示的UIViewController
     *  @param jumpType         跳转类型(默认 push) 1代表present 2代表push
     *  @param customParams     自定义订单统计参数 不需要可以传nil
     */
    
    //必须判空，否则失败
    if ([NSString isNULL:skuId]) {
        [DWBToast showCenterWithText:@"京东商品skuId为空"];
        return;
    }
    //先登录了才能购买
    if ([NSString isNULL:SESSIONID]) {
      
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
        return;
    }

    /*
    //下面开始起调SDK
    //影藏tabbar(必须放在起调SDK之前，否则无效，导航栏可以放在后面)
    controller.tabBarController.tabBar.hidden = YES;
    controller.hidesBottomBarWhenPushed = YES;
    //设置加载进度条颜色
    [[KeplerApiManager sharedKPService] setKeplerProgressBarColor:MAIN_COLOR];
    //打开详情
    [[KeplerApiManager sharedKPService] openItemDetailWithSKU:skuId sourceController:controller jumpType:2 customParams:USERID];
    
    //打开导航栏，不然跳转过去没导航栏(放在后面，必须强制H5打开购买)
    [controller.navigationController setNavigationBarHidden:NO animated:NO];

    //存入京东打开状态，待会返回来的时候去通知后台同步数据
    [OpenJDGoodesDetals addJdorderUserDefauls];
*/
    
    //用户搜索出来的京东商品，用自己的web打开
    TBAndJDGoodsWebController * JdAndTBVC = [[TBAndJDGoodsWebController alloc]init];
    JdAndTBVC.hidesBottomBarWhenPushed = YES;
    JdAndTBVC.type = @"京东";//类型不传是淘宝
    JdAndTBVC.urlTbOrJd =[NSString stringWithFormat:@"https://item.m.jd.com/product/%@.html",skuId];//京东--首页
    [controller.navigationController pushViewController:JdAndTBVC animated:YES];
    
}

/**
 京东商品搜索封装，传入关键词

 @param controller 控制器
 @param WordsStr 关键词
 */
+(void)JDSearchGoodsController:(UIViewController*)controller AndWords:(NSString*)WordsStr{
    if ([NSString isNULL:WordsStr]) {
        WordsStr = @"";
    }
    //跳转到淘宝搜索界面，不需要SDK
    TBAndJDGoodsWebController * JdAndTBVC = [[TBAndJDGoodsWebController alloc]init];
    //汉字转码
    NSString * wordsUTF = [WordsStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * tbSerachUrl =[NSString stringWithFormat:@"https://so.m.jd.com/ware/search.action?keyword=%@",wordsUTF];//京东搜索
    JdAndTBVC.urlTbOrJd = tbSerachUrl;
    JdAndTBVC.type = @"京东";//类型不传是淘宝
    JdAndTBVC.hidesBottomBarWhenPushed = YES;
    
    //判断，淘口令的时候用跟控制器跳转
    if ([controller isEqual:[UIApplication sharedApplication].keyWindow.rootViewController]) {
        UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
        [nav pushViewController:JdAndTBVC animated:YES];
    }else{
        
        [controller.navigationController pushViewController:JdAndTBVC animated:YES];
    }
    
}



/**
 打开京东首页，url传首页地址打开的是京东首页

 @param controller 控制器
 */
+(void)JDOpenHomeGoodsController:(UIViewController*)controller{
    
    //先登录了才能购买
    if ([NSString isNULL:SESSIONID]) {
       
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
        return;
    }
    
    //传入用户ID，后台统计是哪一个用户下单的。出入空发开的是首页
    // 影藏tabbar，必须放在起调SDK之前，否则京东打开后有问题
    controller.tabBarController.tabBar.hidden = YES;
    controller.hidesBottomBarWhenPushed = YES;
    
// 京东首页网址：https://m.jd.com/?ad_od=3
    //设置加载进度条颜色
    [[KeplerApiManager sharedKPService] setKeplerProgressBarColor:MAIN_COLOR];
    [[KeplerApiManager sharedKPService] openKeplerPageWithURL:@"https://m.jd.com/?ad_od=3" sourceController:controller jumpType:2 customParams:USERID];
    
    //存入京东打开状态，待会返回来的时候去通知后台同步数据
    [OpenJDGoodesDetals addJdorderUserDefauls];
}

//添加京东商品状态--待会同步用
+(void)addJdorderUserDefauls{
    //存入状态同步京东订单
    NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
    [defuaults setObject:@"同步京东订单" forKey:@"addJDorderMy"];
    //保证数据存储成功
    [defuaults synchronize];
}


/**
 添加京东订单，通知后台去同步京东订单
 */
+(void)addJDOrderLoadAFN{
    //判空
    if ([NSString isNULL:SESSIONID]) {
        return;
    }
    //读取是否进入过京东,判断，进入过京东后才去同步
    NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
    NSString * JdStr = [defuaults objectForKey:@"addJDorderMy"];
   
    if ([JdStr isEqual:@"同步京东订单"]) {
        //数据发给后台
        NSDictionary * dict = @{@"sessionId":SESSIONID,@"type":@"ios"};
        [GXJAFNetworking POST:addJDOrder parameters:dict success:^(id  _Nullable responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([responseObject[@"code"] isEqual:@"00"]) {
//                    NSLog(@"添加京东订单：%@",responseObject);
                    //存入空，清除同步状态
                    [defuaults setObject:@"" forKey:@"addJDorderMy"];
                    //保证数据存储成功
                    [defuaults synchronize];
                    
                }
            });
        
        } failure:^(NSError * _Nullable error) {
        }];
    }else{
      //没有进入过京东
//        NSLog(@"没有进入过京东，不去后台同步");
    }
}


/**
 手动刷新京东订单
 */
+(void)jdOrderLoadAFN_handRefresh{
    //判空
    if ([NSString isNULL:SESSIONID]) {
        return;
    }
    //数据发给后台
    NSDictionary * dict = @{@"sessionId":SESSIONID,@"type":@"ios"};
    [GXJAFNetworking POST:addJDOrder parameters:dict success:^(id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([responseObject[@"code"] isEqual:@"00"]) {
            }
        });
        
    } failure:^(NSError * _Nullable error) {
    }];
}


@end
