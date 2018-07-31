//
//  RCMyImageMessageCell.h
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/24.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//
//图片消息
#import <UIKit/UIKit.h>
#import "RCmessageContentModel.h"
@interface RCMyImageMessageCell : UITableViewCell
@property(nonatomic,assign)NSInteger  intex;
@property(nonatomic,strong)RCmessageContentModel * model;
//重新发送消息
@property(nonatomic,copy)void (^againSendRCInfo)(void);
//删除消息
@property(nonatomic,copy)void (^deleteRCIMInfo)(void);
@end
