//
//  AppGuidePageView.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2016/11/24.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "AppGuidePageView.h"
//获取广告ID
#import <AdSupport/AdSupport.h>

@interface AppGuidePageView()<UIScrollViewDelegate>{
    
    BOOL isOut;//标识使用进入主界面
}
@property (strong, nonatomic) UIWindow * window;
//引导页
@property(nonatomic,strong) UIScrollView * scroll;
//数组
@property(nonatomic,strong)NSArray * imageArr;

//存放圆点button的数组
@property(nonatomic,strong)NSMutableArray * dataPageSouce;


@end

@implementation AppGuidePageView

// 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark =================创建引导页（Appdelegate里）================================
-(void)createGuidePage:(UIWindow *)window andBlock:(void (^)(void))guideGotoMain{
   
    //打开电池（必须，否则必死）
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    self.window = window;
    self.guideGotoMain = guideGotoMain;
#pragma mark ============== 创建引导页===============
        //否则，不停留，直接进入主界面
        isOut = NO;//只有isout的值为YES的时候才进入主界面
        //先获取版本号判断有版本变化就进入沙河路径
        NSString * Version =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        //取出版本号
        NSString * oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"Version"];
        //判断应用如果是第一次打开或者是版本更新就进入引导页
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]||![Version isEqual:oldVersion]){
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
            //先获取版本号存入沙河路径
            NSString * VersionEnt =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            //版本号存入沙河
            [[NSUserDefaults standardUserDefaults] setObject:VersionEnt forKey:@"Version"];
            
            [self gotoLaunchView];
            
        }else{
            //block回调
            if (guideGotoMain) {
                guideGotoMain();
            }
            
            //判断是否需要用户强制升级
            [self mustLetUserUpgrade];
        }
    //统一改变导航栏背景  分割线
    UINavigationBar * appearance = [UINavigationBar appearance];
    appearance.backgroundColor = [UIColor whiteColor];
}

//程序从后台进入前台时
-(void)setAppEnterForeground:(NSString *)appEnterForeground{
    _appEnterForeground = appEnterForeground;
    //判断是否需要用户强制升级
    [self mustLetUserUpgrade];
    
}

//进入前导页
-(void)gotoLaunchView{
//关闭电池
    [UIApplication sharedApplication].statusBarHidden = YES;
    
#pragma mark ========== 判断3.4.2版本清除用户登陆状态=============
    if ([GET_VERSION isEqual:@"4.1.0"]) {
        NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
        //清除sessionId
        [defuaults setObject:@"" forKey:@"sessionId"];
        //保证数据存储成功
        [defuaults synchronize];
        NSLog(@"%@版本清除了sessionId",GET_VERSION);
    }
    
    //必须设置否则会蹦
    UIViewController * emptyView = [[UIViewController alloc]initWithNibName:nil bundle:nil];
    self.window.rootViewController = emptyView;
    if (iPhoneX) {
        self.imageArr = @[@"x引导页1",@"x引导页2",@"x引导页3",@"x引导页4"];
    }else{
        self.imageArr = @[@"引导页1",@"引导页2",@"引导页3",@"引导页4"];
    }
    _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scroll.pagingEnabled = YES;
    _scroll.bounces = YES;
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH * self.imageArr.count, SCREEN_HEIGHT);
    _scroll.showsHorizontalScrollIndicator = NO;
    //背景色跟最后一张图颜色一样
    _scroll.backgroundColor  = [UIColor whiteColor];
    [self.window  addSubview:_scroll];
    
    //计算小圆点的起始坐标
    CGFloat starePoint = (SCREEN_WIDTH-50.0*px*self.imageArr.count-30.0*px*(self.imageArr.count-1))/2;
    
    for(int i = 0;i<self.imageArr.count;i++)
    {
        //轮播图片
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.image = [UIImage imageNamed:self.imageArr[i]];
        if (i==self.imageArr.count-1) {
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressEnt)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [imageView addGestureRecognizer:tap];
        }
        [_scroll addSubview:imageView];
        
    }
    //创建圆点
    //先移除
    [self.dataPageSouce removeAllObjects];
    
    for(int j = 0;j<self.imageArr.count;j++){
        //小圆点
        UIButton * buttonPage = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonPage.frame = CGRectMake(starePoint+80.0*px*j, SCREEN_HEIGHT-98.0*px, 50.0*px, 20.0*px);
        [buttonPage setImage:[UIImage imageNamed:@"轮播图椭圆"] forState:UIControlStateNormal];
        [buttonPage setImage:[UIImage imageNamed:@"轮播图椭圆选中"] forState:UIControlStateSelected];
         buttonPage.tag = 1000;
        [self.window addSubview:buttonPage];
        if (j==0) {
            //默认选中第一页
            buttonPage.selected = YES;
        }
        //小圆点放入数组
        [self.dataPageSouce addObject:buttonPage];
    }
}

//点击最后一张图片进入首页（方法一）
-(void)pressEnt{

        [_scroll removeFromSuperview];
    
    //移除小圆点
    for (UIButton * btn in self.dataPageSouce) {
        btn.hidden = YES;
        [btn removeFromSuperview];
        
    }
    
    //打开电池
    [UIApplication sharedApplication].statusBarHidden = NO;
        //block回调进入主页
        if (self.guideGotoMain) {
            self.guideGotoMain();
        }
    
    //判断是否需要用户强制升级
    [self mustLetUserUpgrade];

}

//滚动进入首页
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //多大一点在进入
    if (scrollView.contentOffset.x > SCREEN_WIDTH * (self.dataPageSouce.count-1) + SCREEN_WIDTH/2) {
        //滚到第三快速影藏小点点
        for (UIButton * button in self.dataPageSouce) {
            
            button.hidden = YES;
        }
    }
    
    //多大一点在进入
    if (scrollView.contentOffset.x < SCREEN_WIDTH * (self.dataPageSouce.count-1) + SCREEN_WIDTH/2) {
        //滚到第三快速影藏小点点
        for (UIButton * button in self.dataPageSouce) {
            
            button.hidden = NO;
        }
    }
    
    
    
    
    //多大一点在进入
    if (scrollView.contentOffset.x > SCREEN_WIDTH * (self.dataPageSouce.count-1) + SCREEN_WIDTH/10) {
        //进入首页
        [self pressEnt];
    }
}

// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //小圆点坐标改变
    NSUInteger index = scrollView.contentOffset.x/SCREEN_WIDTH;
    for (UIButton * button in self.dataPageSouce) {
        
        button.selected = NO;
    }
    
    //滚到第三页
    if (index==self.dataPageSouce.count) {
       //啥也不干
    }else{
        //其他界面慢速打开小点点
        for (UIButton * button in self.dataPageSouce) {
            
            button.hidden = NO;
        }
        //选中的圆点
        UIButton * buttonP = self.dataPageSouce[index];
        buttonP.selected = YES;
        
    }
    
}

-(NSMutableArray *)dataPageSouce{
    if (!_dataPageSouce) {
        _dataPageSouce = [NSMutableArray array];
    }
    return _dataPageSouce;
}


//程序将要进入后台时
-(void)setApplicationNoActive:(NSString *)applicationNoActive{
    _applicationNoActive = applicationNoActive;
}


#pragma mark ================= 出现重大bug强制用户升级，埋下伏笔-S（程序每次启动都走,2017年9.17日写的，3.4.0版本开始埋下伏笔）======================
-(void)mustLetUserUpgrade{
    //不要用封装的afn
//    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
    //版本号替换成数据，去掉小数点
//    NSLog(@"版本号：%@",GET_VERSION_Number);
//    NSDictionary * dict= @{@"number":GET_VERSION_Number};
//    //调用自己的单例
//    AFHTTPSessionManager * manager =  [GXJAFNetworking sharedManager];
//    [manager POST:getNewIosVersions parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
////        update 是否强制更新   false 不(0)  true 是(1)
//        NSLog(@"app是否需要强制升级：%@",responseObject);
//        if ([responseObject[@"code"] isEqual:@"00"]) {
//            if ([[NSString stringWithFormat:@"%@",responseObject[@"update"]] isEqual:@"1"]) {
//                //强制升级
//                NSString * message = responseObject[@"errorMsg"];
//                if ([NSString isNULL:message]) {
//                    //判空
//                    message  = @"老版本已停止服务，请升级到最新版本！";
//                }
//                [AlertViewTool AlertAlertWithTitle:@"很遗憾！！！" Message:message otherItemArrays:@[@"去升级"] viewController:[UIApplication sharedApplication].keyWindow.rootViewController handler:^(NSInteger index) {
//                    //去AppStore，只需要修改后面的App-Id即可
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppstoreUrl]];
//                }];
//                
//            }else{
//                //01表示已经是最新版本
//                //否则不需要强制升级
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
}

#pragma mark ================= 出现重大bug强制用户升级，埋下伏笔-E（程序每次启动都走）======================




@end
