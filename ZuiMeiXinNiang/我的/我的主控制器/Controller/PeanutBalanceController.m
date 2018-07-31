//
//  PeanutBalanceController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/11.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "PeanutBalanceController.h"
#import "GetMoneyListCell.h"
#import "TotalGetMoneyModel.h"
#import "BalanceErrorController.h"

@interface PeanutBalanceController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)NSMutableArray *dataSouce;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,strong)UILabel *moneyLabel;//消费总存款

@property (nonatomic,strong)UILabel *questionLabel;

@end

@implementation PeanutBalanceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.titleLabel.text = @"余额明细";
    
    [self tableView];
    [self loadData];
    [self refresh];
}

// 上拉下拉刷新
- (void)refresh {
    //自己封装的MJ刷新
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.tableView refreshHeader:^{
        //获取数据
        self.currentPage = 0;
        //数据请求
        [self loadData];
    }];
    //自己封装的MJ加载
    [DWB_refreshFooter DWB_RefreshFooterAddview:self.tableView refreshFooter:^{
        self.currentPage ++;
        //数据请求
        [self loadData];
    }];
    
}

//数据请求
-(void)loadData{
    
    NSDictionary * dict=@{@"sessionId":SESSIONID,
                          @"page.count":@(50),
                          @"page.currPage":@(_currentPage),
                          @"type":@(2)
                          };
    
    [GXJAFNetworking POST:getUserGain parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
            if (_currentPage==0) {
                [self.dataSouce removeAllObjects];
            }
            
            //已经去全部加载完毕
            if (_currentPage>0 && [responseObject[@"result"] count] == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    });
                });
            }
            
            for (NSDictionary *dictInfo in responseObject[@"result"]) {
                TotalGetMoneyModel * model = [[TotalGetMoneyModel alloc]init];
                [model mj_setKeyValues:dictInfo];
                [self.dataSouce addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [LoadingView removeLoadingController:self];
                
            
                if ([NSString isNULL:responseObject[@"balance"]]) {
                    self.moneyLabel.text = @"￥0.00";
                }else{
                    
                    double balance = [responseObject[@"balance"] doubleValue];
                    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.3f",[responseObject[@"balance"] doubleValue]];
                    if (balance < 0) {
                        self.questionLabel.hidden = NO;
                    }else{
                        self.questionLabel.hidden = YES;
                    }
                }
                [self.tableView reloadData];
                //结束刷新
                [self.tableView endRefresh_DWB];
                
            });
            
        }
        
    } failure:^(NSError * _Nullable error) {
    }];
    
}

//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_tableView];
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
        
        _tableView.tableHeaderView = self.header;
        
        
        //加载中+ 封装方法，loadingView：传入控制器 isCreateBack：是否创建返回键，viewMaxY：加载中控件的最大Y值，viewHeight：控件高度
        [LoadingView loadingView:self isCreateBack:NO viewMaxY:SCREEN_HEIGHT viewHeight:SCREEN_HEIGHT-MC_NavHeight];
        
    }
    
    return _tableView;
}

#pragma mark 数据源和代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseID = @"getMoneyListCell";
    GetMoneyListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[GetMoneyListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataSouce[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 15+14+8+11+15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

- (UIView *)header{
    
    if (_header == nil) {
        _header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20+15+20+25+35)];
        _header.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 15)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"可用余额";
        [_header addSubview:label];
        
        UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, label.bottomY+20, SCREEN_WIDTH, 25)];
        self.moneyLabel = moneyLabel;
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.textColor = MAIN_COLOR;
        moneyLabel.font = [UIFont boldSystemFontOfSize:25];
        moneyLabel.text = @"￥0.00";
        [_header addSubview:moneyLabel];
        
        UILabel *questionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, moneyLabel.bottomY, SCREEN_WIDTH, 35)];
        self.questionLabel = questionLabel;
        questionLabel.textAlignment = NSTextAlignmentCenter;
        questionLabel.textColor = MAIN_COLOR_898989;
        questionLabel.font = [UIFont systemFontOfSize:12];
        questionLabel.text = @"为什么余额变成负数 >>";
        questionLabel.hidden = YES;
        [_header addSubview:questionLabel];
        questionLabel.userInteractionEnabled = YES;
        [questionLabel addTapActionTouch:^{
//            NSLog(@"为什么余额变成负数 >>");
            BalanceErrorController *VC = [[BalanceErrorController alloc]init];
            [self.navigationController pushViewController:VC animated:YES];
        }];
        
    }
    return _header;
}

- (NSMutableArray *)dataSouce{
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end
