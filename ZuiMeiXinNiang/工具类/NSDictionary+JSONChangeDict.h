//
//  NSDictionary+JSONChangeDict.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2016/11/23.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONChangeDict)
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)jsonToDictionaryWithJsonString:(NSString *)jsonString;
/**
 把字典转化成JSON字符串
 
 @param dic 字典
 @return json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
/**
 把多个json字符串转为一个json字符串【数组里存了json字符串】
 
 @param array json数组
 @return json字符串
 */
+(NSString *)moreArrayToJSON:(NSArray *)array;

@end
