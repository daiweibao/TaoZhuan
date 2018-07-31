//
//  MessageTextChatCell.m
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/21.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "RCMyTextMessageCell.h"
//聊天时间处理
#import "GetChatTime.h"
@interface RCMyTextMessageCell()

/**
 日期
 */
@property(nonatomic,weak)UILabel * dateLabel;
/**
 头像
 */
@property(nonatomic,weak)UIImageView *headView;
/**
 内容
 */
@property(nonatomic,weak)UILabel * labelContent;
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

//菜单
@property(nonatomic,assign) UIMenuController *menu;

@end

@implementation RCMyTextMessageCell

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
    
     self.buttonSenderStare.hidden = YES;
     self.buttonSenderStare.userInteractionEnabled = NO;
    
    if ([NSString isNULL:model.content]==NO) {
        
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
            //内容
            self.labelContent.textColor = MAIN_COLOR_313131;
            self.labelContent.textAlignment = NSTextAlignmentLeft;
            self.labelContent.text = model.content;
            
            //坐标
            //汉字最大宽度
            CGFloat titleMAXwidth =  380.0*px;

            CGSize sizetitle  = [NSString sizeMyStrWith:self.labelContent.text andFontSize:14 andMineWidth:titleMAXwidth];
            //内容起始坐标
            self.labelContent.frame = CGRectMake(40.0*px, 0, sizetitle.width, sizetitle.height+50.0*px);
            
            //气泡坐标
            //图片拉升不变形
            self.bubbleBackgroundView.image = [self resizableImageWithName:@"聊天气泡左"];
            CGFloat bgheight = self.labelContent.frame.size.height;
            //气泡宽度
             CGFloat bgwindth = sizetitle.width+ 40.0*px +30.0*px;
            self.bubbleBackgroundView.frame = CGRectMake(CGRectGetMaxX(self.headView.frame)+20.0*px, self.dateLabel.bottomY,bgwindth, bgheight);
            
            
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
            //内容
             self.labelContent.textColor = [UIColor whiteColor];
            self.labelContent.textAlignment = NSTextAlignmentLeft;
            self.labelContent.text = model.content;
            
            //坐标
            //汉字最大宽度
            CGFloat titleMAXwidth =  380.0*px;
            
            CGSize sizetitle  = [NSString sizeMyStrWith:self.labelContent.text andFontSize:14 andMineWidth:titleMAXwidth];
            //内容起始坐标
            self.labelContent.frame = CGRectMake(30.0*px, 0, sizetitle.width, sizetitle.height+50.0*px);
            
            //气泡坐标
            //图片拉升不变形
            self.bubbleBackgroundView.image = [self resizableImageWithName:@"聊天气泡右"];
            CGFloat bgheight = self.labelContent.frame.size.height;
            //气泡宽度
            CGFloat bgwindth = sizetitle.width+ 40.0*px +30.0*px;
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
    self.bubbleBackgroundView = bubbleBackgroundView;
    bubbleBackgroundView.userInteractionEnabled = YES;
    [self.contentView addSubview:bubbleBackgroundView];
//    //长按删除
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDoDelete:)];
    //    longPressGr.minimumPressDuration = 0.8;
    [self addGestureRecognizer:longPressGr];
    
    //气泡上面的汉字
    UILabel * labelContent = [[UILabel alloc]init];
    self.labelContent = labelContent;
    labelContent.textAlignment = NSTextAlignmentLeft;
    labelContent.font = [UIFont systemFontOfSize:14];
    labelContent.numberOfLines = 0;
    [bubbleBackgroundView addSubview:labelContent];
    
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
        
        UIMenuItem *copyItem1 = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyItemClicked:)];
       
        
        UIMenuItem *resendItem2 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(resendItemClicked:)];
        
        UIMenuController *menu=[UIMenuController sharedMenuController];
        self.menu = menu;
        [menu setMenuItems:[NSArray arrayWithObjects:copyItem1,resendItem2,nil]];
        
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
   //赋值内容
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.model.content;
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
