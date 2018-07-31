//
//  TBAndJDGoodsClassListController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/9.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "TBAndJDGoodsClassListController.h"

#import "JDAndTBGoodsModel.h"
#import "JDAndTBGoodsCell.h"
//热门商品模型
#import "ActivityGoodsModel.h"
//头部
#import "TBAndJDGoodsClassListHeaderCell.h"

@interface TBAndJDGoodsClassListController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
//刷新用的页码
@property(nonatomic,assign)NSInteger  currentPage;
//collectionView
@property(nonatomic,strong)UICollectionView * collectionView;
//数据
@property(nonatomic,strong)NSMutableArray * dataSouce;

//空白页
@property (nonatomic,strong)UIImageView *blankPagesIcon;
@property (nonatomic,strong)UILabel *blankPagesTitle;
@end

@implementation TBAndJDGoodsClassListController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self collectionView];
    
    //京东商品要求页码最低为1
    self.currentPage = 0;

    //商品
    [self dataLoadAFN];
    
    [self refresh];
    
}

//上拉下拉刷新
- (void)refresh {
    //自己封装的MJ刷新
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.collectionView refreshHeader:^{
        
        self.currentPage=0;
        //商品
        [self dataLoadAFN];
        
    }];
    //自己封装的MJ加载
    [DWB_refreshFooter DWB_RefreshFooterAddview:self.collectionView refreshFooter:^{
        _currentPage++;
        //商品
        [self dataLoadAFN];
    }];
}


//分页获取【京东】商品列表
-(void)dataLoadAFN{
    NSString * typeStr;
    if ([self.GoodsType isEqual:@"1"]) {
        //京东
        typeStr = @"2";
    }else if ([self.GoodsType isEqual:@"2"]){
        //天猫
        typeStr = @"0";
    }else{
        //淘宝
        typeStr = @"1";
    }
    NSDictionary * dictt =  @{@"type":typeStr,//type 非必填 -----1淘宝  0 天猫 不传代表获取全部
                              @"page.count":@(20),
                              @"page.currPage":@(self.currentPage)
                              };
    [GXJAFNetworking POST:getActivityProduct parameters:dictt success:^(id  _Nullable responseObject) {
        //京东商品特殊
        if (_currentPage==0) {
            [self.dataSouce removeAllObjects];
        }
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
//            NSLog(@"热门商品：%@",responseObject);
            //已经去全部加载完毕
            if (_currentPage>1 && [responseObject[@"result"] count] == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                    });
                });
            }
            
            NSArray * array = responseObject[@"result"];
            for (int i =0; i < array.count; i++) {
                ActivityGoodsModel * model = [[ActivityGoodsModel alloc]init];
                JDAndTBGoodsModel  * modelCell = [[JDAndTBGoodsModel alloc]init];
                [model mj_setKeyValues:array[i]];
                //赋值给公共参数
                modelCell.goodsImage = model.image;
                modelCell.goodsName = model.name;
                modelCell.goodsPrice = model.discountPrice;
                modelCell.goodsOldPrice = model.originPrice;
                modelCell.goodsId = model.skuId;
                modelCell.goodsCounponMoney = model.discount_coupon;
                modelCell.goodsUrl = model.taoBaoUrl;
                if ([self.GoodsType isEqual:@"1"]) {
                    //京东
                    modelCell.goodsType = @"1";
                }else if ([self.GoodsType isEqual:@"2"]){
                    //天猫
                    modelCell.goodsType = @"2";
                }else{
                    //淘宝
                  modelCell.goodsType = @"0";
                }
                modelCell.rate = responseObject[@"rate"];//年利率，比如0.15
                //模型加入数组
                [self.dataSouce addObject:modelCell];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
#pragma mark ========== 空白页 S==================
                //移除
                [self.blankPagesIcon removeFromSuperview];
                [self.blankPagesTitle removeFromSuperview];
                //打开刷新脚步
                self.collectionView.mj_footer.hidden = NO;
                if (self.dataSouce.count==0) {
                    //图标
                    self.blankPagesIcon = [[UIImageView alloc] init];
                    self.blankPagesIcon.frame = CGRectMake((SCREEN_WIDTH/2 - 125.0*px), 411.0*px+(SCREEN_HEIGHT-411.0*px)/2-200.0*px, 250.0*px, 273.0*px);
                    self.blankPagesIcon.image = [UIImage imageNamed:@"空白页icon"];
                    [self.collectionView addSubview: self.blankPagesIcon];
                    //标题
                    self.blankPagesTitle = [[UILabel alloc]init];
                    self.blankPagesTitle.frame = CGRectMake(0, CGRectGetMaxY(self.blankPagesIcon.frame)+32.0*px, SCREEN_WIDTH, 12);
                    self.blankPagesTitle.text = @"暂无数据";
                    self.blankPagesTitle.textAlignment = NSTextAlignmentCenter;
                    self.blankPagesTitle.font = [UIFont systemFontOfSize:12];
                    self.blankPagesTitle.textColor = [UIColor colorWithHexString:@"#898989"];
                    [self.collectionView addSubview:self.blankPagesTitle];
                    //影藏刷新脚步
                    self.collectionView.mj_footer.hidden = YES;
                }
                
#pragma mark ========== 空白页 E==================
                //移除封装的加载中
                [LoadingView removeLoadingController:self];
                [self.collectionView reloadData];
                [self.collectionView endRefresh_DWB];
                
                [LoadingView removeLoadingController:self];
                [self.collectionView reloadData];
                [self.collectionView endRefresh_DWB];
            });
            
        }else{
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
        }
        
    } failure:^(NSError * _Nullable error) {
        [self.collectionView endRefresh_DWB];
    }];
}

#pragma mark 创建  collectionView

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayou = [[UICollectionViewFlowLayout alloc]init];
        [flowLayou setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayou];
        //iOS11、iPhoneX适配
        [UIView collectionViewiOS11:_collectionView isHaveTabbar:NO];
        //关闭垂直滚动条
        //_collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        //拖动时收起键盘
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        //注册cell-top
        [_collectionView registerClass:[TBAndJDGoodsClassListHeaderCell class] forCellWithReuseIdentifier:@"JTcellHeader"];
        //注册cell
        [_collectionView registerClass:[JDAndTBGoodsCell class] forCellWithReuseIdentifier:@"JDAndTBGoodsCellTabr"];
        
        //返回
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backButton = backButton;
        backButton.frame = CGRectMake(0, MC_StatusBarHeight, 44, 44);
        backButton.contentMode = UIViewContentModeScaleAspectFill;
        backButton.clipsToBounds = YES;
        [backButton setImage:[UIImage imageNamed:@"悬浮返回"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(pressButtonLeft) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backButton];
        
        //加载中
        [LoadingView loadingView:self isCreateBack:YES viewMaxY:SCREEN_HEIGHT viewHeight:SCREEN_HEIGHT];
    }
    
    return _collectionView;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return self.dataSouce.count;
    }
}

//每一个cell的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return CGSizeMake(SCREEN_WIDTH, 411.0*px);
    }else{
        //cell高度
        CGFloat collectWicth = (SCREEN_WIDTH-25.0*px*3)/2-1;
        return CGSizeMake(collectWicth, collectWicth + 60.0*px+ (23+30.0*px) +20.0*px);
        
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        TBAndJDGoodsClassListHeaderCell * cellHeader = [collectionView dequeueReusableCellWithReuseIdentifier:@"JTcellHeader" forIndexPath:indexPath];
        //传入数据给头部
        cellHeader.GoodsTypeHeader = self.GoodsType;
        return cellHeader;
    }else{
        JDAndTBGoodsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JDAndTBGoodsCellTabr" forIndexPath:indexPath];
        JDAndTBGoodsModel * model = self.dataSouce[indexPath.item];
        cell.model = model;
        return cell;
        
    }
    
}

//整个collview册位置
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section==0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(25.0*px, 25.0*px, 0, 25.0*px);
    }
}
//cell的最小行间距(左右)
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
        
        return 25.0*px;
    }
}
//cell的最小列间距（上下）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
        return 25.0*px;
    }
}


//collectionView的头高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 0.01);
}

//collectionView的脚高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    //150.0*px 高度是选中商品时用
    return CGSizeMake(SCREEN_WIDTH, 0.01);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSMutableArray *)dataSouce{
    if (!_dataSouce) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
#pragma mark ============添加京东订单，通知后台去同步订单账号================
    [OpenJDGoodesDetals addJDOrderLoadAFN];
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
