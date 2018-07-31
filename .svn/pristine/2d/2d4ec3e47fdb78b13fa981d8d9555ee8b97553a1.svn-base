//
//  SVProgressHUD.h
//  SVProgressHUD, https://github.com/SVProgressHUD/SVProgressHUD
//
//  Copyright (c) 2011-2016 Sam Vermette and contributors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000

#define UI_APPEARANCE_SELECTOR

#endif

extern NSString * const SVProgressHUDDidReceiveTouchEventNotification;
extern NSString * const SVProgressHUDDidTouchDownInsideNotification;
extern NSString * const SVProgressHUDWillDisappearNotification;
extern NSString * const SVProgressHUDDidDisappearNotification;
extern NSString * const SVProgressHUDWillAppearNotification;
extern NSString * const SVProgressHUDDidAppearNotification;

extern NSString * const SVProgressHUDStatusUserInfoKey;

typedef NS_ENUM(NSInteger, SVProgressHUDStyle) {
    SVProgressHUDStyleLight,        // default style, white HUD with black text, HUD background will be blurred on iOS 8 and above
    SVProgressHUDStyleDark,         // black HUD and white text, HUD background will be blurred on iOS 8 and above
    SVProgressHUDStyleCustom        // uses the fore- and background color properties
};

typedef NS_ENUM(NSUInteger, SVProgressHUDMaskType) {
    SVProgressHUDMaskTypeNone = 1,  // default mask type, allow user interactions while HUD is displayed
    SVProgressHUDMaskTypeClear,     // don't allow user interactions
    SVProgressHUDMaskTypeBlack,     // don't allow user interactions and dim the UI in the back of the HUD, as on iOS 7 and above
    SVProgressHUDMaskTypeGradient,  // don't allow user interactions and dim the UI with a a-la UIAlertView background gradient, as on iOS 6
    SVProgressHUDMaskTypeCustom     // don't allow user interactions and dim the UI in the back of the HUD with a custom color
};

typedef NS_ENUM(NSUInteger, SVProgressHUDAnimationType) {
    SVProgressHUDAnimationTypeFlat,     // default animation type, custom flat animation (indefinite animated ring)
    SVProgressHUDAnimationTypeNative    // iOS native UIActivityIndicatorView
};

typedef void (^SVProgressHUDShowCompletion)(void);
typedef void (^SVProgressHUDDismissCompletion)(void);

@interface SVProgressHUD : UIView

#pragma mark - Customization

@property (assign, nonatomic) SVProgressHUDStyle defaultStyle UI_APPEARANCE_SELECTOR;                   // default is SVProgressHUDStyleLight
@property (assign, nonatomic) SVProgressHUDMaskType defaultMaskType UI_APPEARANCE_SELECTOR;             // default is SVProgressHUDMaskTypeNone
@property (assign, nonatomic) SVProgressHUDAnimationType defaultAnimationType UI_APPEARANCE_SELECTOR;   // default is SVProgressHUDAnimationTypeFlat
@property (assign, nonatomic) CGSize minimumSize UI_APPEARANCE_SELECTOR;            // default is CGSizeZero, can be used to avoid resizing for a larger message
@property (assign, nonatomic) CGFloat ringThickness UI_APPEARANCE_SELECTOR;         // default is 2 pt
@property (assign, nonatomic) CGFloat ringRadius UI_APPEARANCE_SELECTOR;            // default is 18 pt
@property (assign, nonatomic) CGFloat ringNoTextRadius UI_APPEARANCE_SELECTOR;      // default is 24 pt
@property (assign, nonatomic) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;          // default is 14 pt
@property (strong, nonatomic) UIFont *font UI_APPEARANCE_SELECTOR;                  // default is [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
@property (strong, nonatomic) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;      // default is [UIColor whiteColor]
@property (strong, nonatomic) UIColor *foregroundColor UI_APPEARANCE_SELECTOR;      // default is [UIColor blackColor]
@property (strong, nonatomic) UIColor *backgroundLayerColor UI_APPEARANCE_SELECTOR; // default is [UIColor colorWithWhite:0 alpha:0.4]
@property (strong, nonatomic) UIImage *infoImage UI_APPEARANCE_SELECTOR;            // default is the bundled info image provided by Freepik
@property (strong, nonatomic) UIImage *successImage UI_APPEARANCE_SELECTOR;         // default is the bundled success image provided by Freepik
@property (strong, nonatomic) UIImage *errorImage UI_APPEARANCE_SELECTOR;           // default is the bundled error image provided by Freepik
@property (strong, nonatomic) UIView *viewForExtension UI_APPEARANCE_SELECTOR;      // default is nil, only used if #define SV_APP_EXTENSIONS is set
@property (assign, nonatomic) NSTimeInterval minimumDismissTimeInterval;            // default is 5.0 seconds

@property (assign, nonatomic) UIOffset offsetFromCenter UI_APPEARANCE_SELECTOR;     // default is 0, 0

@property (assign, nonatomic) NSTimeInterval fadeInAnimationDuration;  // default is 0.15
@property (assign, nonatomic) NSTimeInterval fadeOutAnimationDuration; // default is 0.15

@property (assign, nonatomic) UIWindowLevel maxSupportedWindowLevel; // default is UIWindowLevelNormal

+ (void)setDefaultStyle:(SVProgressHUDStyle)style;                  // default is SVProgressHUDStyleLight
+ (void)setDefaultMaskType:(SVProgressHUDMaskType)maskType;         // default is SVProgressHUDMaskTypeNone
+ (void)setDefaultAnimationType:(SVProgressHUDAnimationType)type;   // default is SVProgressHUDAnimationTypeFlat
+ (void)setMinimumSize:(CGSize)minimumSize;                         // default is CGSizeZero, can be used to avoid resizing for a larger message
+ (void)setRingThickness:(CGFloat)ringThickness;                    // default is 2 pt
+ (void)setRingRadius:(CGFloat)radius;                              // default is 18 pt
+ (void)setRingNoTextRadius:(CGFloat)radius;                        // default is 24 pt
+ (void)setCornerRadius:(CGFloat)cornerRadius;                      // default is 14 pt
+ (void)setFont:(UIFont*)font;                                      // default is [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
+ (void)setForegroundColor:(UIColor*)color;                         // default is [UIColor blackColor], only used for SVProgressHUDStyleCustom
+ (void)setBackgroundColor:(UIColor*)color;                         // default is [UIColor whiteColor], only used for SVProgressHUDStyleCustom
+ (void)setBackgroundLayerColor:(UIColor*)color;                    // default is [UIColor colorWithWhite:0 alpha:0.5], only used for SVProgressHUDMaskTypeBlack
+ (void)setInfoImage:(UIImage*)image;                               // default is the bundled info image provided by Freepik
+ (void)setSuccessImage:(UIImage*)image;                            // default is the bundled success image provided by Freepik
+ (void)setErrorImage:(UIImage*)image;                              // default is the bundled error image provided by Freepik
+ (void)setViewForExtension:(UIView*)view;                          // default is nil, only used if #define SV_APP_EXTENSIONS is set
+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)interval;     // default is 5.0 seconds
+ (void)setFadeInAnimationDuration:(NSTimeInterval)duration;        // default is 0.15 seconds
+ (void)setFadeOutAnimationDuration:(NSTimeInterval)duration;       // default is 0.15 seconds
+ (void)setMaxSupportedWindowLevel:(UIWindowLevel)windowLevel;      // default is UIWindowLevelNormal

#pragma mark - Show Methods

+ (void)show;
+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use show and setDefaultMaskType: instead.")));
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showWithStatus: and setDefaultMaskType: instead.")));

+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showProgress: and setDefaultMaskType: instead.")));
+ (void)showProgress:(float)progress status:(NSString*)status;
+ (void)showProgress:(float)progress status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showProgress:status: and setDefaultMaskType: instead.")));

+ (void)setStatus:(NSString*)status; // change the HUD loading status while it's showing

// stops the activity indicator, shows a glyph + status, and dismisses the HUD a little bit later
+ (void)showInfoWithStatus:(NSString*)status;
+ (void)showInfoWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showInfoWithStatus: and setDefaultMaskType: instead.")));
+ (void)showSuccessWithStatus:(NSString*)status;
+ (void)showSuccessWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showSuccessWithStatus: and setDefaultMaskType: instead.")));
+ (void)showErrorWithStatus:(NSString*)status;
+ (void)showErrorWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showErrorWithStatus: and setDefaultMaskType: instead.")));

// shows a image + status, use 28x28 white PNGs
+ (void)showImage:(UIImage*)image status:(NSString*)status;
+ (void)showImage:(UIImage*)image status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType __attribute__((deprecated("Use showImage:status: and setDefaultMaskType: instead.")));

+ (void)setOffsetFromCenter:(UIOffset)offset;
+ (void)resetOffsetFromCenter;

+ (void)popActivity; // decrease activity count, if activity count == 0 the HUD is dismissed
+ (void)dismiss;
+ (void)dismissWithCompletion:(SVProgressHUDDismissCompletion)completion;
+ (void)dismissWithDelay:(NSTimeInterval)delay;
+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(SVProgressHUDDismissCompletion)completion;

+ (BOOL)isVisible;

+ (NSTimeInterval)displayDurationForString:(NSString*)string;

@end

//使用
//SVProgressHUD 作为一个单例（也就是说，它并不需要创建和实例化，你直接调用, 如[SVProgressHUD method]).
//
//使用SVProgressHUD是非常明智的！常用场景：下拉刷新，无限滚动，发送消息
//使用 SVProgressHUD在您的应用程序通常看起来简单:
//
//[SVProgressHUD show];
//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    // time-consuming task
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
//});
//显示 HUD
//您可以使用下面的方法中的任意一个来显示HUD,以及指示任务的状态：
//
//+ (void)show;
//+ (void)showWithStatus:(NSString*)string;
//如果您想在HUD指示任务的进度，请使用下列操作之一：
//
//+ (void)showProgress:(CGFloat)progress;
//+ (void)showProgress:(CGFloat)progress status:(NSString*)status;
//隐藏 HUD
//HUD可以用以下方法隐藏:
//
//+ (void)dismiss;
//+ (void)dismissWithDelay:(NSTimeInterval)delay;
//如果你想显示多个HUD ，可以使用使用一下方法：
//
//+ (void)popActivity;
//该HUD将自动消失, popActivity将与显示的次数匹配。
//
//显示一个提示消息
//也可以用于显示一个提示信息。所述显示时间取决于给定的字符串的长度（ 0.5至5秒）。
//
//+ (void)showInfoWithStatus:(NSString *)string;
//+ (void)showSuccessWithStatus:(NSString*)string;
//+ (void)showErrorWithStatus:(NSString *)string;
//+ (void)showImage:(UIImage*)image status:(NSString*)string;
//自定义
//SVProgressHUD 可通过下列方法进行个性化定制:
//
//+ (void)setDefaultStyle:(SVProgressHUDStyle)style;                  // 默认是SVProgressHUDStyleLight
//=================================SVProgressHUDStyle分割线 ====================
//+ (void)setDefaultMaskType:(SVProgressHUDMaskType)maskType;         // 默认是SVProgressHUDMaskTypeNone

// 1. SVProgressHUDMaskTypeNone : 在提示框显示时，仍可以做其他操作，如View 上面的输入等 。
//
//2. SVProgressHUDMaskTypeClear :在提示框显示时, 不可以做其他操作
//
//3. SVProgressHUDMaskTypeBlack :在提示框显示时,不可以做其他操作且背景色是黑色
//
//4. SVProgressHUDMaskTypeGradient : 在提示框显示时,不可以做其他操作且背景色是渐变的
//
//5.SVProgressHUDMaskTypeCustom:

//================================= 分割线 ====================


//+ (void)setDefaultAnimationType:(SVProgressHUDAnimationType)type;   // 默认是 SVProgressHUDAnimationTypeFlat
//+ (void)setRingThickness:(CGFloat)width;                            // 默认是 2 pt
//+ (void)setCornerRadius:(CGFloat)cornerRadius;                      // 默认是 14 pt
//+ (void)setFont:(UIFont*)font;                                      // 默认是 [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
//+ (void)setForegroundColor:(UIColor*)color;                         // 默认是 [UIColor blackColor], 仅对 SVProgressHUDStyleCustom 有效
//+ (void)setBackgroundColor:(UIColor*)color;                         // 默认是 [UIColor whiteColor], 仅对 SVProgressHUDStyleCustom 有效
//+ (void)setInfoImage:(UIImage*)image;                               //默认是bundle文件夹中的提示图片.
//+ (void)setSuccessImage:(UIImage*)image;                            // 默认是bundle文件夹中的成功图片.
//+ (void)setErrorImage:(UIImage*)image;                              // 默认是bundle文件夹中的错误图片.
//+ (void)setViewForExtension:(UIView*)view;                          // 默认是nil,仅当设置了 #define SV_APP_EXTENSIONS 时有效.
//通知
//SVProgressHUD通过 NSNotificationCenter注册4份通知,以响应正在显示/消失:
//
//SVProgressHUDWillAppearNotification 提示框即将出现
//SVProgressHUDDidAppearNotification 提示框已经出现
//SVProgressHUDWillDisappearNotification 提示框即将消失
//SVProgressHUDDidDisappearNotification 提示框已经消失
//每个通知传递一个 userInfo字典,字典中包含HUD的状态字符串（如果有的话） ，可通过 SVProgressHUDStatusUserInfoKey作为键来获取。
//
//SVProgressHUD还发送通知:
//SVProgressHUDDidReceiveTouchEventNotification当用户触摸整体屏幕上 和SVProgressHUDDidTouchDownInsideNotification当用户直接在HUD接触。这两个通知没有 userInfo参数，但包含了有关的触摸的UIEvent 参数.
//


