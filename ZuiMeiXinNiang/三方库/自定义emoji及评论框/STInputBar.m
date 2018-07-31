//
//  STInputBar.m
//  STEmojiKeyboard
//
//  Created by zhenlintie on 15/5/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STInputBar.h"
#import "STEmojiKeyboard.h"

#define kSTIBDefaultHeight 49
#define kSTLeftButtonWidth 50
#define kSTLeftButtonHeight 30
#define kSTRightButtonWidth 55
#define kSTTextviewDefaultHeight 34
#define kSTTextviewMaxHeight 80

@interface STInputBar () <UITextViewDelegate>

@property (strong, nonatomic) UIButton *keyboardTypeButton;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *sendButton;
@property (strong, nonatomic) STEmojiKeyboard *keyboard;
@property (strong, nonatomic) UILabel *placeHolderLabel;

@property (strong, nonatomic) void (^sendDidClickedHandler)(NSString *);
@property (strong, nonatomic) void (^sizeChangedHandler)();


@end

@implementation STInputBar{
    BOOL _isRegistedKeyboardNotif;
    BOOL _isDefaultKeyboard;
    NSArray *_switchKeyboardImages;
}

+ (instancetype)inputBar{
    return [self new];
}

- (void)dealloc{
    if (_isRegistedKeyboardNotif){
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kSTIBDefaultHeight)]){
        _isRegistedKeyboardNotif = NO;
        _isDefaultKeyboard = YES;
        _switchKeyboardImages = @[@"btn_expression",@"btn_keyboard"];
       
    
        
        
    }
    return self;
}

//得到类型后再创建立
-(void)setTypeString:(NSString *)typeString{
    _typeString = typeString;
    
    if ([typeString isEqual:@"公用回复列表"]) {
        //创建UI
        [self loadUI];
        
    }
   
    if ([typeString isEqual:@"帖子详情回复列表"]) {
        //创建UI
        [self loadUInewTopicDeta];
        
    }
    
    if ([typeString isEqual:@"直播间"]) {
        //创建UI
        [self loadRCIMZhiBoNewUI];
        
    }
    

    
    if ([typeString isEqual:@"融云聊天"]) {
        //创建UI
        [self loadZhiBoHomeUI];
        
    }
    
    if ([typeString isEqual:@"优惠劵兑换"]) {
        //创建优惠劵UI
        [self loadCouponUI];
        
    }
    
    if ([typeString isEqual:@"美问美答"]) {
        //创建UI
        [self loadASKUI];
        
    }
    
    
}

#pragma mark =====================公用回复列表的UI-开始========================
- (void)loadUI{
    self.backgroundColor = [UIColor whiteColor];
    
    //线
    UIImageView * imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    imageLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:imageLine];
    
    //表情
    _keyboard = [STEmojiKeyboard keyboard];
    WeakSelf(self);
    [_keyboard setGetSenderButtonMain:^{
        //表情发送键点击回调
        [weakself sendTextCommentTaped:nil];
    }];
    self.keyboardTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, (kSTIBDefaultHeight-kSTLeftButtonHeight)/2, kSTLeftButtonWidth, kSTLeftButtonHeight)];
    [_keyboardTypeButton addTarget:self action:@selector(keyboardTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _keyboardTypeButton.tag = 0;
    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[_keyboardTypeButton.tag]] forState:UIControlStateNormal];
    
    //输入框
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(kSTLeftButtonWidth, (kSTIBDefaultHeight-kSTTextviewDefaultHeight)/2, CGRectGetWidth(self.frame)-kSTLeftButtonWidth-kSTRightButtonWidth-15, kSTTextviewDefaultHeight)];
//    self.textView.backgroundColor = [UIColor clearColor];
    //    self.textView.textContainerInset = UIEdgeInsetsMake(5.0f, 0.0f, 5.0f, 0.0f);
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.returnKeyType = UIReturnKeySend;
    self.textView.delegate = self;
//    self.textView.tintColor = [UIColor whiteColor];
    self.textView.scrollEnabled = NO;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.textView.layer.cornerRadius = 5;
    self.textView.showsVerticalScrollIndicator = NO;
    
    _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSTLeftButtonWidth+5, CGRectGetMinY(_textView.frame), CGRectGetWidth(_textView.frame), kSTTextviewDefaultHeight)];
    _placeHolderLabel.adjustsFontSizeToFitWidth = YES;
    _placeHolderLabel.minimumScaleFactor = 0.9;
    _placeHolderLabel.textColor = [UIColor grayColor];
    _placeHolderLabel.font = _textView.font;
    _placeHolderLabel.userInteractionEnabled = NO;
    
    //回复那个按钮
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(self.frame.size.width-kSTRightButtonWidth-5, 0, 55, 44);
    [self.sendButton setImage:[UIImage imageNamed:@"btn-huifu"] forState:UIControlStateNormal];
//    [self.sendButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [self.sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.sendButton setTitleEdgeInsets:UIEdgeInsetsMake(2.50f, 0.0f, 0.0f, 0.0f)];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.sendButton addTarget:self action:@selector(sendTextCommentTaped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendButton.enabled = YES;
    
    [self addSubview:_keyboardTypeButton];
    [self addSubview:_textView];
    [self addSubview:_placeHolderLabel];
    [self addSubview:self.sendButton];
    
}
#pragma mark =====================公用回复列表的UI-结束========================



#pragma mark =====================新版话题详情回复列表的UI-开始========================
-(void)loadUInewTopicDeta{
    
    self.backgroundColor = [UIColor whiteColor];
    
    //线
    UIImageView * imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    imageLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:imageLine];
    
//    //表情
//    _keyboard = [STEmojiKeyboard keyboard];
//    WeakSelf(self);
//    [_keyboard setGetSenderButtonMain:^{
//        //表情发送键点击回调
//        [weakself sendTextCommentTaped:nil];
//    }];
//    self.keyboardTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, (kSTIBDefaultHeight-kSTLeftButtonHeight)/2, kSTLeftButtonWidth, kSTLeftButtonHeight)];
//    [_keyboardTypeButton addTarget:self action:@selector(keyboardTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    _keyboardTypeButton.tag = 0;
//    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[_keyboardTypeButton.tag]] forState:UIControlStateNormal];
    
    //输入框
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(30.0*px, (kSTIBDefaultHeight-kSTTextviewDefaultHeight)/2, CGRectGetWidth(self.frame)-30.0*px-279.0*px, kSTTextviewDefaultHeight)];
    //    self.textView.backgroundColor = [UIColor clearColor];
    //    self.textView.textContainerInset = UIEdgeInsetsMake(5.0f, 0.0f, 5.0f, 0.0f);
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.returnKeyType = UIReturnKeySend;
    self.textView.delegate = self;
    //    self.textView.tintColor = [UIColor whiteColor];
    self.textView.scrollEnabled = NO;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.textView.layer.cornerRadius = 5;
    self.textView.showsVerticalScrollIndicator = NO;
    
    _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0*px + 5, CGRectGetMinY(_textView.frame), CGRectGetWidth(_textView.frame), kSTTextviewDefaultHeight)];
    _placeHolderLabel.adjustsFontSizeToFitWidth = YES;
    _placeHolderLabel.minimumScaleFactor = 0.9;
    _placeHolderLabel.textColor = [UIColor grayColor];
    _placeHolderLabel.font = _textView.font;
    _placeHolderLabel.userInteractionEnabled = NO;
    
//    回复那个按钮(创建了别添加，textView占位符不会消失)
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(self.frame.size.width-kSTRightButtonWidth-5, 0, 55, 44);
//    [self.sendButton setImage:[UIImage imageNamed:@"btn-huifu"] forState:UIControlStateNormal];
    //    [self.sendButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //    [self.sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.sendButton setTitleEdgeInsets:UIEdgeInsetsMake(2.50f, 0.0f, 0.0f, 0.0f)];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.sendButton addTarget:self action:@selector(sendTextCommentTaped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendButton.enabled = YES;
    
//    [self addSubview:_keyboardTypeButton];
    [self addSubview:_textView];
    [self addSubview:_placeHolderLabel];
//    [self addSubview:self.sendButton];
    
    
//创建点赞按钮
    
    //点赞
    CGFloat heightJL = (self.frame.size.height-60.0*px)/2;
    _buttonimageZ = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_textView.frame)+23.0*px,heightJL, 60.0*px, 60.0*px)];
    [_buttonimageZ setImage:[UIImage imageNamed:@"新喜欢"] forState:UIControlStateNormal];
    [_buttonimageZ setImage:[UIImage imageNamed:@"新喜欢s"] forState:UIControlStateSelected];
    _buttonimageZ.tag = 102;
    [self addSubview:_buttonimageZ];
    
    
    //点赞数量
    _buttonimageNum = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_textView.frame)+63.0*px,CGRectGetMaxY(_buttonimageZ.frame)-70.0*px, 17, 17)];
    _buttonimageNum.backgroundColor = MAIN_COLOR;
    _buttonimageNum.userInteractionEnabled = NO;
    _buttonimageNum.textAlignment = NSTextAlignmentCenter;
    _buttonimageNum.layer.cornerRadius = 8.5;
    _buttonimageNum.clipsToBounds = YES;
    _buttonimageNum.textColor = [UIColor colorWithHexString:@"#ffffff"];
    _buttonimageNum.font = [UIFont systemFontOfSize:8];
    [self  addSubview:_buttonimageNum];

    
    //收藏
    _buttonimageC = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_buttonimageZ.frame)+23.0*px,heightJL, 60.0*px, 60.0*px)];
    [_buttonimageC setImage:[UIImage imageNamed:@"新收藏"] forState:UIControlStateNormal];
    [_buttonimageC setImage:[UIImage imageNamed:@"新收藏s"] forState:UIControlStateSelected];
    _buttonimageC.tag  =103;
    [self addSubview:_buttonimageC];
    
   //分享
    _buttonimageShare = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_buttonimageC.frame)+23.0*px,heightJL, 60.0*px, 60.0*px)];
    [_buttonimageShare setImage:[UIImage imageNamed:@"新分享"] forState:UIControlStateNormal];
//    [_buttonimageShare addTarget:self action:@selector(pressButtonimageZ:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonimageShare];
    
    
    
}
#pragma mark =====================新版话题详情回复列表的UI-结束========================



#pragma mark =====================融云聊天UI界面-开始========================
- (void)loadZhiBoHomeUI{
    self.backgroundColor = [UIColor whiteColor];
    //加边框
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    
//    //线
//    UIImageView * imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, -0.5, SCREEN_WIDTH, 1)];
//    imageLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self addSubview:imageLine];
    
//    表情
    WeakSelf(self);
    _keyboard = [STEmojiKeyboard keyboard];
    [_keyboard setGetSenderButtonMain:^{
       //表情发送键点击回调
        [weakself sendTextCommentTaped:nil];
    }];
    
    
    self.keyboardTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-88, (kSTIBDefaultHeight-kSTLeftButtonHeight)/2, kSTLeftButtonWidth, kSTLeftButtonHeight)];
    [_keyboardTypeButton addTarget:self action:@selector(keyboardTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _keyboardTypeButton.tag = 0;
    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[_keyboardTypeButton.tag]] forState:UIControlStateNormal];
    
    
    //语音
    _buttonAudio = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 44, 50)];
    [_buttonAudio setImage:[UIImage imageNamed:@"语音按钮"] forState:UIControlStateNormal];
    [_buttonAudio setImage:[UIImage imageNamed:@"语音按钮"] forState:UIControlStateSelected];
     [_buttonAudio addTarget:self action:@selector(ActionAudioChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonAudio];
    
    
    //输入框
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(44, (kSTIBDefaultHeight-kSTTextviewDefaultHeight)/2, SCREEN_WIDTH-88-40, kSTTextviewDefaultHeight)];
    //    self.textView.backgroundColor = [UIColor clearColor];
    //    self.textView.textContainerInset = UIEdgeInsetsMake(5.0f, 0.0f, 5.0f, 0.0f);
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.returnKeyType = UIReturnKeySend;
    self.textView.delegate = self;
    //    self.textView.tintColor = [UIColor whiteColor];
    self.textView.scrollEnabled = NO;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.textView.layer.cornerRadius = 5;
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.userInteractionEnabled = YES;
   
    _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSTLeftButtonWidth+5, CGRectGetMinY(_textView.frame), CGRectGetWidth(_textView.frame), kSTTextviewDefaultHeight)];
    _placeHolderLabel.adjustsFontSizeToFitWidth = YES;
    _placeHolderLabel.minimumScaleFactor = 0.9;
    _placeHolderLabel.textColor = [UIColor grayColor];
    _placeHolderLabel.font = _textView.font;
    _placeHolderLabel.userInteractionEnabled = NO;
    
    
    //加号按钮
     _buttonAdd = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-44, 0,44 ,50)];
    [_buttonAdd setImage:[UIImage imageNamed:@"加号按钮"] forState:UIControlStateNormal];
    //键盘
    [_buttonAdd setImage:[UIImage imageNamed:@"btn_keyboard"] forState:UIControlStateSelected];
    [_buttonAdd addTarget:self action:@selector(ActionAdd:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonAdd];
    
    
    
    // 回复那个按钮(创建了别添加，textView占位符不会消失)
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(self.frame.size.width-kSTRightButtonWidth-5, 8, 55, 29);
//    [self.sendButton setImage:[UIImage imageNamed:@"btn-huifu"] forState:UIControlStateNormal];
     self.sendButton.backgroundColor = MAIN_COLOR;
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
     self.sendButton.layer.cornerRadius = 6;
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendButton setTitleEdgeInsets:UIEdgeInsetsMake(2.50f, 0.0f, 0.0f, 0.0f)];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.sendButton addTarget:self action:@selector(sendTextCommentTaped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendButton.enabled = YES;
    
    [self addSubview:_keyboardTypeButton];//表情
    [self addSubview:_textView];
    [self addSubview:_placeHolderLabel];
//    [self addSubview:self.sendButton];//发送
    
    

    //按住说话
    MyRecordButtonView *buttonAudioView = [[MyRecordButtonView alloc]init];
    self.buttonAudioView = buttonAudioView;
    buttonAudioView.frame = self.textView.frame;
    //影藏
    buttonAudioView.hidden = YES;
    [self addSubview:buttonAudioView];

    //照片选择区域
    self.viewPhoneView = [[UIView alloc]init];
    self.viewPhoneView.frame =CGRectMake(0, 0, SCREEN_WIDTH, 200.0*px);
    self.viewPhoneView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    //照片选择UI
    [self createChatPhoneChooseUI];


}

//照片选择UI
-(void)createChatPhoneChooseUI{
    
    //照片
    UIButton *buttonPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonPhone.frame = CGRectMake(66.0*px, 30.0*px, 120.0*px, self.viewPhoneView.height-70.0*px);
    buttonPhone.titleLabel.font = [UIFont systemFontOfSize:12];
    [buttonPhone setTitle:@"照片" forState:UIControlStateNormal];
    [buttonPhone setTitleColor:MAIN_COLOR_898989 forState:UIControlStateNormal];
    [buttonPhone setImage:[UIImage imageNamed:@"聊天照片选择"] forState:UIControlStateNormal];
    [buttonPhone addTarget:self action:@selector(ActionbuttonChoosePhone) forControlEvents:UIControlEventTouchUpInside];
    //这一行调整图片和文字的位置
    [buttonPhone setImagePositionWithType:SSImagePositionTypeTop spacing:5];
    [self.viewPhoneView addSubview:buttonPhone];
}


//语音按钮点击事件
-(void)ActionAudioChoose:(UIButton*)button{
    [self endEditing:YES];
    button.selected = !button.selected;
    if (button.selected==YES) {
        //打开
        _buttonAudioView.hidden = NO;
    }else{
        //影藏
        _buttonAudioView.hidden = YES;
    }
}


//加号按钮点击事件
-(void)ActionAdd:(UIButton*)button{
    
    button.selected = !button.selected;
    
    if (button.selected==YES) {
        //放弃第一响应
//        [self endEditing:YES];
        //创建选择照片
        self.textView.inputView = self.viewPhoneView;
        
//        //回调键盘高度
//        if (self.getKeyboardHeight) {
//            self.getKeyboardHeight(self.viewPhoneView.height);
//        }
        
    }else{
        //设置为nil恢复键盘
        self.textView.inputView = nil;
      
    }
    
    [_textView becomeFirstResponder];
    [self.textView reloadInputViews];

    //表情键盘复原
    [self keyboardTypeButtonNomal];

}

//点击选择照片
-(void)ActionbuttonChoosePhone{
    if (self.clickPhoneChoose) {
        self.clickPhoneChoose();
    }
}

//关闭照片选择
-(void)clocePhoneShoose{
    
}


#pragma mark =====================融云聊天UI界面-结束========================



#pragma mark =====================直播间UI-开始========================
- (void)loadRCIMZhiBoNewUI{
    self.backgroundColor = [UIColor whiteColor];
    
    //线
    UIImageView * imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    imageLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:imageLine];
    
    //表情
    _keyboard = [STEmojiKeyboard keyboard];
    self.keyboardTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, (kSTIBDefaultHeight-kSTLeftButtonHeight)/2, kSTLeftButtonWidth, kSTLeftButtonHeight)];
    [_keyboardTypeButton addTarget:self action:@selector(keyboardTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _keyboardTypeButton.tag = 0;
    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[_keyboardTypeButton.tag]] forState:UIControlStateNormal];
    
    //输入框
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(kSTLeftButtonWidth, (kSTIBDefaultHeight-kSTTextviewDefaultHeight)/2, CGRectGetWidth(self.frame)-kSTLeftButtonWidth-kSTRightButtonWidth-15, kSTTextviewDefaultHeight)];
    //    self.textView.backgroundColor = [UIColor clearColor];
    //    self.textView.textContainerInset = UIEdgeInsetsMake(5.0f, 0.0f, 5.0f, 0.0f);
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.returnKeyType = UIReturnKeySend;
    self.textView.delegate = self;
    //    self.textView.tintColor = [UIColor whiteColor];
    self.textView.scrollEnabled = NO;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.textView.layer.cornerRadius = 5;
    self.textView.showsVerticalScrollIndicator = NO;
    
    _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSTLeftButtonWidth+5, CGRectGetMinY(_textView.frame), CGRectGetWidth(_textView.frame), kSTTextviewDefaultHeight)];
    _placeHolderLabel.adjustsFontSizeToFitWidth = YES;
    _placeHolderLabel.minimumScaleFactor = 0.9;
    _placeHolderLabel.textColor = [UIColor grayColor];
    _placeHolderLabel.font = _textView.font;
    _placeHolderLabel.userInteractionEnabled = NO;
    
    //回复那个按钮
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(self.frame.size.width-kSTRightButtonWidth-5, 8, 55, 29);
    //    [self.sendButton setImage:[UIImage imageNamed:@"btn-huifu"] forState:UIControlStateNormal];
    self.sendButton.backgroundColor = MAIN_COLOR;
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButton.layer.cornerRadius = 6;
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendButton setTitleEdgeInsets:UIEdgeInsetsMake(2.50f, 0.0f, 0.0f, 0.0f)];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.sendButton addTarget:self action:@selector(sendTextCommentTaped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendButton.enabled = YES;
    
    [self addSubview:_keyboardTypeButton];
    [self addSubview:_textView];
    [self addSubview:_placeHolderLabel];
    [self addSubview:self.sendButton];
    
}
#pragma mark =====================直播间UI-结束========================




#pragma mark =====================优惠劵兑换UI-开始========================
- (void)loadCouponUI{
    self.backgroundColor = [UIColor whiteColor];
    
    //线
    UIImageView * imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    imageLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:imageLine];
    
    //表情
//    _keyboard = [STEmojiKeyboard keyboard];
//    
//    WeakSelf(self);
//    [_keyboard setGetSenderButtonMain:^{
//        //表情发送键点击回调
//        [weakself sendTextCommentTaped:nil];
//    }];
//    self.keyboardTypeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, (kSTIBDefaultHeight-kSTLeftButtonHeight)/2, kSTLeftButtonWidth, kSTLeftButtonHeight)];
//    [_keyboardTypeButton addTarget:self action:@selector(keyboardTypeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    _keyboardTypeButton.tag = 0;
//    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[_keyboardTypeButton.tag]] forState:UIControlStateNormal];
    
    //输入框
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(30.0*px, (kSTIBDefaultHeight-kSTTextviewDefaultHeight)/2, CGRectGetWidth(self.frame)-kSTLeftButtonWidth-35-15, kSTTextviewDefaultHeight)];
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.returnKeyType = UIReturnKeySend;
    self.textView.delegate = self;
    self.textView.scrollEnabled = NO;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.textView.layer.cornerRadius = 5;
    self.textView.showsVerticalScrollIndicator = NO;
    
    _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0*px+5, CGRectGetMinY(_textView.frame), CGRectGetWidth(_textView.frame), kSTTextviewDefaultHeight)];
    _placeHolderLabel.adjustsFontSizeToFitWidth = YES;
    _placeHolderLabel.minimumScaleFactor = 0.9;
    _placeHolderLabel.textColor = [UIColor grayColor];
    _placeHolderLabel.font = _textView.font;
    _placeHolderLabel.userInteractionEnabled = NO;
    
    //回复那个按钮
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(self.frame.size.width-kSTRightButtonWidth-15, 8, 55, 29);
    self.sendButton.backgroundColor = MAIN_COLOR;
    [self.sendButton setTitle:@"确定" forState:UIControlStateNormal];
    self.sendButton.layer.cornerRadius = 6;
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.sendButton setTitleEdgeInsets:UIEdgeInsetsMake(2.50f, 0.0f, 0.0f, 0.0f)];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.sendButton addTarget:self action:@selector(sendTextCommentTaped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendButton.enabled = YES;
    
    [self addSubview:_keyboardTypeButton];
    [self addSubview:_textView];
    [self addSubview:_placeHolderLabel];
    [self addSubview:self.sendButton];
    
}
#pragma mark =====================优惠劵兑换UI-结束========================





#pragma mark =====================美问美答UI-开始========================
- (void)loadASKUI{
    self.backgroundColor = [UIColor whiteColor];
    
    //线
    UIImageView * imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    imageLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:imageLine];
    
    //输入框
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 9.5, SCREEN_WIDTH-30-55-10, 30)];
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont systemFontOfSize:12];
    self.textView.returnKeyType = UIReturnKeySend;
    self.textView.delegate = self;
    self.textView.scrollEnabled = NO;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.textView.layer.cornerRadius = 5;
    self.textView.showsVerticalScrollIndicator = NO;
    
    _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 9.5, SCREEN_WIDTH-30-55-10-20, 30)];
    _placeHolderLabel.adjustsFontSizeToFitWidth = YES;
    _placeHolderLabel.minimumScaleFactor = 0.9;
    _placeHolderLabel.textColor = [UIColor grayColor];
    _placeHolderLabel.font = _textView.font;
    _placeHolderLabel.userInteractionEnabled = NO;
    
    //回复那个按钮
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.frame = CGRectMake(SCREEN_WIDTH-15-55, 12.5, 55, 24);
    self.sendButton.backgroundColor = MAIN_COLOR;
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButton.layer.cornerRadius = 5;
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.sendButton addTarget:self action:@selector(sendTextCommentTaped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_keyboardTypeButton];
    [self addSubview:_textView];
    [self addSubview:_placeHolderLabel];
    [self addSubview:self.sendButton];
    
}
#pragma mark =====================美问美答UI-结束========================






- (void)layout{
    
    self.sendButton.enabled = ![@"" isEqualToString:self.textView.text];
    _placeHolderLabel.hidden = self.sendButton.enabled;
    
    self.sendButton.enabled = YES;
    
    CGRect textViewFrame = self.textView.frame;
    CGSize textSize = [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth(textViewFrame), 1000.0f)];
    
    //这里必须写15，非常重要
    CGFloat offset = 15;
    self.textView.scrollEnabled = (textSize.height > kSTTextviewMaxHeight-offset);
    textViewFrame.size.height = MAX(kSTTextviewDefaultHeight, MIN(kSTTextviewMaxHeight, textSize.height));
    self.textView.frame = textViewFrame;
    
    CGRect addBarFrame = self.frame;
    CGFloat maxY = CGRectGetMaxY(addBarFrame);
    addBarFrame.size.height = textViewFrame.size.height+offset;
    addBarFrame.origin.y = maxY-addBarFrame.size.height;
    self.frame = addBarFrame;
    
    self.keyboardTypeButton.center = CGPointMake(CGRectGetMidX(self.keyboardTypeButton.frame), CGRectGetHeight(addBarFrame)/2.0f);
    self.sendButton.center = CGPointMake(CGRectGetMidX(self.sendButton.frame), CGRectGetHeight(addBarFrame)/2.0f);
    
    if (self.sizeChangedHandler){
        self.sizeChangedHandler();
    }
#pragma mark ============ 聊天界面 ===================
     self.buttonAudio.center = CGPointMake(CGRectGetMidX(self.buttonAudio.frame), CGRectGetHeight(addBarFrame)/2.0f);
     self.buttonAdd.center = CGPointMake(CGRectGetMidX(self.buttonAdd.frame), CGRectGetHeight(addBarFrame)/2.0f);
    
    
#pragma mark  ========= 新话题详情 =============
    self.buttonimageZ.center = CGPointMake(CGRectGetMidX(self.buttonimageZ.frame), CGRectGetHeight(addBarFrame)/2.0f);
    self.buttonimageC.center = CGPointMake(CGRectGetMidX(self.buttonimageC.frame), CGRectGetHeight(addBarFrame)/2.0f);
    self.buttonimageShare.center = CGPointMake(CGRectGetMidX(self.buttonimageShare.frame), CGRectGetHeight(addBarFrame)/2.0f);
    self.buttonimageNum.frame = CGRectMake(CGRectGetMaxX(_textView.frame)+63.0*px,CGRectGetMaxY(_buttonimageZ.frame)-70.0*px, 17, 17);
}

#pragma mark - public

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolderLabel.text = placeHolder;
    _placeHolder = [placeHolder copy];
}

- (BOOL)resignFirstResponder{
    [super resignFirstResponder];
    return [_textView resignFirstResponder];
}

- (void)registerKeyboardNotif{
    _isRegistedKeyboardNotif = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    //点击子回复弹出键盘
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(replyActionSon) name:@"replyActionSon" object:nil];
    //清除评论框里的内容
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DeleteContent) name:@"DeleteContent" object:nil];
    
    
}

//清除评论框里的内容
-(void)DeleteContent{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.textView.text = @"";
        //布局
        [self layout];
        
    });
}

-(void)replyActionSon{
    //弹出键盘
    [self.textView becomeFirstResponder];
    
}

//换行键的代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
       
        if (self.sendDidClickedHandler){
            self.sendDidClickedHandler(self.textView.text);
//            self.textView.text = @"";
            [self layout];
        }

        return NO;
        
    }
    
    return YES;
    
}


- (void)setDidSendClicked:(void (^)(NSString *))handler{
    _sendDidClickedHandler = handler;
}

- (void)setInputBarSizeChangedHandle:(void (^)())handler{
    _sizeChangedHandler = handler;
}

- (void)setFitWhenKeyboardShowOrHide:(BOOL)fitWhenKeyboardShowOrHide{
    if (fitWhenKeyboardShowOrHide){
        [self registerKeyboardNotif];
    }
    if (!fitWhenKeyboardShowOrHide && _fitWhenKeyboardShowOrHide){
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    _fitWhenKeyboardShowOrHide = fitWhenKeyboardShowOrHide;
}

#pragma mark - notif

- (void)keyboardWillShow:(NSNotification *)notification
{
    //影藏语音，关闭选中
     _buttonAudioView.hidden = YES;
    _buttonAudio.selected = NO;
    
     NSDictionary* info = [notification userInfo];
     CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //回调键盘高度
    if (self.getKeyboardHeight) {
        self.getKeyboardHeight(kbSize.height);
    }
    
      if ([self.typeString isEqual:@"融云聊天"]||[self.typeString isEqual:@"直播间"]) {
      //融云聊天,自己弹出高度，所以不需要
      }else{

          [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                                delay:0
                              options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                           animations:^{
                               CGRect newInputBarFrame = self.frame;
                               newInputBarFrame.origin.y = [UIScreen mainScreen].bounds.size.height-CGRectGetHeight(self.frame)-kbSize.height;
                               self.frame = newInputBarFrame;
                           }
                           completion:nil];
          
      }
}

- (void)keyboardWillHidden:(NSNotification *)notification {
    
//    if (self.textView.inputView !=nil) {
        //结束编辑
        if (self.endEidt) {
            self.endEidt(self.textView.text);
        }
//    }
    
    NSDictionary* info = [notification userInfo];
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         self.center = CGPointMake(self.bounds.size.width/2.0f, height-CGRectGetHeight(self.frame)/2.0-MC_TabbarSafeBottomMargin);
                     }
                     completion:nil];
    
    //设置为nil恢复键盘
    self.textView.inputView = nil;
    //加号按钮关闭选中
    self.buttonAdd.selected = NO;
    //表情键盘复原
    [self keyboardTypeButtonNomal];
}

//表情键盘复原
-(void)keyboardTypeButtonNomal{
    //表情处理
    _keyboardTypeButton.tag = 0;//tage
    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[0]] forState:UIControlStateNormal];//图片
}

#pragma mark - action

- (void)sendTextCommentTaped:(UIButton *)button{
    if (self.sendDidClickedHandler){
        self.sendDidClickedHandler(self.textView.text);
//        self.textView.text = @"";
        
        if (![self.typeString isEqual:@"美问美答"]) {
            [self layout];
        }
    }
}

- (void)keyboardTypeButtonClicked:(UIButton *)button{
    if (button.tag == 1){
        self.textView.inputView = nil;
    }
    else{
        [_keyboard setTextView:self.textView];
    }
    [self.textView reloadInputViews];
    button.tag = (button.tag+1)%2;
    [_keyboardTypeButton setImage:[UIImage imageNamed:_switchKeyboardImages[button.tag]] forState:UIControlStateNormal];
    [_textView becomeFirstResponder];
    
    //加号按钮关闭选中（复原）
    self.buttonAdd.selected = NO;
}

#pragma mark - text view delegate

- (void)textViewDidChange:(UITextView *)textView{
    [self layout];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //设置为nil恢复键盘
//    self.textView.inputView = nil;
  
    return YES;
}

//结束编辑
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.endEidt) {
        self.endEidt(textView.text);
    }
}



@end
