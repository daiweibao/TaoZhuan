//
//  GXJChatListController.m
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/19.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "GXJChatListController.h"
#import "ChatListCell.h"
#import "ChatListModel.h"
#import "GXJChatViewController.h"
//后台获取的用户资料
#import "GXJChatUserInfo.h"

@interface GXJChatListController ()<UITableViewDelegate,UITableViewDataSource>
//创建tableview
@property (nonatomic,strong) UITableView * tableView;
//数据
@property (nonatomic,strong) NSMutableArray * dataSouce;
//系统消息
@property (nonatomic,strong) NSMutableArray * dataSouceThree;
//空白页
@property (nonatomic,strong)UIImageView *blankPagesIcon;
@property (nonatomic,strong)UILabel *blankPagesTitle;
@end

@implementation GXJChatListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"聊天消息列表";
    //创建tableview
    [self tableView];
    
    //从融云获取聊天列表，然后在从后台获取用户资料
    [self getRCDChatListInfo:nil];
    
    //刷新
    [self refresh];
    
    
    //App程序从后台启动==>>进入前台时的通知(删者必死)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    //程序从前台进入==>>后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive) name:UIApplicationWillResignActiveNotification object:nil];
    
    //接收到聊天消息内容【重要】
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RicveMessageContent:) name:@"RicveRCIDChatMessageContent" object:nil];
}

//程序从前后台进入==>>前台
-(void)appWillEnterForeground{
}

//程序从前台进入==>>后台
-(void)appBecomeActive{
}


// 上拉下拉刷新
- (void)refresh {
    //自己封装的MJ刷新
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.tableView refreshHeader:^{
        //获取数据
        [self getRCDChatListInfo:nil];
   
    }];
    
}
-(NSMutableArray *)dataSouceThree{
    if (!_dataSouceThree) {
        _dataSouceThree = [NSMutableArray array];
    }
    return _dataSouceThree;
}


#pragma mark ======== 接收到融云聊天消息，项目中统一在AppDelegate设置一处监听就可以了 ==========
-(void)RicveMessageContent:(NSNotification *)notification{
    RCMessage * message  = notification.object;
    //收到消息后插入一条（主要是用户停留在当前界面时用）
    ChatListModel * modelList;
    //是否是新用户(初始化是)
    BOOL isNewUser = YES;
    for (int i = 0; i < self.dataSouce.count; i++) {
        modelList = self.dataSouce[i];
        if ([message.targetId isEqual:modelList.userId]) {
            //是老用户
            isNewUser = NO;
            //结束循环
            break;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (isNewUser==YES) {
            //是新用户,刷新数据，重新请求服务器数据
            [self getRCDChatListInfo:nil];
            
        }else{
            //老用户，把该条数据放到最前面
            [self receivedOldUserInfo:message];
        }
    });
}

//收到老用户消息
-(void)receivedOldUserInfo:(RCMessage *)message{
    
    for (int i = 0; i< self.dataSouce.count; i++) {
       ChatListModel * modelList = self.dataSouce[i];
        if ([message.targetId isEqual:modelList.userId]) {
            //用户ID
            modelList.userId = message.targetId;
            //最后一条消息时间
            modelList.lastSentTime = message.sentTime;
            //未读消息数量
            modelList.unreadMessageCount = modelList.unreadMessageCount+1;
            //发送成功(不显示状态)
            modelList.messageState = 2;
            
            //下面获取最后一条消息内容
            //文本消息
            if ([message.content isMemberOfClass:[RCTextMessage class]]) {
                RCTextMessage *textMessage = (RCTextMessage *)message.content;
                modelList.lastContent = textMessage.content;
                
            }else if ([message.content isMemberOfClass:[RCImageMessage class]]){
                //图片消息
                //                RCImageMessage *textMessage = (RCImageMessage *)conversation.lastestMessage;
                modelList.lastContent = @"[图片]";
                
            }else if ([message.content isMemberOfClass:[RCVoiceMessage class]]){
                //语音消息
                //                RCVoiceMessage *textMessage = (RCVoiceMessage *)conversation.lastestMessage;
                modelList.lastContent = @"[语音]";
                
            }else if ([message.content isMemberOfClass:[RCRichContentMessage class]]){
                //分享消息
                RCRichContentMessage *textMessage = (RCRichContentMessage *)message.content;
                modelList.lastContent = [NSString stringWithFormat:@"[连接]%@",textMessage.title];
                
            }
          
            //移除老数据
            [self.dataSouce removeObjectAtIndex:i];
            //放到第一位
            [self.dataSouce insertObject:modelList atIndex:0];
            
            //结束循环
            break;
        }
    
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新表格
        [self.tableView reloadData];
        
    });

}


-(void)pressButtonLeft{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)dataSouce{
    
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

//获取会话列表（只获取单聊、客服）
- (void)getRCDChatListInfo:(NSString*)type{
    
    NSArray *conversationList = [[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE)]];
    
   //存放数据源
    NSMutableArray * marray = [NSMutableArray array];
  
    //获取所有用户ID
    NSMutableString * mstrUserIdList = [NSMutableString string];
    
    for (RCConversation *conversation in conversationList) {
        ChatListModel * modelList = [[ChatListModel alloc]init];
        //用户ID
        modelList.userId = conversation.targetId;
        
        //字符串追加(用逗号隔开)
        [mstrUserIdList appendString:[NSString stringWithFormat:@"%@,",conversation.targetId]];
        
        //最后一条消息时间
        modelList.lastSentTime = conversation.sentTime;
        //未读消息数量
        modelList.unreadMessageCount = conversation.unreadMessageCount;
        if (conversation.lastestMessageDirection==MessageDirection_SEND) {
            //发送
            //消息发送状态
            if (conversation.sentStatus==SentStatus_SENDING) {
                //发送中
                modelList.messageState = 0;
                
            }else if (conversation.sentStatus==SentStatus_FAILED){
                //发送失败
                modelList.messageState = 1;
            }else{
                //发送成功
                modelList.messageState = 2;
            }
            
        }else{
            //发送成功(不显示状态)
            modelList.messageState = 2;
            
        }
        //下面获取最后一条消息内容
        //文本消息
        if ([conversation.lastestMessage isMemberOfClass:[RCTextMessage class]]) {
            RCTextMessage *textMessage = (RCTextMessage *)conversation.lastestMessage;
            modelList.lastContent = textMessage.content;
            
            
        }else if ([conversation.lastestMessage isMemberOfClass:[RCImageMessage class]]){
            //图片消息
            //                RCImageMessage *textMessage = (RCImageMessage *)conversation.lastestMessage;
            modelList.lastContent = @"[图片]";
            
        }else if ([conversation.lastestMessage isMemberOfClass:[RCVoiceMessage class]]){
            //语音消息
            //                RCVoiceMessage *textMessage = (RCVoiceMessage *)conversation.lastestMessage;
            modelList.lastContent = @"[语音]";
            
        }else if ([conversation.lastestMessage isMemberOfClass:[RCRichContentMessage class]]){
            //分享消息
            RCRichContentMessage *textMessage = (RCRichContentMessage *)conversation.lastestMessage;
            modelList.lastContent = [NSString stringWithFormat:@"[连接]%@",textMessage.title];
            
        }
        //添加到数组
        [marray addObject:modelList];
        
    }

    //去后台请求用户资料
    [self laodAfnUserInfoAndRCDinfoArray:marray AnduseList:mstrUserIdList];
}


//根据ID从后台获取用户资料（在这里刷新数据源）
-(void)laodAfnUserInfoAndRCDinfoArray:(NSMutableArray*)mArray AnduseList:(NSString *)userIdList{
    //向服务器请求用户数据(最后一个有逗号)
    NSDictionary * dict = @{@"userIdList":userIdList};
//    KEFU150406475516502
//    NSLog(@"后台请求用户ID：%@",userIdList);
    if ([NSString isNULL:userIdList]) {
        //为空就移除加载中（这里删者必死）
        [LoadingView removeLoadingController:self];
        //没有Id就不请求数据
        //结束刷新
        [self.tableView endRefresh_DWB];
        
#pragma mark ========== 空白页 ==================
        //移除
        [self.blankPagesIcon removeFromSuperview];
        [self.blankPagesTitle removeFromSuperview];
        //打开刷新脚步
        self.tableView.mj_footer.hidden = NO;
        if (self.dataSouce.count==0) {
            //图标
            self.blankPagesIcon = [[UIImageView alloc] init];
            self.blankPagesIcon.frame = CGRectMake((SCREEN_WIDTH/2 - 125.0*px), MC_NavHeight+200.0*px, 250.0*px, 273.0*px);
            self.blankPagesIcon.image = [UIImage imageNamed:@"空白页icon"];
            [self.tableView addSubview: self.blankPagesIcon];
            //标题
            self.blankPagesTitle = [[UILabel alloc]init];
            self.blankPagesTitle.frame = CGRectMake(0, CGRectGetMaxY(self.blankPagesIcon.frame)+32.0*px, SCREEN_WIDTH, 12);
            self.blankPagesTitle.text = @"暂无新消息哦";
            self.blankPagesTitle.textAlignment = NSTextAlignmentCenter;
            self.blankPagesTitle.font = [UIFont systemFontOfSize:12];
            self.blankPagesTitle.textColor = [UIColor colorWithHexString:@"#898989"];
            [self.tableView addSubview:self.blankPagesTitle];
            //影藏刷新脚步
            self.tableView.mj_footer.hidden = YES;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
        
        return;
    }
    
    [GXJAFNetworking POST:getChatUserInfo parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"]isEqual:@"00"]) {
//            NSLog(@"刷新AFN");
            NSArray * array = responseObject[@"result"];
            for (int i = 0; i< array.count;i++) {
                //解析数据,得到用户资料
                GXJChatUserInfo * modelUser = [[GXJChatUserInfo alloc]init];
                [modelUser mj_setKeyValues:array[i]];
                //双层循环遍历，把资料和Id对上
                for (int j = 0; j< mArray.count;j++) {
                    ChatListModel * modelList = mArray[j];
                    if ([modelUser.userId isEqual:modelList.userId]) {
                        modelList.name = modelUser.nickName;
                        modelList.portraitUri = modelUser.image;
                        //类型
                        modelList.type = modelUser.type;
                        //头像昵称设置完成后数组替换
                        mArray[j]=modelList;
                    }
                }
            }
            
            //从后台请求到数据处理完后在移除数据源、替换数据刷新表格
            [self.dataSouce removeAllObjects];
            NSArray * dataArray = mArray;
            [self.dataSouce addObjectsFromArray:dataArray];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //移除加载中
                [LoadingView removeLoadingController:self];
                //结束刷新
                [self.tableView endRefresh_DWB];
                //刷新表格
                [self.tableView reloadData];
                
            });
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}


//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) style:UITableViewStyleGrouped];
        //iOS11、iPhoneX适配
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor whiteColor];
        //tableview拖动时收起键盘
//        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //去掉分割线
//        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [self.view addSubview:_tableView];
        
        //加载中+ 封装方法，loadingView：传入控制器 isCreateBack：是否创建返回键，viewMaxY：加载中控件的最大Y值，viewHeight：控件高度
        [LoadingView loadingView:self isCreateBack:NO viewMaxY:SCREEN_HEIGHT viewHeight:SCREEN_HEIGHT-MC_NavHeight];

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
    return 60;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}


//脚
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建UI
    static NSString *identifier = @"cellChatList";
    ChatListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[ChatListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        /* 忽略点击效果 */
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    
    //融云消息
    if (self.dataSouce.count>0) {
        
        ChatListModel * modelList = self.dataSouce[indexPath.row];
        //传值
        cell.model = modelList;
    }
    
    //cell标识传过去（放在最后面）
    cell.intex = indexPath.row;
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatListModel * modelList = self.dataSouce[indexPath.row];
    //进入融云聊天
    GXJChatViewController * ChatVC = [[GXJChatViewController alloc]init];
    //别人的ID
    ChatVC.userIdOther = modelList.userId;
    //聊天对象的名字
    ChatVC.userNameOther = modelList.name;
    //聊天对象头像
    ChatVC.userImageOther = modelList.portraitUri;
    //普通用户 ==> 普通用户
    ChatVC.chatType = nil;
    [ChatVC setRefreshChatList:^{
        //刷新数据
        [self getRCDChatListInfo:nil];
    }];
    [self.navigationController pushViewController:ChatVC animated:YES];
}

#pragma mark ========== tableview侧滑删除 S===================
//开启tableview的编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    //开启侧滑删除
    return YES;
    
}
//侧滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        [self.dataSouce removeObjectAtIndex:indexPath.row];//删除数据源当前行数据
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationNone];
    }
    
}
//如果想在侧拉的时候显示是中文的删除，只需要用下面的方法替换掉上面的方法就好了
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){//title可自已定义
        [AlertViewTool AlertWXSheetToolWithTitle:@"确定删除该会话吗？" otherItemArrays:@[@"删除"] ShowRedindex:-1 CancelTitle:@"取消" handler:^(NSInteger index) {
            if (index==0) {
                ChatListModel * modelList = self.dataSouce[indexPath.row-3];
                //单聊
                //                        此方法会从本地存储中删除该会话，但是不会删除会话中的消息。
                [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:modelList.userId];
                //                         清除某个会话中的未读消息数
                [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:ConversationType_PRIVATE targetId:modelList.userId];
                //刷新表格
                [self.dataSouce removeObjectAtIndex:indexPath.row-3];//删除数据源当前行数据
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }];
    return @[deleteRoWAction];
}

#pragma mark ========== tableview侧滑删除 E===================



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   
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
