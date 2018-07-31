//
//  PeanutRankListController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/19.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "PeanutRankListController.h"

@interface PeanutRankListController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation PeanutRankListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backButton.hidden = NO;
    self.titleLabel.text = @"邀请排行榜";
    
    [self createWebView];
    
}

-(void)createWebView{
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight)];
    NSURL *url = [NSURL URLWithString:weekList];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.scrollView.bounces = NO;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //加载中+ 封装方法，loadingView：传入控制器 isCreateBack：是否创建返回键，viewMaxY：加载中控件的最大Y值，viewHeight：控件高度
    [LoadingView loadingView:self isCreateBack:NO viewMaxY:SCREEN_HEIGHT viewHeight:SCREEN_HEIGHT-MC_NavHeight];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [LoadingView removeLoadingController:self];
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
