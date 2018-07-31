//
//  GXJChatViewController.h
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/6/27.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

//聊天界面
#import "XMRootViewController.h"

@interface GXJChatViewController : XMRootViewController

/*!
 聊天对象UserID(必填)
 */
@property(nonatomic, strong) NSString *userIdOther;

/*!
 聊天对象名称(必填)
 */
@property(nonatomic, strong) NSString *userNameOther;

/*!
 聊天对象头像(必填)
 */
@property(nonatomic, strong) NSString *userImageOther;

/**
 聊天类型，在线客服聊天，还是普通聊天,还是达人聊天（达人聊天有处理）
 */
@property(nonatomic, strong) NSString *chatType;

//回调刷新聊天列表数据
@property(nonatomic,copy)void (^refreshChatList)(void);

@end
