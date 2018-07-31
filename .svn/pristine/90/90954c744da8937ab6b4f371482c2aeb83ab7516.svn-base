//
//  AppGuidePageView.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2016/11/24.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppGuidePageView : UIView
//程序将要进入后台是
@property(nonatomic,strong)NSString * applicationNoActive;
//程序从后台进入前台时
@property(nonatomic,strong)NSString * appEnterForeground;

//进入主界面的回调
@property(nonatomic,copy)void(^guideGotoMain)(void);

//创建引导页
-(void)createGuidePage:(UIWindow *)window andBlock:(void (^)(void))guideGotoMain;

@end
