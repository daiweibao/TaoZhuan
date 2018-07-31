//
//  ChatListModel.h
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/19.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatListModel : NSObject

/*!
 用户ID(必填)
 */
@property(nonatomic, strong) NSString *userId;

/*!
 用户名称(必填)
 */
@property(nonatomic, strong) NSString *name;

/*!
 用户头像的URL(必填)
 */
@property(nonatomic, strong) NSString *portraitUri;
/*!
 最后一条消息内容
 */
@property(nonatomic, strong) NSString *lastContent;

/*!
 最后一条消息发送时间（Unix时间戳、毫秒）
 */
@property(nonatomic, assign) long long lastSentTime;

/*!
 会话中的未读消息数量
 */
@property(nonatomic, assign) int unreadMessageCount;

/*!
 消息状态，对应显示：1、发送中（接收中）、2、失败、3、成功
 */
@property(nonatomic, assign) NSInteger messageState;
/*!
 用户类型 固定汉字：达人、官方
 */
@property(nonatomic, strong) NSString *type;

@end
