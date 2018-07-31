//
//  GXJChatViewController.m
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/6/27.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "GXJChatViewController.h"
//融云聊天
#import <RongIMLib/RongIMLib.h>
//文字消息cell
#import "RCMyTextMessageCell.h"
//图片消息cell
#import "RCMyImageMessageCell.h"
//语音消息cell
#import "RCMyVoiceMessageCell.h"
//自定义分享消息cell
#import "RCDShareMessageCell.h"
//自定义分享消息模型
#import "RCDShareMessage.h"
//第三方输入框
#import "STInputBar.h"
//消息内容
#import "RCmessageContentModel.h"

//照片多选
#import "TZImagePickerController.h"
//语音播放
#import <AVFoundation/AVFoundation.h>

@interface GXJChatViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,AVAudioPlayerDelegate>

//是客服还是普通聊天模式
@property(nonatomic,assign)NSInteger RCIMChatType;
//发送消息框
@property(nonatomic,strong)STInputBar * inputBar;
//创建tableview
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataSouce;
//语音播放器对象
@property (nonatomic, strong) AVAudioPlayer *player;
//播放
@property (nonatomic, strong) AVAudioSession *session;
/**
 语音播放按钮
 */
@property (nonatomic, weak) UIButton *messageVoiceButton;
//语音cellmodel，点击播放用
@property(nonatomic,strong)RCmessageContentModel * modelAction;


@end

@implementation GXJChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //设置标题
     self.backButton.hidden = NO;//返回
     self.titleLabel.text = self.userNameOther;
    
    //图文消息，暂时屏蔽
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.backButton = backButton;
//    backButton.frame = CGRectMake(0, 0, 17, 44);
//    backButton.contentMode = UIViewContentModeScaleAspectFill;
//    backButton.clipsToBounds = YES;
//    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(pressButtonLeftRight) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //播放器初始化(断点会崩溃到这里，去掉断点就没事)
    self.session =[AVAudioSession sharedInstance];
    
    //创建tableview
    [self tableView];
    
    //创建输入框
    [self createInputBar];
    
    //tableview坐标
    self.tableView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-50-MC_TabbarSafeBottomMargin);
    
#pragma mark ======== 客服 ==========
    if ([self.chatType isEqual:@"客服"]) {
      //会话类型（客服）
        self.RCIMChatType = ConversationType_CUSTOMERSERVICE;
        
        //登陆客服
        [self loginKefu];
    
    }else{
        //会话类型（单聊）
        self.RCIMChatType = ConversationType_PRIVATE;
        
        //获取历史消息
        [self getHostChatInfoAndKefuChatInfo];
    }
    
    
    //App程序从后台启动==>>进入前台时的通知(删者必死)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];

    //程序从前台进入==>>后台
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive) name:UIApplicationWillResignActiveNotification object:nil];
    
    //接收到聊天消息内容【重要】
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RicveMessageContent:) name:@"RicveRCIDChatMessageContent" object:nil];
}

//获取历史消息总类
-(void)getHostChatInfoAndKefuChatInfo{
    //获取聊天历史消息
    [self getRCIMHostChat];
    
    //tableview滚动到最底部
    [UIView scrollTableToFoot:self.tableView Animated:NO];

}

#pragma mark ========== 客服处理（仅仅人工客服）==开始 ============
-(void)loginKefu{
    [[RCIMClient sharedRCIMClient] startCustomerService:self.userIdOther info:nil onSuccess:^(RCCustomerServiceConfig *config) {
        
        NSLog(@"客服连接成功");
        //从机器人客服切换到人工客服（机器人客服优先模式使用）
//        [[RCIMClient sharedRCIMClient] switchToHumanMode:self.userIdOther];
        
        //获取历史消息
        [self getHostChatInfoAndKefuChatInfo];
        
//        [DWBToast showCenterWithText:@"客服连接成功"];
        
    } onError:^(int errorCode, NSString *errMsg) {
        //         发起客服会话失败的回调 [errorCode:失败的错误码 errMsg:错误信息]
        [AlertGXJView AlertGXJAlertWithController:self Title:errMsg Message:nil otherItemArrays:@[@"返回"] Width:-1 Type:-1 handler:^(NSInteger index) {
            [self pressButtonLeft];
        }];
    } onModeType:^(RCCSModeType mode) {
//       客服模式变化
        if (mode==RC_CS_NoService) {
//            [DWBToast showCenterWithText:@"当前无在线客服服务"];
            NSLog(@"当前无在线客服服务");
        }else if (mode==RC_CS_RobotOnly){
            NSLog(@"机器人客服");
           
        }else if (mode==RC_CS_HumanOnly){
             NSLog(@"人工客服");
            
        }else if (mode==RC_CS_RobotFirst){
            NSLog(@"机器人优先服务");
        }
    } onPullEvaluation:^(NSString *dialogId) {
//         客服请求评价
    } onSelectGroup:^(NSArray<RCCustomerServiceGroupItem *> *groupList) {
//        客服分组选择 
    } onQuit:^(NSString *quitMsg) {
//        客服被动结束。如果主动调用stopCustomerService，则不会调用到该block
          NSLog(@"客服被动结束");
    }];
    
    
}
#pragma mark ========== 客服处理==结束 ============

//程序从前后台进入==>>前台
-(void)appWillEnterForeground{
}

//程序从前台进入==>>后台
-(void)appBecomeActive{
}


//发送分享消息
-(void)pressButtonLeftRight{
    
    [self senderShareRCtitle:@"我是标题发生大法师当地广东佛山功夫大使馆地方撒割发代首" Content:@"我是内容发多少滚动时法规发生的不发生的股份收到过发多少割发代首" ShareUrl:@"我是分享连接"];
}

//程序从后台启动进入前台时开始播放
- (void)appWillEnterForeground:(NSNotification*)note{
    //关闭键盘
    [self CloseKeyBody];
}

//返回
-(void)pressButtonLeft{
    
    //刷新聊天列表数据
    if (self.refreshChatList) {
        self.refreshChatList();
    }
    
    //客服要退出客服界面
    if ([self.chatType isEqual:@"客服"]) {
        //退出客服（结束会话）
//        [[RCIMClient sharedRCIMClient] stopCustomerService:self.userIdOther];
        
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
    
    //清除
    self.session = nil;
}



//创建输入框
-(void)createInputBar{
    
    
    //    inputBar最后创建
    if(self.inputBar == nil){
        _inputBar = [STInputBar inputBar];
        _inputBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _inputBar.typeString = @"融云聊天";
        _inputBar.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.bounds)-CGRectGetHeight(_inputBar.frame)+CGRectGetHeight(_inputBar.frame)/2 - MC_TabbarSafeBottomMargin);
        [_inputBar setFitWhenKeyboardShowOrHide:YES];
        _inputBar.placeHolder = @"";
        _inputBar.userInteractionEnabled = YES;
        [_inputBar addTapActionTouch:^{
            //点击事件，拦截，不要删
        }];
        [self.view addSubview:_inputBar];
        //移动到最上层
        [self.view bringSubviewToFront:_inputBar];
    }
    __weak typeof(self) weakSelf = self;
    
    //点击时得到键盘高度
    [_inputBar setGetKeyboardHeight:^(CGFloat KeyBoardHeight){
        
//        NSLog(@"键盘高度：%f",KeyBoardHeight);
        [UIView animateWithDuration:0.35 animations:^{
            //重置输入框坐标
            weakSelf.inputBar.center = CGPointMake(CGRectGetWidth(weakSelf.view.frame)/2, CGRectGetHeight(weakSelf.view.bounds)-CGRectGetHeight(_inputBar.frame)+CGRectGetHeight(_inputBar.frame)/2 -KeyBoardHeight);
            
            //正常聊天
            weakSelf.tableView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-50-KeyBoardHeight);
            
        }completion:^(BOOL finished) {
            //tableview滚动到最底部
            [UIView scrollTableToFoot:weakSelf.tableView Animated:NO];
        }];
        
    }];
    
    

    //回复按钮点击事件
    [_inputBar setDidSendClicked:^(NSString *text) {
        
        //去掉首尾空格和回车
        text = [NSString removeStringTwoSpace:text];
        
        if (text.length>0) {
            
#pragma mark =========== 融云聊天与融云直播的冲突，包含这些关键词都不允许发送 ====================
            if ([text containsString:@"&&%%##"]||[text containsString:@"&&&%%$$$"]||[text containsString:@"$$senderGoods##"]) {
                //包含这个不允许发送
                 [DWBToast showCenterWithText:@"内容含有非法字符"];
               
            }else{
                //向融云发送消息
                [weakSelf senderInfoContent:text];
                
            }
            
        }else{
            
            [DWBToast showCenterWithText:@"消息不能为空"];
            
        }
        
    }];
    
    //结束编辑时框里的内容
    [_inputBar setEndEidt:^(NSString *string){
        //重置输入框坐标
        weakSelf.inputBar.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.bounds)-CGRectGetHeight(_inputBar.frame)+CGRectGetHeight(_inputBar.frame)/2 - MC_TabbarSafeBottomMargin);
        //动画,iphonex先不开动画
//        [UIView animateWithDuration:0.35 animations:^{
        
        //正常聊天
        weakSelf.tableView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-50-MC_TabbarSafeBottomMargin);
//        }completion:^(BOOL finished) {
//
//        }];
        
        if (string.length==0) {
            //            weakSelf.tage = 0;
            weakSelf.inputBar.placeHolder = @"";
        }
    }];
    
#pragma mark ========== 点击选择照片 ===================
    [_inputBar setClickPhoneChoose:^{
        //照片
        [weakSelf actionChoosePhone];
    }];
#pragma mark ========== 按住录音得到录音文件 ===================
    [_inputBar.buttonAudioView setGetAudioPathURL:^(NSURL * urlAudio,long duration){
        //得到录音文件路径，和录音时长
         NSData* dataAudio= [NSData dataWithContentsOfFile:urlAudio.path];
        [weakSelf senderVoiceRCInfo:dataAudio Duration:duration];
        
    }];
    
    //按下录音键盘，停止播放
    [_inputBar.buttonAudioView setDownButtonPlay:^{
        [weakSelf stopPlayMy];
    }];
    
}



//得到融云历史聊天消息
-(void)getRCIMHostChat{
    //    此方法会获取该会话中指定数量的最新消息实体，返回的消息实体按照时间从新到旧排列。
    //    如果会话中的消息数量小于参数count的值，会将该会话中的所有消息返回。
    NSArray * messageHostArray = [[RCIMClient sharedRCIMClient] getLatestMessages:self.RCIMChatType targetId:self.userIdOther count:1000];
    //解析消息
    for (int i = 0; i < messageHostArray.count; i++) {
        RCMessage *message = [messageHostArray objectAtIndex:i];
        RCmessageContentModel * modelMessage = [[RCmessageContentModel alloc]init];
        //聊天对象头像可点击
        modelMessage.isActionPhone = YES;
        //聊天Id
        modelMessage.userIdOther = self.userIdOther;
        //1是发送，2是接收
        modelMessage.messageType = message.messageDirection;
        //消息的发送状态
        modelMessage.messageSendState = message.sentStatus;
        //消息的接收状态
        modelMessage.messageReceiveState = message.receivedStatus;
        //消息接收时间
        modelMessage.receivedTime = message.receivedTime;
        //消息发送时间
        modelMessage.sentTime = message.sentTime;
        
        //设置消息ID
        modelMessage.messageId = message.messageId;
        
        if (message.messageDirection==MessageDirection_SEND) {
            //发送者资料
            modelMessage.userId = USERID;
            modelMessage.name = USER_name;
            modelMessage.portraitUri = USER_PhoneImage;
        }else{
            //聊天对象资料
            modelMessage.userId = self.userIdOther;
            modelMessage.name = self.userNameOther;
            modelMessage.portraitUri = self.userImageOther;
            
            //聊天对象头像可点击
            modelMessage.isActionPhone = YES;
            
        }
        
        
        if ([message.content isMemberOfClass:[RCTextMessage class]]) {
            //消息类型,文字消息、图片消息、语音消息
            RCTextMessage *ricveMessage = (RCTextMessage *)message.content;
            //消息类型
            modelMessage.contentType = @"文字消息";
            //内容
            modelMessage.content = ricveMessage.content;
           
        }else if ([message.content isMemberOfClass:[RCImageMessage class]]) {
            //消息类型,文字消息、图片消息、语音消息
            RCImageMessage *ricveMessage = (RCImageMessage *)message.content;
            //消息类型
            modelMessage.contentType = @"图片消息";
            //图片缩略图
            modelMessage.thumbnailImage = ricveMessage.thumbnailImage;
            modelMessage.imageUrl = ricveMessage.imageUrl;
            modelMessage.originalImage = ricveMessage.originalImage;
            //图片宽高(比例计算小点)
            modelMessage.imageMAXwidth = ricveMessage.thumbnailImage.size.width *2/3;
            modelMessage.imageMAXheight = ricveMessage.thumbnailImage.size.height *3/4;
            
            
        }else if ([message.content isMemberOfClass:[RCVoiceMessage class]]) {
            //消息类型,文字消息、图片消息、语音消息
            RCVoiceMessage *ricveMessage = (RCVoiceMessage *)message.content;
            //消息类型
            modelMessage.contentType = @"语音消息";
            //语音数据
            modelMessage.wavAudioData = ricveMessage.wavAudioData;
            //语音时长
            modelMessage.duration = ricveMessage.duration;
        
            
        }else if ([message.content isMemberOfClass:[RCRichContentMessage class]]) {
            //消息类型,文字消息、图片消息、语音消息
            RCRichContentMessage *ricveMessage = (RCRichContentMessage *)message.content;
            //消息类型
            modelMessage.contentType = @"分享消息";
        
            //标题
            modelMessage.title = ricveMessage.title;
            //内容
            modelMessage.digest = ricveMessage.digest;
            //分享连接
            modelMessage.shareUrl = ricveMessage.url;
           
            
        }
        
        //(接收到的消息,并且未读)消息设置成已读
        if (message.messageDirection==MessageDirection_RECEIVE && message.receivedStatus==ReceivedStatus_UNREAD) {
            //融云设置接收消息的接收状态（已读）
            [[RCIMClient sharedRCIMClient] setMessageReceivedStatus:message.messageId receivedStatus:ReceivedStatus_READ];
        }
        
        //添加数据
        [self.dataSouce addObject:modelMessage];
        
    }
    
    //数组倒序输出（容易历史消息顺序问题）
    self.dataSouce = (NSMutableArray*)[[self.dataSouce reverseObjectEnumerator] allObjects];
    
    //判断时间展示规则,并刷新表格
    [self computeVisibleTimeAndRefreshTable:@"历史消息"];
    
    
}

//计算每条消息是否显示时间
//dataArray:UITableView的数据源
-(void)computeVisibleTimeAndRefreshTable:(NSString *)type{
    RCmessageContentModel *modeTime;
    long long  lastVisibleTime = 0;
    for (int i=0; i<self.dataSouce.count; i++) {
        modeTime = self.dataSouce[i];
        if (i==0) {
            //一定显示时间
            modeTime.isTimeVisible=true;
            //最后的时间
            lastVisibleTime = modeTime.sentTime;
            
        }else{
            
            //计算时间差，毫秒（5分钟）
            long long timeSpan = modeTime.sentTime - lastVisibleTime;
            if (timeSpan>=5*60*1000){
                //一定显示时间
                modeTime.isTimeVisible=true;
                //最后的时间
                lastVisibleTime = modeTime.sentTime;
            }else{
                //不展示时间
                modeTime.isTimeVisible=false;
            }
        }
        //时间设置完成后数组替换
        self.dataSouce[i]=modeTime;
    }
    //刷新表格，判断完时间后的刷新（这里千万不要加主线程）
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        if ([type isEqual:@"历史消息"]) {
            //tableview滚动到最底部
            [UIView scrollTableToFoot:self.tableView Animated:NO];
        }else{
            //tableview滚动到最底部
            [UIView scrollTableToFoot:self.tableView Animated:YES];
            
        }
    });
    
}




//点击照片
-(void)actionChoosePhone{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
#pragma mark 照片选择器===================
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    //是否显示原图，聊天设置不显示，否则内存过大崩溃
    imagePickerVc.isSelectOriginalPhoto = NO;
  
 
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
      /// 默认为YES，如果设置为NO,原图按钮将隐藏，用户不能选择发送原图(聊天界面暂时不显示)
    imagePickerVc.allowPickingOriginalPhoto = NO;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = NO;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        if (photos.count>0) {
            //发消息（照片写入沙盒路径后在发送，否则内存过大崩溃）
            [self senderImageRCInfo:photos];
        
        }
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


//消息发送者的信息
-(RCUserInfo*)geSenderUser{
    //消息发送者信息
    RCUserInfo *senderUserInfo = [[RCUserInfo alloc]init];
    senderUserInfo.userId = USERID;
    senderUserInfo.name = USER_name;
    senderUserInfo.portraitUri = USER_PhoneImage;
    return senderUserInfo;
}

//融云发文字消息
-(void)senderInfoContent:(NSString*)content{
    
    // 构建消息的内容，这里以文本消息为例。
    RCTextMessage *testMessage = [RCTextMessage messageWithContent:content];
   //消息发送者资料
    testMessage.senderUserInfo = [self geSenderUser];
    
    //自己的cell数据model
    RCmessageContentModel * modelMessage = [[RCmessageContentModel alloc]init];
    //聊天对象头像可点击
    modelMessage.isActionPhone = YES;
    //聊天Id
    modelMessage.userIdOther = self.userIdOther;
    //消息类型
    modelMessage.contentType = @"文字消息";
    
    modelMessage.messageType = 1;
    modelMessage.content = content;
    //用户资料
    modelMessage.userId = USERID;
    modelMessage.name = USER_name;
    modelMessage.portraitUri = USER_PhoneImage;
    
    //消息发送状态(发送中)
    modelMessage.messageSendState = 10;
    //消息发送时间(获取系统时间毫秒数)
    modelMessage.sentTime = [NSString getNowTime_Ms];
    
    //添加数据
    [self.dataSouce addObject:modelMessage];
    
    //判断时间展示规则,并刷新表格
    [self computeVisibleTimeAndRefreshTable:nil];
    
    //清除评论框里的内容
    [self.inputBar DeleteContent];
    
    // 调用RCIMClient的sendMessage方法进行发送，结果会通过回调进行反馈。
    [[RCIMClient sharedRCIMClient] sendMessage:self.RCIMChatType targetId:self.userIdOther content:testMessage pushContent:nil pushData:nil success:^(long messageId) {
        //发送消息的ID
         modelMessage.messageId = messageId;
        //消息发送状态(发送成功)
        modelMessage.messageSendState = 30;
   
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新表格，不需要判断时间
            [self.tableView reloadData];
        });
//        NSLog(@"发送成功。当前消息ID：%ld", messageId);
    } error:^(RCErrorCode nErrorCode, long messageId) {
        //发送消息的ID
        modelMessage.messageId = messageId;
        //消息发送状态(发送失败)
        modelMessage.messageSendState = 20;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新表格，不需要判断时间
            [self.tableView reloadData];
            
        });
        
        NSLog(@"发送失败。消息ID：%ld， 错误码：%ld", messageId, (long)nErrorCode);
    }];
    
}

//融云发送图片消息
-(void)senderImageRCInfo:(NSArray *)photos{
    //        photos是照片数组照片
#pragma mark ============ 选取的照片发送到融云服务器 ========================
    for (UIImage * phoneSender in photos) {

        //照片写入沙盒路径(临时用，离开界面后就不在用)
        NSData* imageData = UIImagePNGRepresentation(phoneSender);
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentsDirectory = [paths objectAtIndex:0];
        //现在我们得到文件的完整路径（读取图片时用这个路径）  self.messageImageView.image = [[UIImage alloc]initWithContentsOfFile:self.model.imageUrl];
        NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:[NSString getNowDateFormat:@"yyyy-MM-dd HH:mm:ss"]];
        //然后我们把它写出来
        [imageData writeToFile:fullPathToFile atomically:NO];
        
        RCImageMessage *imageMessage = [RCImageMessage messageWithImageURI:fullPathToFile];
        //设置full为YES，会发送原图。不设置默认发送经过压缩的图片。(内存过大，不发原图)
        imageMessage.full = NO;
        //消息发送者资料
        imageMessage.senderUserInfo = [self geSenderUser];
        
        //自己的cell数据model
        RCmessageContentModel * modelMessage = [[RCmessageContentModel alloc]init];
        //聊天对象头像可点击
        modelMessage.isActionPhone = YES;
        //聊天Id
        modelMessage.userIdOther = self.userIdOther;
        //消息类型
        modelMessage.contentType = @"图片消息";
        
        modelMessage.messageType = 1;
        //发送图片路径
        modelMessage.imageUrl = fullPathToFile;
        
        //图片宽高(本地发送要除于4.5，否则太大)
        modelMessage.imageMAXwidth = phoneSender.size.width/4.5;
        modelMessage.imageMAXheight = phoneSender.size.height/4.5;
        
        //防止图片显示太小,所以限制个最小显示
        if (phoneSender.size.width/4.5 < 300.0*px) {
            modelMessage.imageMAXwidth = 300.0*px;
        }
        if (phoneSender.size.width/4.5 <200.0*px) {
            modelMessage.imageMAXheight = 200.0*px;
        }
        
   
        //用户资料
        modelMessage.userId = USERID;
        modelMessage.name = USER_name;
        modelMessage.portraitUri = USER_PhoneImage;
        
        //消息发送状态(发送中)
        modelMessage.messageSendState = 10;
        //消息发送时间(获取系统时间毫秒数)
        modelMessage.sentTime = [NSString getNowTime_Ms];
        
        //添加数据
        [self.dataSouce addObject:modelMessage];
        
        [[RCIMClient sharedRCIMClient] sendMediaMessage:self.RCIMChatType targetId:self.userIdOther content:imageMessage pushContent:nil pushData:nil progress:^(int progress, long messageId) {
            //图片发送的进度条
         
            
        } success:^(long messageId) {
            //发送消息的ID
            modelMessage.messageId = messageId;
            //消息发送状态(发送成功)
            modelMessage.messageSendState = 30;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新表格,不需要判断时间
                [self.tableView reloadData];
                
            });
            
        } error:^(RCErrorCode errorCode, long messageId) {
            
            //发送消息的ID
            modelMessage.messageId = messageId;
            //消息发送状态(发送失败)
            modelMessage.messageSendState = 20;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新表格，不需要判断时间
                [self.tableView reloadData];
                
            });
            
        } cancel:^(long messageId) {
            //消息发送状态(发送取消)
            modelMessage.messageSendState = 70;
        }];
        
    }
    
    //判断时间展示规则,并刷新表格（放在循环外面）
     [self computeVisibleTimeAndRefreshTable:nil];
}

#pragma mark ==========融云发送语音消息============
-(void)senderVoiceRCInfo:(NSData *)dataAudio Duration:(long)duration{
    
    RCVoiceMessage *voiceMessage = [RCVoiceMessage messageWithAudio:dataAudio duration:duration];
    //消息发送者资料
    voiceMessage.senderUserInfo = [self geSenderUser];
    
    //自己的cell数据model
    RCmessageContentModel * modelMessage = [[RCmessageContentModel alloc]init];
    //聊天对象头像可点击
    modelMessage.isActionPhone = YES;
    //聊天Id
    modelMessage.userIdOther = self.userIdOther;
    //消息类型
    modelMessage.contentType = @"语音消息";
    
    modelMessage.messageType = 1;
   //语音数据
    modelMessage.wavAudioData = dataAudio;
   //语音时长
    modelMessage.duration = duration;
    //用户资料
    modelMessage.userId = USERID;
    modelMessage.name = USER_name;
    modelMessage.portraitUri = USER_PhoneImage;
    
    //消息发送状态(发送中)
    modelMessage.messageSendState = 10;
    //消息发送时间(获取系统时间毫秒数)
    modelMessage.sentTime = [NSString getNowTime_Ms];
    
    //添加数据
    [self.dataSouce addObject:modelMessage];
    
    //判断时间展示规则,并刷新表格
    [self computeVisibleTimeAndRefreshTable:nil];
    
    //清除评论框里的内容
    [self.inputBar DeleteContent];
    
    //发送语音消息
    [[RCIMClient sharedRCIMClient] sendMessage:self.RCIMChatType targetId:self.userIdOther content:voiceMessage pushContent:nil pushData:nil success:^(long messageId) {
//        NSLog(@"发送语音消息成功");
        //发送消息的ID
        modelMessage.messageId = messageId;
        //消息发送状态(发送成功)
        modelMessage.messageSendState = 30;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新表格，不需要判断时间
            [self.tableView reloadData];
            
        });
    } error:^(RCErrorCode nErrorCode, long messageId) {
        NSLog(@"发送语音消息失败，错误码是(%ld)", (long)nErrorCode);
        //发送消息的ID
        modelMessage.messageId = messageId;
        //消息发送状态(发送失败)
        modelMessage.messageSendState = 20;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新表格，不需要判断时间
            [self.tableView reloadData];
            
        });

    }];
    
}


#pragma merk ========== 融云发送分享消息(富文本消息) ================
-(void)senderShareRCtitle:(NSString*)title Content:(NSString*)content ShareUrl:(NSString*)shareUrl{
    /*!
     初始化公众服务图文信息条目
      title       图文信息条目的标题
      digest      图文信息条目的内容摘要
      imageURL    图文信息条目的图片URL
      url         图文信息条目中包含的需要跳转到的URL
      extra       图文信息条目的扩展信息
     */
    RCRichContentMessage *testMessage = [RCRichContentMessage messageWithTitle:title digest:content imageURL:nil url:shareUrl extra:nil];
    //消息发送者资料
    testMessage.senderUserInfo = [self geSenderUser];
    
    //自己的cell数据model
    RCmessageContentModel * modelMessage = [[RCmessageContentModel alloc]init];
    //聊天对象头像可点击
    modelMessage.isActionPhone = YES;
    //聊天Id
    modelMessage.userIdOther = self.userIdOther;
    //消息类型
    modelMessage.contentType = @"分享消息";
    modelMessage.messageType = 1;
    
    //内容
    modelMessage.title = title;
    modelMessage.digest = content;
    modelMessage.shareUrl = shareUrl;
    //用户资料
    modelMessage.userId = USERID;
    modelMessage.name = USER_name;
    modelMessage.portraitUri = USER_PhoneImage;
    
    //消息发送状态(发送中)
    modelMessage.messageSendState = 10;
    //消息发送时间(获取系统时间毫秒数)
    modelMessage.sentTime = [NSString getNowTime_Ms];
    
    //添加数据
    [self.dataSouce addObject:modelMessage];
    
    //判断时间展示规则,并刷新表格
     [self computeVisibleTimeAndRefreshTable:nil];
    

    // 调用RCIMClient的sendMessage方法进行发送，结果会通过回调进行反馈。
    [[RCIMClient sharedRCIMClient] sendMessage:self.RCIMChatType targetId:self.userIdOther content:testMessage pushContent:nil pushData:nil success:^(long messageId) {
        //发送消息的ID
        modelMessage.messageId = messageId;
        //消息发送状态(发送成功)
        modelMessage.messageSendState = 30;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新表格，不需要判断时间
            [self.tableView reloadData];
            
        });
        
//        NSLog(@"分享发送成功。当前消息ID：%ld", messageId);
        
        
    } error:^(RCErrorCode nErrorCode, long messageId) {
        //发送消息的ID
        modelMessage.messageId = messageId;
        //消息发送状态(发送失败)
        modelMessage.messageSendState = 20;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //刷新表格，不需要判断时间
            [self.tableView reloadData];
            
        });
        
        NSLog(@"发送失败。消息ID：%ld， 错误码：%ld", messageId, (long)nErrorCode);
    }];
    
}



#pragma mark ======== 接收到融云聊天消息，项目中统一在AppDelegate设置一处监听就可以了 ==========
-(void)RicveMessageContent:(NSNotification *)notification{
    RCMessage * message  = notification.object;
    
    
    if (![message.targetId isEqual:self.userIdOther]) {
        NSLog(@"收到第三者发送的消息，不加入该列表");
        return;
    }
    
    RCmessageContentModel * modelMessage = [[RCmessageContentModel alloc]init];
    
    //聊天对象头像可点击
    modelMessage.isActionPhone = YES;
    
    //设置消息ID
    modelMessage.messageId = message.messageId;
    
    //消息接收时间
    modelMessage.receivedTime = message.receivedTime;
    
    //消息发送时间
    modelMessage.sentTime = message.sentTime;
    
    //聊天对象资料
    modelMessage.userId = self.userIdOther;
    modelMessage.name = self.userNameOther;
    modelMessage.portraitUri = self.userImageOther;
    
    if ([message.content isMemberOfClass:[RCTextMessage class]]) {
#pragma mark ======== 收到文字消息 ==========
        RCTextMessage *ricveMessage = (RCTextMessage *)message.content;
      
        //消息类型
        modelMessage.contentType = @"文字消息";
        
        modelMessage.messageType = 2;
        modelMessage.content = ricveMessage.content;
        
//        NSLog(@"收到文字消息：%@",ricveMessage.content);

    
    }else  if ([message.content isMemberOfClass:[RCImageMessage class]]) {
#pragma mark ======== 收到图片消息 ==========
        RCImageMessage *ricveMessage = (RCImageMessage *)message.content;
        //消息类型
        modelMessage.contentType = @"图片消息";
        modelMessage.messageType = 2;
        //图片缩略图
        modelMessage.thumbnailImage = ricveMessage.thumbnailImage;
        modelMessage.imageUrl = ricveMessage.imageUrl;
        modelMessage.originalImage = ricveMessage.originalImage;
        //图片宽高
        modelMessage.imageMAXwidth = ricveMessage.thumbnailImage.size.width *2/3;
        modelMessage.imageMAXheight = ricveMessage.thumbnailImage.size.height *3/4;
        
    } else  if ([message.content isMemberOfClass:[RCVoiceMessage class]]) {
#pragma mark ======== 收到语音消息 ==========
        RCVoiceMessage *ricveMessage = (RCVoiceMessage *)message.content;
        //消息类型
        modelMessage.contentType = @"语音消息";
        modelMessage.messageType = 2;
        //语音数据
        modelMessage.wavAudioData = ricveMessage.wavAudioData;
        //语音时长
        modelMessage.duration = ricveMessage.duration;
      
    } else  if ([message.content isMemberOfClass:[RCRichContentMessage class]]) {
#pragma mark ======== 收到分享消息 ==========
        RCRichContentMessage *ricveMessage = (RCRichContentMessage *)message.content;
        //消息类型
        modelMessage.contentType = @"分享消息";
        modelMessage.messageType = 2;
        //标题
        modelMessage.title = ricveMessage.title;
        //内容
        modelMessage.digest = ricveMessage.digest;
        //分享连接
        modelMessage.shareUrl = ricveMessage.url;
        
    }
    
    //添加数据
    [self.dataSouce addObject:modelMessage];
    
    //判断时间展示规则,并刷新表格
     [self computeVisibleTimeAndRefreshTable:nil];
    
    
//    NSLog(@"还剩余的未接收的消息数：%d", nLeft);
}



//点击关闭键盘
-(void)CloseKeyBody{
    [self.inputBar resignFirstResponder];
}

- (NSMutableArray *)dataSouce{
    
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-50-MC_TabbarSafeBottomMargin) style:UITableViewStyleGrouped];
        //iOS11、iPhoneX适配
        [UIView tablevieiOS11:_tableView isHaveTabbar:YES];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //tableview拖动时收起键盘
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //去掉分割线
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [self.view addSubview:_tableView];
        
        //点击关闭键盘
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CloseKeyBody)];
        [self.tableView addGestureRecognizer:tap];
        
    }
    
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     RCmessageContentModel * model = self.dataSouce[indexPath.row];
    
    //消息发送时间高度
    CGFloat timeHeight = 80.0*px;
    if (model.isTimeVisible==true) {
        timeHeight = 80.0*px;
        
    }else{
        //不展示时间
        timeHeight = 0;
    }
    
    if ([model.contentType isEqual:@"文字消息"]) {
        //汉字坐标
        CGFloat titleMAXwidth =  380.0*px;
        CGSize sizetitle  = [NSString sizeMyStrWith:model.content andFontSize:14 andMineWidth:titleMAXwidth];
        //
        return timeHeight + sizetitle.height+50.0*px + 40.0*px;
        
    }else if ([model.contentType isEqual:@"图片消息"]) {
        //图片高度
        return timeHeight + model.imageMAXheight + 40.0*px;
        
    }else if ([model.contentType isEqual:@"语音消息"]) {
        //语音高度是30
        return timeHeight + 40 + 40.0*px;
        
    }else if ([model.contentType isEqual:@"分享消息"]) {
        //分享cell，框高90
        return timeHeight + 90 + 40.0*px;
        
    }else{
        return 0.01;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}


//脚
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     RCmessageContentModel * modelMessage = self.dataSouce[indexPath.row];
    if ([modelMessage.contentType isEqual:@"文字消息"]) {
#pragma mark ======== 文字消息 ==========
        static NSString *identifier = @"cellChattext";
        RCMyTextMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[RCMyTextMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            /* 忽略点击效果 */
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        //标识传过去
        cell.intex = indexPath.row;
        //内容传过去
        cell.model = self.dataSouce[indexPath.row];
        
        //消息发送失败后重新发送消息
        WeakSelf(self);
        WeakSelf(cell);
        [cell setAgainSendRCInfo:^{
        
            NSString * contentagain = weakcell.model.content;
            //删除本地消息，在重新发送
            [self.dataSouce removeObjectAtIndex:indexPath.row];
            //删除融云消息,按照ID删除
            [[RCIMClient sharedRCIMClient] deleteMessages:@[@(weakcell.model.messageId)]];
            //向融云发送消息
            [weakself senderInfoContent:contentagain];
            
        }];
        
        //删除消息
        [cell setDeleteRCIMInfo:^{
            //删除本地消息
            [self.dataSouce removeObjectAtIndex:indexPath.row];
            //删除融云消息,按照ID删除
            [[RCIMClient sharedRCIMClient] deleteMessages:@[@(weakcell.model.messageId)]];
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新表格，不需要判断时间
                [weakself.tableView reloadData];
                
            });
            
        }];
        
        return cell;
        
    }else  if ([modelMessage.contentType isEqual:@"图片消息"]) {
#pragma mark ======== 图片消息 ==========
        static NSString *identifier = @"cellChatImage";
        RCMyImageMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[RCMyImageMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            /* 忽略点击效果 */
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        //标识传过去
        cell.intex = indexPath.row;
        //内容传过去
        cell.model = self.dataSouce[indexPath.row];
        
        //消息发送失败后重新发送消息
        WeakSelf(self);
        WeakSelf(cell);
        [cell setAgainSendRCInfo:^{
            
            UIImage * againImage = weakcell.model.thumbnailImage;
            //删除本地消息，在重新发送
            [self.dataSouce removeObjectAtIndex:indexPath.row];
            //删除融云消息,按照ID删除
            [[RCIMClient sharedRCIMClient] deleteMessages:@[@(weakcell.model.messageId)]];
            //向融云发送消息
            [weakself senderImageRCInfo:@[againImage]];
            
        }];
        
        //删除消息
        [cell setDeleteRCIMInfo:^{
            //删除本地消息
            [weakself.dataSouce removeObjectAtIndex:indexPath.row];
            //删除融云消息,按照ID删除
            [[RCIMClient sharedRCIMClient] deleteMessages:@[@(weakcell.model.messageId)]];
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新表格，不需要判断时间
                [weakself.tableView reloadData];
                
            });
            
        }];

        
        return cell;
        
    } else  if ([modelMessage.contentType isEqual:@"语音消息"]) {
#pragma mark ======== 图片消息 ==========
        static NSString *identifier = @"cellChatAudio";
        RCMyVoiceMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[RCMyVoiceMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            /* 忽略点击效果 */
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        //标识传过去
        cell.intex = indexPath.row;
        //内容传过去
        cell.model = self.dataSouce[indexPath.row];
        
        //消息点击回调
        WeakSelf(cell);
        WeakSelf(self);
        [cell setActionVoiceButton:^{
            //点击事件
            [weakself ActionbuttonPlaycell:weakcell cellModel:weakcell.model];
            
            
        }];
        
        //消息发送失败后重新发送消息
        [cell setAgainSendRCInfo:^{
            
            NSData * againdataAudio = weakcell.model.wavAudioData;
            long  durationAgain = weakcell.model.duration;
            
            //删除本地消息，在重新发送
            [self.dataSouce removeObjectAtIndex:indexPath.row];
            //删除融云消息,按照ID删除
            [[RCIMClient sharedRCIMClient] deleteMessages:@[@(weakcell.model.messageId)]];
            //向融云发送消息
            [weakself senderVoiceRCInfo:againdataAudio Duration:durationAgain];
            
        }];
        //删除消息
        [cell setDeleteRCIMInfo:^{
            //删除本地消息
            [weakself.dataSouce removeObjectAtIndex:indexPath.row];
            //删除融云消息,按照ID删除
            [[RCIMClient sharedRCIMClient] deleteMessages:@[@(weakcell.model.messageId)]];
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新表格，不需要判断时间
                [weakself.tableView reloadData];
                
            });
            
        }];
        
        return cell;
        
    }else  if ([modelMessage.contentType isEqual:@"分享消息"]) {
#pragma mark ======== 分享消息 ==========
        static NSString *identifier = @"cellChatshare";
        RCDShareMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[RCDShareMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            /* 忽略点击效果 */
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        //标识传过去
        cell.intex = indexPath.row;
        //内容传过去
        cell.model = self.dataSouce[indexPath.row];
        
        //消息发送失败后重新发送消息
        WeakSelf(self);
        WeakSelf(cell);
        [cell setAgainSendRCInfo:^{
            
             NSString * againTitle = weakcell.model.content;
             NSString * againContent = weakcell.model.extra;
             NSString * againShareUrl = weakcell.model.shareUrl;
            
            //删除本地消息，在重新发送
            [self.dataSouce removeObjectAtIndex:indexPath.row];
            //删除融云消息,按照ID删除
            [[RCIMClient sharedRCIMClient] deleteMessages:@[@(weakcell.model.messageId)]];
            //向融云发送消息
            [weakself senderShareRCtitle:againTitle Content:againContent ShareUrl:againShareUrl];
        
            
        }];
        
        //删除消息
        [cell setDeleteRCIMInfo:^{
            //删除本地消息
            [weakself.dataSouce removeObjectAtIndex:indexPath.row];
            //删除融云消息,按照ID删除
            [[RCIMClient sharedRCIMClient] deleteMessages:@[@(weakcell.model.messageId)]];
            dispatch_async(dispatch_get_main_queue(), ^{
                //刷新表格，不需要判断时间
                [weakself.tableView reloadData];
                
            });
            
        }];
        
        return cell;
        
    } else{
        return [UITableViewCell new];
    }
   
}


//播放语音
-(void)ActionbuttonPlaycell:(RCMyVoiceMessageCell*)cell cellModel:(RCmessageContentModel*)model{
 
    //刷新表格，不需要判断时间
    [self.tableView reloadData];

    // 如果是同意下语音正在播放，再次点击就停止播放，否则继续播放
    if ([self.player isPlaying]&&model.messageId==self.modelAction.messageId){
        //停止播放
        [self stopPlayMy];
        NSLog(@"同一条消息停止播放");
        return;
    }
    //播放，先停止播放
    [self.player stop];
    self.player = [[AVAudioPlayer alloc] initWithData:model.wavAudioData error:nil];
    self.player.delegate = self;
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
    

    //刷新表格等待0.35秒后在打开动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (model.messageType==2) {
            //播放图片
            [self playAudioAnimon:@[[UIImage imageNamed:@"语音左3"],
                                    [UIImage imageNamed:@"语音左1"],
                                    [UIImage imageNamed:@"语音左2"],
                                    [UIImage imageNamed:@"语音左3"]
                                    ] And:cell.messageVoiceButton];
            
        }else if (model.messageType==1){
            //播放图片
            [self playAudioAnimon:@[[UIImage imageNamed:@"语音右3"],
                                    [UIImage imageNamed:@"语音右1"],
                                    [UIImage imageNamed:@"语音右2"],
                                    [UIImage imageNamed:@"语音右3"]
                                    ] And:cell.messageVoiceButton];
        }
        
    });
    
  
    
    //语音播放按钮
    self.messageVoiceButton = cell.messageVoiceButton;
    //model（在后面赋值，前面要做判断）
    self.modelAction = model;
    
}

//播放动画
-(void)playAudioAnimon:(NSArray*)imageS And:(UIButton*)button{
    
    //语音图标动画播放
    button.imageView.animationImages = imageS;
    button.imageView.animationDuration = 1.0;
    [button.imageView startAnimating];
}

#pragma mark - AVAudioPlayerDelegate语音播放完毕代理
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //停止播放
    [self stopPlayMy];
}

//停止播放和动画
-(void)stopPlayMy{
    //停止播放
    [self.player stop];
    //语音播放完-停止动画
    [self.messageVoiceButton.imageView stopAnimating];
    //语音播放完毕
    self.messageVoiceButton.imageView.image = nil;
    
    if (self.modelAction.messageType==2) {
        [self.messageVoiceButton setImage:[UIImage imageNamed:@"语音左3"] forState:UIControlStateNormal];
        
    }else if (self.modelAction.messageType==1){
        [self.messageVoiceButton setImage:[UIImage imageNamed:@"语音右3"] forState:UIControlStateNormal];
    }

}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击
    
}

//滚动监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //移除菜单
     [[NSNotificationCenter defaultCenter]postNotificationName:@"removeMenu" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"聊天界面走了dealloc");
}
//将要出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    //是否在状态栏展示聊天消息，程序启动默认展示
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isShowRCIMChatStatusBar"];
    [[NSUserDefaults standardUserDefaults] synchronize]; //保证数据存储成功

}
//将要消失
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //停止播放
    [self stopPlayMy];
    
    //是否在状态栏展示聊天消息，程序启动默认展示
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isShowRCIMChatStatusBar"];
    [[NSUserDefaults standardUserDefaults] synchronize]; //保证数据存储成功
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
