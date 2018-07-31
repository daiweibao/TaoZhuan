//
//  WebViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/1/11.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "WebViewController.h"
//网页
#import "HtmlWKWebView.h"

@interface WebViewController ()<WKNavigationDelegate>

@property(nonatomic,strong)UILabel *labelTitle;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //必须
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavigationController];
    
    if (self.sttWebID.length>0) {
        
        [self createWebView];
        
    }else{
        [AlertViewTool AlertAlertWithTitle:@"这个页面已经去火星了~" Message:nil otherItemArrays:@[@"知道啦"] viewController:self handler:^(NSInteger index) {
            //返回
            [self pressButtonLeft];
        }];

    }
    
    // Do any additional setup after loading the view.
}


#pragma mark 创建导航栏
-(void)createNavigationController{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(pressButtonLeft)];
    self.navigationItem.leftBarButtonItem = item;
    //设置中间标题
   _labelTitle                = [[UILabel alloc]init];
    _labelTitle.frame                   = CGRectMake(100, 0, self.view.frame.size.width-200, 64);
    _labelTitle.text                    = self.strTitle;
    _labelTitle.textColor               = [UIColor blackColor];
    _labelTitle.textAlignment           = NSTextAlignmentCenter;
    _labelTitle.font                    = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = _labelTitle;

    
}

-(void)createWebView{
    
    WKWebView *webView = [[WKWebView alloc]init];
    webView.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight-MC_TabbarSafeBottomMargin);
    webView.scrollView.showsVerticalScrollIndicator=YES;
    //关闭水平滚动条
    webView.scrollView.showsHorizontalScrollIndicator=NO;
    //设置滚动视图的背景颜色
    webView.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    webView.navigationDelegate = self;
    //两条属性关闭黑影
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    

    //解析网址
     [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.sttWebID]]]];
    [self.view addSubview:webView];
    
    //加载中+ 封装方法，loadingView：传入控制器 isCreateBack：是否创建返回键，viewMaxY：加载中控件的最大Y值，viewHeight：控件高度
    [LoadingView loadingView:self isCreateBack:NO viewMaxY:SCREEN_HEIGHT viewHeight:SCREEN_HEIGHT-MC_NavHeight];
}

//页面加载完后获取高度，设置脚,注意，控制器里不能重写代理方法，否则这里会不执行
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //移除封装的加载中
        [LoadingView removeLoadingController:self];
        
    });
}


-(void)pressButtonLeft{
    //回去开始时间
    if (self.timeStare) {
        self.timeStare();
    }
    //其他返回
    [self.navigationController popViewControllerAnimated:YES];
    //启动广告的返回（勿删，否则启动广告点击无法返回）
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pressButtonRight{
//    NSLog(@"设置");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@", self.class]];//("PageOne"为页面名称，可自定义)
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@", self.class]];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
