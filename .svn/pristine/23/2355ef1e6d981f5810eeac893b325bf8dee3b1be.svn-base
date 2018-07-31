
//
//  BigWheelViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/6/28.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "BigWheelViewController.h"
#import "WebViewJavascriptBridge.h"

@interface BigWheelViewController ()<UIWebViewDelegate>{
    
    //加载中
    MBProgressHUD * hudLoding;
}

@property WebViewJavascriptBridge *bridge;

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation BigWheelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"幸运抽奖";
    self.backButton.hidden = NO;
    
    [self createWebView];

}

-(void)pressButtonLeft{
    //刷新美币数量
    [[NSNotificationCenter defaultCenter]postNotificationName:@"bigWheerrefresh" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createWebView{
    
    _webView = [[UIWebView alloc]init];
    _webView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-MC_TabbarSafeBottomMargin);
    //    设置背景色
    _webView.backgroundColor = [UIColor whiteColor];
    
//    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    
    //    使网页透明
    _webView.opaque = NO;
    _webView.scrollView.bounces = NO;
    _webView.delegate = self;
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:turntableDraw]]];
    [self.view addSubview:_webView];
    
    // 禁止网页复制
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    //必须放在这里，否则必死
    hudLoding = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudLoding.animationType = MBProgressHUDAnimationZoomIn;
    hudLoding.color = [UIColor blackColor];
    [hudLoding setLabelText:@"加载中..."];
    
    //交互
    [self getJSdate];
    
}

#pragma mark =================================与H5交互 =======================================
-(void)getJSdate{
    // 开启日志
    [WebViewJavascriptBridge enableLogging];
    
    //给哪个webview建立JS与OjbC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [self.bridge setWebViewDelegate:self];
    
    
    //给h5发数据(sessionId)
    [self.bridge callHandler:@"getSessionId" data:SESSIONID responseCallback:^(id responseData) {
//        NSLog(@"发sessionId后的反馈结果：%@", responseData);
    }];

    
    //接收js数据
//    [self.bridge registerHandler:@"getBlogNameFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"接收到的JS数据：%@", data);
//        
//        if (responseCallback) {
//            //反馈数据给h5
//            responseCallback(@{@"name": @"测试"});
//        }
//    }];

    
}

//加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    hudLoding.mode = MBProgressHUDModeText;
    [hudLoding setLabelText:@"加载完成"];
    [hudLoding hide:YES afterDelay:0.5];

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
