//
//  OpenTaobaoGoodes.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/5/9.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "OpenTaobaoGoodes.h"
//阿里百川SDK3.1(2017年5月9日)
#import <AlibcTradeSDK/AlibcTradeSDK.h>
//阿里百川电商授权登陆
#import <AlibabaAuthSDK/ALBBSDK.h>
//淘宝商品web展示
#import "TBGoodsSDKWebController.h"
//淘宝商品搜索页web展示
#import "TBAndJDGoodsWebController.h"
@interface OpenTaobaoGoodes()

@end

@implementation OpenTaobaoGoodes

/**
 是否已经登录过淘宝
 
 @return YES代表登陆
 */
+(BOOL)isTaoBaoLoginTb{
     ALBBSession *albbSDK = [ALBBSession sharedInstance];
    return  [albbSDK isLogin];
}


/**
 京东授权登陆
 
 @param controller 控制器
 */
+(void)openTBLoginController:(UIViewController*)controller LoginSuccess:(void (^)(void))success{
    /**
     *  淘宝登录授权
     */
    ALBBSDK *albbSDK = [ALBBSDK sharedInstance];
    [albbSDK setAuthOption:NormalAuth];//授权方式--正常授权（淘宝+h5）
    [albbSDK auth:controller successCallback:^(ALBBSession *session) {
        //登陆成功回调
        if (success) {
            success();
        }
    } failureCallback:^(ALBBSession *session, NSError *error) {
        
    }];
}



/**
 淘宝商品SDK，通过商品连接打开商品详情
 
 @param controller 控制器
 @param taoBaoUrl 淘宝客商品Url
 @param goodsId 淘宝客商品Id
 */
+(void)openTaoboMallDetaController:(UIViewController*)controller TaoBaoUrl:(NSString*)taoBaoUrl taoBaoGoodId:(NSString*)goodsId{
    
    /**
     * 使用百川SDK的webview打开page，可以实现淘宝账号免登以及电商交易支付流程
     *
     * @param parentController            当前view controller. 若isNeedPush为YES, 需传入当前UINavigationController.
     * @param page                        想要打开的page
     * @param showParams                  打开方式的一些自定义参数
     * @param taoKeParams                 淘客参数
     * @param trackParam                  链路跟踪参数
     * @param tradeProcessSuccessCallback 交易流程中成功回调(加购成功(使用+[AlibcTradePageFactory addCartPage:]时)/发生支付)
     * @param tradeProcessFailedCallback  交易流程中退出或者调用发生错误的回调
     *
     * @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
     */
    
    //必须判空，否则失败
    if ([NSString isNULL:taoBaoUrl]) {
        [DWBToast showCenterWithText:@"淘宝商品连接为空"];
        return;
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
    
    
    // 禁用 iOS7 返回手势(必须，否则淘宝客导航栏会消失)
    if ([controller.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        controller.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    NSLog(@"商品连接：%@",taoBaoUrl);
    
    id<AlibcTradePage> page = [AlibcTradePageFactory page:taoBaoUrl];
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    
    showParams.isNeedPush = YES;
    //强制H5打开
    showParams.openType = AlibcOpenTypeH5;
    
    // 以下是让电商SDK自己生成 WebView 对象进行展示的方式
    //     @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
    //用户Id用来追踪订单
    NSString * userId;
    if ([NSString isNULL:USERID]) {
        userId = @"";
    }else{
        userId = USERID;
    }
    NSDictionary * dictTrackParam = @{@"userId":userId};
    NSInteger res = [service
                     show:showParams.isNeedPush ? controller.navigationController : controller
                     page:page
                     showParams:showParams
                     taoKeParams:nil
                     trackParam:dictTrackParam //链路跟踪参数
                     tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
                         
                         // 开启侧滑返回(必须，否则淘宝客导航栏会消失)
                         if ([controller.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                             controller.navigationController.interactivePopGestureRecognizer.enabled = YES;
                         }
                         NSLog(@"淘宝商品成功：%@",result);
                         NSLog(@"支付成功订单：%@",result.payResult.paySuccessOrders);
                         NSLog(@"支付失败订单：%@",result.payResult.payFailedOrders);
                         
                         [AlertGXJView AlertGXJAlertWithController:controller Title:@"淘宝商品支付成功的订单为看打印数据" Message:nil otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {
                             
                             
                         }];
                         
                     } tradeProcessFailedCallback:^(NSError * _Nullable error) {
                         //         NSLog(@"淘宝商品失败：%@",error);
                         //             701    SEC_ERROR_STA_KEY_ENC_INVALID_PARAM    参数不正确，请检查输入的参数
                         
                         NSLog(@"淘宝失败回调：%@",error);
                         
                         // 开启侧滑返回(必须，否则淘宝客导航栏会消失)
                         if ([controller.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                             controller.navigationController.interactivePopGestureRecognizer.enabled = YES;
                         }
                     }];
    
    if (res == 1) {
        //打开导航栏，不然跳转过去没导航栏---强制h5打开的时候必填
        [controller.navigationController setNavigationBarHidden:NO animated:NO];
        
    }
    
    if (goodsId.length>0) {
        //浏览商品点击淘宝统计发给后台服务器
        [NSString totalTaobaoUrl:goodsId];
        
    }
}


/**
 淘宝商品SDK，通过Itmid打开商品详情--在SDK网页控制器中打开
 
 @param controller 控制器
 @param itemId 淘宝客商平itemId
 @param goodsId 淘宝客商品Id
 */
+(void)openTaoboMallDetaController:(UIViewController*)controller TaoBaoItemId:(NSString*)itemId{
    
    /**
     * 使用百川SDK的webview打开page，可以实现淘宝账号免登以及电商交易支付流程
     *
     * @param parentController            当前view controller. 若isNeedPush为YES, 需传入当前UINavigationController.
     * @param page                        想要打开的page
     * @param showParams                  打开方式的一些自定义参数
     * @param taoKeParams                 淘客参数
     * @param trackParam                  链路跟踪参数
     * @param tradeProcessSuccessCallback 交易流程中成功回调(加购成功(使用+[AlibcTradePageFactory addCartPage:]时)/发生支付)
     * @param tradeProcessFailedCallback  交易流程中退出或者调用发生错误的回调
     *
     * @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
     */
    
    //必须判空，否则失败
    if ([NSString isNULL:itemId]) {
        [DWBToast showCenterWithText:@"淘宝商品Id为空"];
        return;
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
    
    
    // 禁用 iOS7 返回手势(必须，否则淘宝客导航栏会消失)
    if ([controller.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        controller.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    NSLog(@"商品Id：%@",itemId);
    
    id<AlibcTradePage> page = [AlibcTradePageFactory itemDetailPage:itemId];
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    
    showParams.isNeedPush = NO;
    //强制H5打开
    showParams.openType = AlibcOpenTypeH5;
    //     @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
    
    //用户Id用来追踪订单
    NSString * userId;
    if ([NSString isNULL:USERID]) {
        userId = @"";
    }else{
        userId = USERID;
    }
    NSDictionary * dictTrackParam = @{@"userId":userId};
    NSInteger res = [service
                     show:showParams.isNeedPush ? controller.navigationController : controller
                     page:page
                     showParams:showParams
                     taoKeParams:nil
                     trackParam:dictTrackParam //链路跟踪参数
                     tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
                         
                         // 开启侧滑返回(必须，否则淘宝客导航栏会消失)
                         if ([controller.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                             controller.navigationController.interactivePopGestureRecognizer.enabled = YES;
                         }
                         NSLog(@"淘宝商品成功：%@",result);
                         NSLog(@"支付成功订单：%@",result.payResult.paySuccessOrders);
                         NSLog(@"支付失败订单：%@",result.payResult.payFailedOrders);
                         
                         [AlertGXJView AlertGXJAlertWithController:controller Title:@"淘宝商品支付成功的订单为看打印数据" Message:nil otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {
                             
                             
                         }];
                         
                     } tradeProcessFailedCallback:^(NSError * _Nullable error) {
                         //         NSLog(@"淘宝商品失败：%@",error);
                         //             701    SEC_ERROR_STA_KEY_ENC_INVALID_PARAM    参数不正确，请检查输入的参数
                         
                         NSLog(@"淘宝失败回调：%@",error);
                         
                         // 开启侧滑返回(必须，否则淘宝客导航栏会消失)
                         if ([controller.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                             controller.navigationController.interactivePopGestureRecognizer.enabled = YES;
                         }
                     }];
    
    if (res == 1) {
        //打开导航栏，不然跳转过去没导航栏---强制h5打开的时候必填
        [controller.navigationController setNavigationBarHidden:NO animated:NO];
        
    }
}



/**
 淘宝商品搜索封装，传入关键词
 
 @param controller 控制器
 @param WordsStr 关键词
 */
+(void)TBSearchGoodsController:(UIViewController*)controller AndTBWords:(NSString*)WordsStr{
    if ([NSString isNULL:WordsStr]) {
        WordsStr = @"";
    }
    //跳转到淘宝搜索界面，不需要SDK
    TBAndJDGoodsWebController * JdAndTBVC = [[TBAndJDGoodsWebController alloc]init];
    //汉字转码
    NSString * wordsUTF = [WordsStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * tbSerachUrl =[NSString stringWithFormat:@"https://ai.m.taobao.com/search.html?&q=%@&pid=%@",wordsUTF,TB_mmId];//爱淘宝搜索
    JdAndTBVC.urlTbOrJd = tbSerachUrl;
    JdAndTBVC.type = @"淘宝";//类型不传是淘宝
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
  淘宝商品SDK，通过Itmid、或者通过商品url打开商品详情--在自己的网页控制器中打开【只有在真正支付的时候才会触发，返回不会触发回调】
 
 @param controller 控制器
 @param itemId 淘宝客商品itemId
 @param taoBaoUrl 淘宝商品详情连接
 @param goodsType 商品类型 0是淘宝，2是天猫
 @param price 商品价格
 @param imageUrl 商品封面
 @param goodsName 商品名字
 */
+(void)openTaoboMallDetaMyWebViewController:(UIViewController*)controller TaoBaoItemId:(NSString*)itemId TaoBaoUrl:(NSString*)taoBaoUrl AndGoodsType:(NSString*)goodsType AndGoodsPrice:(NSString *)goodsPrice AndGoodsImageUrl:(NSString *)imageUrl AndGoodsName:(NSString *)goodsName{
    
    /**
     * 使用百川SDK的webview打开page，可以实现淘宝账号免登以及电商交易支付流程
     *
     * @param parentController            当前view controller. 若isNeedPush为YES, 需传入当前UINavigationController.
     * @param page                        想要打开的page
     * @param showParams                  打开方式的一些自定义参数
     * @param taoKeParams                 淘客参数
     * @param trackParam                  链路跟踪参数
     * @param tradeProcessSuccessCallback 交易流程中成功回调(加购成功(使用+[AlibcTradePageFactory addCartPage:]时)/发生支付)
     * @param tradeProcessFailedCallback  交易流程中退出或者调用发生错误的回调
     *
     * @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
     */
    
    //必须判空，否则失败
    if ([NSString isNULL:itemId]&&[NSString isNULL:taoBaoUrl]) {
        [DWBToast showCenterWithText:@"⚠️淘宝商品不存在,该商品可能是假的~"];
        return;
    }
    if ([NSString isNULL:itemId]) {
        itemId = @"";
    }
    if ([NSString isNULL:taoBaoUrl]) {
        taoBaoUrl = @"";
    }
    //先登录了才能购买
    if ([NSString isNULL:SESSIONID]) {
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
        return;
    }
    
//    影藏tabbar(必须放在起调SDK之前，否则无效，导航栏可以放在后面)
    controller.tabBarController.tabBar.hidden = YES;
    controller.hidesBottomBarWhenPushed = YES;
    
    
//    NSLog(@"淘宝商品Id：%@",itemId);
//    NSLog(@"淘宝商品连接：%@",taoBaoUrl);
    
    id<AlibcTradePage> page;
    //判断商品连接存在就根据商品连接跳转，否则根据商品Id跳转商品详情
    if ([NSString isNULL:taoBaoUrl]==NO) {
        //淘宝商品连接存在
        page = [AlibcTradePageFactory page:taoBaoUrl];
    }else{
        //根据ID跳转商品详情，iD必须转化成字符串
        page = [AlibcTradePageFactory itemDetailPage:[NSString stringWithFormat:@"%@",itemId]];
    }
    id<AlibcTradeService> service = [AlibcTradeSDK sharedInstance].tradeService;
    AlibcTradeShowParams *showParams = [[AlibcTradeShowParams alloc] init];
    showParams.isNeedPush = YES;
    //强制H5打开
    showParams.openType = AlibcOpenTypeH5;
    
   //  绑定自己的WebView
    // YourWebViewController类中,webview的delegate设置不能放在viewdidload里面,必须在init的时候,否则函数调用的时候还是nil
        TBGoodsSDKWebController* MyWebView = [[TBGoodsSDKWebController alloc] init];
    //商品类型--京东商品还是淘宝商品：类型: 0 淘宝 1京东 2天猫
        if([goodsType isEqual:@"2"]){
            //是指标题
            MyWebView.titleStr = @"天猫";
        }else{
            MyWebView.titleStr = @"淘宝";
        }
    //测试数据 95206329004178891  95297759269010891   87602812008995789
//     [OpenTaobaoGoodes addTaobaoOrderMyAllGoodsPaySuccessOrder:@[@"115956213198178870",@"115821255367446173",@"115843148276178870",@"11581895671415649",@"115818956714156495"] AndGoodsPrice:goodsPrice AndGoodsImageUrl:imageUrl AndGoodsName:goodsName TaoBaoItemId:nil];
    
     // 返利：买12000000 --->得32876元
    // @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
    //用户Id用来追踪订单
    NSString * userId;
    if ([NSString isNULL:USERID]) {
        userId = @"";
    }else{
        userId = USERID;
    }
    NSDictionary * dictTrackParam = @{@"userId":userId};
        NSInteger res = [service
                         show:MyWebView
                         webView:MyWebView.webView
                         page:page
                         showParams:showParams
                         taoKeParams:nil
                         trackParam:dictTrackParam//链路跟踪参数
                         tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
//                             【只有在真正支付的时候才会触发，返回不会触发回调】
                             NSLog(@"淘宝商品成功：%@",result);
                             NSLog(@"支付成功订单：%@",result.payResult.paySuccessOrders);
                             NSLog(@"支付失败订单：%@",result.payResult.payFailedOrders);
                             //支付成功后添加订单
                             NSArray * arrayOrder = result.payResult.paySuccessOrders;
                             //遍历订单号，传给后台，购物车结算的时候会有多个订单号
                             [OpenTaobaoGoodes addTaobaoOrderMyAllGoodsPaySuccessOrder:arrayOrder AndGoodsPrice:goodsPrice AndGoodsImageUrl:imageUrl AndGoodsName:goodsName TaoBaoItemId:itemId];
                         }
                         tradeProcessFailedCallback:^(NSError * _Nullable error) {
//                             【只有在真正支付的时候才会触发，返回不会触发回调】
                            NSLog(@"淘宝失败回调：%@",error);
                             NSLog(@"失败理由：%@",error.localizedDescription);
                         }];
        // @return 0标识跳转到手淘打开了,1标识用h5打开,-1标识出错
        if (res == 1) {
            [controller.navigationController pushViewController:MyWebView animated:NO];
        }
    
//#pragma mark =========== 商品Id不存在的情况提示用户，购买可能会丢单--《只能放在界面跳转后面》（如购物车结算按钮。没有获取到id的商品）===========
//    if ([NSString isNULL:itemId]) {
//        [AlertViewTool AlertAlertWithTitle:@"警告" Message:@"该行为购买会造成丢单，请你在购买后及时联系嗅美客服补单，谢谢你的体谅~" otherItemArrays:@[@"明白了"] viewController:[UIApplication sharedApplication].keyWindow.rootViewController handler:^(NSInteger index) {
//            if (index==0) {
//                //知道了
//            }
//        }];
//    }
}

//添加淘宝订单
+ (void)addTaobaoOrderMyAllGoodsPaySuccessOrder:(NSArray *)orderArray AndGoodsPrice:(NSString *)goodsPrice AndGoodsImageUrl:(NSString *)imageUrl AndGoodsName:(NSString *)goodsName TaoBaoItemId:(NSString*)itemId{
    //必须判空，否则失败
    if ([NSString isNULL:SESSIONID]) {
        return;
    }
    //判空
    if (orderArray.count == 0) {
        [AlertViewTool AlertAlertWithTitle:@"订单号为空" Message:@"支付成功，但是该订单号为空，该单将无法存入淘赚，如有疑问请及时联系淘赚客服"  otherItemArrays:@[@"知道了"] viewController:[UIApplication sharedApplication].keyWindow.rootViewController handler:^(NSInteger index) {
            if (index==0) {
                //知道了
            }
        }];
        return;
    }
    for (int i = 0; i < orderArray.count; i++) {
        NSString * orderNum = orderArray[i];
        //判空
        if ([NSString isNULL:goodsPrice]) {
            goodsPrice = @"0.00";
        }
        //封面判空
        if ([NSString isNULL:imageUrl]) {
            imageUrl = @"";
        }
        //判空
        if ([NSString isNULL:goodsName]) {
            goodsName = @"";
        }
        //判空
        if ([NSString isNULL:itemId]) {
            itemId = @"";
        }
        
        //参数    @"skuId":itemId//商品Id
        NSDictionary * dictt =  @{@"sessionId":SESSIONID,
                                  @"order_number":orderNum,//订单号
                                  @"skuId":itemId//商品Id
                                  };
        [GXJAFNetworking POST:addTaobaoOrder parameters:dictt success:^(id  _Nullable responseObject) {
            if ([responseObject[@"code"] isEqual:@"00"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //添加成功
                    NSLog(@"淘宝订单添加成功：%@",responseObject);
                    if (i==orderArray.count-1) {
                    //循环到最后一次的时候在提示
                        [AlertViewTool AlertAlertWithTitle:@"支付成功，订单已进入待存入状态" Message:nil otherItemArrays:@[@"知道了"] viewController:[UIApplication sharedApplication].keyWindow.rootViewController handler:^(NSInteger index) {
                            if (index==0) {
                                //知道了
                            }
                        }];
                    }
                });
            }else{
                if (i==orderArray.count-1) {
                    //循环到最后一次才提示
                    //其他错误提示
                    [AlertViewTool AlertAlertWithTitle:responseObject[@"errorMsg"] Message:nil otherItemArrays:@[@"知道了"] viewController:[UIApplication sharedApplication].keyWindow.rootViewController handler:^(NSInteger index) {
                        if (index==0) {
                            //知道了
                        }
                    }];
                }
            }
        } failure:^(NSError * _Nullable error) {
        }];
    }
}


@end

