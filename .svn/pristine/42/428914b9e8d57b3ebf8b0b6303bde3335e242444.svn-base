//
//  CXTestController.m
//  xiumei
//
//  Created by 爱恨的潮汐 on 2017/8/22.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//
#import "CXTestController.h"
#import <JDKeplerSDK/KeplerApiManager.h>
#import "TodayGetMoneyController.h"
//阿里百川SDK3.1(2017年5月9日)
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "TBAndJDGoodsWebController.h"
@interface CXTestController ()<UITableViewDelegate,UITableViewDataSource>
//创建tableview
@property (nonatomic,strong) UITableView * tableView;

@end

@implementation CXTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.titleLabel.text = @"测试界面(勿删)";
   //创建tableview
    [self tableView];
//
//    TestLine * line = [[TestLine alloc]init];
//    line.frame = CGRectMake(10, 100, 50, 100);
//    line.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:line];
    
    //控件旋转
//    _tableView.transform=CGAffineTransformMakeRotation(M_PI/2);
     NSLog(@"%@",[[UIDevice currentDevice] systemVersion]);
}


//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) style:UITableViewStylePlain];
        //iOS11、iPhoneX适配
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //tableview拖动时收起键盘
        //        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //去掉分割线
//        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [self.view addSubview:_tableView];
        
        
    }
    
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

//脚
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //关闭缓存
    UITableViewCell * cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    /* 忽略点击效果 */
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (indexPath.row==0) {
    cell.textLabel.text = @"京东登陆";
    }else if (indexPath.row==1){
       cell.textLabel.text = @"京东退出登陆";
    }else if (indexPath.row==2){
//         cell.textLabel.text = @"京东首页";
    }else if (indexPath.row==3){
         cell.textLabel.text = @"普通淘宝搜索";
    }else if (indexPath.row==4){
        cell.textLabel.text = @"爱淘宝搜索";
    }else if (indexPath.row==5){
        cell.textLabel.text = @"爱淘宝主页";
    }else if (indexPath.row==6){
         cell.textLabel.text = @"京东首页网页版";
    }else if (indexPath.row==7){

    }else if (indexPath.row==8){

    }else if (indexPath.row==9){

    }else if (indexPath.row==10){

    }else if (indexPath.row==11){

    }else if (indexPath.row==12){

    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        /**
         *  Kepler登录授权
         */
        [[KeplerApiManager sharedKPService] keplerLoginWithViewController:self success:^(NSString *token) {
            NSLog(@"京东登陆后返回的token：%@",token);
            [DWBToast showCenterWithText:@"京东登陆成功"];
        } failure:^(NSError *error) {
            
        }];
    }else if (indexPath.row==1){
        //退出京东登陆
        [[KeplerApiManager sharedKPService] cancelAuth];
        [DWBToast showCenterWithText:@"退出登录"];
    }else if (indexPath.row==2){
        //京东首页
      
    }else if (indexPath.row==3){
        //搜索普通淘宝商品
        [OpenTaobaoGoodes TBSearchGoodsController:self AndTBWords:@"手机"];
    }else if (indexPath.row==4){
        //跳转到爱淘宝搜索界面
        TBAndJDGoodsWebController * JdAndTBVC = [[TBAndJDGoodsWebController alloc]init];
        NSString * wordStr = @"手机";
        //汉字转码
        NSString * words = [wordStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * tbSerachUrl =[NSString stringWithFormat:@"https://ai.m.taobao.com/search.html?&q=%@&pid=%@",words,TB_mmId];//爱淘宝搜索
        JdAndTBVC.urlTbOrJd = tbSerachUrl;
        JdAndTBVC.type = @"淘宝";//类型不传是淘宝
        JdAndTBVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:JdAndTBVC animated:YES];

    }else if (indexPath.row==5){
        //爱淘宝主页
        TBAndJDGoodsWebController * aitbHomeVC = [[TBAndJDGoodsWebController alloc]init];
        NSString * aitbHomeUrl =@"https://ai.m.taobao.com";//爱淘宝主页
        aitbHomeVC.urlTbOrJd = aitbHomeUrl;
        aitbHomeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aitbHomeVC animated:YES];
        
    }else if (indexPath.row==6){
        //京东主页
        TBAndJDGoodsWebController * aitbHomeVC = [[TBAndJDGoodsWebController alloc]init];
        NSString * aitbHomeUrl =@"https://m.jd.com/?ad_od=3";//
        aitbHomeVC.urlTbOrJd = aitbHomeUrl;
        aitbHomeVC.type = @"京东";
        aitbHomeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aitbHomeVC animated:YES];
    }else if (indexPath.row==7){
       
        
    }else if (indexPath.row==8){
     
       
    }else if (indexPath.row==9){
      
    }else if (indexPath.row==10){
       
    }else if (indexPath.row==11){
      

    }else if (indexPath.row==12){

    }
    
}
//cell will display
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)dealloc{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    //友盟统计
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@", self.class]];
    
#pragma mark ============添加京东订单，通知后台去同步订单账号================
    [OpenJDGoodesDetals addJDOrderLoadAFN];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //友盟统计
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@", self.class]];
    
}


/*
 
 
 scrollView的contentSize要根据containerView的高度来设置，containView的高度又要根据它内部的子控件来设置,make.bottom.equalTo(self.containerView)确定containerView的高度，make.width.equalTo(self.scrollView)确定containerview的宽度。
 

 */



@end
