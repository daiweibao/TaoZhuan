
//
//  LoadingView.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/9/12.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView()

@property (nonatomic,strong)UIViewController *vc;

@end

@implementation LoadingView

// 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}

#pragma mark ==================新封装方法 ====================================
//新封装方法，传入起始坐标和高度，是否有导航栏 就可以（暂未启用）
+(void)loadingView:(UIViewController*)controller isCreateBack:(BOOL)isBack viewMaxY:(CGFloat)max_Y viewHeight:(CGFloat)height{
    
    //必须判断否则会崩溃
    if (![controller isKindOfClass:[UIViewController class]]) {
//          NSLog(@"不是控制器");
        
    }else{
        
        LoadingView * loadView = [[LoadingView alloc]init];
        loadView.backgroundColor = [UIColor whiteColor];
        loadView.controller = controller;
        //是否创建返回键
        loadView.isBack = isBack;
        //y的最大坐标
        loadView.Max_Y = max_Y;
        //控件高度（调set方法）
        loadView.height = height;
        
        //判断要不要创建返回键
        if (isBack==YES) {
            //如果要创建返回按钮，起始坐标固定为0
            loadView.frame = CGRectMake(0, max_Y-height, SCREEN_WIDTH, height);
        }else{
            //如果要创建返回按钮，起始坐标固定为0
            loadView.frame = CGRectMake(0, max_Y-height, SCREEN_WIDTH, height);
        }
        loadView.tag = 456672;
        //添加到控制器上
        [controller.view addSubview:loadView];
        //添加到控制器最上层
        [controller.view bringSubviewToFront:loadView];
        
    }
    
    
}

//新加载
-(void)setHeight:(CGFloat)height{
    _height = height;
    //创建UI
    [self loadingNew];
    
}

//新的加载中
-(void)loadingNew{
    //gif动画
//    NSMutableArray * imagesArr = [NSMutableArray array];
//    for (int i = 0; i <2; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"加载中%d",i]];
//        if (image) {
//            [imagesArr addObject:image];
//           
//        }
//    }
    //判断控件高度==图片
    
    //初始化
    CGFloat myheight;
    //判断要不要创建返回键
    if (self.isBack==YES) {
        //如果要创建返回按钮
        myheight = MC_NavHeight+ (self.height-MC_NavHeight)/2-150.0*px;
        
    }else{
        //不用创建返回按钮
        myheight = self.height/2-150.0*px;
    }

    
   UIImageView * imageLoding = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-200.0*px, myheight, 400.0*px, 300.0*px)];
//    imageLoding.animationImages = imagesArr; //获取Gif图片列表
//    imageLoding.animationDuration = 1;     //执行一次完整动画所需的时长
//    imageLoding.animationRepeatCount = 0;  //动画重复次数
//    [imageLoding startAnimating];
    imageLoding.image = [UIImage gifImagePlay:@"加载中最新"];
    [self addSubview:imageLoding];
    
    
    //创建返回键和线
    if (self.isBack==YES) {
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, MC_StatusBarHeight, 44, 44);
        backButton.contentMode = UIViewContentModeScaleAspectFill;
        backButton.clipsToBounds = YES;
        [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(pressButtonLeftNew) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        //线
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, MC_NavHeight-1, SCREEN_WIDTH, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#d1d3db"];
        line.alpha = 0.55;
        [self addSubview:line];
    
    }
    
}
//加载失败
+(void)loadingfailure{
    
    UIViewController * controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    //必须判断否则会崩溃
    if ([controller isKindOfClass:[UIViewController class]]) {
        
        UIView * loadView = (UIView*)[controller.view viewWithTag:456672];
        //控件存在才添加
        if (loadView) {
            UIView * viewSub = [[UIView alloc]init];
            viewSub.backgroundColor = [UIColor whiteColor];
            viewSub.frame = CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, loadView.height-MC_NavHeight);
            [loadView addSubview:viewSub];
            
            UIButton * buttonFailu = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonFailu.frame = CGRectMake(0, viewSub.height/2.0f-280.0*px, SCREEN_WIDTH, 280.0*px);
            [buttonFailu setImage:[UIImage imageNamed:@"加载失败"] forState:UIControlStateNormal];
            buttonFailu.userInteractionEnabled = NO;
            [viewSub addSubview:buttonFailu];
            
            UILabel * labeltitle = [[UILabel alloc]init];
            labeltitle.frame = CGRectMake(0, buttonFailu.bottomY+40.0*px, SCREEN_WIDTH, 40);
            labeltitle.text = @"加载失败\n请检查你的网络";
            labeltitle.font = [UIFont systemFontOfSize:14];
            labeltitle.numberOfLines = 2;
            labeltitle.textAlignment = NSTextAlignmentCenter;
            labeltitle.textColor = MAIN_COLOR_898989;
            [viewSub addSubview:labeltitle];
            
        }
       
    }
    
    
}




//返回
-(void)pressButtonLeftNew{
    //返回
    [self.controller.navigationController popViewControllerAnimated:YES];
    
    //启动广告的返回（勿删，否则启动广告点击无法返回）
    [self.controller dismissViewControllerAnimated:YES completion:nil];

}


//移除加载中-新
+(void)removeLoadingController:(UIViewController*)controller{
    
    //必须判断否则会崩溃
    if ([controller isKindOfClass:[UIViewController class]]) {
        
        UIView * loadView = (UIView*)[controller.view viewWithTag:456672];
        //移除
        [loadView removeFromSuperview];
        
    }else{
        
//        NSLog(@"不是控制器");
    }
    
}





@end
