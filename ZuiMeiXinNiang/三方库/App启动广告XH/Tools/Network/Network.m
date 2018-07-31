//
//  Network.m
//  XHLaunchAdExample
//
//  Created by zhuxiaohui on 2016/6/28.
//  Copyright © 2016年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHLaunchAd
//  数据请求类
#import "Network.h"
#import "XHLaunchAd.h"
@implementation Network

/**
 *  此处模拟广告数据请求,实际项目中请做真实请求（图片）
 */
+(void)getLaunchAdImageDataSuccess:(NetworkSucess)success failure:(NetworkFailure)failure;
{
    //读取启动闪屏广告缓存
    id cacheJsonAd = [XHNetworkCache cacheJsonWithURL:[NSString stringWithFormat:@"app启动广告Ad%@",GET_VERSION]];
    //延迟0.1秒，如果第一次启动的时候网络请求购快，就能读取到缓存的图片
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //本地图片读取直接回调
        NSLog(@"本地缓存广告：%@",cacheJsonAd);
        dispatch_async(dispatch_get_main_queue(), ^{
            if(success) success(cacheJsonAd);
        });
    });

    //每次程序启动都正常请求一次数据，在XHLaunchAdManager初始化里做了请求，这里就不请求了
}

//每次前后切换都获取app启动广告
+(void)getAppAdAFN{
    //正式向后台请求数据（每次都请求，但是不影响启动广告逻辑）
    [GXJAFNetworking POST:getstartPage parameters:nil success:^(id  _Nullable responseObject) {
        //// 测试数据
        ////         NSDictionary *  responseObjectmy = @{@"reply":@{@"imgUrl": @"http://c.hiphotos.baidu.com/image/pic/item/4d086e061d950a7b78c4e5d703d162d9f2d3c934.jpg"}};
//        NSLog(@"启动广告：%@",responseObject);
        if ([NSString isNULL:responseObject[@"reply"][@"imgUrl"]]==NO) {
            //缓存图片，下载图片，不然首次加载很慢，必须判空，否则崩溃-(暂时不缓存了，会崩溃2017.11.10)
            //            [XHLaunchAd  downLoadImageAndCacheWithURLArray:@[responseObject[@"reply"][@"imgUrl"]]];
        }
#pragma mark ================(异步)写入/更新缓存数据(只能是json类型，不能使model) ========
        //后台不返回启动页的时候就存空，相当于清除
        [XHNetworkCache save_asyncJsonResponseToCacheFile:responseObject andURL:[NSString stringWithFormat:@"app启动广告Ad%@",GET_VERSION] completed:^(BOOL result) {}];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

/**
 *  此处模拟广告数据请求,实际项目中请做真实请求(视频)
 */
+(void)getLaunchAdVideoDataSuccess:(NetworkSucess)success failure:(NetworkFailure)failure;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LaunchVideoAd" ofType:@"json"]];
        NSDictionary *json =  [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        if(success) success(json);
        
    });
}
@end
