//
//  JDAndTBAboutGoodsModel.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/6.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "JDAndTBAboutGoodsModel.h"

@implementation JDAndTBAboutGoodsModel
-(NSString *)rate{
    if ([NSString isNULL:_rate]) {
         //默认值百分之20
        return @"0.20";
    }else{
        return _rate;
    }
}

-(NSString *)discount_coupon{
    if ([NSString isNULL:_discount_coupon]) {
        return @"";
    }else{
        return [NSString stringWithFormat:@"%@",_discount_coupon];
    }
}

@end
