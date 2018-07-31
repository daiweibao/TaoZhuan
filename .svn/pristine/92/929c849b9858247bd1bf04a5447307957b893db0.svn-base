//
//  TBGoodsWebController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/8.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "TBGoodsSDKWebController.h"

#import <AlibcTradeSDK/AlibcTradeSDK.h>

@interface TBGoodsSDKWebController()
//进度条
@property (strong, nonatomic) UIProgressView *progressView;

@property(nonatomic,strong)UIView * viewImnfoSub;
//标题
@property(nonatomic,weak)UILabel *titleLabel;
//不支持返利提示汉字
@property(nonatomic,weak)UILabel *labelInfo;

@end

@implementation TBGoodsSDKWebController
- (instancetype)init
{
    self = [super init];
    if (self) {
            // YourWebViewController类中,webview的delegate设置不能放在viewdidload里面,必须在init的时候,否则函数调用的时候还是nil
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-MC_TabbarSafeBottomMargin)];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.delegate = self;
        //关闭垂直滚动条
//         _webView.scrollView.showsVerticalScrollIndicator = NO;
        //水平滚动条
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        adjustsScrollViewInsets_NO(_webView.scrollView, self);//适配iOS11,必须
        [self.view addSubview:_webView];
        
        
        //进度条UIProgressView初始化
        self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        self.progressView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 3);
        self.progressView.trackTintColor = [UIColor clearColor];
        self.progressView.progressTintColor = MAIN_COLOR;//设置进度条的色彩
        [_webView addSubview:self.progressView];
        // 设置初始的进度，防止用户进来就懵逼了（微信大概也是一开始设置的10%的默认值）
        [self.progressView setProgress: 0.1 animated:YES];
        
        //进度条模拟
        [self sowMyProgressView];
        
    }
    return self;
}
//模拟进度条
-(void)sowMyProgressView{
    //延迟1.5秒走进度条--假的
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //防止进度条倒流
        if (self.progressView.progress<0.8) {
            [self.progressView setProgress: 0.8 animated:YES];
        }
        
    });
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //这里nil
}

//这样，不然取不到值
-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
//    [SVProgressHUD showSVPLodingUseCanActionStart:@"加载中..."];//暂时不加，有问题
     [self createUI];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)createUI{
    //返回
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 17, 44);
    backButton.contentMode = UIViewContentModeScaleAspectFill;
    backButton.clipsToBounds = YES;
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(pressButtonLeftTB) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,0, SCREEN_WIDTH-200, 44)];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.titleStr;
    self.navigationItem.titleView = titleLabel;
    
    //右边导航栏设置方法
    UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonRight.frame = CGRectMake(SCREEN_WIDTH-44, MC_StatusBarHeight, 44, 44);
    [buttonRight setImage:[UIImage imageNamed:@"登录关闭"] forState:UIControlStateNormal];
    UIBarButtonItem * navTtme2 = [[UIBarButtonItem alloc] initWithCustomView:buttonRight];
    [buttonRight addTarget:self action:@selector(ActionRightButton) forControlEvents:UIControlEventTouchUpInside];
    
    //右边导航栏设置方法
    UILabel *labelRight = [[UILabel alloc]init];
    labelRight.textAlignment = NSTextAlignmentCenter;
    labelRight.text =@"刷新";
    labelRight.textColor = [UIColor blueColor];
    labelRight.font = [UIFont systemFontOfSize:16];
    labelRight.frame = CGRectMake(SCREEN_WIDTH-44, MC_StatusBarHeight, 44, 44);
    UIBarButtonItem * navTtme1 = [[UIBarButtonItem alloc] initWithCustomView:labelRight];
    labelRight.userInteractionEnabled = YES;
    WeakSelf(self);
    [labelRight addTapActionTouch:^{
        //刷新网页
        [weakself.webView reload];
    }];
    //导航赋值
    self.navigationItem.rightBarButtonItems = @[navTtme2,navTtme1];
    
    //底部提示
    UIView * viewImnfoSub = [[UIView alloc]init];
    self.viewImnfoSub = viewImnfoSub;
    viewImnfoSub.frame =CGRectMake(0, SCREEN_HEIGHT-49-MC_TabbarSafeBottomMargin, SCREEN_WIDTH,49+MC_TabbarSafeBottomMargin);
    viewImnfoSub.backgroundColor = MAIN_COLOR;
    viewImnfoSub.hidden = YES;//先影藏
    [self.view addSubview:viewImnfoSub];
    
    //提示汉字
    UILabel *labelInfo = [[UILabel alloc]init];
    self.labelInfo = labelInfo;
    labelInfo.textAlignment = NSTextAlignmentCenter;
    labelInfo.textColor = [UIColor whiteColor];
    labelInfo.font = [UIFont systemFontOfSize:14];
    //    labelInfo.text = @"提示：购物车结算时有可能发生丢单，如果丢单请及时联系客服补单。";
    //    CGFloat sizeHeight = [NSString sizeMyStrWith:labelInfo.text andFontSize:14 andMineWidth:SCREEN_WIDTH-60.0*px].height+10;//必须加10，否则不够展示
    //    labelInfo.frame = CGRectMake(30.0*px,(49-sizeHeight)/2, SCREEN_WIDTH-60.0*px,sizeHeight);
    //    labelInfo.numberOfLines = 0;
    [viewImnfoSub addSubview:labelInfo];
    

}

//返回
-(void)pressButtonLeftTB{
    //网页一层一层的返回，通过自己创建的返回按钮来控制网页的返回--太好用了
    if (_webView.canGoBack == YES) {
        [_webView goBack];
    }else{
        //最后返回
         [self.navigationController popViewControllerAnimated:NO];
    }
   
}

//关闭
-(void)ActionRightButton{
    //返回
    [self.navigationController popViewControllerAnimated:NO];
}
//网页开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    //默认值
    self.progressView.hidden = NO;
    if (self.progressView.progress<0.1) {
        [self.progressView setProgress: 0.1 animated:YES];
    }
    //进度条模拟
    [self sowMyProgressView];
    
    //导航标题-开始加载
//    _titleLabel.text = @"跳转中...";
}
//网页加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //进度条首先加载到头
    [self.progressView setProgress:1 animated:YES];
    // 之后0.3秒延迟隐藏
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        weakSelf.progressView.hidden = YES;
        [weakSelf.progressView setProgress:0 animated:NO];
    });
    //获取网页导航栏标题
    NSString * webTitleStr = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    _titleLabel.text = webTitleStr;
    if ([NSString isNULL:webTitleStr]) {
        _titleLabel.text = @"淘宝";
    }
}



#pragma mark - UIWebViewDelegate--与H5的交互---
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    
//    NSLog(@"淘宝商品绑定网页：%@",request.URL.absoluteString);

//    NSDictionary * dictGoodsURL = [NSString dictionaryWithUrlString:request.URL.absoluteString];

//    NSLog(@"参数字典：%@",dictGoodsURL);
    
    //购物车或者商品详情底部提示，先关闭--判断网页能打开的才隐藏
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:request.URL.absoluteString]]&& ![request.URL.absoluteString containsString:@"wqs.jd.com/portal/wx/storageBridge2.shtml"]){
        //        https://wqs.jd.com/portal/wx/storageBridge2.shtml?1209//代理，购物车，和个人中心会走这里
        _webView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-MC_TabbarSafeBottomMargin);
        _viewImnfoSub.hidden = YES;//隐藏提示的父视图
    }
    
#pragma mark =========== 禁止打开淘宝、天猫app=================
    if ([request.URL.absoluteString containsString:@"tbopen://"]||//淘宝协议
        [request.URL.absoluteString containsString:@"taobao://"]||//淘宝协议
        [request.URL.absoluteString containsString:@"tmall://"]||//天猫协议
        [request.URL.absoluteString containsString:@"//mobile.tmall"]//手机点击在天猫中打开会走
        ) {
        //拦截他，禁止打开淘宝、天猫app，不然商品详情统计不到订单
         return NO;
    }else if ([request.URL.absoluteString containsString:@"https://h5.m.taobao.com/awp/base/bag.htm"]||[request.URL.absoluteString containsString:@"https://h5.m.taobao.com/mlapp/cart.html"]||
              [request.URL.absoluteString containsString:@"https://cart.m.tmall.com/cart/myCart.htm"]) {
        //淘宝购物车底部提示
        [self webBottonInfoTipsContent:@"提示：通过淘赚APP添加到购物车的商品才能存入成功,通过淘宝APP加入购物车后到淘赚付款，不支持存入" typeIsMoney:nil];
        return YES;
    }else{
        return YES;
    }
//    return YES;//    [AppMonitor turnOnAppMonitorRealtimeDebug:@{@"debug_api_url":@"http://muvp.alibaba-inc.com/online/UploadRecords.do",@"debug_key":@"baichuan_sdk_utDetection"}];
    
}

//购物车底部提示,type:0代表不支持存入，1代表支持存入，2代表无法确定，nil代表购物侧
-(void)webBottonInfoTipsContent:(NSString *)content typeIsMoney:(NSString *)type{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //点击购物车提示
        _webView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-49-MC_TabbarSafeBottomMargin);
        _viewImnfoSub.hidden = NO;//打开提示的父视图
        //提示的汉字
        _labelInfo.text = content;
        CGFloat sizeHeight = [NSString sizeMyStrWith:_labelInfo.text andFontSize:14 andMineWidth:SCREEN_WIDTH-60.0*px].height+10;//必须加10，否则不够展示
        _labelInfo.frame = CGRectMake(30.0*px,(49-sizeHeight)/2, SCREEN_WIDTH-60.0*px,sizeHeight);
        _labelInfo.numberOfLines = 0;
        //购物车,nil
        _viewImnfoSub.backgroundColor = MAIN_COLOR;
        _labelInfo.textColor = [UIColor whiteColor];
       
    });
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //不能影藏导航
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    //友盟统计
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@", self.class]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [SVProgressHUD dismiss];
    //友盟统计
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@", self.class]];
}

//销毁通知
- (void)dealloc {

}


@end
