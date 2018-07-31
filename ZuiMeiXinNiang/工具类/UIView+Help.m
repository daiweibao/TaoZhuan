//
//  UIView+Help.m
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/6/27.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "UIView+Help.h"

@implementation UIView (Help)
#pragma mark  - tableview滑到最底部
+ (void)scrollTableToFoot:(UITableView*)table Animated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger s = [table numberOfSections];  //有多少组
        if (s<1) return;  //无数据时不执行 要不会crash
        NSInteger r = [table numberOfRowsInSection:s-1]; //最后一组有多少行
        if (r<1) return;
        NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
        [table scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
    });
}


/**
 判断一块view是否在屏幕中
 
 @param myView  yes:在屏幕中 no：不在屏幕中
 */
+ (BOOL)isViewAddWindowUp:(UIView*)myView{
    // 如果本控制器的view显示在最前面，就下拉刷新（必须要判断，否点击其他tabbar也会触发刷新）
    // 判断一个view是否显示在根窗口上，该方法在UIView的分类中实现
    // 把这个view在它的父控件中的frame(即默认的frame)转换成在window的frame
    CGRect convertFrame = [myView.superview convertRect:myView.frame toView: [UIApplication sharedApplication].keyWindow];
    CGRect windowBounds = [UIApplication sharedApplication].keyWindow.bounds;
    // 判断这个控件是否在主窗口上（即该控件和keyWindow有没有交叉）
    BOOL isOnWindow = CGRectIntersectsRect(convertFrame, windowBounds);
    // 再判断这个控件是否真正显示在窗口范围内（是否在窗口上，是否为隐藏，是否透明）
    BOOL isShowingOnWindow = (myView.window == [UIApplication sharedApplication].keyWindow) && !myView.isHidden && (myView.alpha > 0.01) && isOnWindow;
    
    return isShowingOnWindow;
}



/**
 tableviewIOS11适配，明杰刷新跳动和组头组脚有空白

 @param tableView 滚动视图
 @param ishaveTabbar 底部是否有工具条，有工具条传入YES，没有传入NO
 */
+(void)tablevieiOS11:(UITableView*)tableView isHaveTabbar:(BOOL)ishaveTabbar{
#pragma mark =====继承：XMRootViewController用【系统导航栏的】的 iOS11 tableview偏移适配（放到tableview初始化里面）S==============
    if (@available(iOS 11.0, *)) {
        //1、tableView的section之间间距变大问题,解决办法：初始化的时候增加以下代码
        //tableView 头部视图和尾部视图出现一块留白问题
        //iOS11下tableview默认开启了self-Sizing，Headers, footers, and cells都默认开启Self-Sizing，所有estimated 高度默认值从iOS11之前的 0 改变为
        tableView.estimatedRowHeight =0;
        tableView.estimatedSectionHeaderHeight =0;
        tableView.estimatedSectionFooterHeight =0;
        //2、MJ刷新异常，上拉加载出现跳动刷新问题,解决办法：初始化的时候增加以下代码（tableView和collectionView类似）
        tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        if (ishaveTabbar==YES) {
            //底部有工具条
            tableView.contentInset =UIEdgeInsetsMake(0,0, 0, 0);//底部有tabbar或者工具条的不改变偏移
        }else{
            //底部无工具条
            tableView.contentInset =UIEdgeInsetsMake(0,0, MC_TabbarSafeBottomMargin, 0);//距离底部的距离，防止拉到最后被盖住
        }
        tableView.scrollIndicatorInsets =tableView.contentInset;
    }
#pragma mark ======== iOS11 tableview偏移适配 E==============
}


/**
 collectionViewIOS11适配，明杰刷新跳动和组头组脚有空白
 
 @param collectionView 滚动视图
 @param ishaveTabbar 底部是否有工具条，有工具条传入YES，没有传入NO
 */
+(void)collectionViewiOS11:(UICollectionView *)collectionView isHaveTabbar:(BOOL)ishaveTabbar{
#pragma mark =====继承：XMRootViewController用【系统导航栏的】的 iOS11 tableview偏移适配（放到tableview初始化里面）S==============
    if (@available(iOS 11.0, *)) {
        //2、MJ刷新异常，上拉加载出现跳动刷新问题,解决办法：初始化的时候增加以下代码（tableView和collectionView类似）
        collectionView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        if (ishaveTabbar==YES) {
            //底部有工具条
            collectionView.contentInset =UIEdgeInsetsMake(0,0, 0, 0);//底部有tabbar或者工具条的不改变偏移
        }else{
            //底部无工具条
            collectionView.contentInset =UIEdgeInsetsMake(0,0, MC_TabbarSafeBottomMargin, 0);//距离底部的距离，防止拉到最后被盖住
        }
        collectionView.scrollIndicatorInsets =collectionView.contentInset;
    }
#pragma mark ======== iOS11 tableview偏移适配 E==============
}



@end
