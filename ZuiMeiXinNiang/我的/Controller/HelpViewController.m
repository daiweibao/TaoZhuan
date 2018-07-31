

//
//  HelpViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/7/8.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "HelpViewController.h"
#import "WebViewJavascriptBridge.h"
//联系客服界面
#import "PeanutServiceListController.h"
@interface HelpViewController ()<WKScriptMessageHandler,WKNavigationDelegate>
//分享
@property (nonatomic,weak)UIView *bageView;
@property (nonatomic,weak)UIView *contentView;

@property WebViewJavascriptBridge *bridge;

@property(nonatomic,strong)WKWebView * webView;
@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"帮助";
    
    //创建网页
    [self createWebView];
    
}

-(void)createWebView{
    
    //进行配置控制器
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    configuration.userContentController = [WKUserContentController new];
    //与JS交互的注册，JS调用OC方法，联系客服
    [configuration.userContentController addScriptMessageHandler:self name:@"goService"];
    
    //初始化
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) configuration:configuration];
    _webView.navigationDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:appHelp4_1]]];

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
    //联系客服
    
    if ([NSString isNULL:SESSIONID]) {
      
        //弹窗登陆
        [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
            
        }];
    }else{
        //客服界面
        PeanutServiceListController * search=[[PeanutServiceListController alloc]init];
        [self.navigationController pushViewController:search animated:YES];
    }

    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [LoadingView removeLoadingController:self];
    //    NSLog(@"3、WKWebView加载完成时调用");
    //    NSLog(@"%f",webView.scrollView.contentSize.height);
    //    NSLog(@"%f",self.webView.scrollView.contentSize.height);
}

//注意！注意！注意：上面将当前ViewController设置为MessageHandler之后需要在当前ViewController销毁前将其移除，否则会造成内存泄漏。
-(void)dealloc{
    
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"goService"];
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


