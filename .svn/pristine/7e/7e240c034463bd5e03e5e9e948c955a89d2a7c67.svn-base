//
//  DWB_refreshHeader.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/9/12.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "DWB_refreshHeader.h"
#import "MJChiBaoZiHeader.h"
@interface DWB_refreshHeader()

@end

@implementation DWB_refreshHeader
//加载
+(void)DWB_RefreshHeaderAddview:(UIScrollView *)tableview refreshHeader:(void (^)(void))refresh{
//    //（1）普通刷新
//    MJRefreshNormalHeader * Header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        //刷新回调
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (refresh) {
//                refresh();
//            }
//        });
//    }];
//    tableview.mj_header=Header;
//    //背景色
//     Header.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    
    
    
    //（2）gif动画刷新
    MJChiBaoZiHeader * Header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        //刷新回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (refresh) {
                refresh();
            }
        });
        
    }];
    //上面那排字（不能放到回调里设置）
    // 设置文字（三句都设置）
    [Header setTitle:@"别弯腰，王冠会掉，别急躁，好物不少" forState:MJRefreshStateIdle];
    [Header setTitle:@"别弯腰，王冠会掉，别急躁，好物不少" forState:MJRefreshStatePulling];
    [Header setTitle:@"知识改变命运, 美文改变心情               ." forState:MJRefreshStateRefreshing];
   
    
    //状态文字的起始坐标
    Header.labelStartX = 50.0*px;
   //文字距图片的距离，改变此距离能让图片往右边移动
    Header.labelLeftInset = -45.0*px;
    // 设置字体
    Header.stateLabel.font = [UIFont systemFontOfSize:12];
    // 设置颜色
    Header.stateLabel.textColor = [UIColor colorWithHexString:@"#aaaaaa"];
    
    //隐藏刷新时间
    Header.lastUpdatedTimeLabel.hidden = YES;
    
     tableview.mj_header = Header;
    //背景色
    Header.backgroundColor = [UIColor clearColor];
   
    //明杰刷新适配iPhoneX没有导航栏的刷新时间被挡住的问题----先注释，有时间再去改
//    Header.ignoredScrollViewContentInsetTop = -MC_StatusBarHeight;
//    Header.automaticallyChangeAlpha = YES;
}



@end



