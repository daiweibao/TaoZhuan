//
//  DWB_refreshFooter.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/9/12.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "DWB_refreshFooter.h"
#import "MJChiBaoZiFooter.h"
@interface DWB_refreshFooter()

@end

@implementation DWB_refreshFooter
//加载
+(void)DWB_RefreshFooterAddview:(UIScrollView *)tableview refreshFooter:(void (^)(void))refresh{
    //暂时不加在封装里
//    if (@available(iOS 11.0, *)) {
//        //2、MJ刷新异常，上拉加载出现跳动刷新问题,解决办法：初始化的时候增加以下代码（tableView和collectionView类似）
//        tableview.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
//        tableview.contentInset =UIEdgeInsetsMake(0,0, 0, 0);//20是动态的，64和49自己看效果，是否应该改成0
//        tableview.scrollIndicatorInsets =tableview.contentInset;
//    }
    
    //普通菊花的加载
    MJRefreshAutoNormalFooter * footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //加载回调 loading
        dispatch_async(dispatch_get_main_queue(), ^{
            if (refresh) {
                refresh();
            }
        });

    }];
 
//    //gif动画的加载
//    MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingBlock:^{
//        //加载回调 loading
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (refresh) {
//                refresh();
//            }
//        });
//    }];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    // 设置颜色
    footer.stateLabel.textColor =  [UIColor colorWithHexString:@"#aaaaaa"];
    //已经加载完全部
     [footer setTitle:@"——————  已经到底了  ——————" forState:MJRefreshStateNoMoreData];
    
    // 隐藏刷新状态的文字
    footer.refreshingTitleHidden = YES;
    
    // 设置footer
    tableview.mj_footer = footer;

    footer.backgroundColor = [UIColor groupTableViewBackgroundColor];

}


@end
