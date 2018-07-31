//
//  PeanutInviteFriendController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/19.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "PeanutInviteFriendController.h"
#import "WebViewJavascriptBridge.h"

@interface PeanutInviteFriendController ()<WKScriptMessageHandler,WKNavigationDelegate>
//分享
@property (nonatomic,weak)UIView *bageView;
@property (nonatomic,weak)UIView *contentView;

@property WebViewJavascriptBridge *bridge;

@property(nonatomic,strong)WKWebView * webView;
@end

@implementation PeanutInviteFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"分享淘赚";
    
    //创建网页
    [self createWebView];
    
}

-(void)createWebView{
   
    //进行配置控制器
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    configuration.userContentController = [WKUserContentController new];
    //与JS交互的注册，JS调用OC方法
    [configuration.userContentController addScriptMessageHandler:self name:@"shareInvite"];
    
    //初始化
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.scrollView.bounces = NO;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:shareInvite_ios]]];
    [self.view addSubview:_webView];

    //加载中+ 封装方法，loadingView：传入控制器 isCreateBack：是否创建返回键，viewMaxY：加载中控件的最大Y值，viewHeight：控件高度
    [LoadingView loadingView:self isCreateBack:NO viewMaxY:SCREEN_HEIGHT viewHeight:SCREEN_HEIGHT-MC_NavHeight];
}


/**
 * JS给原生传数据：JS调用原生的方法
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //得到JS返回的数据
    //    NSDictionary *dict = message.body;
    NSLog(@"----WKwebView交互----");
    //分享  只能分享微信好友和微信朋友圈
    [self shareXiumei];
    
}


//分享
-(void)shareXiumei{
    
//    peanutFriendInvit
    
    //分享
    UIImage * image = [UIImage imageNamed:@"花生分享红包图"];
    [ShareView share:self ShareTitle:@"淘赚-有花就有生，用花掉的钱生钱！" WithContent:@"通过淘赚在京东、淘宝下单，消费金额如同存款，每天有收益，利率高达20\%，小伙伴们一起来赚钱吧！" ShareUrl:peanutFriendInvit shareImage:image ReporStrType:@"只分享到微信" shareType:nil completion:^(NSString *code) {

    }];
    
    
}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [LoadingView removeLoadingController:self];
//    NSLog(@"3、WKWebView加载完成时调用");
//    NSLog(@"%f",webView.scrollView.contentSize.height);
//    NSLog(@"%f",self.webView.scrollView.contentSize.height);
}

//注意！注意！注意：上面将当前ViewController设置为MessageHandler之后需要在当前ViewController销毁前将其移除，否则会造成内存泄漏。
-(void)dealloc{
    
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"appShareIOS"];
}

- (void)pressButtonLeft{
    if (_webView.canGoBack == YES) {
        [_webView goBack];
    }else{
        //最后返回
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end
