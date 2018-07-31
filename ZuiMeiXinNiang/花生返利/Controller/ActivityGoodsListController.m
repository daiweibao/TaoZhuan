//
//  ActivityGoodsListController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/8.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "ActivityGoodsListController.h"
#import "JDAndTBAboutGoodsCell.h"
#import "ActivityGoodsModel.h"
#import "JDAndTBGoodsModel.h"

@interface ActivityGoodsListController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,assign)NSInteger  currentPage;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataSouce;
@property(nonatomic,strong)NSArray * buttons;//排序4个按钮



@property (nonatomic,assign)NSInteger priceState;//价格状态 0，1，2

@property (nonatomic,copy)NSString *sort;//排序类型

@property(nonatomic,strong)UITextField *maxTextField;//最高价
@property(nonatomic,strong)UITextField *minTextField;//最低价
@property(nonatomic,strong)UIImageView *coverImage;//蒙版

@end

@implementation ActivityGoodsListController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = self.navTitle.length == 0 ? @"商品列表":self.navTitle;
    self.sort = @"";
    self.priceState = 0;
    
    [self toolBarView];
    
    [self tableView];
    
    [self loadData];
   
    //刷新
    [self refresh];
    
}

#pragma mark ==============刷新==================
-(void)refresh{
    //自己封装的MJ加载
    
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.tableView refreshHeader:^{
        _currentPage = 0;
         [self loadData];
    }];
    

    [DWB_refreshFooter DWB_RefreshFooterAddview:self.tableView refreshFooter:^{
        _currentPage++;
        [self loadData];
    }];

}

//分页获取品牌列表
-(void)loadData{

    NSLog(@"%@",self.sort);
    
    NSDictionary * dict;
    if (self.sort.length == 0) {//默认
        
        dict=@{@"activityId":self.avtiveId,@"page.count":@(20),@"page.currPage":@(_currentPage)};
        
    }else if ([self.sort isEqualToString:@"上新"]) {//上新
        
        dict=@{@"activityId":self.avtiveId,@"page.count":@(20),@"page.currPage":@(_currentPage),@"createDate":@"createDate"};
        
    }else if ([self.sort isEqualToString:@"上新筛选"]) {//上新筛选
        dict=@{@"activityId":self.avtiveId,@"page.count":@(20),@"page.currPage":@(_currentPage),@"createDate":@"createDate",@"start_price":self.minTextField.text,@"end_price":self.maxTextField.text};
        
    }else if ([self.sort isEqualToString:@"销量"]) {//销量
        dict=@{@"activityId":self.avtiveId,@"page.count":@(20),@"page.currPage":@(_currentPage),@"saleNumberDesc":@"saleNumberDesc"};
        
    }else if ([self.sort isEqualToString:@"销量筛选"]) {//销量筛选
        dict=@{@"activityId":self.avtiveId,@"page.count":@(20),@"page.currPage":@(_currentPage),@"saleNumberDesc":@"saleNumberDesc",@"start_price":self.minTextField.text,@"end_price":self.maxTextField.text};
        
    }else if ([self.sort isEqualToString:@"价格上"]) {//价格上
        
        dict=@{@"activityId":self.avtiveId,@"page.count":@(20),@"page.currPage":@(_currentPage),@"priceDesc":@"priceDesc"};
        
    }else if ([self.sort isEqualToString:@"价格上筛选"]) {//价格上筛选
        
        dict=@{@"activityId":self.avtiveId,@"page.count":@(20),@"page.currPage":@(_currentPage),@"priceDesc":@"priceDesc",@"start_price":self.minTextField.text,@"end_price":self.maxTextField.text};
        
    }else if ([self.sort isEqualToString:@"价格下"]) {//价格下
        
        dict=@{@"activityId":self.avtiveId,@"page.count":@(20),@"page.currPage":@(_currentPage),@"priceAsc":@"priceAsc"};
        
    }else if ([self.sort isEqualToString:@"价格下筛选"]) {//价格下筛选
        dict=@{@"activityId":self.avtiveId,@"page.count":@(20),@"page.currPage":@(_currentPage),@"priceAsc":@"priceAsc",@"start_price":self.minTextField.text,@"end_price":self.maxTextField.text};
        
    }else if ([self.sort isEqualToString:@"筛选"]) {//筛选
        dict=@{@"activityId":self.avtiveId,@"page.count":@(20),@"page.currPage":@(_currentPage),@"start_price":self.minTextField.text,@"end_price":self.maxTextField.text};
        
    }else{
        dict=@{@"activityId":self.avtiveId,@"page.count":@(20),@"page.currPage":@(_currentPage)};
    }
    
    [GXJAFNetworking POST:getActivityProduct parameters:dict success:^(id  _Nullable responseObject) {

        [LoadingView removeLoadingController:self];
        
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

            for (NSDictionary *dict in responseObject[@"result"]) {
                ActivityGoodsModel  * model = [[ActivityGoodsModel alloc]init];
                [model mj_setKeyValues:dict];
                JDAndTBGoodsModel *JDmodel = [[JDAndTBGoodsModel alloc]init];
                JDmodel.goodsImage = model.image;
                JDmodel.goodsName = model.name;
                JDmodel.goodsPrice = model.discountPrice;
                JDmodel.goodsOldPrice = model.originPrice;
                JDmodel.goodsId = model.skuId;
                JDmodel.goodsType = @"0";
                JDmodel.goodsCounponMoney = model.discount_coupon;
                 JDmodel.goodsUrl = model.taoBaoUrl;
                 JDmodel.rate = model.rate;//年利率，比如0.15，没有返回就默认0.20
                [self.dataSouce addObject:JDmodel];
            }
            
            //空白页
            if (self.dataSouce.count == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    });
                });
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                if (![NSString isNULL:responseObject[@"typeName"]]) {
                    self.titleLabel.text = responseObject[@"typeName"];
                }
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            });

        }else{
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {
                [self pressButtonLeft];
            }];
        }
        
    } failure:^(NSError * _Nullable error) {

    }];

}

//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, MC_NavHeight+36, SCREEN_WIDTH, SCREEN_HEIGHT-(MC_NavHeight+36)) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.showsHorizontalScrollIndicator=NO;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_tableView];
        [UIView tablevieiOS11:_tableView isHaveTabbar:NO];
        
        //加载中+ 封装方法，loadingView：传入控制器 isCreateBack：是否创建返回键，viewMaxY：加载中控件的最大Y值，viewHeight：控件高度
        [LoadingView loadingView:self isCreateBack:NO viewMaxY:SCREEN_HEIGHT viewHeight:SCREEN_HEIGHT-MC_NavHeight-37];
    }
    
    return _tableView;
}

#pragma mark 数据源和代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseID = @"activityGoodsListCell";
    JDAndTBAboutGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[JDAndTBAboutGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataSouce[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80+42.0*px;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(NSMutableArray *)dataSouce{
    if (!_dataSouce) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

#pragma mark 排序那一行
- (void )toolBarView{
    
    UIView *toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, 36)];
    toolBarView.backgroundColor = [UIColor whiteColor];
    toolBarView.layer.borderWidth = 0.5;
    toolBarView.layer.borderColor = [UIColor colorWithHexString:@"#d1d3db"].CGColor;
    [self.view addSubview:toolBarView];
    
    CGFloat btnW = SCREEN_WIDTH/4;
    NSArray *names = @[@"上新",@"销量",@"价格",@"筛选"];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i=0; i<names.count; i++) {
        
        UIButton * button= [UIButton buttonWithType:UIButtonTypeCustom];
        [tempArr addObject:button];
        button.frame = CGRectMake(btnW*i, 0, btnW, 36);
        [button setTitle:names[i] forState:UIControlStateNormal];
        [button setTitleColor:MAIN_COLOR_898989 forState:UIControlStateNormal];
        [button setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = i;
        [toolBarView addSubview:button];
        [button addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
        if (i==names.count-2) {//价格
            [button setImage:[UIImage imageNamed:@"九块九价格三角0"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"九块九价格三角0"] forState:UIControlStateSelected];
            [button setImagePositionWithType:SSImagePositionTypeRight spacing:7];
        }
        
        if (i==names.count-1) {//筛选
            [button setImage:[UIImage imageNamed:@"购物车展开"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"购物车展开红"] forState:UIControlStateSelected];
            [button setImagePositionWithType:SSImagePositionTypeRight spacing:7];
        }

    }
    
    self.buttons = tempArr;
    
}

//排序那一栏点击事件
- (void)sortButtonClick:(UIButton *)sortbtn{
    
    [self.view endEditing:YES];
    
    UIButton *timeBtn = self.buttons.firstObject;
    UIButton *numBtn = self.buttons[1];
    UIButton *priceBtn = self.buttons[2];
    UIButton *chooseBtn = self.buttons.lastObject;
    
    double min = [self.minTextField.text doubleValue];//目前存在的最小值
    double max = [self.maxTextField.text doubleValue];//目前存在的最大值
    
    
    
    if (sortbtn.tag == 0) {//时间排序
        
        //先判断筛选
        if (min > max) {
            [DWBToast showCenterWithText:@"价格区间设置不合理！"];
            return;
        }
        
        timeBtn.selected = YES;//选中上新按钮
        
        numBtn.selected = NO;//销量按钮不选中
        
        self.priceState = 0;//切换价格状态标示清零
        priceBtn.selected = NO;//价格按钮不被选中  并且图标变化
        [priceBtn setImage:[UIImage imageNamed:@"九块九价格三角0"] forState:UIControlStateNormal];
        [priceBtn setImage:[UIImage imageNamed:@"九块九价格三角0"] forState:UIControlStateSelected];
        
        self.coverImage.alpha = 0;//让筛选蒙版透明化，如果输入框有值，才让筛选按钮变色
        if (self.maxTextField.text.length > 0 && self.minTextField.text.length > 0) {
            chooseBtn.selected = YES;
            self.sort = @"上新筛选";
        }else{
            chooseBtn.selected = NO;
            self.sort = @"上新";
        }
    
//        [self.tableView.mj_header beginRefreshing];
        _currentPage = 0;
        [self loadData];
        
    }
    
    
    

    else if (sortbtn.tag == 1) {//销量排序
        //先判断筛选
        if (min > max) {
            [DWBToast showCenterWithText:@"价格区间设置不合理！"];
            return;
        }
        
        
        timeBtn.selected = NO;//不选中上新按钮
        
        numBtn.selected = YES;//销量按钮选中
        
        self.priceState = 0;//切换价格状态标示清零
        priceBtn.selected = NO;//价格按钮不被选中  并且图标变化
        [priceBtn setImage:[UIImage imageNamed:@"九块九价格三角0"] forState:UIControlStateNormal];
        [priceBtn setImage:[UIImage imageNamed:@"九块九价格三角0"] forState:UIControlStateSelected];
        
        self.coverImage.alpha = 0;//让筛选蒙版透明化，如果输入框有值，才让筛选按钮变色
        if (self.maxTextField.text.length > 0 && self.minTextField.text.length > 0) {
            chooseBtn.selected = YES;
            self.sort = @"销量筛选";
        }else{
            chooseBtn.selected = NO;
            self.sort = @"销量";
        }
//        [self.tableView.mj_header beginRefreshing];
        _currentPage = 0;
        [self loadData];
    }
    
    
    
    
    
    else if (sortbtn.tag == 2) {//价格排序
        //先判断筛选
        if (min > max) {
            [DWBToast showCenterWithText:@"价格区间设置不合理！"];
            return;
        }
        
        timeBtn.selected = NO;//不选中上新按
        numBtn.selected = NO;//销量按钮不选中
        priceBtn.selected = YES;//价格按钮选中
        self.priceState = self.priceState+1;
        self.coverImage.alpha = 0;//让筛选蒙版透明化，如果输入框有值，才让筛选按钮变色
        if (self.maxTextField.text.length > 0 && self.minTextField.text.length > 0) {
            chooseBtn.selected = YES;
            
            if (self.priceState%2 == 1) {
                [priceBtn setImage:[UIImage imageNamed:@"九块九价格上选中"] forState:UIControlStateNormal];
                [priceBtn setImage:[UIImage imageNamed:@"九块九价格上选中"] forState:UIControlStateSelected];
                self.sort = @"价格上筛选";
            }else{
                [priceBtn setImage:[UIImage imageNamed:@"九块九价格下选中"] forState:UIControlStateNormal];
                [priceBtn setImage:[UIImage imageNamed:@"九块九价格下选中"] forState:UIControlStateSelected];
                self.sort = @"价格下筛选";
            }
            
        }else{
            chooseBtn.selected = NO;
            
            if (self.priceState%2 == 1) {
                [priceBtn setImage:[UIImage imageNamed:@"九块九价格上选中"] forState:UIControlStateNormal];
                [priceBtn setImage:[UIImage imageNamed:@"九块九价格上选中"] forState:UIControlStateSelected];
                self.sort = @"价格上";
            }else{
                [priceBtn setImage:[UIImage imageNamed:@"九块九价格下选中"] forState:UIControlStateNormal];
                [priceBtn setImage:[UIImage imageNamed:@"九块九价格下选中"] forState:UIControlStateSelected];
                self.sort = @"价格下";
            }
            
        }
//        [self.tableView.mj_header beginRefreshing];
        _currentPage = 0;
        [self loadData];
    }
    
    
    
    
    else if (sortbtn.tag == 3) {//筛选排序
        chooseBtn.selected = YES;
        [self makePriceHighandLow];
    }

}

//筛选高低价格
- (void)makePriceHighandLow{
    
    if (self.coverImage != nil &&  self.coverImage.alpha == 0) {
        self.coverImage.alpha = 1;
        return;
    }
    
    if (self.coverImage != nil &&  self.coverImage.alpha == 1) {
        [self doneClick];
        return;
    }
    
    
    if (self.coverImage == nil) {
        //蒙版
        UIImageView *coverImage = [[UIImageView alloc]init];
        self.coverImage = coverImage;
        coverImage.userInteractionEnabled = YES;
        coverImage.frame = CGRectMake(0, MC_NavHeight+36, SCREEN_WIDTH, SCREEN_HEIGHT-(MC_NavHeight+36));
        coverImage.image = [UIImage imageNamed:@"黑色蒙板"];
        [self.view addSubview:coverImage];
        [coverImage addTapActionTouch:^{
            [self doneClick];
        }];
        
        //底板
        UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
        popView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
        [coverImage addSubview:popView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 60)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = MAIN_COLOR_898989;
        label.text = @"价格区间（元）";
        [popView addSubview:label];
        
        //max
        UITextField *maxTextField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-15-90,15, 90, 30)];
        maxTextField.backgroundColor = [UIColor whiteColor];
        maxTextField.placeholder=@"最高价";
        self.maxTextField = maxTextField;
        maxTextField.delegate = self;
        maxTextField.tag = 10000;
        maxTextField.font = [UIFont systemFontOfSize:14];
        maxTextField.keyboardType = UIKeyboardTypeNumberPad;
        maxTextField.textAlignment=NSTextAlignmentCenter;
        maxTextField.textColor = [UIColor blackColor];
        maxTextField.layer.borderWidth = 0.5;
        maxTextField.layer.borderColor = MAIN_COLOR_Line_Xi.CGColor;
        maxTextField.layer.cornerRadius = 3;
        maxTextField.clipsToBounds = YES;
        [popView addSubview:maxTextField];
        
        //-
        UILabel *midLine = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-15-90-20, 29, 10, 2)];
        midLine.backgroundColor = MAIN_COLOR_898989;
        [popView addSubview:midLine];
        
        //min
        UITextField *minTextField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-15-90-30-90,15, 90, 30)];
        minTextField.backgroundColor = [UIColor whiteColor];
        minTextField.placeholder=@"最低价";
        self.minTextField = minTextField;
        minTextField.delegate = self;
        minTextField.tag = 9999;
        minTextField.font = [UIFont systemFontOfSize:14];
        minTextField.keyboardType = UIKeyboardTypeNumberPad;
        minTextField.textAlignment=NSTextAlignmentCenter;
        minTextField.textColor = [UIColor blackColor];
        minTextField.layer.borderWidth = 0.5;
        minTextField.layer.borderColor = MAIN_COLOR_Line_Xi.CGColor;
        minTextField.layer.cornerRadius = 3;
        minTextField.clipsToBounds = YES;
        [popView addSubview:minTextField];
        
        UILabel *clear = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH/2, 45)];
        clear.font = [UIFont systemFontOfSize:16];
        clear.textColor = [UIColor blackColor];
        clear.text = @"清除筛选";
        clear.textAlignment = NSTextAlignmentCenter;
        clear.backgroundColor = [UIColor whiteColor];
        [popView addSubview:clear];
        clear.userInteractionEnabled = YES;
        [clear addTapActionTouch:^{
            self.minTextField.text = @"";
            self.maxTextField.text = @"";
//            UIButton *btn = self.buttons.lastObject;
//            btn.selected = NO;
        }];
        
        UILabel *done = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 60, SCREEN_WIDTH/2, 45)];
        done.font = [UIFont systemFontOfSize:16];
        done.textColor = [UIColor whiteColor];
        done.text = @"完成";
        done.textAlignment = NSTextAlignmentCenter;
        done.backgroundColor = MAIN_COLOR;
        [popView addSubview:done];
        done.userInteractionEnabled = YES;
        [done addTapActionTouch:^{
            [self doneClick];
        }];
    }
    
}

//筛选完成点击事件
- (void)doneClick{
    [self.view endEditing:YES];
    
    if (self.maxTextField.text.length == 0 && self.minTextField.text.length == 0) {
        //让筛选按钮被不选中
        UIButton *btn = self.buttons.lastObject;
        btn.selected = NO;
        
        UIButton *timeBtn = self.buttons.firstObject;
        UIButton *numBtn = self.buttons[1];
        UIButton *priceBtn = self.buttons[2];
        
        if (timeBtn.selected == YES) {
            self.sort = @"上新";
        }else if (numBtn.selected == YES) {
            self.sort = @"销量";
        }else if (priceBtn.selected == YES) {
            if (self.priceState%2==1) {
                self.sort = @"价格上";
            }else{
                self.sort = @"价格下";
            }
        }else{
            self.sort = @"";
        }
        self.coverImage.alpha = 0;//让筛选蒙版透明化，如果输入框有值，才让筛选按钮变色
//        [self.tableView.mj_header beginRefreshing];
        _currentPage = 0;
        [self loadData];
        return ;
    }
    
    if (self.maxTextField.text.length == 0 || self.minTextField.text.length == 0) {
        [DWBToast showCenterWithText:@"请合理设置价格区间"];
        return ;
    }
    
    double max = [self.maxTextField.text doubleValue];
    double min = [self.minTextField.text doubleValue];
    if (min > max) {
        [DWBToast showCenterWithText:@"价格区间设置不合理"];
        return ;
    }
    
    //让筛选按钮被选中
    UIButton *btn = self.buttons.lastObject;
    btn.selected = YES;
    
    
    UIButton *timeBtn = self.buttons.firstObject;
    UIButton *numBtn = self.buttons[1];
    UIButton *priceBtn = self.buttons[2];
    
    if (timeBtn.selected == YES) {
        self.sort = @"上新筛选";
    }else if (numBtn.selected == YES) {
        self.sort = @"销量筛选";
    }else if (priceBtn.selected == YES) {
        if (self.priceState%2==1) {
            self.sort = @"价格上筛选";
        }else{
            self.sort = @"价格下筛选";
        }
    }else{
        self.sort = @"筛选";
    }
    
    self.coverImage.alpha = 0;//让筛选蒙版透明化，如果输入框有值，才让筛选按钮变色
//    [self.tableView.mj_header beginRefreshing];
    _currentPage = 0;
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
#pragma mark ============添加京东订单，通知后台去同步订单账号================
    [OpenJDGoodesDetals addJDOrderLoadAFN];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
@end
