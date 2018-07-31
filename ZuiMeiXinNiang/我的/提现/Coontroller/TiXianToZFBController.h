//
//  TiXianToZFBController.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/14.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//
//花生钱包提现到支付宝
#import "XMRootViewController.h"

@interface TiXianToZFBController : XMRootViewController
//回调刷新
@property(nonatomic,copy)void(^blackRefreshMoney)(void);
@end
