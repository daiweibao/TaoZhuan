
//
//  TBSearchViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/24.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "TBAndJDGoodsWebController.h"

#import <AlibcTradeSDK/AlibcTradeSDK.h>
//阿里百川电商授权登陆
#import <AlibabaAuthSDK/ALBBSDK.h>

@interface TBAndJDGoodsWebController()<UIWebViewDelegate, NSURLConnectionDelegate>
@property (strong, nonatomic) UIWebView *webView;
//进度条
@property (strong, nonatomic) UIProgressView *progressView;

@property(nonatomic,strong)UIView * viewImnfoSub;
//标题
@property(nonatomic,weak)UILabel *titleLabel;
//不支持返利提示汉字
@property(nonatomic,weak)UILabel *labelInfo;

@end

@implementation TBAndJDGoodsWebController


- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-MC_TabbarSafeBottomMargin)];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;
    //网页加载
    NSURL *url = [NSURL URLWithString:self.urlTbOrJd];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    //关闭垂直滚动条
    // _webView.scrollView.showsVerticalScrollIndicator = NO;
    //水平滚动条
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    adjustsScrollViewInsets_NO(_webView.scrollView, self);//适配iOS11,必须
    [self.view addSubview:_webView];

    //创建导航
    [self createNavUI];
    
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


-(void)createNavUI{
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
    if ([self.type isEqual:@"京东"]) {
        titleLabel.text = @"京东";
    }else{
        titleLabel.text = @"淘宝";
    }
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
    labelRight.textColor = MAIN_COLOR;
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
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//关闭
-(void)ActionRightButton{
    //返回
    [self.navigationController popViewControllerAnimated:YES];
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
    _titleLabel.text = @"跳转中...";
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
    
    //设置网页导航标题
    [self setUpwebNavTitle];
}

//设置网页导航标题
-(void)setUpwebNavTitle{
    //获取网页导航栏标题
    NSString * webTitleStr = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    _titleLabel.text = webTitleStr;
    if ([NSString isNULL:webTitleStr]) {
        if ([self.type isEqual:@"京东"]) {
            _titleLabel.text = @"京东";
        }else{
            _titleLabel.text = @"淘宝";
        }
    }
    
    //浏览足迹界面导航修改
    if ([_webView.request.URL.absoluteString containsString:@"home.m.jd.com/myJd/history/wareHistory.action"]){
        _titleLabel.text = @"浏览记录";
    }else if ([_webView.request.URL.absoluteString containsString:@"https://home.m.jd.com/myJd/newhome.action"]){
        _titleLabel.text = @"我的京东";
    }
    
    //淘宝购物车提示
    if (![self.type isEqual:@"京东"]) {
        if ([self.titleLabel.text isEqual:@"购物车"]) {
            //购物车，打开底部提示
            [self webBottonInfoTipsContent:@"提示：购物车结算时有可能发生丢单，如果丢单请及时联系客服补单。" typeIsMoney:nil];
        }
    }
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType returnValue:(BOOL)returnValue{
    
    return YES;
}
#pragma mark - UIWebViewDelegate
//在点击网页上的东西时拦截网页url（网址）--在发送请求之前，决定是否跳转
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //    NSLog(@"淘宝商品绑定网页：%@",navigationAction.request.URL.absoluteString);
    NSDictionary * dictGoodsURL = [NSString dictionaryWithUrlString:request.URL.absoluteString];
    //    NSLog(@"参数字典：%@",dictGoodsURL);
    
    //购物车或者商品详情底部提示，先关闭--判断网页能打开的才隐藏
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:request.URL.absoluteString]]&& ![request.URL.absoluteString containsString:@"wqs.jd.com/portal/wx/storageBridge2.shtml"]){
//        https://wqs.jd.com/portal/wx/storageBridge2.shtml?1209//代理，购物车，和个人中心会走这里
        _webView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-MC_TabbarSafeBottomMargin);
        _viewImnfoSub.hidden = YES;//隐藏提示的父视图
    }
    
#pragma mark =========京东商品详情处理=====================
    if ([self.type isEqual:@"京东"]) {
//       商品详情1： https://item.m.jd.com/product/5089253.html?sid=9c3dcbf9e8d389ca2936f7cf3d3171af
//      商品详情2：  https://item.m.jd.com/ware/view.action?wareId=5089239&clickUrl=
        if ([request.URL.absoluteString containsString:@"item.m.jd.com/product"]||
            [request.URL.absoluteString containsString:@"item.m.jd.com/ware/view.action"]){
            //京东商品，判断网址能打开，并且是京东商品详情,去判断是否支持返佣
            [self JdGoodsIsHaveMoneyGoodsUrl:request.URL.absoluteString];
            return YES;
        }else if ([request.URL.absoluteString containsString:@"p.m.jd.com/cart/cart.action"]){
            //京东购物车底部提示
            [self webBottonInfoTipsContent:@"提示：通过淘赚APP添加到购物车的商品才能存入成功,通过京东APP加入购物车后到淘赚付款，不支持存入" typeIsMoney:nil];
            return YES;
        }else if ([request.URL.absoluteString containsString:@"openapp.jdmobile"]){
            //禁止京东触屏版自动打开京东app,openapp.jdmobile是京东的协议
            return NO;
        }else if ([request.URL.absoluteString containsString:@"passport.m.jd.com/user/login.action"]||
                  [request.URL.absoluteString containsString:@"plogin.m.jd.com/user/login.action"]){
            //拦截京东去登陆-用SDK的
            [OpenJDGoodesDetals openJDLoginController:self LoginSuccess:^{
                //登陆成功后刷新网页
                [self.webView reload];
            }];
            //设置网页导航标题
            [self setUpwebNavTitle];
            
            return NO;
        }else if ([request.URL.absoluteString containsString:@"p.m.jd.com/norder/order.action"]){
            //这里拦截京东立即购买和、购物车结算按钮，然后通过sdk连接打开，实现返佣金
            [OpenJDGoodesDetals openJDMallDetaController:self JDUrl:request.URL.absoluteString JDGoodId:nil];
            //隐藏进度条
             self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
            //设置网页导航标题
            [self setUpwebNavTitle];
            return NO;
        }else if ([request.URL.absoluteString containsString:@"home.m.jd.com/myJd/history/wareHistory.action"]){
            //            https://home.m.jd.com/myJd/history/wareHistory.action
            //京东浏览足迹提示
            [self webBottonInfoTipsContent:@"京东APP、网站上的足迹不在淘赚上显示！" typeIsMoney:@"2"];
            return YES;
    
        }else{
          return YES;
        }
    }else{
#pragma mark =========淘宝商品处理()===================
       if ([NSString isNULL:dictGoodsURL[@"id"]]==NO){
            //         id = 540526921832;
            //        NSLog(@"网页获取到淘宝商品itemId：%@",dictGoodsURL[@"id"]);
            [OpenTaobaoGoodes openTaoboMallDetaMyWebViewController:self TaoBaoItemId:dictGoodsURL[@"id"] TaoBaoUrl:request.URL.absoluteString AndGoodsType:nil AndGoodsPrice:nil AndGoodsImageUrl:nil AndGoodsName:nil];
            //隐藏进度条
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
           //设置网页导航标题
           [self setUpwebNavTitle];
            //取消网页打开NO
            return NO;
       }else if ([NSString isNULL:dictGoodsURL[@"itemid"]]==NO){
           //         id = 540526921832;
           //        NSLog(@"网页获取到淘宝商品itemId：%@",dictGoodsURL[@"id"]);

           [OpenTaobaoGoodes openTaoboMallDetaMyWebViewController:self TaoBaoItemId:dictGoodsURL[@"itemid"] TaoBaoUrl:request.URL.absoluteString AndGoodsType:nil AndGoodsPrice:nil AndGoodsImageUrl:nil AndGoodsName:nil];
           //隐藏进度条
           self.progressView.hidden = YES;
           [self.progressView setProgress:0 animated:NO];
           //设置网页导航标题
           [self setUpwebNavTitle];
           //取消网页打开NO
           return NO;
       }else if ([NSString isNULL:dictGoodsURL[@"item_id"]]==NO){
            //聚划算~ item_id 是商品ID
//            https://ju.taobao.com/m/jusp/alone/detailwap/mtp.htm?item_id=527758354524&_force=wap&_target=_blank&spm=a2147.7632989.List.1&ju_id=10000067538927&item_id=527758354524&_format=true
            [OpenTaobaoGoodes openTaoboMallDetaMyWebViewController:self TaoBaoItemId:dictGoodsURL[@"item_id"] TaoBaoUrl:request.URL.absoluteString AndGoodsType:nil AndGoodsPrice:nil AndGoodsImageUrl:nil AndGoodsName:nil];
            //隐藏进度条
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
           //设置网页导航标题
           [self setUpwebNavTitle];
            //取消网页打开NO
            return NO;
       }else if ([request.URL.absoluteString containsString:@"h5.m.taobao.com/cart/order.html"]||//淘宝购物车结算
                 [request.URL.absoluteString containsString:@"/buy.m.tmall.com/order/confirm_order_wap.htm"]//天猫购物车结算
                 ){
           //这里拦截淘宝购物车结算按钮，用SDK打开。
           [OpenTaobaoGoodes openTaoboMallDetaMyWebViewController:self TaoBaoItemId:nil TaoBaoUrl:request.URL.absoluteString AndGoodsType:nil AndGoodsPrice:nil AndGoodsImageUrl:nil AndGoodsName:nil];
           //隐藏进度条
           self.progressView.hidden = YES;
           [self.progressView setProgress:0 animated:NO];
           //设置网页导航标题
           [self setUpwebNavTitle];
           
           return NO;
       }else if ([request.URL.absoluteString containsString:@"login.m.taobao.com/login.htm"]//拦截淘宝登陆
                 ){
           //淘宝授权登陆
           [OpenTaobaoGoodes openTBLoginController:self LoginSuccess:^{
               //登陆成功后不能刷新网页，否则天猫登陆会死循环
           }];
           return NO;
       }else if ([request.URL.absoluteString containsString:@"tbopen://"]||//淘宝协议
                 [request.URL.absoluteString containsString:@"taobao://"]||//淘宝协议
                 [request.URL.absoluteString containsString:@"tmall://"]||//天猫协议
                 [request.URL.absoluteString containsString:@"//mobile.tmall"]//手机点击在天猫中打开会走
                 ){
#pragma mark =========== 禁止打开淘宝、天猫app=================
            //拦截他，禁止打开淘宝、天猫app，不然商品详情统计不到订单
            return NO;
        }else{
#pragma mark ===========购物车提示===============
            if ([request.URL.absoluteString containsString:@"https://h5.m.taobao.com/awp/base/bag.htm"]||[request.URL.absoluteString containsString:@"https://h5.m.taobao.com/mlapp/cart.html"]||
                [request.URL.absoluteString containsString:@"https://cart.m.tmall.com/cart/myCart.htm"]) {
                //淘宝购物车底部提示
                [self webBottonInfoTipsContent:@"提示：通过淘赚APP添加到购物车的商品才能存入成功,通过淘宝APP加入购物车后到淘赚付款，不支持存入" typeIsMoney:nil];
            }
            //允许网页打开YES
            return YES;
        }
    }
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
        
        //根据type控制汉字颜色
        if ([type isEqual:@"0"]) {
            //不支持存入
            _viewImnfoSub.backgroundColor = [UIColor grayColor];
            _labelInfo.textColor = [UIColor whiteColor];
        }else if ([type isEqual:@"1"]){
            //支持存入
            _viewImnfoSub.backgroundColor = MAIN_COLOR;
            _labelInfo.textColor = [UIColor whiteColor];
        }else if ([type isEqual:@"2"]){
            //不能判断
            _viewImnfoSub.backgroundColor = [UIColor orangeColor];
            _labelInfo.textColor = [UIColor whiteColor];
        }else if ([NSString isNULL:type]){
            //购物车,nil
            _viewImnfoSub.backgroundColor = MAIN_COLOR;
            _labelInfo.textColor = [UIColor whiteColor];
        }
        
    });
    
}

//京东商品判断是否支持返利
-(void)JdGoodsIsHaveMoneyGoodsUrl:(NSString *)goodsUrl{
    //截取id
    //       京东商品详情1： https://item.m.jd.com/product/5089253.html?sid=9c3dcbf9e8d389ca2936f7cf3d3171af
    //      京东商品详情2：  https://item.m.jd.com/ware/view.action?wareId=5089239&clickUrl=
    //取出一个字符串括号item.m.jd.com/product/ .html之间的内容
    NSString * skuId;
    if ([goodsUrl containsString:@"item.m.jd.com/product"]){
        NSString *string = goodsUrl;
        NSRange startRange = [string rangeOfString:@"item.m.jd.com/product/"];
        NSRange endRange = [string rangeOfString:@".html"];
        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
       skuId = [string substringWithRange:range];
    }else{
        NSDictionary * dictGoods = [NSString dictionaryWithUrlString:goodsUrl];
        if ([NSString isNULL:dictGoods[@"wareId"]]==NO) {
            skuId = dictGoods[@"wareId"];
        }
    }
    //判空防止崩溃，并判空
    if ([NSString isNULL:skuId]) {
         [self webBottonInfoTipsContent:@"抱歉，淘赚前端无法为你判断该商品是否支持淘赚存入" typeIsMoney:@"2"];
        return;
    }
    //判断是否支持佣金    备注 : false()0表示没有佣金 true(1)表示有佣金
    NSDictionary * dict = @{@"skuId":skuId,@"type":@"ios"};
    [GXJAFNetworking POST:getProductCommision parameters:dict success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([responseObject[@"result"] isEqual:@1]) {
                    //有佣金
                    //购物车底部提示
                    [self webBottonInfoTipsContent:@"本商品支持淘赚，购买后实付金额存入消费金（邮费除外）" typeIsMoney:@"1"];
                }else{
                    //购物车底部提示
                    [self webBottonInfoTipsContent:@"本商品不支持淘赚，可以逛逛其他商品" typeIsMoney:@"0"];
                }
                
            });
        }else{
            //后台其他错误
            //购物车底部提示
            [self webBottonInfoTipsContent:@"抱歉，淘赚服务器未能检测该商品是否支持淘赚存入" typeIsMoney:@"2"];
        }
    } failure:^(NSError * _Nullable error) {
        //没网
        //购物车底部提示
        [self webBottonInfoTipsContent:@"抱歉，淘赚服务器未能检测该商品是否支持淘赚存入" typeIsMoney:@"2"];
    }];
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
    //经测试网页加载页面走了dealloc
    NSLog(@"淘宝公用网页走了dealloc");
}

@end
