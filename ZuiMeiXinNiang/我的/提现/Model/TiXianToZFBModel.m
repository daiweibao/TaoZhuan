//
//  TiXianToZFBModel.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/14.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "TiXianToZFBModel.h"

@implementation TiXianToZFBModel
-(NSString *)gainMoney{
    if ([NSString isNULL:_gainMoney]) {
        return @"0.00";
    }else{
        return [NSString stringWithFormat:@"%@",_gainMoney];
    }
}
@end
