//
//  MyRecordListController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/5/2.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "MyRecordListController.h"
#import "MyRecordListCell.h"
#import "MyRecordListModel.h"
#import "MyRecordLisHeaderModel.h"
@interface MyRecordListController ()<UITableViewDelegate,UITableViewDataSource>
//创建tableview
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,assign)NSInteger currentPage;
@property(nonatomic,strong)NSMutableArray * dataSouce;
//创建头部背景
@property(nonatomic,weak)UIImageView * imageHeader;

@property(nonatomic,assign)CGFloat rowHeight;

//创建空白页
@property(nonatomic,weak)UILabel * blankPagesTitle;

@property(nonatomic,strong)MyRecordLisHeaderModel * headerModel;

@end

@implementation MyRecordListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    
    self.headerModel = [[MyRecordLisHeaderModel alloc]init];
    
    //头部数据
    [self loadDataAllHeader];
    //下面数据
     [self loadData];
    
    [self refresh];
}


// 上拉下拉刷新
- (void)refresh {
    //自己封装的MJ刷新
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.tableView refreshHeader:^{
        //获取数据
        self.currentPage = 0;
        //头部数据
        [self loadDataAllHeader];
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



//请求我的战绩界面，头部累计数据
-(void)loadDataAllHeader{
    NSDictionary * dict=@{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:getMyPlayCardData parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            [self.headerModel mj_setKeyValues:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                //创建头部UI
                [self createUI];
            });
        }else{
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"]?:responseObject[@"msg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
        }
        
    } failure:^(NSError * _Nullable error) {
    
    }];
    
}



//数据请求
-(void)loadData{
    
    NSDictionary * dict=@{@"sessionId":SESSIONID,@"page.count":@(30),@"page.currPage":@(self.currentPage)};
    [GXJAFNetworking POST:getMyPlayCardRecord parameters:dict success:^(id  _Nullable responseObject) {
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
                MyRecordListModel * model = [[MyRecordListModel alloc]init];
                [model mj_setKeyValues:dictInfo];
                [self.dataSouce addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [LoadingView removeLoadingController:self];
                
                [self.tableView reloadData];
                //结束刷新
                [self.tableView endRefresh_DWB];
                
                //空白页
                [self.blankPagesTitle removeFromSuperview];
                self.tableView.mj_footer.hidden = NO;
                if (self.dataSouce.count == 0) {
                    //标题
                    UILabel *blankPagesTitle = [[UILabel alloc]init];
                    self.blankPagesTitle = blankPagesTitle;
                    blankPagesTitle.text = @"暂无明细";
                    blankPagesTitle.textAlignment = NSTextAlignmentCenter;
                    blankPagesTitle.font = [UIFont systemFontOfSize:14];
                    blankPagesTitle.textColor = [UIColor colorWithHexString:@"#898989"];
                    [self.tableView addSubview:blankPagesTitle];
                    self.tableView.mj_footer.hidden = YES;
                    [blankPagesTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.left.mas_equalTo(self.tableView);
                        make.height.mas_equalTo(self.tableView);
                        make.width.mas_equalTo(self.tableView);
                        
                    }];
                }
            });
            
        }else{
            
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
        }
        
    } failure:^(NSError * _Nullable error) {
        
       
    }];
    
}

//创建自定义导航栏
- (void)createNav{
    
    UIImageView * imageHeader = [[UIImageView alloc]init];
    self.imageHeader = imageHeader;
    imageHeader.image = [UIImage imageNamed:@"标题背景"];
    imageHeader.contentMode = UIViewContentModeScaleAspectFill;
    imageHeader.clipsToBounds = YES;
    imageHeader.userInteractionEnabled = YES;
    [self.view addSubview:imageHeader];
    [imageHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(MC_NavHeight+90);
    }];
    
    //主导航栏
    UIView *TopView = [[UIView alloc]init];
    [self.view addSubview:TopView];
    [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(MC_NavHeight);
    }];
    
    UILabel *navTitle = [[UILabel alloc]init];
    navTitle.text = @"我的战绩";
    navTitle.textColor = [UIColor whiteColor];
    navTitle.font = [UIFont systemFontOfSize:18];
    navTitle.textAlignment = NSTextAlignmentCenter;
    [TopView addSubview:navTitle];
    [navTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MC_StatusBarHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    
    //返回
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.contentMode = UIViewContentModeScaleAspectFill;
    backButton.clipsToBounds = YES;
    [backButton setImage:[UIImage imageNamed:@"白色返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MC_StatusBarHeight);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    //每日明细
    UILabel * labelday = [[UILabel alloc]init];
    labelday.backgroundColor = [UIColor groupTableViewBackgroundColor];
    labelday.text = @"   打卡明细";
    labelday.textColor = [UIColor grayColor];
    labelday.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:labelday];
    
    [labelday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageHeader.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    
    //创建tableview
    [self tableView];
    
}


-(void)createUI{
    //移除上面所有子视图在创建
    [self.imageHeader removeAllSubviews];
    
    NSMutableArray * Array = [NSMutableArray array];
    NSArray * arraytitle = @[@"\n投入(元)",@"\n收入(元)",@"\n参与(天)",@"\n成功(天)"];
    for (int i = 0; i< 4; i++) {
        //金额
        UILabel * labelMoney = [[UILabel alloc]init];
        labelMoney.textColor = [UIColor whiteColor];
        labelMoney.font = [UIFont systemFontOfSize:16];
        labelMoney.textAlignment = NSTextAlignmentCenter;
        labelMoney.numberOfLines = 2;
        NSString * moneyOrCount = @"--";
        if (i==0) {
            //投入
            moneyOrCount = self.headerModel.pay;
        }else if (i==1){
            //收入
             moneyOrCount = self.headerModel.gain;
        }else if (i==2){
            //参与次数
             moneyOrCount = self.headerModel.join;
        }else if (i==3){
            //成功次数
             moneyOrCount = self.headerModel.success;
        }
        labelMoney.attributedText = [NSString getLabelNOSpacingChangeColor:[UIColor whiteColor] andFont:[UIFont systemFontOfSize:12] andString1:moneyOrCount andChangeString:arraytitle[i] andGetstring3:@""];
        [self.imageHeader addSubview:labelMoney];
        [Array addObject:labelMoney];
    }
    
    //水平方向控件间隔固定等间隔
    [Array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [Array mas_makeConstraints:^(MASConstraintMaker *make) { //数组额你不必须都是view
        make.top.mas_equalTo(self.imageHeader).offset(MC_NavHeight + 20);
        make.height.mas_equalTo(40);
    }];
}


//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor whiteColor];
        //tableview拖动时收起键盘
        //        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        //去掉分割线
//        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageHeader.mas_bottom).offset(40);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
      
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
    return 50;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

//脚
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseID = @"notfMine";
    MyRecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[MyRecordListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //传值给cell
    cell.model = self.dataSouce[indexPath.row];
    return cell;
}



-(void)backButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSMutableArray *)dataSouce{
    if (!_dataSouce) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

-(void)dealloc{
    
}





-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
    //改变电池颜色（白色）
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //改变电池颜色（黑色）
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
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
