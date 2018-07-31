//
//  UIView+Help.h
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/6/27.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Help)
/**
 tableview滑到最底部

 @return
 */
#pragma mark  - 滑到最底部
+ (void)scrollTableToFoot:(UITableView*)table Animated:(BOOL)animated;
/**
 判断一块view是否在屏幕中
 
 @param myView yes:在屏幕中 no：不在屏幕中
 */
+ (BOOL)isViewAddWindowUp:(UIView*)myView;

/**
 tableviewIOS11、iPhoneX适配，明杰刷新跳动和组头组脚有空白
 
 @param tableView
 */
+(void)tablevieiOS11:(UITableView*)tableView isHaveTabbar:(BOOL)ishaveTabbar;
/**
 collectionViewIOS11适配，明杰刷新跳动和组头组脚有空白
 
 @param collectionView 滚动视图
 @param ishaveTabbar 底部是否有工具条，有工具条传入YES，没有传入NO
 */
+(void)collectionViewiOS11:(UICollectionView *)collectionView isHaveTabbar:(BOOL)ishaveTabbar;
@end
