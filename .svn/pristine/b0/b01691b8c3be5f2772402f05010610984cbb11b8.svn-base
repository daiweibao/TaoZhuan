//
//  NSDictionary+JSONChangeDict.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2016/11/23.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "NSDictionary+JSONChangeDict.h"

@implementation NSDictionary (JSONChangeDict)


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)jsonToDictionaryWithJsonString:(NSString *)jsonString {
    if ([NSString isNULL:jsonString]) {
        //判空拦截，否则会崩溃
        return nil;
    }
//    json格式字符串转字典不能直接转化需要先转换成Data，在转化成字，
//    同样字典也不能直接转换成json格式字符串。
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


/**
 把字典转化成JSON字符串

 @param dic 字典
 @return json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
//    NSJSONWritingPrettyPrinted 是有换位符的。
//    如果NSJSONWritingPrettyPrinted 是nil 的话 返回的数据是没有 换位符的
    if (dic.count>0) {
        NSError *parseError = nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
        
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }else{
        
        return @"";
    }
    
    
    
}



/**
 把多个json字符串转为一个json字符串【数组里存了json字符串】

 @param array json数组
 @return json字符串
 */
+(NSString *)moreArrayToJSON:(NSArray *)array {
    if (array.count<=0) {
        return @"";
    }
    NSString *jsonStr = @"[";
    for (NSInteger i = 0; i < array.count; ++i) {
        if (i != 0) {
            jsonStr = [jsonStr stringByAppendingString:@","];
        }
        jsonStr = [jsonStr stringByAppendingString:array[i]];
    }
    jsonStr = [jsonStr stringByAppendingString:@"]"];
    
    return jsonStr;
}


@end
