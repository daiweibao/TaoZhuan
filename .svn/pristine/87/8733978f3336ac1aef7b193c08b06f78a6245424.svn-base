//
//  DakaModel.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/5/4.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
//手气之星
#import "ShouQiFirstModel.h"

@interface DakaModel : NSObject

@property(nonatomic,strong)NSArray * result;//打卡用户集合,userId ,nickName ,image
@property(nonatomic,copy)NSString * count;//当日打卡人数，一人支付一元，可以等价为奖金总额
@property(nonatomic,assign)BOOL  isPlayToday;//用户今日是否已打卡，true 已打，false 未打卡
@property(nonatomic,assign)BOOL  isPlayYestodayAndSign;//昨日已经打卡并完成签到为true，
@property(nonatomic,assign)BOOL canSign;//true表示昨日打卡，今日未签到且在合理的签到时间，false表示昨日已打卡，今日未签到，不在合理的签到时间

@property(nonatomic,copy)NSString *failCount;//失败个数
@property(nonatomic,copy)NSString *successCount;//成功个数
@property(nonatomic,copy)NSString * ruleInfo;//挑战规则

//二层解析
@property(nonatomic,strong)ShouQiFirstModel * gainStar;//收益最高 gainMoney  image nickName successCount time userId
@property(nonatomic,strong)ShouQiFirstModel * successStar;//打卡最早
@property(nonatomic,strong)ShouQiFirstModel * timeStar;//打卡成功最多


@end




