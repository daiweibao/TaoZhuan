//
//  MineCurrencyCellModel.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/1/11.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "JSONModel.h"

@interface MineCurrencyCellModel : NSObject

//日期
@property(nonatomic,strong)NSString * createDate;
//类型
@property(nonatomic,strong)NSString* type;
//领取积分数
@property(nonatomic,strong)NSString * point;
//标题
@property (nonatomic,strong)NSString * info;
@end
