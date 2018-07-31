//
//  GXJAFNetworking.h
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/6/19.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface GXJAFNetworking : NSObject

+ (AFHTTPSessionManager *)sharedManager;

/**
 AFNetworking二次封装-POST

 @param URLString 请求接口
 @param parameters 接口参数-字典
 @param results 请求成功结果
 @param MyError 失败结果
 */
+(void)POST:(NSString *_Nullable)URLString parameters:(id _Nullable )parameters success:(void (^_Nullable)(id _Nullable responseObject))results failure:(void (^_Nullable)(NSError * _Nullable error))MyError;

@end
