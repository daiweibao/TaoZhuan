//
//  MessageTextChatCell.m
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/21.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "RCMyVoiceMessageCell.h"
//聊天时间处理
#import "GetChatTime.h"
@interface RCMyVoiceMessageCell()

/**
 日期
 */
@property(nonatomic,weak)UILabel * dateLabel;
/**
 头像
 */
@property(nonatomic,weak)UIImageView *headView;

/**
 气泡
 */
@property(nonatomic,weak)UIImageView * bubbleBackgroundView;
/**
 发送状态
 */
@property(nonatomic,weak)UIButton * buttonSenderStare;

/**
 *  菊花（加载框）
 */
@property (nonatomic,strong) UIActivityIndicatorView *loadingView;
//语音消息是否已读的小红点
@property(nonatomic,weak)UILabel * labelAudioPoint;

//菜单
@property(nonatomic,assign) UIMenuController *menu;

@end

@implementation RCMyVoiceMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //创建自己ui
        [self createUIMy];
        //监听滚动移除菜单
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeMenuMy) name:@"removeMenu" object:nil];

    }
    return self;
}


-(void)setModel:(RCmessageContentModel *)model{
    _model = model;
    
      self.buttonSenderStare.userInteractionEnabled = NO;
     self.buttonSenderStare.hidden = YES;
     self.labelAudioPoint.hidden = YES;
    
    if (self.model.wavAudioData) {
        
        //消息发送时间
        if (self.model.isTimeVisible==true) {
            //展示时间
            self.dateLabel.frame = CGRectMake(0,30.0*px, SCREEN_WIDTH,80.0*px);
//            self.dateLabel.text = [NSString dateChange:@(self.model.sentTime) andFormat:@"yyyy-MM-dd HH:mm"];
            //聊天时间转换（封装）
            self.dateLabel.text = [GetChatTime getMessageDateStringFromTimeInterval:self.model.sentTime andNeedTime:YES];
        }else{
            //不展示时间
            self.dateLabel.frame = CGRectMake(0,30.0*px, SCREEN_WIDTH,0);
            self.dateLabel.text=@"";
        }
        
        if (model.messageType==2) {
            //收到消息
            //融云设置接收消息的接收状态（已读,不要再收到消息哪里设置已读）
            if (self.model.messageReceiveState==0) {
                [[RCIMClient sharedRCIMClient] setMessageReceivedStatus:self.model.messageId receivedStatus:ReceivedStatus_READ];
            }
            //头像
            self.headView.frame = CGRectMake(20.0*px,self.dateLabel.bottomY, 40,40);
            if ([NSString isNULL:self.model.portraitUri]==NO) {
                if ([self.model.portraitUri containsString:@"http"]) {
                    //网络头像
                    [self.headView sd_setImageWithURL:[NSURL URLWithString:self.model.portraitUri] placeholderImage:[UIImage imageNamed:@"默认头像"]];
                    
                }else{
                    //本地头像
                    self.headView.image  =[UIImage imageNamed:self.model.portraitUri];
                }
            }else{
//                self.headView.image = [UIImage imageNamed:@"默认头像"];
                 self.headView.image = [UIImage imageNamed:appLogoName];
            }
            //语音
            [self.messageVoiceButton setImage:[UIImage imageNamed:@"语音左3"] forState:UIControlStateNormal];
            [self.messageVoiceButton setTitle:[NSString stringWithFormat:@"%ld\"",self.model.duration] forState:UIControlStateNormal];
             [self.messageVoiceButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.messageVoiceButton addTarget:self action:@selector(ActionbuttonPlay:) forControlEvents:UIControlEventTouchUpInside];
            //对齐方式
             self.messageVoiceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            //这一行调整图片和文字的位置
            [self.messageVoiceButton setImagePositionWithType:SSImagePositionTypeLeft spacing:20];
            self.messageVoiceButton.frame = CGRectMake(23.0*px, 0, 70 , 40);
            
            //气泡坐标
            //图片拉升不变形
            self.bubbleBackgroundView.image = [self resizableImageWithName:@"聊天气泡左"];
            //气泡宽度
            CGFloat bgwindth = self.messageVoiceButton.width+ 23.0*px;
            CGFloat bgheight = self.messageVoiceButton.frame.size.height;
            
            self.bubbleBackgroundView.frame = CGRectMake(CGRectGetMaxX(self.headView.frame)+20.0*px, self.dateLabel.bottomY,bgwindth, bgheight);
            
            //收到语音消息标记未读
            self.labelAudioPoint.frame = CGRectMake(self.bubbleBackgroundView.rightX+1, self.bubbleBackgroundView.y, 4, 4);
            //2代表已听
            if (self.model.messageReceiveState==2) {
                self.labelAudioPoint.hidden = YES;
            }else{
                //未听
                 self.labelAudioPoint.hidden = NO;
            }
            
            
            
        }else{
            
            //发送消息
            //头像
            self.headView.frame = CGRectMake(SCREEN_WIDTH-20.0*px-40,self.dateLabel.bottomY, 40,40);
            if ([NSString isNULL:self.model.portraitUri]==NO) {
                if ([self.model.portraitUri containsString:@"http"]) {
                    //网络头像
                    [self.headView sd_setImageWithURL:[NSURL URLWithString:self.model.portraitUri] placeholderImage:[UIImage imageNamed:@"默认头像"]];
                    
                }else{
                    //本地头像
                    self.headView.image  =[UIImage imageNamed:self.model.portraitUri];
                }
            }else{
                self.headView.image = [UIImage imageNamed:@"默认头像"];
            }
            //语音
            [self.messageVoiceButton setImage:[UIImage imageNamed:@"语音右3"] forState:UIControlStateNormal];
            [self.messageVoiceButton setTitle:[NSString stringWithFormat:@"%ld\"",self.model.duration] forState:UIControlStateNormal];
            [self.messageVoiceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.messageVoiceButton addTarget:self action:@selector(ActionbuttonPlay:) forControlEvents:UIControlEventTouchUpInside];
            //对齐方式
            self.messageVoiceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            //这一行调整图片和文字的位置
            [self.messageVoiceButton setImagePositionWithType:SSImagePositionTypeRight spacing:10];
            self.messageVoiceButton.frame = CGRectMake(0, 0, 70, 40);
            
            //气泡坐标
            //图片拉升不变形
            self.bubbleBackgroundView.image = [self resizableImageWithName:@"聊天气泡右"];
            //气泡宽度
            CGFloat bgwindth = self.messageVoiceButton.width+ 23.0*px;
            CGFloat bgheight = self.messageVoiceButton.frame.size.height;
            self.bubbleBackgroundView.frame = CGRectMake(self.headView.x-20.0*px-bgwindth, self.dateLabel.bottomY, bgwindth, bgheight);
            
            //发送状态
            self.buttonSenderStare.frame = CGRectMake(self.bubbleBackgroundView.x-80.0*px, self.bubbleBackgroundView.centerY-40.0*px, 80.0*px, 80.0*px);
            
            if (self.model.messageSendState==10) {
                //发送中
                //开始加载中
                [self.loadingView startAnimating];
                self.buttonSenderStare.hidden = NO;
                [self.buttonSenderStare setImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
                self.buttonSenderStare.userInteractionEnabled = NO;
                
            }else if (self.model.messageSendState==20){
                //发送失败
                //停止加载
                [self.loadingView stopAnimating];
                self.buttonSenderStare.hidden = NO;
                [self.buttonSenderStare setImage:[UIImage imageNamed:@"发送失败"] forState:UIControlStateNormal];
                self.buttonSenderStare.userInteractionEnabled = YES;
                
                
            }else if (self.model.messageSendState==30){
                //发送成功
                //停止加载
                [self.loadingView stopAnimating];
                self.buttonSenderStare.hidden = NO;
                [self.buttonSenderStare setImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
                self.buttonSenderStare.userInteractionEnabled = NO;
                
            }
            
            
        }
        
    }
    
}


//创建自己UI
-(void)createUIMy{
    
    //时间
    UILabel * dateLabel = [[UILabel alloc]init];
    self.dateLabel = dateLabel;
    dateLabel.frame = CGRectMake(0,30.0*px, SCREEN_WIDTH,80.0*px);
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.textColor = MAIN_COLOR_898989;
    dateLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:dateLabel];
    
    //头像
    UIImageView *headView = [[UIImageView alloc]init];
    self.headView = headView;
    headView.userInteractionEnabled = YES;
    //圆角头像
    headView.contentMode = UIViewContentModeScaleAspectFill;
    headView.layer.cornerRadius = 20;
    headView.layer.masksToBounds = YES;
    //头像点击
    [headView addTapActionTouch:^{
        //判断头像是否可以点击
        if (self.model.isActionPhone==YES) {
            [PhoneAction ActionPhoneControll:self.parentController UseId:@([self.model.userId integerValue])];
        }
    }];
    [self.contentView addSubview:headView];
    
    //大气泡
    UIImageView * bubbleBackgroundView = [[UIImageView alloc]init];
    bubbleBackgroundView.userInteractionEnabled = YES;
    self.bubbleBackgroundView = bubbleBackgroundView;
    [self.contentView addSubview:bubbleBackgroundView];
    //    //长按删除
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDoDelete:)];
    //    longPressGr.minimumPressDuration = 0.8;
    [self addGestureRecognizer:longPressGr];
    
    //语音按钮
    UIButton * messageVoiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.messageVoiceButton = messageVoiceButton;
    messageVoiceButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [bubbleBackgroundView addSubview:messageVoiceButton];
    
    //消息是否已读的状态标记
    UILabel * labelAudioPoint = [[UILabel alloc]init];
    self.labelAudioPoint = labelAudioPoint;
    labelAudioPoint.backgroundColor = MAIN_COLOR;
    labelAudioPoint.layer.cornerRadius = 2;
    labelAudioPoint.clipsToBounds = YES;
    [self.contentView addSubview:labelAudioPoint];
    
    //发送状态
    UIButton * buttonSenderStare  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonSenderStare = buttonSenderStare;
    [buttonSenderStare addTarget:self action:@selector(ActionButtonagain) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:buttonSenderStare];
    buttonSenderStare.hidden = YES;
    buttonSenderStare.userInteractionEnabled = NO;
    
    //创建小菊花
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //    UIActivityIndicatorViewStyleWhiteLarge 的尺寸是（37，37）
    //    UIActivityIndicatorViewStyleWhite 的尺寸是（22，22）
    //设置颜色
    self.loadingView.color = [UIColor grayColor];
    [buttonSenderStare addSubview:self.loadingView];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(buttonSenderStare);
    }];
    
    
}


//图片拉升不变形
- (UIImage *)resizableImageWithName:(NSString *)name{
    
    UIImage *oldImage = [UIImage imageNamed:name];
    //    resizableImageWithCapInsets：设定拉伸范围（让图片距离上左下右有多少范围不拉伸）
    //    resizingMode:表示拉伸的方法。
    CGFloat w = oldImage.size.width * 0.8;
    CGFloat h = oldImage.size.height * 0.8;
    return [oldImage resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    
}


//播放语音
-(void)ActionbuttonPlay:(UIButton*)button{
   //小红点影藏(已听)
    self.labelAudioPoint.hidden = YES;
    //模型改变
    self.model.messageReceiveState = 2;
   
    //融云设置消息的接收状态（已听）
    [[RCIMClient sharedRCIMClient] setMessageReceivedStatus:self.model.messageId receivedStatus:ReceivedStatus_LISTENED];
    
    //语音点击播放回调处理其他cell上的播放停止
    if (self.ActionVoiceButton) {
        self.ActionVoiceButton();
    }
}


//发送失败button点击事件
-(void)ActionButtonagain{
    
    [AlertGXJView AlertGXJAlertWithController:self.parentController Title:@"重新发送该消息？" Message:nil otherItemArrays:@[@"重新发送",@"取消"] Width:-1 Type:-1 handler:^(NSInteger index) {
        if (index==0) {
            if (self.againSendRCInfo) {
                self.againSendRCInfo();
            }
            
        }
        
    }];
}

#pragma mark ============ 处理长按菜单=开始 =====================

- (void)longPressToDoDelete:(UILongPressGestureRecognizer *)longRecognizer {
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        
        [self becomeFirstResponder];
        
        UIMenuItem *resendItem2 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(resendItemClicked:)];
        
        UIMenuController *menu=[UIMenuController sharedMenuController];
        self.menu = menu;
        [menu setMenuItems:[NSArray arrayWithObjects:resendItem2,nil]];
        
        [menu setTargetRect:self.bubbleBackgroundView.bounds inView:self.bubbleBackgroundView];
        
        [menu setMenuVisible:YES animated:YES];
    }
}

//移除菜单
-(void)removeMenuMy{
    [self.menu setMenuVisible:NO animated:YES];
}

- (void)resendItemClicked:(id)sender {
    //删除
    if (self.deleteRCIMInfo) {
        self.deleteRCIMInfo();
    }
}

- (void)copyItemClicked:(UIMenuItem *)sender {
//    //赋值内容
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = self.model.content;
}

//处理action事件
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if(action == @selector(copyItemClicked:)){
        return YES;
    } else if (action == @selector(resendItemClicked:)){
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}
//实现成为第一响应者方法
- (BOOL)canBecomeFirstResponder {
    return YES;
}
#pragma mark ============ 处理长按菜单=结束 =====================


@end
