//
//  ActivityGoodsModel.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/9.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "ActivityGoodsModel.h"

@implementation ActivityGoodsModel
-(NSString *)rate{
    if ([NSString isNULL:_rate]) {
        //默认值百分之20
        return @"0.20";
    }else{
        return _rate;
    }
}

//判空
-(NSString *)discount_coupon{
    if ([NSString isNULL:_discount_coupon]) {
        return @"";
    }else{
        return [NSString stringWithFormat:@"%@",_discount_coupon];
    }
}
//判空
-(NSString *)taoBaoUrl{
    if ([NSString isNULL:_taoBaoUrl]) {
        return @"";
    }else{
        return _taoBaoUrl;
    }
}

@end
