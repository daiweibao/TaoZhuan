//
//  JDAndTBGoodsModel.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/4.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "JDAndTBGoodsModel.h"

@implementation JDAndTBGoodsModel
-(NSString *)imageUrl{
    /*
     返回图片地址(imageUrl)为相对路径，全路径格式为：
     http://imgServer.360buyimg.com/size/ + imageUrl
     其中imgServer为img10-14，建议平均分配
     size为下列值：
     n0  800*800
     n1  350*350
     n2  160*160
     n3  130*130
     n4  100*100
     n5  50*50
     比如下面链接
     http://img10.360buyimg.com/n1/jfs/t2299/230/2253855915/284347/23e5fb2b/56fa70bdNac64bc79.jpg
     获取350*350的图片
     */
    return [NSString stringWithFormat:@"http://img10.360buyimg.com/n1/%@",_imageUrl];
}
-(NSString *)rate{
    if ([NSString isNULL:_rate]) {
        //默认值百分之20
        return @"0.20";
    }else{
        return _rate;
    }
}

-(NSString *)goodsCounponMoney{
    if ([NSString isNULL:_goodsCounponMoney]) {
        return @"";
    }else{
        return [NSString stringWithFormat:@"%@",_goodsCounponMoney];
    }
}

@end
