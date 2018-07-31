//
//  HSOrderListController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/4/16.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "HSOrderListController.h"
#import "HSOrderListSubController.h"
#import "FindOrderController.h"
@interface HSOrderListController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)UIImageView *redLine;//副导航下面的小红线

@property (nonatomic,strong)NSMutableArray *buttons;//附导航按钮

@property (nonatomic,strong)NSArray *stateTypes;//订单状态分类

@end

@implementation HSOrderListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = YES;
    self.titleLabel.text = @"淘赚订单";
    
    
    //右边导航栏设置方法
    UILabel *labelRight = [[UILabel alloc]init];
    labelRight.textAlignment = NSTextAlignmentRight;
    labelRight.text =@"手动找回订单";
    labelRight.textColor = MAIN_COLOR;
    labelRight.font = [UIFont systemFontOfSize:14];
    labelRight.frame = CGRectMake(SCREEN_WIDTH-120, MC_StatusBarHeight, 105, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:labelRight];
    labelRight.userInteractionEnabled = YES;
    [labelRight addTapActionTouch:^{

        FindOrderController * vc = [[FindOrderController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
    
    self.stateTypes = @[@"全部",@"待存入",@"已存入",@"无效"];
    
    [self collectionView];
    
    
    //登陆成功后刷新
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:@"mineLoginSussce" object:nil];
    
    
}

//刷新
-(void)loadData{
    [self.collectionView reloadData];
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayou = [[UICollectionViewFlowLayout alloc]init];
        [flowLayou setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayou.minimumLineSpacing = 0;//设置上下两个表格之间的距离
        flowLayou.minimumInteritemSpacing = 0;//左右
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,MC_NavHeight+35, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-35-MC_TabbarHeight) collectionViewLayout:flowLayou];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        //关闭垂直滚动条
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:_collectionView];
        [UIView collectionViewiOS11:_collectionView isHaveTabbar:YES];
        //注册对象html1
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ordercell"];
        
        //副导航
        UIView *subNav = [[UIView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, 35)];
        subNav.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:subNav];
        
        NSInteger count = self.stateTypes.count;
        CGFloat btnW = SCREEN_WIDTH/count;//按钮宽度
        CGFloat textW = [NSString sizeMyStrWith:@"待存入" andFontSize:14 andMineWidth:111].width;//文字宽度
        for (int i=0; i<count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            btn.frame = CGRectMake(btnW * i, 0, btnW, 35);
            [btn setTitle:self.stateTypes[i] forState:UIControlStateNormal];
            [btn setTitleColor:MAIN_COLOR_898989 forState:UIControlStateNormal];
            [btn setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [subNav addSubview:btn];
            [self.buttons addObject:btn];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i == 0) {
                btn.selected = YES;
            }
            
        }
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 34.5, SCREEN_WIDTH, 0.5)];
        lineView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [subNav addSubview:lineView1];
        
        //下面的小红线
        UIImageView *redLine = [[UIImageView alloc]init];
        self.redLine = redLine;
        redLine.frame = CGRectMake((SCREEN_WIDTH/count-textW)/2, 33, textW, 2);
        redLine.image = [UIImage imageWithColor:MAIN_COLOR];
        [subNav addSubview:redLine];
        
    }
    
    return _collectionView;
}

//附导航点击
- (void)btnClick:(UIButton *)btn{
    
    for (UIButton *button in self.buttons){
        if (btn.tag == button.tag) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
    
    CGFloat textW = [NSString sizeMyStrWith:@"待存入" andFontSize:14 andMineWidth:111].width;//文字宽度
    self.redLine.frame = CGRectMake((SCREEN_WIDTH/self.stateTypes.count-textW)/2+(SCREEN_WIDTH/self.stateTypes.count)*(btn.tag), 33, textW, 2);
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:btn.tag inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:(UICollectionViewScrollPositionNone) animated:NO];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.stateTypes.count;
}

//每一个cell的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT - MC_NavHeight - 35 -MC_TabbarHeight);
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ordercell" forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    
    //创建控制器
    HSOrderListSubController *item = [[HSOrderListSubController alloc]init];
    item.subId = [NSString stringWithFormat:@"%zd",indexPath.item];
    item.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - MC_NavHeight - 35 -MC_TabbarHeight);
    [self addChildViewController:item];
    [cell.contentView addSubview:item.view];
    return cell;
}

//整个collview册位置
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//collectionView的头高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0.01, 0.01);
}
//collectionView的脚高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0.01, 0.01);
}

- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = NO;
    
    if ([NSString isNULL:SESSIONID] == NO) {
        self.tabBarController.tabBar.hidden = NO;
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }else{
      
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
        return;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end
