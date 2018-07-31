//
//  HuaShenMoneyBarController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/7.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "HuaShenMoneyBarController.h"
#import "JDAndTBGoodsModel.h"
#import "JDAndTBGoodsCell.h"
//热门商品模型
#import "ActivityGoodsModel.h"
//头部
#import "HuaShenMoneyBarHeaderCell.h"
#import "HuaShenMoneyBarTopicCell.h"
#import "PeanutServiceListController.h"//花生客服

//融云聊天
#import <RongIMLib/RongIMLib.h>

#import "NewUserAlterView.h"//新用户弹窗
#import "UserRedBagAlertView.h"//红包弹窗
#import "GXJChatListController.h"


@interface HuaShenMoneyBarController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
//刷新用的页码
@property(nonatomic,assign)NSInteger  currentPage;
//collectionView
@property(nonatomic,strong)UICollectionView * collectionView;
//数据
@property(nonatomic,strong)NSMutableArray * dataSouce;
@property (nonatomic,strong)NSArray *headimages;//轮播图数据
@property (nonatomic,strong)NSArray *arrayActiveType;//推广活动类型
//缓存
@property(nonatomic,strong)NSMutableArray * dataSouceCache;

@property (nonatomic,strong)NSString * selseTitle;//选中的标题,是选中了京东还是淘宝天猫

//消息按钮
@property(nonatomic,weak)UIButton * buttonMessage;
//消息数量
@property(nonatomic,weak)UILabel * numChatlabel;

@end

@implementation HuaShenMoneyBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNav];
    
    [self collectionView];
    
    //京东商品要求页码最低为1
    self.currentPage = 0;
    
    //请求数据前先读缓存
    [self readerCheahe];
    
    [self refresh];
    
    //AppDelegate收到融云消息监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRicveRCIDChatInfoMy) name:@"RicveRCIDChatInfo" object:nil];
    
    
    //登陆成功后通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSussce) name:@"mineLoginSussce" object:nil];

    // 监听UITabBarItem被重复点击时的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarDidClick) name:@"LLTabBarDidClickNotification" object:nil];
    
}


//导航栏设置
- (void)createNav{
    
    //导航栏
    UILabel *labelNav = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MC_NavHeight)];
    labelNav.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:labelNav];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, MC_NavHeight-1, SCREEN_WIDTH, 1)];
    line.backgroundColor = MAIN_COLOR_Line_Xi;
    [self.view addSubview:line];
    
    
    //客服按钮
    UIButton * buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonright.frame = CGRectMake(0, MC_StatusBarHeight, 44, 44);
    [buttonright setImage:[[UIImage imageNamed:@"花生客服"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.view addSubview:buttonright];
    [buttonright addTapActionTouch:^{
        if ([NSString isNULL:SESSIONID]) {
          
            //弹窗登陆
            [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                
            }];
        }else{
            //客服界面
            PeanutServiceListController * search=[[PeanutServiceListController alloc]init];
            [self.navigationController pushViewController:search animated:YES];
        }
    }];
    
    //标题
    UILabel *labelTitle = [[UILabel alloc]init];
    labelTitle.frame = CGRectMake(100, MC_StatusBarHeight, self.view.frame.size.width-200, 44);
    labelTitle.text = @"淘赚";
    labelTitle.textColor = [UIColor blackColor];
    labelTitle.textAlignment= NSTextAlignmentCenter;
    labelTitle.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:labelTitle];
    
    //消息
    UIButton * buttonMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonMessage = buttonMessage;
    buttonMessage.frame = CGRectMake(SCREEN_WIDTH-44, MC_StatusBarHeight, 44, 44);
    [buttonMessage setImage:[[UIImage imageNamed:@"iconfont-anonymous-iconfont"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [buttonMessage addTarget:self action:@selector(ActionButtonNotf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonMessage];

    //消息小红点
    UILabel * numChatlabel = [[UILabel alloc]init];
    self.numChatlabel = numChatlabel;
    numChatlabel.backgroundColor = MAIN_COLOR;
    numChatlabel.frame = CGRectMake(buttonMessage.x, buttonMessage.y, 25, 25);
    numChatlabel.textColor = [UIColor whiteColor];
    numChatlabel.font  =[UIFont systemFontOfSize:14];
    numChatlabel.layer.cornerRadius = 12.5;
    numChatlabel.textAlignment = NSTextAlignmentCenter;
    numChatlabel.clipsToBounds = YES;
    numChatlabel.adjustsFontSizeToFitWidth = YES;
    numChatlabel.hidden = YES;
    [self.view addSubview:numChatlabel];
    
    //首页1秒以后再获取
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //获取所有的未读消息数
        [self getRicveRCIDChatInfoMy];
    });
}

//消息
-(void)ActionButtonNotf{
    //消息
    GXJChatListController  * Notfinfo = [[GXJChatListController alloc]init];
    Notfinfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Notfinfo animated:YES];
}


//先读缓存，然后在异步去请求数据
-(void)readerCheahe{
#pragma mark ================获取缓存数据（轮播图）============
    //网络请求前先读出数据，请求到数据在刷新(加版本号)
    id cacheJsonScroller = [XHNetworkCache cacheJsonWithURL:[NSString stringWithFormat:@"花生返利主界面%@%@",GET_VERSION,loadFocusIndex]];
    //数据
    self.headimages = cacheJsonScroller;//轮播图
    
#pragma mark ================获取缓存数据（推广活动）============
    //网络请求前先读出数据，请求到数据在刷新(加版本号)
    id cacheJsonActive = [XHNetworkCache cacheJsonWithURL:[NSString stringWithFormat:@"花生返利主界面%@%@",GET_VERSION,getActivityType]];
        self.arrayActiveType = cacheJsonActive[@"result"];//推广活动
#pragma mark ================获取缓存数据（cell）============
    //年利率
      id cacheJsonrateStr = [XHNetworkCache cacheJsonWithURL:[NSString stringWithFormat:@"花生返利主界面年利率%@%@",GET_VERSION,getActivityProduct]];
    //网络请求前先读出数据，请求到数据在刷新(加版本号)
    id cacheJsonCell = [XHNetworkCache cacheJsonWithURL:[NSString stringWithFormat:@"花生返利主界面%@%@",GET_VERSION,getActivityProduct]];
    
    NSArray * array = cacheJsonCell;
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
        modelCell.goodsType = @"0";//固定传0代表淘宝
        modelCell.rate = cacheJsonrateStr;//年利率，比如0.15
        //模型加入数组
        [self.dataSouce addObject:modelCell];
    }
      [self.collectionView reloadData];//必须刷新
   
    
#pragma mark ========= 正式请求数据 ======
    //加载轮播图
    [self ScrollLoadData];
    //推广活动
    [self loadDataActiveType];
    //商品
    [self dataLoadAFN];
}


//上拉下拉刷新
- (void)refresh {
    //自己封装的MJ刷新
    [DWB_refreshHeader DWB_RefreshHeaderAddview:self.collectionView refreshHeader:^{
        
        self.currentPage=0;
        //加载轮播图
        [self ScrollLoadData];
        //推广活动
        [self loadDataActiveType];
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

//二次点击tabbar的事件,控件在屏幕中才刷新，不然点击其他tabbar也会刷新
- (void)tabBarDidClick{
    if ([UIView isViewAddWindowUp:self.view]==YES) {
        //必须在主线程，否则会死
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView.mj_header beginRefreshing]; // MJRefresh
        });
    }
}

#pragma mark  ==========广告栏数据数据请求与解析==================
- (void)ScrollLoadData{
    NSDictionary * dict = @{@"moduleCode":@"1"};
    [GXJAFNetworking POST:loadFocusIndex parameters:dict success:^(id  _Nullable responseObject) {
        [self.collectionView endRefresh_DWB];
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
#pragma mark ============= 过滤掉广告轮播图中的内部商品 =====================
            NSMutableArray * arrayScroller = [NSMutableArray array];
            for (NSDictionary * dictScroller in responseObject[@"root"]) {
                [arrayScroller addObject:dictScroller];
            }
            //数据
            self.headimages = arrayScroller;//轮播图
            [self.collectionView reloadData];//必须刷新
            
            
#pragma mark ================(异步)写入/更新缓存数据(只能是json类型，不能使model) ========
            [XHNetworkCache save_asyncJsonResponseToCacheFile:arrayScroller andURL:[NSString stringWithFormat:@"花生返利主界面%@%@",GET_VERSION,loadFocusIndex] completed:^(BOOL result) {
                //if(result)  NSLog(@"(异步)写入/更新缓存数据 成功");
            }];
            
        }
    } failure:^(NSError * _Nullable error) {
        [self.collectionView endRefresh_DWB];
    }];
}

#pragma mark  ==========推广活动类型==================
- (void)loadDataActiveType{
    [GXJAFNetworking POST:getActivityType parameters:nil success:^(id  _Nullable responseObject) {
        [self.collectionView endRefresh_DWB];
        if ([responseObject[@"code"] isEqual:@"00"]) {
//            activityId = 1;
//            imgUrl = "http://192.168.1.23:8088/upload/image2/1487035677062/1487035677062.jpg";
//            typeName = ceshi1;
            //数据
            self.arrayActiveType = responseObject[@"result"];//推广活动
            [self.collectionView reloadData];
#pragma mark ================(异步)写入/更新缓存数据(只能是json类型，不能使model) ========
            [XHNetworkCache save_asyncJsonResponseToCacheFile:responseObject andURL:[NSString stringWithFormat:@"花生返利主界面%@%@",GET_VERSION,getActivityType] completed:^(BOOL result) {
                //if(result)  NSLog(@"(异步)写入/更新缓存数据 成功");
            }];
        }
    } failure:^(NSError * _Nullable error) {
        [self.collectionView endRefresh_DWB];
    }];
}




//分页获取【推广】商品列表
-(void)dataLoadAFN{
    NSDictionary * dictt =  @{@"type":@"",//type 非必填 -----1淘宝  0 天猫 不传代表获取全部
                              @"page.count":@(20),
                              @"page.currPage":@(self.currentPage)
                              };
    [GXJAFNetworking POST:getActivityProduct parameters:dictt success:^(id  _Nullable responseObject) {
        //京东商品特殊
        if (_currentPage==0) {
            [self.dataSouce removeAllObjects];
            [self.dataSouceCache removeAllObjects];
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
                modelCell.goodsType = @"0";//固定传0代表淘宝
                modelCell.rate = responseObject[@"rate"];//年利率，比如0.15
                //模型加入数组
                [self.dataSouce addObject:modelCell];
                //缓存
                [self.dataSouceCache addObject:array[i]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                [self.collectionView reloadData];
                [self.collectionView endRefresh_DWB];
            });
            
#pragma mark ================(异步)写入/更新缓存数据(只能是json类型，不能使model) ========
            [XHNetworkCache save_asyncJsonResponseToCacheFile:self.dataSouceCache andURL:[NSString stringWithFormat:@"花生返利主界面%@%@",GET_VERSION,getActivityProduct] completed:^(BOOL result) {
                //if(result)  NSLog(@"(异步)写入/更新缓存数据 成功");
            }];
            //缓存年率
            [XHNetworkCache save_asyncJsonResponseToCacheFile:responseObject[@"rate"] andURL:[NSString stringWithFormat:@"花生返利主界面年利率%@%@",GET_VERSION,getActivityProduct] completed:^(BOOL result) {
                //if(result)  NSLog(@"(异步)写入/更新缓存数据 成功");
            }];
            
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
        if (self.isHaveTabbar.length > 0) {
             _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) collectionViewLayout:flowLayou];
            //iOS11、iPhoneX适配
            [UIView collectionViewiOS11:_collectionView isHaveTabbar:NO];
        }else{
            
            _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-MC_TabbarHeight) collectionViewLayout:flowLayou];
            //iOS11、iPhoneX适配
            [UIView collectionViewiOS11:_collectionView isHaveTabbar:YES];
        }
      
        //关闭垂直滚动条
        //_collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        //拖动时收起键盘
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        //注册cell-top
        [_collectionView registerClass:[HuaShenMoneyBarHeaderCell class] forCellWithReuseIdentifier:@"cellHeader"];
        //注册cell-top2
        [_collectionView registerClass:[HuaShenMoneyBarTopicCell class] forCellWithReuseIdentifier:@"cellHeader2"];
        
        //注册cell
        [_collectionView registerClass:[JDAndTBGoodsCell class] forCellWithReuseIdentifier:@"JDAndTBGoodsCellTabr"];
        

    }
    
    return _collectionView;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else{
        return self.dataSouce.count;
    }
}

//每一个cell的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //轮播图高度
            CGFloat scrollerHeight;
            if (self.headimages.count>0) {
                scrollerHeight = ImageHeight;
            }else{
                //            scrollerHeight = 0.0;
                scrollerHeight = ImageHeight;
            }
            //展开后淘宝功能按钮高度
            CGFloat tbTools_Height;
            if ([NSString isNULL:self.selseTitle]) {
                //三个都没选中
                tbTools_Height = 0;
            }else{
                tbTools_Height = 320.0*px-20.0*px;//减去与底部的距离
            }
            
            return CGSizeMake(SCREEN_WIDTH,  scrollerHeight + 30.0*px + 42 +30.0*px + 70 + tbTools_Height  + 20.0*px);
            
        }else{
            //高度精心计算加出来的
            //动态计算活动推广高度
            CGFloat buttonActiveHeight = 0;//活动模块高度，包含顶部距离
            CGFloat Activewidth = SCREEN_WIDTH/2-45.0*px;
            CGFloat ActiveHeight = 190.0*px;
            for (int j = 0; j <self.arrayActiveType.count ; j++) {
                //搜索框和汉字
                UIButton * buttonBig = [UIButton buttonWithType:UIButtonTypeCustom];
                buttonBig.frame =CGRectMake(30.0*px+(Activewidth+30.0*px)*(j%2),30.0*px+(ActiveHeight+30.0*px)*(j/2), Activewidth, ActiveHeight);
                //活动模块高度，包含顶部距离
                buttonActiveHeight = buttonBig.bottomY;
            }
            
            if (self.arrayActiveType.count==0) {
                //减去距离,和大分割线的距离
                buttonActiveHeight = -30.0*px -20.0*px;
            }
             return CGSizeMake(SCREEN_WIDTH, 20.0*px + 30.0*px + buttonActiveHeight + 60.0*px);
        }
    }else{
        //cell高度
        CGFloat collectWicth = (SCREEN_WIDTH-25.0*px*3)/2-1;
        return CGSizeMake(collectWicth, collectWicth + 60.0*px+ (23+30.0*px) +20.0*px);
        
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //头部
            HuaShenMoneyBarHeaderCell * cellHeader = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellHeader" forIndexPath:indexPath];
            [cellHeader setActionTBJDTMTitle:^(NSString *selsetitle) {
                //得到选中的
                self.selseTitle = selsetitle.copy;
                //_collectionView刷新指定表格--有动画
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
                [_collectionView reloadItemsAtIndexPaths:@[indexPath]];
                
            }];
            //传入数据给头部
            [cellHeader getDateScrollerArray:self.headimages AndActiveArray:self.arrayActiveType andSelseTitle:self.selseTitle.copy];
            return cellHeader;
        }else{
            //推荐专题商品
            HuaShenMoneyBarTopicCell * cellHeader2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellHeader2" forIndexPath:indexPath];
            //传入数据给头部
            [cellHeader2 getDateScrollerArray:self.headimages AndActiveArray:self.arrayActiveType andSelseTitle:self.selseTitle.copy];
            return cellHeader2;
        }
       
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

-(NSMutableArray *)dataSouceCache{
    if (!_dataSouceCache) {
        _dataSouceCache = [NSMutableArray array];
    }
    return _dataSouceCache;
}


//将要出现获取所有未读消息
-(void)getRicveRCIDChatInfoMy{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([NSString isNULL:SESSIONID]) {
            self.numChatlabel.hidden = YES;
            return;
        }
        
        //系统未读消息数量
        int infoNum = 0;
        //获取融云所有的未读消息数
        int chatNum = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    
        //总消息数
        int chatAllNum  = infoNum + chatNum;
        if (chatAllNum>0) {
            self.numChatlabel.hidden = NO;
            self.numChatlabel.text = [NSString stringWithFormat:@"%d",chatAllNum];
            _numChatlabel.layer.cornerRadius = 12.5;
            //两种显示方式
            CGFloat sizeNumZanWidth;
            if (chatAllNum<100) {
                sizeNumZanWidth = 25;
            }else{
                sizeNumZanWidth = [NSString sizeMyStrWith:[NSString stringWithFormat:@"%d",chatAllNum] andFontSize:14 andMineWidth:100].width+10;
            }
            //消息数量坐标
            _numChatlabel.frame = CGRectMake(_buttonMessage.x-sizeNumZanWidth+25, _buttonMessage.y, sizeNumZanWidth, 25);
        }else{
            self.numChatlabel.hidden = YES;
            //表示哪一个页面的标识(影藏)
            //self.tabBarItem.badgeValue = nil;
        }
        
    });
    
}


//登录成功后需要判断消费金和红包逻辑
- (void)loginSussce{
    
#pragma mark =========登录的情况下判断是否显示领取200消费红包==============
    if([NSString isNULL:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"red%@",USERID]]]) {
        //显示领取200消费金  然后再判断红包
        [self getmyCostGold];
        
    }else{
#pragma mark =========登录的情况下判断是否显示领取红包==============
        [self getmyredbag];
        
    }
    
}

//判断是否领取过200红包  当cost为-1证明领取过
- (void)getmyCostGold{
    NSDictionary * dic=@{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:getCostGold parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"NewUserAlterView111" forKey:[NSString stringWithFormat:@"red%@",USERID]];
            if ([responseObject[@"cost"] integerValue] == -1) {
#pragma mark =========登录的情况下判断是否显示领取红包==============
                [self getmyredbag];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [NewUserAlterView new];
                });
            }
            
        }else{
            
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

//判断是否领取过红包  当gain为-1证明领取过
- (void)getmyredbag{
    NSDictionary * dic=@{@"sessionId":SESSIONID};
    
    [GXJAFNetworking POST:getRedPacket parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
            if ([responseObject[@"gain"] integerValue] == -1) {
                
            }else{//弹出领取红包界面
                dispatch_async(dispatch_get_main_queue(), ^{
                    UserRedBagAlertView *view = [UserRedBagAlertView new];
                    view.gain = [NSString isNULL:responseObject[@"gain"]] ? @"0.00" : responseObject[@"gain"];
                });
            }
            
        }else{
            
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if (self.isHaveTabbar.length > 0) {
        self.tabBarController.tabBar.hidden = YES;
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
    
    self.hidesBottomBarWhenPushed = NO;//不要删除，否则进入一次淘宝商品后切换tabbar时候会隐藏tabbar会消失，蛇者必死
    
#pragma mark ============添加京东订单，通知后台去同步订单账号================
    [OpenJDGoodesDetals addJDOrderLoadAFN];
    
    
    [self getRicveRCIDChatInfoMy];//获取融云所有的未读消息数
    
    
#pragma mark =========没登录的情况下判断是否显示领取200消费红包==============
    if (SESSIONID.length == 0) {
        if([NSString isNULL:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"NoLogin"]]]) {
            [NewUserAlterView new];//弹出200消费金
        }
    }
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
