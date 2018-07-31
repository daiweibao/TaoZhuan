//
//  HSOrderListSubController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/4/16.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "HSOrderListSubController.h"
#import "SubPeanutOrderListModel.h"
#import "SubPeanutOrderListCell.h"
#import "PeanutOrderDetailController.h"
@interface HSOrderListSubController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)NSInteger currentPage;//当前页码
@property (nonatomic,strong)NSMutableArray *dataSouce;

@property (nonatomic,strong)UIView * blankBg;//空白页

@end

@implementation HSOrderListSubController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentPage = 0;
    [self tableView];
    [self loadData];
    [self addRefreshfans];
    
    //刷新订单列表
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshOrderList) name:@"refreshMyOrderList" object:nil];
    
    
}

//刷新
-(void)refreshOrderList{
    //必须在主线程，否则会死
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView.mj_header beginRefreshing]; // MJRefresh
    });
}

//刷新关注
- (void)addRefreshfans {
    
    //自己封装的MJ刷新
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.tableView refreshHeader:^{
        
        self.currentPage=0;
        [self loadData];
        
    }];
    //自己封装的MJ加载
    [DWB_refreshFooter DWB_RefreshFooterAddview:self.tableView refreshFooter:^{
        _currentPage++;
        [self loadData];
    }];
    
}

- (void)loadData{
    
    [self.blankBg removeFromSuperview];
    
    NSInteger n = [self.subId integerValue];
    //    state : 1 待存入  2 已存入  3失效
    NSDictionary * dict;
    NSString * path;
    if (n == 2) {//已存入
        dict=@{@"sessionId":SESSIONID,@"page.count":@(50),@"page.currPage":@(self.currentPage),@"state":@"1"};
        path = getOrderList;
    }else if (n == 3) {//失效
        dict=@{@"sessionId":SESSIONID,@"page.count":@(50),@"page.currPage":@(self.currentPage),@"state":@"2"};
        path = getOrderList;
    }else if (n == 1) {//待存入
        dict=@{@"sessionId":SESSIONID,@"page.count":@(50),@"page.currPage":@(self.currentPage),@"state":@"0"};
        //        path = getAuditOrder;
        path = getOrderList;
    }else{//全部
        dict=@{@"sessionId":SESSIONID,@"page.count":@(50),@"page.currPage":@(self.currentPage)};
        path = getOrderList;
    }
    
    [GXJAFNetworking POST:path parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
            //已经去全部加载完毕
            if (_currentPage>0 && [responseObject[@"result"] count] == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    });
                });
            }
            
            if (_currentPage==0) {
                [self.dataSouce removeAllObjects];
            }
            
            for (NSDictionary *dic in responseObject[@"result"]) {
                SubPeanutOrderListModel * model=[[SubPeanutOrderListModel alloc]init];
                [model mj_setKeyValues:dic];
                
                //对于京东单独做的转换
                if ([model.type doubleValue] == 0) {
                    model.type = @"2";
                }
                
                //对于订单状态做的转换
                if (n==1 || [model.order_state doubleValue] == 0) {//待存入
                    model.order_state = @"3";
                }
                
                [self.dataSouce addObject:model];
            }
            
            //空白页
            if (self.dataSouce.count == 0) {
                
                UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-36)];
                self.blankBg = bg;
                bg.backgroundColor = [UIColor groupTableViewBackgroundColor];
                [self.view addSubview:bg];
                
                //标题
                UILabel *blankPagesTitle = [[UILabel alloc]init];
                blankPagesTitle.frame = CGRectMake(0, 200, SCREEN_WIDTH, 15);
                blankPagesTitle.text = @"暂无订单";
                blankPagesTitle.backgroundColor = [UIColor groupTableViewBackgroundColor];
                blankPagesTitle.textAlignment = NSTextAlignmentCenter;
                blankPagesTitle.font = [UIFont systemFontOfSize:14];
                blankPagesTitle.textColor = [UIColor colorWithHexString:@"#898989"];
                [bg addSubview:blankPagesTitle];
                
                
                return ;
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            });
            
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-35-MC_TabbarHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [UIView tablevieiOS11:_tableView isHaveTabbar:YES];
        
    }
    
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseID = @"subPeanutOrderListCell";
    SubPeanutOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[SubPeanutOrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataSouce[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SubPeanutOrderListModel *model = self.dataSouce[indexPath.row];
    PeanutOrderDetailController *vc = [[PeanutOrderDetailController alloc]init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)dataSouce{
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = NO;
    if (_tableView != nil) {
        self.currentPage=0;
        [self loadData];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end
