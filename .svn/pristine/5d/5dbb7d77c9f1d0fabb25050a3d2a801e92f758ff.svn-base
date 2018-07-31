//
//  RCmessageContentModel.h
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/21.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
//融云聊天无界面组件
#import <RongIMLib/RongIMLib.h>

@interface RCmessageContentModel : NSObject

//消息基类
@property(nonatomic,strong)RCMessage * message;

////是否是历史消息
//@property(nonatomic,strong)NSString * hostMessage;

/*!
 聊天对象头像是否可以点击
 */
@property(nonatomic, assign) BOOL isActionPhone;
/*!
 聊天对象UserID
 */
@property(nonatomic, strong) NSString *userIdOther;

/*!
 记录消息类型
 */
@property(nonatomic, strong) NSString * contentType;
/*!
 消息的内容
 */
@property(nonatomic, strong) NSString *content;

/*!
 消息的附加信息
 */
@property(nonatomic, strong) NSString *extra;

/*!
 消息Id
 */
@property(nonatomic, assign)long messageId;
/*!
 是否展示时间
 */
@property(nonatomic, assign)BOOL isTimeVisible;

/*!
 消息类型：1代表发送消息，2代表收到消息
 */
@property(nonatomic, assign) NSInteger messageType;


/*!
 消息发送状态：10代表发送中，20代表发送失败，30代表发送成功，（跟容易文档保持一致）
 */
@property(nonatomic, assign) NSInteger messageSendState;
/*!
 消息接收状态：0未读，1代表已读，2代表已听，仅仅实用语音消息，（跟容易文档保持一致）
 */
@property(nonatomic, assign) NSInteger messageReceiveState;
/*!
 消息的接收时间（Unix时间戳、毫秒）
 */
@property(nonatomic, assign) long long receivedTime;

/*!
 消息的发送时间（Unix时间戳、毫秒）
 */
@property(nonatomic, assign) long long sentTime;


/*!
 用户ID
 */
@property(nonatomic, strong) NSString *userId;

/*!
 用户名称
 */
@property(nonatomic, strong) NSString *name;

/*!
 用户头像的URL
 */
@property(nonatomic, strong) NSString *portraitUri;


#pragma mark ========== 图片消息专属 ============
/*!
 图片消息的URL地址
 
 @discussion 发送方此字段为图片的本地路径，接收方此字段为网络URL地址。
 */
@property(nonatomic, strong) NSString *imageUrl;
/*!
 图片消息的缩略图
 */
@property(nonatomic, strong) UIImage *thumbnailImage;
/*!
 图片消息的原始图片信息
 */
@property(nonatomic, strong) UIImage *originalImage;

//图片宽度
@property(nonatomic, assign) CGFloat imageMAXwidth;
//图片高度
@property(nonatomic, assign) CGFloat imageMAXheight;

#pragma mark ==================语音消息专属 ============
/*!
 wav格式的音频数据
 */
@property(nonatomic, strong) NSData *wavAudioData;

/*!
 语音消息的时长
 */
@property(nonatomic, assign) long duration;
//语音的播放中状态
@property(nonatomic,strong)NSString * voicePlayingState;

#pragma mark ==================分享消息专属 ============
/**
 图文消息标题
 */
@property(nonatomic, strong) NSString *title;

/**
 图文消息的内容摘要
 */
@property(nonatomic, strong) NSString *digest;

/**
 图文消息连接
 */
@property(nonatomic, strong) NSString *shareUrl;


@end
