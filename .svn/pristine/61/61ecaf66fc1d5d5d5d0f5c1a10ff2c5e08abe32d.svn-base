//
//  GXJRootViewController.h
//  GongXiangJie
//
//  Created by 爱淘包 on 2017/6/19.
//  Copyright © 2017年 GongXiangJie. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XMRootViewController : UIViewController

@property (nonatomic,strong)UILabel *titleLabel;//标题

@property (nonatomic,strong)UIButton *backButton;//返回按钮

- (void)pressButtonLeft;//返回

@end

/*
 #pragma mark ======== ios11适配安全边距（宏定义）========
 adjustsScrollViewInsets_NO(self.tableView, self);
 */
/*
 #pragma mark =====继承：XMRootViewController用【系统导航栏的】的 iOS11 tableview偏移适配（放到tableview初始化里面）S=========
 //1、tableView的section之间间距变大问题,解决办法：初始化的时候增加以下代码
 _tableView.estimatedRowHeight =0;
 _tableView.estimatedSectionHeaderHeight =0;
 _tableView.estimatedSectionFooterHeight =0;
 //2、MJ刷新异常，上拉加载出现跳动刷新问题,解决办法：初始化的时候增加以下代码（tableView和collectionView类似）
 if (@available(iOS 11.0, *)) {
 _tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
 _tableView.contentInset =UIEdgeInsetsMake(20,0, 0, 0);//20是动态的，64和49自己看效果，是否应该改成0
 _tableView.scrollIndicatorInsets =_tableView.contentInset;
 }
 #pragma mark ======== iOS11 tableview偏移适配 E==============
 */
