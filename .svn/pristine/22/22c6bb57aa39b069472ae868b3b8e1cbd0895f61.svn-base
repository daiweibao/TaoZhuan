//
//  DWBHelpHeader.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/8/24.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#ifndef DWBHelpHeader_h
#define DWBHelpHeader_h


#pragma mark ============ 头文件=====================
//布局
#import "UIView+Extension.h"

//支付宝要导的头文件，其他控制器也最好导入下
#import<Foundation/Foundation.h>
//图片解析
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
//通过view获取view所在控制器
#import "UIView+ParentController.h"
//刷新封装
#import "DWB_refresh.h"

//系统提示框封装
#import "AlertViewTool.h"

//字符串的工具类
#import "NSString+PhoneVerify.h"
//密码加密
#import "NSString+Hashing.h"
//NSNumber扩展类
#import "NSNumber+isNullNumber.h"

//带占位符的TextView
#import "ZBHTextView.h"

//MBProgressHUD的扩展类
#import "MBProgressHUD+MJ.h"
//SVP指示器扩展类
#import "SVProgressHUD+KZ.h"
//颜色转换
#import "UIColor+UIColorChange.h"
//封装的Html
#import "HTMLWebView.h"
//封装的WKWebView
#import "HtmlWKWebView.h"

//点赞放大动画
#import "UIView+ChangeBig.h"

//带复制的label
#import "CopyLabel.h"
//状态栏提醒
#import "JDStatusBarNotification+KZ.h"
//图片相关个人工具类
#import "UIImage+MyImage.h"
//[iOS]利用runtime,解决多次点击相同button,导致重复跳转的问题

#import "UIControl+ZHW.h"
//点击手势封装
#import "UIView+ActionTap.h"

//扩大button点击范围
#import "BigActionButton.h"

//分享封装
#import "ShareView+Share.h"

//加载中封装
#import "LoadingView.h"
//菊花封装
#import "JHViewLoading.h"

//WKWebView框架
#import <WebKit/WebKit.h>
//json字符串转化成字典
#import "NSDictionary+JSONChangeDict.h"

//图片处理牛逼类

#import "UIImage+Rotate.h"
#import "UIImage+PlayGif.h"
#import "UIImage+Extend.h"//二维码
#import "NSString+QRCode.h"

//获取设备唯一标示（卸载后也不变化）
#import "getUUID.h"

//button同时显示图片和汉字
#import "UIButton+SSEdgeInsets.h"

//聊天时间
#import "GetChatTime.h"

//AFN封装
#import "GXJAFNetworking.h"

//弹框
#import "AlertGXJView.h"

//UIView扩展类
#import "UIView+Help.h"
//悬浮拖拽的button
#import "DragEnableButton.h"

//app用户退出登录
#import "OutLoginHelp.h"

//Appstore地址==1086017752(嗅美)  //只需要修改后面的App-Id即可
#define AppstoreId  @"1086017752"
#define AppstoreUrl [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@",AppstoreId]

#pragma mark ============ 宏定义=====================

//屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//高度和屏幕高度的比例
//#define px SCREEN_HEIGHT/1334.0
//为了适配iphoneX，用这个
#define px SCREEN_WIDTH/750.0

//屏幕宽度的封面9/16
#define ImageHeight  SCREEN_WIDTH*9/16   //图片比例宽度
//有30.0安全边距的屏幕宽度的封面9/16
#define ImageHeightCover (SCREEN_WIDTH-60.0*px) * (9.0/16)


// iPhone X 宏定义
#define  iPhoneX ([UIScreen mainScreen].bounds.size.width == 375.f && [UIScreen mainScreen].bounds.size.height == 812.f ? YES : NO)
// 适配iPhone X 状态栏高度
#define  MC_StatusBarHeight      (iPhoneX ? 44.f : 20.f)
// 适配iPhone X Tabbar高度
#define  MC_TabbarHeight         (iPhoneX ? (49.f+34.f) : 49.f)
// 适配iPhone X Tabbar距离底部的距离
#define  MC_TabbarSafeBottomMargin         (iPhoneX ? 34.f : 0.f)
// 适配iPhone X 导航栏高度
#define  MC_NavHeight  (iPhoneX ? 88.f : 64.f)


//对于大量页面需要设置 contentInsetAdjustmentBehavior属性 仅需在appdelegate 里边设置就可 全局适配
//iOS11安全边距适配，防止tableview偏移。automaticallyAdjustsScrollViewInsets = NO
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)
// adjustsScrollViewInsets_NO(self.tableView, self);//用法
/*
 if (@available(iOS 11.0, *)) {
 self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
 } else {
 self.automaticallyAdjustsScrollViewInsets = NO;
 }
 */



//声明一个弱引用,##是连接的作用, 即当使用上面的宏会把weak与输入的type值连接起来如下图:
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
//获取手机唯一标识UUID（卸载后会变，需要类：getUUID.h）
//#define UUIDPhoneChangge [UIDevice currentDevice].identifierForVendor.UUIDString
#define UUIDPhoneChangge [getUUID getUUID]

//获取手机UUID，卸载后也不会变（暂时不用）
#define UUIDPhone  [getUUID getUUID]



#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]
/**
 *  宏定义16进制颜色代码， # 必须换成 0x
 */
#define Color_FromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//蒙版背景色aleart
// self.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.7];

//宏定义颜色  RGB_COLOR(0, 189, 253)
#define MAIN_COLOR_QQGree RGB_COLOR(0, 189, 253)//qq绿色背景
#define MAIN_COLOR_WXBlue RGB_COLOR(0, 206, 23)//微信蓝色背景

//#define MAIN_COLOR [UIColor colorWithHexString:@"#eb4c97"]//主题色

#define MAIN_COLOR [UIColor colorWithRed:255/255.0 green:76/255.0 blue:40/255.0 alpha:1]//超级淘换色

#define MAIN_COLOR_AlertBJ [UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.7]//蒙版半透明黑色背景

#define MAIN_COLOR_qqGreen [UIColor colorWithRed:0/255.0 green:189/255.0 blue:253/255.0 alpha:1]//qq绿色背景

#define MAIN_COLOR_Line_Cu [UIColor colorWithHexString:@"#f5f5f5"]//浅灰色 用于粗分割线  比如话题列表
#define MAIN_COLOR_Line_Xi  [UIColor colorWithHexString:@"#eaeaea"]//深灰色 用于细分割线 比如用户列表
#define MAIN_COLOR_BLACK [UIColor colorWithHexString:@"#000000"]
#define MAIN_COLOR_GRAY  [UIColor colorWithHexString:@"#c0c0c0"]//(备用)
#define MAIN_COLOR_898989 [UIColor colorWithHexString:@"#898989"]
#define MAIN_COLOR_313131 [UIColor colorWithHexString:@"#313131"]
#define MAIN_COLOR_Sex_nan [UIColor colorWithHexString:@"#9db4ff"]//性别：男-颜色
#define MAIN_COLOR_Sex_nv [UIColor colorWithHexString:@"#ff8af0"]//性别：女-颜色
#define MAIN_COLOR_ababab [UIColor colorWithHexString:@"#ababab"]//灰色，跟898989很像



//获取app logo图片可以显示图片名字
#define appLogoName [[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]

//获取版本号，带小数点
#define GET_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//获取版本号纯数字(字符串格式，3.4.0版本修改，2017年9月17日)
#define GET_VERSION_Number  [GET_VERSION stringByReplacingOccurrencesOfString:@"." withString:@""]


//取出融云聊天Token
#define RCIMToken [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"RCIMToken"]]
//取出融云聊天是否在状态栏展示
#define isShowRCIMChatStatusBar [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"isShowRCIMChatStatusBar"]]

//聊天用户是否已经绑定达人
#define ISBangDingTalentPeople [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ISBangDingTalentPeople"]]

//取出来用户唯一标示sessionId
#define SESSIONID [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]]
//取出用户类型（1是普通用户，2是设计师，3是主播用户）
#define USER_type [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"]]
//取出用户ID
#define USERID [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]]
//取出用户昵称
#define USER_name [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]]
//取出用户头像连接
#define USER_PhoneImage [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userPhoneImage"]]
/**
 *   随机颜色
 */
#define MAIN_COLOR_Random  [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1]
/**
 *   RGB颜色
 */

//哦~我忘记说了[[UIDevice currentDevice] systemVersion].floatValue这个方法也是不靠谱的，好像在8.3版本输出的值是8.2，记不清楚了反正是不靠谱的，所以建议大家用[[UIDevice currentDevice] systemVersion]这个方法！

#define ios7orLater [UIDevice currentDevice].systemVersion.floatValue>=7.0

#define ios8orLater [UIDevice currentDevice].systemVersion.floatValue>=8.0

#define ios9orLater [UIDevice currentDevice].systemVersion.floatValue>=9.0

#define ios9_1orLater [UIDevice currentDevice].systemVersion.floatValue>=9.1

#define ios10_0orLater [UIDevice currentDevice].systemVersion.floatValue>=10.0

#define ios10_3orLater [UIDevice currentDevice].systemVersion.floatValue>=10.3

//判断ios11 系统的宏这样写 判断时候就不会报警告-主要用
#define ios11_0orLater @available(iOS 11.0, *)
//下边的这种写法判断iOS11会报警高很烦-不用
//#define IOS11 ([[UIDevice currentDevice].systemVersion intValue] >= 11 ? YES : NO)

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)






#endif /* DWBHelpHeader_h */
