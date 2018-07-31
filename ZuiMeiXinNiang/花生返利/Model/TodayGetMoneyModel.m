//
//  TodayGetMoneyModel.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/11.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "TodayGetMoneyModel.h"

@implementation TodayGetMoneyModel

-(NSString *)gain{
    if ([NSString isNULL:_gain]) {
        return @"0.000";
    }else{
        return [NSString stringWithFormat:@"%@",_gain];
    }
}

//类型转换
-(NSString *)allMoneyStr{
    if ([NSString isNULL:_allMoneyStr]) {
        return @"0.000";
    }else{
        return [NSString stringWithFormat:@"%@",_allMoneyStr];
    }
}
@end
