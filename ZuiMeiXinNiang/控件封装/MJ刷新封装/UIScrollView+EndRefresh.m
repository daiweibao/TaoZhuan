//
//  UIScrollView+EndRefresh.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/9/12.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "UIScrollView+EndRefresh.h"

@implementation UIScrollView (EndRefresh)
//结束刷新和加载
-(void)endRefresh_DWB{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

@end
