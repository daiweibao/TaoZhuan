//
//  TiXianRecordController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2018/1/10.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "TiXianRecordController.h"
#import "GetMoneyListCell.h"
#import "TotalGetMoneyModel.h"


@interface TiXianRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)NSMutableArray *dataSouce;
@property (nonatomic,assign)NSInteger currentPage;

@end

@implementation TiXianRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.titleLabel.text = @"提现记录";
    
    //    [self tableView];
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
    NSDictionary * dict=@{@"sessionId":SESSIONID,@"page.count":@(50),@"page.currPage":@(_currentPage),};
    
    [GXJAFNetworking POST:myWithdraw parameters:dict success:^(id  _Nullable responseObject) {
        [LoadingView removeLoadingController:self];
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
            if (_currentPage==0) {
                [self.dataSouce removeAllObjects];
            }
            
            //已经去全部加载完毕
            if (_currentPage>0 && [responseObject[@"myTopic"] count] == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    });
                });
            }
            
            for (NSDictionary *dictInfo in responseObject[@"result"]) {
                TotalGetMoneyModel * model = [[TotalGetMoneyModel alloc]init];
                [model mj_setKeyValues:dictInfo];
                model.gain = model.limitW;
                [self.dataSouce addObject:model];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.dataSouce.count == 0) {//空白页
                
                    //标题
                    UILabel *blankPagesTitle = [[UILabel alloc]init];
                    blankPagesTitle.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight);
                    blankPagesTitle.text = @"暂无提现记录";
                    blankPagesTitle.backgroundColor = [UIColor groupTableViewBackgroundColor];
                    blankPagesTitle.textAlignment = NSTextAlignmentCenter;
                    blankPagesTitle.font = [UIFont systemFontOfSize:14];
                    blankPagesTitle.textColor = [UIColor colorWithHexString:@"#898989"];
                    [self.view addSubview:blankPagesTitle];
                    
                    return ;
                    
                }
                
                
                if ([NSString isNULL:responseObject[@"sum"]]) {
                    self.moneyLabel.text = @"￥0.00";
                }else{
                    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",responseObject[@"sum"]];
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

- (UIView *)header{
    if (_header == nil) {
        
        _header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        _header.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, 15)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = MAIN_COLOR_BLACK;
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"已提现";
        [_header addSubview:label];
        
        
        UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, label.bottomY+15, SCREEN_WIDTH, 25)];
        self.moneyLabel = moneyLabel;
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.textColor = MAIN_COLOR;
        moneyLabel.font = [UIFont boldSystemFontOfSize:24];
        moneyLabel.text = @"￥0.00";
        [_header addSubview:moneyLabel];
        
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
