//
//  RCMyVoiceMessageCell.h
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/25.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//
//语音消息
#import <UIKit/UIKit.h>
#import "RCmessageContentModel.h"
@interface RCMyVoiceMessageCell : UITableViewCell
@property(nonatomic,assign)NSInteger  intex;
@property(nonatomic,strong)RCmessageContentModel * model;
/**
 语音播放按钮
 */
@property (nonatomic, weak) UIButton *messageVoiceButton;

//消息点击事件回调
@property (nonatomic,copy) void(^ActionVoiceButton)(void);
//重新发送消息
@property(nonatomic,copy)void (^againSendRCInfo)(void);
//删除消息
@property(nonatomic,copy)void (^deleteRCIMInfo)(void);
@end
