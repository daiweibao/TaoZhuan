//
//  PeanutGuideController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/19.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "PeanutGuideController.h"

#import "WebViewJavascriptBridge.h"

@interface PeanutGuideController ()<WKScriptMessageHandler,WKNavigationDelegate>
//分享
@property (nonatomic,weak)UIView *bageView;
@property (nonatomic,weak)UIView *contentView;

@property WebViewJavascriptBridge *bridge;

@property(nonatomic,strong)WKWebView * webView;
@end

@implementation PeanutGuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"淘赚攻略";
    
    //分享
    UIBarButtonItem *itemshare = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"商家分享"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(pressButtonshare)];
    self.navigationItem.rightBarButtonItem = itemshare;
    
    //创建网页
    [self createWebView];
    
}

-(void)createWebView{
    
    //进行配置控制器
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    configuration.userContentController = [WKUserContentController new];
    //与JS交互的注册，JS调用OC方法
    [configuration.userContentController addScriptMessageHandler:self name:@"goShopping"];
    
    //初始化
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) configuration:configuration];
    _webView.navigationDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:peanutGuides]]];
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
   
    //去逛街
    self.tabBarController.selectedIndex = 1;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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

- (void)pressButtonshare{
//    [DWBToast showCenterWithText:@"分享"];
    
    if (SESSIONID.length == 0) {
        //去登陆
      
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
        return;
    }
    
    NSString *shareUrl = [NSString stringWithFormat:@"http://www.xiumeiapp.com/WeChat/cost.html?userId=%@",USERID];
    UIImage * image = [UIImage imageNamed:@"花生分享红包图"];
    [ShareView share:self ShareTitle:@"玩转淘赚" WithContent:@"淘赚——购物还可以生钱" ShareUrl:shareUrl shareImage:image ReporStrType:@"只分享到微信" shareType:nil completion:^(NSString *code) {
        
    }];
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
