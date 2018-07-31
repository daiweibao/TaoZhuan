//
//  MyRecordListModel.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/5/2.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRecordListModel : NSObject
@property (nonatomic,copy)NSString * isSuccess;//是否打卡成功，后台返回标题
@property (nonatomic,copy)NSString *gainMoney;//获取的钱
@property (nonatomic,copy)NSString *createDate;//打卡时间（long类型）
@end
