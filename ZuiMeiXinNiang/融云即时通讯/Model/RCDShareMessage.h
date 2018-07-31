//
//  RCDShareMessage.h
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/26.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//
//融云自定义分享消息
#import <RongIMLib/RongIMLib.h>

/*!
 测试消息的类型名
 */
#define RCDTestMessageTypeIdentifier @"RCD:TstMsg"

/*!
 Demo测试用的自定义消息类
 
 @discussion Demo测试用的自定义消息类，此消息会进行存储并计入未读消息数。
 */
@interface RCDShareMessage : RCMessageContent <NSCoding>

/*!
 测试消息的标题
 */
@property(nonatomic, strong) NSString *content;

/*!
 测试消息的附加信息
 */
@property(nonatomic, strong) NSString *extra;
/*!
 消息分享连接
 */
@property(nonatomic, strong) NSString *shareUrl;

/*!
 初始化测试消息
 
 @param content 文本内容
 @return        测试消息对象
 */
+ (instancetype)messageWithContent:(NSString *)content;
@end
