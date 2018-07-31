//
//  ChuanYiJieHuoListController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/9/14.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "PeanutServiceListController.h"
#import "ChuanYiJieHuoCell.h"
#import "AskModel.h"
#import "GXJChatViewController.h"

@interface PeanutServiceListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation PeanutServiceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.titleLabel.text = @"客服";
    [self tableView];
}

//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_tableView];
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
        
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseID = @"chuanYiJieHuoCell";
    ChuanYiJieHuoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[ChuanYiJieHuoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.index = indexPath.row;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 15 + 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (SESSIONID.length == 0) {
        //跳到登陆界面
      
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
        return;
    }

        //进入融云聊天(达人聊天)
        GXJChatViewController * ChatVC = [[GXJChatViewController alloc]init];
    
    if (indexPath.row==0) {
        
        ChatVC.userIdOther = @"2";
        ChatVC.userNameOther = @"人工客服一";
        ChatVC.userImageOther = @"客服一";
        
    }else{
        
        ChatVC.userIdOther = @"3";
        ChatVC.userNameOther = @"人工客服二";
        ChatVC.userImageOther = @"客服二";
    }
    //客服聊天进入普通用户聊天界面
    ChatVC.chatType = nil;
    [self.navigationController pushViewController:ChatVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end


