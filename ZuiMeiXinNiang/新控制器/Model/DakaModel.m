//
//  DakaModel.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/5/4.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "DakaModel.h"

@implementation DakaModel
-(NSString *)count{
    if ([NSString isNULL:_count]) {
        return @"0";
    }else{
        return _count;
    }
}

-(NSString *)successCount{
    if ([NSString isNULL:_successCount]) {
        return @"0";
    }else{
        return [NSString stringWithFormat:@"%@",_successCount];
    }
}
-(NSString *)failCount{
    if ([NSString isNULL:_failCount]) {
        return @"0";
    }else{
        return [NSString stringWithFormat:@"%@",_failCount];
    }
}

@end
