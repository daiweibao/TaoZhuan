//
//  ShouQiFirstModel.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/5/4.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "ShouQiFirstModel.h"

@implementation ShouQiFirstModel

-(NSString *)gainMoney{
    if ([NSString isNULL:_gainMoney]) {
        return @"--";
    }else{
        return _gainMoney;
    }
}
-(NSString *)nickName{
    if ([NSString isNULL:_nickName]) {
        return @"--";
    }else{
        return _nickName;
    }
}

-(NSString *)successCount{
    if ([NSString isNULL:_successCount]) {
        return @"--";
    }else{
        return _successCount;
    }
}

-(NSString *)time{
    if ([NSString isNULL:_time]) {
        return @"0";
    }else{
        return _time;
    }
}

@end
