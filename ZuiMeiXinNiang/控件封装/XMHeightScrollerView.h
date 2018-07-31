//
//  XMHeightScrollerView.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/8/23.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMHeightScrollerView : UIView
/**
 （1）传入包含图片名字和图片高度的数组（数组里包含字典，字典里包含图片url和图片高度）
 @param WindthName 图片宽度名字
 @param arrayImageAndHeight 图片高度名字
 @param name 图片url的键
 @param HeightName 图片高度url的键
 */
-(void)getScrollerArrayImage:(NSArray*)arrayImageAndHeight AndImagename:(NSString *)urlName AndImageWindthName:(NSString *)WindthName AndImageHeightName:(NSString *)HeightName;
//(2)高度时时改变回调（必须先传数组在回调高度）
@property (nonatomic,copy) void(^getScrollerHeight)(CGFloat heightScroller);

@end


/*

 #pragma ====================自己封装的动态高度的轮播图（开始）=====================
 XMHeightScrollerView * viewScroller = [[XMHeightScrollerView alloc]init];
 //这行代码必须设置
 //    self.automaticallyAdjustsScrollViewInsets = NO;
 //必须先回调高度,在传入数组
 WeakSelf(viewScroller)
 [viewScroller setGetScrollerHeight:^(CGFloat heightScroller){
 weakviewScroller.frame = CGRectMake(0,  CGRectGetMaxY(headView.frame)+20.0*px, SCREEN_WIDTH, heightScroller);
 //回调高度
 //        NSLog(@"回调高度：%f",heightScroller);
 
 //设置父视图的坐标
 self.viewSubScrollerUp.frame = CGRectMake(0, weakviewScroller.bottomY+20.0*px, SCREEN_WIDTH, self.viewSubScrollerUp.height);
 
 //回调高度
 if (self.headerHeight) {
 self.headerHeight(self.viewSubScrollerUp.bottomY);
 }
 
 
 }];
 
 //（2）回调高度后，传入数据（数组里包含字典，必须放在block高度回调后面传入）
 NSArray * arrayImage =  self.model.topicNewRes;
 [viewScroller getScrollerArrayImage:arrayImage AndImagename:@"url" AndImageWindthName:@"width" AndImageHeightName:@"height"];
 //(3)第一张图片高度初始化滚动视图高度
 
 #pragma marl ========= 按比例限制宽度不要超过屏幕，封装里面也计算了（开始） ====================
 //高度存在  宽度初始化
 CGFloat W = [arrayImage.firstObject[@"width"] floatValue];
 //高度初始化
 CGFloat H = [arrayImage.firstObject[@"height"] floatValue];
 if (W != SCREEN_WIDTH) {
 CGFloat WC = 0.0;
 if (W > SCREEN_WIDTH) {
 //比例
 WC = (W- SCREEN_WIDTH)/W;
 //计算出最终高度（减去）
 H = H - H * WC;
 }else{
 //比例
 WC = (SCREEN_WIDTH - W)/W;
 //计算出最终高度（加上）
 H = H + H * WC;
 }
 
 //最终宽度永远是屏幕那么宽
 W = SCREEN_WIDTH;
 
 }
 #pragma marl ========= 按比例限制宽度不要超过屏幕，封装里面也计算了（结束） ====================
 viewScroller.frame = CGRectMake(0,  CGRectGetMaxY(headView.frame)+20.0*px, SCREEN_WIDTH, H);
 
 [self addSubview:viewScroller];
 #pragma ====================自己封装的动态高度的轮播图（结束）=====================
 
*/
