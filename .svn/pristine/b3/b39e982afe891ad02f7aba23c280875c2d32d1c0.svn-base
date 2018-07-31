//
//  WonderfulActivitiesController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2018/1/10.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "WonderfulActivitiesController.h"
#import "WebViewJavascriptBridge.h"

@interface WonderfulActivitiesController ()<WKScriptMessageHandler,WKNavigationDelegate>
//分享
@property (nonatomic,weak)UIView *bageView;
@property (nonatomic,weak)UIView *contentView;

@property WebViewJavascriptBridge *bridge;

@property(nonatomic,strong)WKWebView * webView;



//头像
@property(nonatomic,strong)UIImageView *headView;
@property(nonatomic,strong)UIView *bgview;
@end

@implementation WonderfulActivitiesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"精彩活动";
    
    
    
    //创建网页
    [self createWebView];
    
}

-(void)createWebView{
    
    //进行配置控制器
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //实例化对象
    configuration.userContentController = [WKUserContentController new];
    //与JS交互的注册，JS调用OC方法
    [configuration.userContentController addScriptMessageHandler:self name:@"shareInviteActivity"];
    
    //初始化
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.scrollView.bounces = NO;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:activityList]]];
    [self.view addSubview:_webView];
    
    //获取网页导航栏标题
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
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
    [self shareBtnClick];
    
}


//分享
- (void)shareBtnClick{
    
    //背景
    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0,0, 750, 1334)];
    self.bgview = bgview;
    
    
    UIImageView *bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 750, 1334)];
    bgimg.image = [UIImage imageNamed:@"精彩活动分享图4_1"];
    [bgview addSubview:bgimg];
    
    //帖二维码的控件
    UIImageView *dd = [[UIImageView alloc]initWithFrame:CGRectMake((750-750*0.39)*0.5, 1334*0.71, 750*0.39, 750*0.39)];
    [bgview addSubview:dd];
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(750*0.39*0.8*0.5, 750*0.39*0.8*0.5, 750*0.39*0.2, 750*0.39*0.2)];
    logo.image = [UIImage imageNamed:appLogoName];
    logo.layer.cornerRadius = 1;
    logo.clipsToBounds = YES;
    [dd addSubview:logo];
    
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    // 2. 给滤镜添加数据
    NSString *string = invite_go;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    // 4. 显示二维码
    dd.image = [UIImage imageWithCIImage:image];
    
   
        //截屏分享
        UIImage * imageShare = [UIImage captureImageFromViewLowNoSaveAndInfo:self.bgview];
        [ShareView share:[UIApplication sharedApplication].keyWindow.rootViewController ShareTitle:nil WithContent:nil ShareUrl:nil shareImage:imageShare ReporStrType:@"嗅美花生好友邀请" shareType:@"只分享图片" completion:^(NSString *code) {
            
        }];
        
   
}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [LoadingView removeLoadingController:self];
    
}

#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    //网页title
    if ([keyPath isEqualToString:@"title"]){
        if (object == _webView) {
            self.titleLabel.text = _webView.title;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


//注意！注意！注意：上面将当前ViewController设置为MessageHandler之后需要在当前ViewController销毁前将其移除，否则会造成内存泄漏。
-(void)dealloc{
    [_webView removeObserver:self forKeyPath:@"title"];
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
