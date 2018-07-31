//
//  HSOrderListSubController.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/4/16.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "XMRootViewController.h"

@interface HSOrderListSubController : XMRootViewController

@property (nonatomic,strong)NSString *subId;//0全部  1待存入  2已存入  3失效

@property (nonatomic,strong)UITableView *tableView;

@end
