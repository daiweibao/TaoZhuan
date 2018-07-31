//
//  STInputBar.h
//  STEmojiKeyboard
//
//  Created by zhenlintie on 15/5/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>
//按住说话
#import "MyRecordButtonView.h"

@interface STInputBar : UIView

+ (instancetype)inputBar;

@property (assign, nonatomic) BOOL fitWhenKeyboardShowOrHide;

- (void)setDidSendClicked:(void(^)(NSString *text))handler;

//占位符汉字
@property (copy, nonatomic) NSString *placeHolder;
//类型
@property(nonatomic,strong)NSString * typeString;

- (void)setInputBarSizeChangedHandle:(void(^)())handler;
//结束编辑时
@property(nonatomic,copy)void (^endEidt)(NSString * str);
//得到键盘高度
@property(nonatomic,copy)void (^getKeyboardHeight)(CGFloat KeyBoardHeight);

//清除评论框里的内容
-(void)DeleteContent;

#pragma mark =========== 新版话题详情用到的 ==============
//点赞
@property(nonatomic,strong) UIButton * buttonimageZ;
//收藏
@property(nonatomic,strong) UIButton * buttonimageC;
//分享
@property(nonatomic,strong)UIButton * buttonimageShare;
//点赞数量
@property(nonatomic,strong)UILabel * buttonimageNum;


#pragma mark ================= 聊天界面 ========
//按住说话
@property(nonatomic,weak)MyRecordButtonView *buttonAudioView;
//语音按钮
@property(nonatomic,strong)UIButton * buttonAudio;
//加号按钮
@property(nonatomic,strong)UIButton * buttonAdd;
//照片选择区域View
@property(nonatomic,strong)UIView * viewPhoneView;
//关闭照片选择
-(void)clocePhoneShoose;
//点击照片按钮
@property(nonatomic,copy)void (^clickPhoneChoose)(void);



@end
