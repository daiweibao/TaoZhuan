//
//  MessageTextChatCell.m
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/21.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "RCMyImageMessageCell.h"
//聊天时间处理
#import "GetChatTime.h"
//图片浏览1
#import "ImageReviewViewController.h"
//图片浏览2
#import "JZAlbumViewController.h"
@interface RCMyImageMessageCell()

/**
 日期
 */
@property(nonatomic,weak)UILabel * dateLabel;
/**
 头像
 */
@property(nonatomic,weak)UIImageView *headView;
/**
 图片
 */
@property (nonatomic, weak) UIImageView *messageImageView;
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

@implementation RCMyImageMessageCell

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
    if (self.model.imageUrl) {
        
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
                 self.headView.image = [UIImage imageNamed:appLogoName];//客服
            }
            
            //收到图片
            if ([NSString isNULL:self.model.imageUrl]==NO) {
                [self.messageImageView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] placeholderImage:self.model.thumbnailImage];
            }else{
               //缩略图
                self.messageImageView.image = self.model.thumbnailImage;
            }
            
            //坐标
            //图片最大宽度
            CGFloat imageMAXwidth =  self.model.imageMAXwidth;
            //图片最大高度
            CGFloat imageMAXheight =   self.model.imageMAXheight;
            //图片起始坐标
            self.messageImageView.frame = CGRectMake(13.0*px, 1.0*px, imageMAXwidth, imageMAXheight);
            
            //气泡坐标
            //图片拉升不变形
            self.bubbleBackgroundView.image = [self resizableImageWithName:@"聊天气泡左"];
            //气泡宽度
            CGFloat bgwindth = self.messageImageView.width+ 13.0*px;
            CGFloat bgheight = self.messageImageView.frame.size.height+2.0*px;
            
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
            
             //发送的图片
//            if (self.model.originalImage) {
//                //自己发送的图片（在当前界面发送时有原始图片）
//                self.messageImageView.image = self.model.originalImage;
//                
//            }else{
//                //自己发送的历史图片（沙盒路径）
//                //读取本地图片
//                UIImage *imgFromUrl=[[UIImage alloc]initWithContentsOfFile:self.model.imageUrl];
//                if (imgFromUrl) {
//                     self.messageImageView.image = imgFromUrl;
//                }else{
//                    //实在不存在图片就显示缩略图
//                     self.messageImageView.image = self.model.thumbnailImage;
//                }
//            }
            
            //读取图片路径
            if ([NSString isNULL:self.model.imageUrl]) {
                self.messageImageView.image = [UIImage imageNamed:@"启动图标最终版"];
            }else{
                UIImage * imageSend = [[UIImage alloc]initWithContentsOfFile:self.model.imageUrl];
                if (imageSend) {
                    
                    self.messageImageView.image =imageSend;
                    
                }else{
                    //模拟器不存在显示缩略图
                     self.messageImageView.image =self.model.thumbnailImage ;
                }
            }
            
            //坐标
            //图片最大宽度
            CGFloat imageMAXwidth =  self.model.imageMAXwidth;
            //图片最大高度
            CGFloat imageMAXheight =   self.model.imageMAXheight;
            
            //图片起始坐标
            self.messageImageView.frame = CGRectMake(1.0*px, 1.0*px,imageMAXwidth, imageMAXheight);
            
            //气泡坐标
            //图片拉升不变形
            self.bubbleBackgroundView.image = [self resizableImageWithName:@"聊天气泡右"];
            //气泡宽度
            CGFloat bgwindth = self.messageImageView.width+ 13.0*px;
            CGFloat bgheight = self.messageImageView.frame.size.height+2.0*px;
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


//图片点击
- (void)tapGestureAction {
#pragma mark ===================== 点击查看原图 =======================
    //收到的图片（网址)
    //如果加载完后拿不到所有图片数组，就查看当前点击的图片
    //控制器跳转
    JZAlbumViewController *jzAlbumVC = [[JZAlbumViewController alloc]init];
    //当前点击图片的索引
    jzAlbumVC.currentIndex = 0;
    
//    NSLog(@"%@==%@==%@",self.model.thumbnailImage,self.model.imageUrl,self.model.originalImage);

    //imgArr可以为url数组, 可以为urlString 数组, 可以为二进制 UIImage 数组
    if ([NSString isNULL:self.model.imageUrl]&&self.model.messageType==1) {
        //自己发送的图片，不是历史图片,是缩略图
        jzAlbumVC.imgArr = [NSMutableArray arrayWithArray:@[self.model.thumbnailImage]];
        
    }else if(self.model.messageType==1&&[NSString isNULL:self.model.imageUrl]==NO){
        //自己发送的历史图片（沙盒路径）
        //读取本地图片
        UIImage *imgFromUrl=[[UIImage alloc]initWithContentsOfFile:self.model.imageUrl];
        if (imgFromUrl) {
            
            jzAlbumVC.imgArr = [NSMutableArray arrayWithArray:@[imgFromUrl]];
        }else{
            //不存在就显示缩略图，模拟器
             jzAlbumVC.imgArr = [NSMutableArray arrayWithArray:@[self.model.thumbnailImage]];
        }
        
    }else if(self.model.messageType==2&&[NSString isNULL:self.model.imageUrl]==NO){
       //收到的网路图片
        jzAlbumVC.imgArr = [NSMutableArray arrayWithArray:@[self.model.imageUrl]];
        
    }
    
    if (jzAlbumVC.imgArr.count>0) {
        
        [[self parentController].navigationController presentViewController:jzAlbumVC animated:NO completion:nil];
        
    }else{
        [DWBToast showCenterWithText:@"图片不存在"];
        return;
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
    
    //图片
    UIImageView * messageImageView = [[UIImageView alloc] init];
    self.messageImageView = messageImageView;
    [messageImageView setContentMode:UIViewContentModeScaleAspectFill];
    messageImageView.userInteractionEnabled = YES;
    messageImageView.layer.cornerRadius = 6;
    messageImageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    [messageImageView addGestureRecognizer:tapGesture];
    [bubbleBackgroundView addSubview:messageImageView];
    
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
    //赋值内容
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
