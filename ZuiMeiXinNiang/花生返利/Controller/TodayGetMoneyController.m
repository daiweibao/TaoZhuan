//
//  TodayGetMoneyController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/10.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "TodayGetMoneyController.h"
#import "CFLineChartView.h"//曲线图
#import "TodayGetMoneyModel.h"//模型

@interface TodayGetMoneyController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIView * headerView;
@property(nonatomic,strong)NSMutableArray * dataSouce;
@property(nonatomic,strong) TodayGetMoneyModel * modelData;//所有数据
@end

@implementation TodayGetMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"今日收益";
    //曲线必须放在头部，否则有问题
    [self headerView];
    //在创建tableview
    [self tableView];
    
    //请求数据
    [self dataAFN];

}

//收益
-(void)dataAFN{
    NSDictionary * dic = @{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:getWeekGain parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]){
            [self.dataSouce removeAllObjects];
            NSArray * arrayInfo = responseObject[@"result"];
            //曲线图数据处理
            NSMutableArray * MarrayDate = [NSMutableArray array];//日期数组-乱序
            NSMutableArray * MarrayMoney = [NSMutableArray array];//金额数组-乱序
             NSMutableArray * MarrayAll = [NSMutableArray array];//总的数组-乱序
            
            for (int i = 0; i< arrayInfo.count; i++) {
                NSDictionary * dictMode = arrayInfo[i];
                TodayGetMoneyModel * model = [[TodayGetMoneyModel alloc]init];
                [model mj_setKeyValues:dictMode];
                [MarrayAll addObject:model];
                //金额数组
                [MarrayMoney addObject: model.gain];
                //毫秒日期数组
                [MarrayDate addObject:model.createDate];
            }
            //（1）毫秒日期从小到大排序
            //通过自带的compare方法升序排列
            [MarrayDate sortUsingSelector:@selector(compare:)];
            //（2）大数组重新排序，根据日期匹配数组
            for (int j=0; j < MarrayDate.count; j++) {
                NSString * dateStr = MarrayDate[j];
                for (int k=0; k<MarrayAll.count ; k++) {
                    TodayGetMoneyModel * modelAll = MarrayAll[k];
                    if ([dateStr isEqual:modelAll.createDate]) {
                        //根据日期匹配数组
                        [self.dataSouce addObject:modelAll];
                    }
                }
            }
            
            //累计收益
            if ([NSString isNULL:responseObject[@"balance"]]) {
                self.modelData.allMoneyStr = @"0.000";
            }else{
                self.modelData.allMoneyStr = responseObject[@"balance"];
            }
            
            if (self.dataSouce.count>=3) {
                //计算昨日收益
                TodayGetMoneyModel * modelYesary = self.dataSouce[self.dataSouce.count-3];
                self.modelData.YesterdayMoneyStr = [NSString stringWithFormat:@"%@",modelYesary.gain];
                
                //计算今日收益
                TodayGetMoneyModel * modelToday = self.dataSouce[self.dataSouce.count-2];
                self.modelData.todayMoneyStr = [NSString stringWithFormat:@"%@",modelToday.gain];
                
                //计算明日收益
                TodayGetMoneyModel * modelNex = self.dataSouce.lastObject;
                self.modelData.nextDayMoneyStr = [NSString stringWithFormat:@"%@",modelNex.gain];
                
            }else{
                //其他错误提示
                [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:@"返回的数据不足三组，无法展示~" otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //数据必须固定8条才创建UI
                //添加曲线
                [self createCurveLineUI];
                [self.tableView reloadData];
                //移除
                [LoadingView removeLoadingController:self];
            });
        }else{
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
        }
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}
-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140 + 140.0*px);
    }
    return _headerView;
}
-(NSMutableArray *)dataSouce{
    if (!_dataSouce) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}
//初始化
-(TodayGetMoneyModel *)modelData{
    if (!_modelData) {
        _modelData = [[TodayGetMoneyModel alloc]init];
    }
    return _modelData;
}
//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_TabbarHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        //iOS11、iPhoneX适配
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
        //关闭垂直滚动条
//        _tableView.showsVerticalScrollIndicator=NO;
        //背景
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //去掉分割线
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
        //头部
        _tableView.tableHeaderView = _headerView;
        
        //加载中
        [LoadingView loadingView:self isCreateBack:NO viewMaxY:SCREEN_HEIGHT viewHeight:SCREEN_HEIGHT-MC_NavHeight];
    
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0) {
        return 3;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0) {
        return 44;
    }else{
       return 88;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0) {
        return 20.0*px;
    }else{
        return 20.0*px;
    }
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
    
    //关闭缓存
    UITableViewCell * cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellLL"];
    /* 忽略点击效果 */
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView removeAllSubviews];//移除所有子视图
     if (indexPath.section==0){
        
      [self createThreeUI:cell IndexPath:indexPath];

    }else{
        [self createAllMoneyUI:cell];
    }
    
    return cell;
}

//创建曲线UI，曲线必须放在头部，否则有问题
-(void)createCurveLineUI{
    [_headerView removeAllSubviews];//移除所有子视图
    //创建今日金额
    CopyLabel * labelNum = [[CopyLabel alloc]init];
    labelNum.frame = CGRectMake(0, 0, SCREEN_WIDTH, 140.0*px);
    labelNum.textColor = MAIN_COLOR;
    labelNum.textAlignment = NSTextAlignmentCenter;
    labelNum.font = [UIFont boldSystemFontOfSize:30];
    if ([self.modelData.todayMoneyStr isEqual:@"0.000"]) {
         labelNum.text = @"今日暂无收益";
    }else{
        labelNum.text = self.modelData.todayMoneyStr;
    }
    [_headerView addSubview:labelNum];
    
    
   //曲线图数据处理
    NSMutableArray * MarrayDate = [NSMutableArray array];
    NSMutableArray * MarrayMoney = [NSMutableArray array];
    //少循环一次，不要取到明天的
    for (int i =0 ; i< self.dataSouce.count-1; i++) {
        TodayGetMoneyModel * model = self.dataSouce[i];
        [MarrayMoney addObject: model.gain];//金额数组
        NSString * dateString;
        if (i==self.dataSouce.count-2) {
            dateString = @"今天";
        }else{
            dateString = [NSString dateChangeStr:model.createDate andFormat:@"MM-dd"];
        }
        [MarrayDate addObject:dateString];//日期数组
    }
   //数组转化
     NSArray * arrayDate = MarrayDate.copy;
     NSArray * arrayMoney = MarrayMoney.copy;

    //开始创建曲线,-20,坐标往左边移动点
    CFLineChartView *LCView = [CFLineChartView lineChartViewWithFrame:CGRectMake(-20,labelNum.bottomY, SCREEN_WIDTH, 120)];
    //设置日期
//    LCView.xValues = @[@"11-21",@"11-22",@"11-23",@"11-24",@"11-25",@"11-26",@"今天"];
    LCView.xValues = arrayDate;
    //设置每天收益
//    LCView.yValues = @[@0.35, @3.23, @0.04, @6.00, @0.51, @0.15, @9.0];
    LCView.yValues = arrayMoney;
    
    // 设置条件
    LCView.isShowLine = NO;
    LCView.isShowPoint = YES;
    LCView.isShowPillar = NO;
    LCView.isShowValue = YES;
    //添加
    [_headerView addSubview:LCView];
    [LCView drawChartWithLineChartType:0 pointType:1];
}

//创建三个cellUI
-(void)createThreeUI:(UITableViewCell*)cell IndexPath:(NSIndexPath *)indexPath{
    //创建分割线
    UIImageView * cellLine = [[UIImageView alloc]init];
    cellLine.frame = CGRectMake(0, cell.contentView.bottomY-0.5, SCREEN_WIDTH, 0.5);
    cellLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [cell.contentView addSubview:cellLine];
    
    //创建标题1
    UILabel * labelTitle = [[UILabel alloc]init];
    labelTitle.frame = CGRectMake(30.0*px, 0, SCREEN_WIDTH/2, 44);
    labelTitle.textColor = [UIColor blackColor];
    [cell.contentView addSubview:labelTitle];

    //创建金额
    UILabel * labelNum = [[UILabel alloc]init];
    labelNum.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2-30.0*px, 44);
    labelNum.textAlignment = NSTextAlignmentRight;
    labelNum.textColor = MAIN_COLOR;
     [cell.contentView addSubview:labelNum];
    if (indexPath.row==0) {
        labelTitle.textColor = [UIColor blackColor];
        labelTitle.font = [UIFont systemFontOfSize:12];
        labelTitle.text = @"昨日收益";
        //金额
        labelNum.font = [UIFont systemFontOfSize:12];
        labelNum.text = self.modelData.YesterdayMoneyStr;
        
    }else if (indexPath.row==1){
        labelTitle.textColor = MAIN_COLOR;
        labelTitle.font = [UIFont boldSystemFontOfSize:12];
        labelTitle.text = @"今日收益";
        //金额
        labelNum.font = [UIFont boldSystemFontOfSize:12];
         labelNum.text = self.modelData.todayMoneyStr;
    }else{
        labelTitle.font = [UIFont systemFontOfSize:12];
        labelTitle.textColor = [UIColor blackColor];
        labelTitle.text = @"明日预计";
        //金额
        labelNum.font = [UIFont systemFontOfSize:12];
        labelNum.text = self.modelData.nextDayMoneyStr;
    }
}

//创建累计收益UI
-(void)createAllMoneyUI:(UITableViewCell*)cell{
    //创建标题
    CopyLabel * labelTitle = [[CopyLabel alloc]init];
    labelTitle.frame = CGRectMake(30.0*px, 14, SCREEN_WIDTH/3*2, 13);
    labelTitle.textColor = [UIColor blackColor];
    labelTitle.font = [UIFont systemFontOfSize:12];
    labelTitle.text = @"累计收益";
    [cell.contentView addSubview:labelTitle];
    
    //创建金额
    CopyLabel * labelNum = [[CopyLabel alloc]init];
    labelNum.frame = CGRectMake(30.0*px, labelTitle.bottomY+15, SCREEN_WIDTH/3*2, 31);
    labelNum.textColor = MAIN_COLOR;
    labelNum.font = [UIFont boldSystemFontOfSize:30];
    labelNum.text = self.modelData.allMoneyStr;
    [cell.contentView addSubview:labelNum];
    
    //查看明细
    UIButton * buttonSeen = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSeen.frame = CGRectMake(SCREEN_WIDTH-156.0*px-80.0*px, 0, 166.0*px,88);
    [buttonSeen setImage:[UIImage imageNamed:@"查看明细"] forState:UIControlStateNormal];
    [buttonSeen addTarget:self action:@selector(ActionButtonSeen) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:buttonSeen];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
//查看明细
-(void)ActionButtonSeen{
//    NSLog(@"查看明细");
//    TotalGetMoneyController//收益明细
    UIViewController * MyVC = [[NSClassFromString(@"TotalGetMoneyController") alloc] init];
    [self.navigationController pushViewController:MyVC animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
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
