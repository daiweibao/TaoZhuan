//
//  TurntableViewController1.m
//  YDXTurntable
//
//  Created by LIN on 16/11/26.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "TurntableViewController.h"
#import "TurntableView.h"
//散花效果
#import "RewardSuccess.h"
@interface TurntableViewController ()<CAAnimationDelegate>{
    
    
    
}
@property(nonatomic,weak)UIScrollView * bigScroller;
@property(nonatomic,weak)UIView * contentView;

@property (nonatomic,strong) TurntableView * turntable;
@property (nonatomic,strong) UILabel * label;


@property(nonatomic,strong)NSArray * arrayTitle;

@end

@implementation TurntableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"超级大转盘";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //加载中
    [LoadingView loadingView:self isCreateBack:NO viewMaxY:SCREEN_HEIGHT viewHeight:SCREEN_HEIGHT-MC_NavHeight];
    
    //请求数据
    [self loadData];
}


//数据请求
-(void)loadData{
    
    NSDictionary * dict=@{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:getPlayCardUser parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
//            [self.model mj_setKeyValues:responseObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                //创建转盘UI
                [self createUI];
                //移除加载中
                [LoadingView removeLoadingController:self];
            });
        }else{
            
            //其他错误提示
            [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
            
            [self.bigScroller endRefresh_DWB];
        }
    } failure:^(NSError * _Nullable error) {
        [self.bigScroller endRefresh_DWB];
    }];
    
}


//创建转盘UI
- (void)createUI{
    
    //背景
    UIImageView * imageBj = [[UIImageView alloc]init];
    imageBj.image = [UIImage imageNamed:@"标题背景"];
    imageBj.contentMode = UIViewContentModeScaleAspectFill;
    imageBj.clipsToBounds = YES;
    [self.view addSubview:imageBj];
    [imageBj mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    //masonry布局UIScrollView，contentSize在自动布局中无效
    UIScrollView * bigScroller = [[UIScrollView alloc]init];
    self.bigScroller = bigScroller;
    adjustsScrollViewInsets_NO(bigScroller, self);//适配iOS11
    bigScroller.alwaysBounceVertical = YES; //垂直方向遇到边框是否总是反弹，必须开启，不然用masonry布局时内容填充不满屏幕就无法反弹（CollectionView、tableview也一样）
    [self.view addSubview:bigScroller];
    [bigScroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(MC_NavHeight);
    }];
    //在利用自动布局来布局UIScrollView时,一般都会在上面添加一个UIView的子控件，来正确布局
    UIView * conrentView = [[UIView alloc]init];
    self.contentView = conrentView;
    [self.bigScroller addSubview:conrentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bigScroller);
        // 确定containerView的宽度
        make.width.equalTo(self.bigScroller);
    }];
    
    // 转盘View,只能用坐标布局
    self.turntable = [[TurntableView alloc] initWithFrame:CGRectMake(25, 40, SCREEN_WIDTH-50, SCREEN_WIDTH-50)];
    //先传标题
    self.arrayTitle =  @[@"谢谢参与",@"淘赚消费金200元",@"现金0.5元",@"腾讯视频会员1个月",@"跑车一辆",@"北京户口一个"];
    self.turntable.numberArray =  self.arrayTitle;
    //图片后传
    self.turntable.imageArray =  @[@"默认头像",@"默认头像",@"默认头像",@"默认头像",@"默认头像",@"默认头像"];
    [self.contentView addSubview:self.turntable];
    //用masonry布局看不到了
    //点击button
    WeakSelf(self);
    [self.turntable setActionButtonChouJiang:^{
        
        //抽奖按钮交互关闭
        weakself.turntable.playButton.userInteractionEnabled = NO;
        
        //(1)转盘一直旋转
        [weakself turnTableMore];
        
        //(2)请求抽奖结果,得到结果后转盘转
        [weakself ActionButtonLuckyDrawOnce];
        
    }];
    
    
    //显示奖励的label
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"抽奖结果";
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.backgroundColor = MAIN_COLOR;
    [self.contentView addSubview:self.label];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(SCREEN_WIDTH-50 + 60);
        make.centerX.mas_equalTo(self.contentView.centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-200, 30));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    
    
    //提示与苹果公司无关
    UILabel * labelTips = [[UILabel alloc] init];
    labelTips.textAlignment = NSTextAlignmentCenter;
    labelTips.text = @"上述业务推广,营销活动等内容与苹果公司无关";
    labelTips.font = [UIFont systemFontOfSize:14];
    labelTips.textColor = MAIN_COLOR;
    labelTips.numberOfLines = 0;
    [self.view addSubview:labelTips];
    [labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-MC_TabbarSafeBottomMargin-20);
    }];
    
}


//转盘一直旋转,等待请求数据
-(void)turnTableMore{
    //旋转
    CGFloat perAngle = 360 * M_PI/180.0;//转一圈
    //转
     CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:perAngle * 30];
    rotationAnimation.duration = 10;//动画时长
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    [self.turntable.rotateWheel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

//得到数据后开始抽奖动画
-(void)startAnimaition
{
    
    //先移除一直旋转的大转盘
    [self.turntable.rotateWheel.layer removeAllAnimations];
    
    NSInteger count = 6;
    NSInteger getCout = 3;//得到那个奖品
    
    NSInteger turnAngle;
    NSInteger turnsNum = arc4random()%5+1;//控制圈数
    
    turnAngle  = 360 / count * getCout;
    CGFloat perAngle = M_PI/180.0;
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:turnAngle * perAngle + 360 * perAngle * turnsNum];
    rotationAnimation.duration = 3.0f;//动画时长
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.turntable.rotateWheel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //抽奖按钮交互打开
        self.turntable.playButton.userInteractionEnabled = YES;
        
        //动画结束后，转盘结束后调用，显示获得的对应奖励
        self.label.text = [NSString stringWithFormat:@"恭喜您抽中%@",self.arrayTitle[self.arrayTitle.count - getCout]];
        
        [AlertViewTool AlertAlertWithTitle:@"恭喜你" Message:self.label.text otherItemArrays:@[@"知道了"] viewController:self handler:^(NSInteger index) {
            
            
        }];
        //展示散花动画
        [RewardSuccess showLuckyDrawSuccessAnimation];
    
    });
}


//点击抽奖一次
-(void)ActionButtonLuckyDrawOnce{

    NSDictionary *dict = @{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:playCard parameters:dict success:^(id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //开始旋转大转盘
            [self startAnimaition];
            
        });
//        if ([responseObject[@"code"] isEqual:@"00"]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [MBProgressHUD hideHUDForView:self.view];//影藏加载中
//
//                //开始旋转大转盘
//                [self startAnimaition];
//
//            });
//        }else{
//
//        //其他错误提示
//        [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:@"谢谢参与" otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
//        }
    } failure:^(NSError * _Nullable error) {
        //数据请求失败--移除动画停止转动
        [self.turntable.rotateWheel.layer removeAllAnimations];
        //抽奖按钮交互打开
        self.turntable.playButton.userInteractionEnabled = YES;
        //其他错误提示
        [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:@"谢谢参与" otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
  
}



@end
