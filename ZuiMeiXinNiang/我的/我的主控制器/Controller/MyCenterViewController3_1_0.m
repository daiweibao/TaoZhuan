//
//  MyCenterViewController3_1_0.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/2/15.
//  Copyright © 2017年 zmxn. All rights reserved.
//

#import "MyCenterViewController3_1_0.h"
#import <CoreImage/CoreImage.h>
//个人中心头部
#import "MyCenterheader3_1_0.h"
//关于嗅美
#import "AboutMyViewController.h"
//意见反馈
#import "AdviceViewController.h"
//帮助
#import "HelpViewController.h"

#import "PeanutOrderListController.h"//花生订单
#import "WonderfulActivitiesController.h"//精彩活动
#import "PeanutInviteFriendController.h"

//大转盘
#import "TurntableViewController.h"


@interface MyCenterViewController3_1_0 ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)UIView *typeView;//底部分类

@property(nonatomic,strong)MyCenterheader3_1_0 * HeaderView;
@property(nonatomic,assign)CGFloat HeaderViewH;//头部高度

@end

@implementation MyCenterViewController3_1_0

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (iPhoneX) {
        self.HeaderViewH = 180+44+85+(MC_StatusBarHeight-20);//头部高度
    }else{
        self.HeaderViewH = 180+44+85;//头部高度
    }
    
    //先创建头部
    [self HeaderView];
    //在创建tableview
    [self tableView];
    
    // 监听UITabBarItem被重复点击时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarDidClick) name:@"LLTabBarDidClickNotification" object:nil];
    
}

//双击tabbar
- (void)tabBarDidClick{
    // 如果本控制器的view显示在最前面，就下拉刷新（必须要判断，否点击其他tabbar也会触发刷新）
    if ([UIView isViewAddWindowUp:self.view]==YES) {
        //必须在主线程，否则会死
        dispatch_async(dispatch_get_main_queue(), ^{
            //滚到顶部
            [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
            //刷新头部
            [self.HeaderView loadData];
        });
    }
}

//滚动视图下拉头部变大
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取偏移量
    CGPoint offset = scrollView.contentOffset;
    CGRect rect = self.HeaderView.bgView.frame;
    if (offset.y < 0) {
        //我们只需要改变图片的y值和高度即可
        rect.origin.y = offset.y;
        
        if (iPhoneX) {
           rect.size.height = 180+(MC_StatusBarHeight-20) - offset.y;
        }else{
            rect.size.height = 180 - offset.y;
        }
        self.HeaderView.bgView.frame = rect;
    }
}

//tableView的头
-(MyCenterheader3_1_0 *)HeaderView{
    if (!_HeaderView) {
        _HeaderView = [[MyCenterheader3_1_0 alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.HeaderViewH)];
    }
    return _HeaderView;
}

//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-MC_TabbarHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
//        _tableView.bounces = NO;
        //关闭垂直滚动条
        _tableView.showsVerticalScrollIndicator=NO;
        //背景
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //去掉分割线
//        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
        //iOS11、iPhoneX适配
        [UIView tablevieiOS11:_tableView isHaveTabbar:YES];
        
        _tableView.tableHeaderView = self.HeaderView;
    
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//组头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * viewHeader = [[UIView alloc]init];
    viewHeader.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return viewHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseID = @"SHOPINGCELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
      NSArray *names = @[@"淘赚订单",@"邀请好友",@"好友助力",@"我的邀请",@"精彩活动",@"福利专区",@"帮助手册",@"关于淘赚",@"意见反馈"];
    //图片
      NSArray *ImageS = @[@"花生订单",@"邀请好友",@"好友助力",@"我的邀请",@"精彩活动",@"福利专区",@"帮助手册",@"关于嗅美",@"意见反馈"];
    
    cell.textLabel.text = names[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@img",ImageS[indexPath.row]]];
    //cell右侧的小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (SESSIONID.length == 0) { //去登陆
      
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
        return;
    }
    
    if (indexPath.row == 0) {//花生订单
        
        PeanutOrderListController * integraVC=[[ PeanutOrderListController alloc]init];
        [self.navigationController pushViewController:integraVC animated:YES];
        
    }else if (indexPath.row==1) {//邀请好友
        //分享
        UIImage * image = [UIImage imageNamed:@"花生分享红包图"];
        [ShareView share:self ShareTitle:@"淘赚-有花就有生，用花掉的钱生钱！" WithContent:@"通过淘赚在京东、淘宝下单，消费金额如同存款，每天有收益，利率高达20\%，小伙伴们一起来赚钱吧！" ShareUrl:peanutFriendInvit shareImage:image ReporStrType:@"只分享到微信" shareType:nil completion:^(NSString *code) {
            
        }];
        //        花生邀请分享图
        //        UIImage * image = [UIImage imageNamed:@"花生分享红包图"];
        //        [ShareView share:self ShareTitle:nil WithContent:nil ShareUrl:nil shareImage:image ReporStrType:@"嗅美花生好友邀请" shareType:@"只分享图片" completion:^(NSString *code) {
        //
        //        }];
        
    }else if (indexPath.row==2) {//好友助力
        
        UIImage * image = [UIImage imageNamed:@"花生分享红包图"];
        [ShareView share:self ShareTitle:@"帮我助力——下淘赚，获得更多收益！" WithContent:@"淘赚，花钱如存款，收益拿不停！" ShareUrl:peanutFriendHelp shareImage:image ReporStrType:@"只分享到微信" shareType:nil completion:^(NSString *code) {
            
        }];
        
    }else if (indexPath.row==3) {//我的好友
        
        PeanutInviteFriendController *VC= [[PeanutInviteFriendController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if (indexPath.row==4) {//精彩活动
        
        WonderfulActivitiesController * integraVC=[[ WonderfulActivitiesController alloc]init];
        [self.navigationController pushViewController:integraVC animated:YES];
        
    }else if (indexPath.row==5) {//福利专区
        
        TurntableViewController * integraVC=[[ TurntableViewController alloc]init];
        integraVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:integraVC animated:YES];
        
    }else if (indexPath.row==6){//帮助
        
        HelpViewController * helpVC = [[HelpViewController alloc]init];
        [self.navigationController pushViewController:helpVC animated:YES];
    }else if (indexPath.row==7){//关于
        
        AboutMyViewController * aboutMyVC = [[AboutMyViewController alloc]init];
        aboutMyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutMyVC animated:YES];
    }else if (indexPath.row==8){//意见反馈
        
        AdviceViewController * adviceVC = [[AdviceViewController alloc]init];
        adviceVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:adviceVC animated:YES];
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];

    if ([NSString isNULL:SESSIONID] == NO) {
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }else{
     
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
        return;
    }
    
    //刷新头部
    [self.HeaderView loadData];
    
#pragma mark ============添加京东订单，通知后台去同步订单账号================
    [OpenJDGoodesDetals addJDOrderLoadAFN];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end
