//
//  EzraRoundView.m
//  EzraRoundView
//
//  Created by Ezra on 2017/6/9.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "EzraRoundView.h"
#import "UICountingLabel.h"

#import "UIColor+Hex.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式


static CGFloat  lineWidth = 1.5;   // 线宽

static CGFloat  progressLineWidth = 1.5;  // 外圆进度的线宽


@interface EzraRoundView ()<UIScrollViewDelegate>
@property (nonatomic,strong)UILabel *reteLabel;

@property (nonatomic,strong)CAShapeLayer *rateLayer;//进度


@property (nonatomic,strong)UIImageView *coverImage;//蒙版


@property (nonatomic,strong)UIScrollView *scrollView;//轮播图
@property (nonatomic,strong)NSArray *indexBtns;//

@property (nonatomic,strong) CAShapeLayer *bottomShapeLayer; // 外圆的底层layer




@property (nonatomic,assign)CGFloat startAngle;  // 开始的弧度
@property (nonatomic,assign)CGFloat endAngle;  // 结束的弧度
@property (nonatomic,assign)CGFloat radius; // 内圆半径
@property (nonatomic,assign)CGFloat progressRadius; // 外圆半径

@property (nonatomic,assign)CGFloat centerX;  // 中心点 x
@property (nonatomic,assign)CGFloat centerY;  // 中心点 y

//@property (nonatomic,strong)UILabel *progressView;  //  进度文字

@property (nonatomic,strong)CAShapeLayer *progressBottomLayer; // 底部进度条的layer


@property (nonatomic,assign) int ratio;  // 记录百分比 用于数字跳动

//指示器
@property (nonatomic, strong) UIImageView *markerImageView;
@property (nonatomic, strong) CAKeyframeAnimation *pathAnimation;

@end

@implementation EzraRoundView


- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        
        [self drawLayers];
        [self MakeButton];//创建下面的说明
        
    }
    return self;
}

- (void)drawLayers{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 315)];
    bg.image = [UIImage imageNamed:@"年化率背景"];
    [self addSubview:bg];
    
    UIImageView *kedu = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 35+10, 200, 163)];
    kedu.image = [UIImage imageNamed:@"年化率刻度"];
    [self addSubview:kedu];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 105, SCREEN_WIDTH, 20)];
    label1.text = @"年化利率";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:20];
    [self addSubview:label1];
    
//    [self progressView];
    
    
    _startAngle = - 212;  // 启始角度
    _endAngle = 32;  // 结束角度
    
    _centerX = SCREEN_WIDTH / 2;  // 控制圆盘的X轴坐标
    _centerY = 35 + 115; // 控制圆盘的Y轴坐标
    
    _radius = 100;  // 内圆的半径
    _progressRadius = 115; // 外圆的半径
    
    //外圆底部园
    [self drawProgressBottomLayer];
     [self.layer addSublayer:_progressBottomLayer];
    
    //外圆变化的进度条
    [self drawProgressingLayer];//进度条颜色
    [self.layer addSublayer:_progressingLayer];
    
}

//外圆底部
- (CAShapeLayer *)drawProgressBottomLayer{
    
    _progressBottomLayer                 = [[CAShapeLayer alloc] init];
    _progressBottomLayer.frame           = self.bounds;
    UIBezierPath *path                   = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY)
                                                                          radius:_progressRadius
                                                                      startAngle:degreesToRadians(_startAngle)
                                                                        endAngle:degreesToRadians(_endAngle) clockwise:YES];
    
    _progressBottomLayer.path   = path.CGPath;
    
#pragma mark - 线段的开头为圆角
    _progressBottomLayer.lineCap = kCALineCapRound;
    _progressBottomLayer.lineWidth = progressLineWidth;
    _progressBottomLayer.strokeColor     = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5].CGColor;
    _progressBottomLayer.fillColor       = [UIColor clearColor].CGColor;
    
    return _progressBottomLayer;
}

//进度条
- (CAShapeLayer *)drawProgressingLayer{
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY )
                                                              radius:_progressRadius  startAngle:degreesToRadians(_startAngle)
                                                            endAngle:degreesToRadians(_endAngle )  clockwise:YES];
    
    _progressingLayer = [CAShapeLayer layer];
    _progressingLayer.frame = self.bounds;
    _progressingLayer.lineCap = kCALineCapRound;
    _progressingLayer.path = bezierPath.CGPath;
    _progressingLayer.fillColor = [UIColor clearColor].CGColor;
    _progressingLayer.strokeColor = [UIColor whiteColor].CGColor;
    _progressingLayer.lineWidth = progressLineWidth;
    //    _progressingLayer.strokeStart = 0;
    _progressingLayer.strokeEnd = 0;
    
    return _progressingLayer;
}







/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@synthesize percent = _percent;

- (void)setMaximum:(CGFloat)maximum
{
    if (maximum <= 0) {
        maximum = 1;
    }
    
    _maximum = maximum;
}

- (CGFloat )percent{
    return _percent;
}

//百分比的设置
- (void)setPercent:(CGFloat)percent{
    
    if (percent > 10000) {
        percent = 10000;
    }
    else if(percent<0){
        percent = 0;
    }
    else if (self.maximum < percent)
    {
        percent = 1;
    }
    
    _percent = percent / self.maximum ;
    
    self.ratio = percent * 100;
    
    
    [self performSelector:@selector(shapeChange) withObject:nil afterDelay:0];
    
}

- (void)shapeChange{
    
    // 复原
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:0];
    _progressingLayer.strokeEnd = 0 ;
    _upperShapeLayer.strokeEnd = 0 ;
    [CATransaction commit];
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:2.f];
    _progressingLayer.strokeEnd = _percent;;
    _upperShapeLayer.strokeEnd = _percent;;
    [self createAnimationWithEndAngle:_percent];
    
    [CATransaction commit];
    
    
    
  
   
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_percent * 0.02 target:self selector:@selector(updateLabl:) userInfo:nil repeats:YES];
//     [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}

- (void)createAnimationWithEndAngle:(CGFloat)endAngle{
    _pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    _pathAnimation.calculationMode = kCAAnimationPaced;
    _pathAnimation.fillMode = kCAFillModeForwards;
    _pathAnimation.removedOnCompletion = NO;
    _pathAnimation.duration = 2;
    _pathAnimation.repeatCount = 1;
    
    
    // 设置动画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL,_centerX, _centerY, _progressRadius, degreesToRadians(_startAngle), degreesToRadians(_startAngle + (fabs(_startAngle)+fabs(_endAngle))*endAngle), NO);
    _pathAnimation.path = path;
    CGPathRelease(path);
    
    //    //指示器
    [self addSubview:self.markerImageView];
    [self.markerImageView.layer addAnimation:_pathAnimation forKey:@"moveMarker"];
    
}

//指示器
- (UIImageView *)markerImageView {
    
    CGFloat height = self.frame.size.height;
    
    if (nil == _markerImageView) {
        _markerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-100, height, 16, 16)];
        _markerImageView.image = [UIImage imageNamed:@"年化率发光"];
        
    }
    return _markerImageView;
}

////中间的数字
//- (UILabel *)progressView{
//    if (!_progressView) {
//
//        _progressView = [[UILabel alloc]init];
//        _progressView.frame = CGRectMake(0, 142, SCREEN_WIDTH, 31);
//        _progressView.font = [UIFont systemFontOfSize:30];
//        _progressView.textAlignment = NSTextAlignmentCenter;
//        _progressView.textColor = [UIColor whiteColor];
//        _progressView.text = @"0%";
//        [self addSubview:_progressView];
//    }
//
//    return _progressView;
//}
//
//- (void)updateLabl:(NSTimer *)sender{
//    static int flag = 0;
//
//    if (flag   == self.ratio) {
//
//
//        [sender invalidate];
//        sender = nil;
//
//        self.progressView.text = [NSString stringWithFormat:@"%d",flag];
//
//        flag = 0;
//
//
//    }else{
//        self.progressView.text = [NSString stringWithFormat:@"%d",flag];
//
//    }
//
//    flag ++;
//
//}

- (void)setMyper:(CGFloat)myper{
    
    
    
    // make one that counts up from 5% to 10%, using ease in out (the default)
    UICountingLabel* countPercentageLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(0, 142, SCREEN_WIDTH, 31)];
    [self addSubview:countPercentageLabel];
    countPercentageLabel.font = [UIFont systemFontOfSize:30];
            countPercentageLabel.textAlignment = NSTextAlignmentCenter;
            countPercentageLabel.textColor = [UIColor whiteColor];
    countPercentageLabel.format = @"%.2f%%";
    countPercentageLabel.myrate = self.myrate;
    [countPercentageLabel countFrom:0.0 to:myper];
}



//创建说明
- (void)MakeButton{
    
    UIButton * button1= [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(SCREEN_WIDTH/2-120, 495.0*0.5, 120, 18);
    [button1 setTitle:@"消费能力" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"年化率说明圆圈"] forState:UIControlStateNormal];
    button1.titleLabel.font =[UIFont systemFontOfSize:13];
    [self addSubview:button1];
    button1.tag = 0;
    [button1 setImagePositionWithType:SSImagePositionTypeLeft spacing:8];
    [button1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * button2= [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(SCREEN_WIDTH/2, 495.0*0.5, 120, 18);
    [button2 setTitle:@"好友邀请" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"年化率说明圆圈"] forState:UIControlStateNormal];
    button2.titleLabel.font =[UIFont systemFontOfSize:13];
    [self addSubview:button2];
    button2.tag = 1;
    [button2 setImagePositionWithType:SSImagePositionTypeLeft spacing:8];
    [button2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat w = (SCREEN_WIDTH - 30)/3;
    NSArray *names = @[@"活跃度",@"分享率",@"购物行为"];
    for (int i=0; i<3; i++) {
        
        UIButton * button1= [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(15+(w)*i, button2.bottomY+20, w, 18);
        [button1 setTitle:names[i] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"年化率说明圆圈"] forState:UIControlStateNormal];
        button1.titleLabel.font =[UIFont systemFontOfSize:13];
        button1.tag = i+2;
        [self addSubview:button1];
        [button1 setImagePositionWithType:SSImagePositionTypeLeft spacing:8];
        [button1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


//弹框
-(void)btnClick:(UIButton *)btn{
    
    //蒙版
    UIImageView *coverImage = [[UIImageView alloc]init];
    self.coverImage = coverImage;
    coverImage.userInteractionEnabled = YES;
    coverImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    coverImage.image = [UIImage imageNamed:@"黑色蒙板"];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:coverImage];
    [coverImage addTapActionTouch:^{
        //        [self.coverImage removeFromSuperview];
    }];
    
    //内容
    UIView * viewSub = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-270)*0.5, (SCREEN_HEIGHT-295)*0.5, 270, 295)];
    viewSub.backgroundColor = [UIColor whiteColor];
    viewSub.layer.cornerRadius = 5;
    viewSub.clipsToBounds = YES;
    [coverImage addSubview:viewSub];
    
    //关闭按钮
    UIButton * AdbuttonOff = [UIButton buttonWithType:UIButtonTypeCustom];
    AdbuttonOff.frame = CGRectMake(270-44, 0, 44, 35);
    [AdbuttonOff setImage:[UIImage imageNamed:@"rate关闭"] forState:UIControlStateNormal];
    [viewSub addSubview:AdbuttonOff];
    [AdbuttonOff addTapActionTouch:^{
        [self.coverImage removeFromSuperview];
    }];
    
    //创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 35, 270, 260-36)];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.userInteractionEnabled = YES;
    scrollView.pagingEnabled = YES;
    [viewSub addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(270*5, 260-36);
    
    
    NSArray *imagenames = @[@"弹窗消费能力",@"弹窗好友邀请",@"弹窗活跃度",@"弹窗分享率",@"弹窗购物行为"];
    NSArray *mainLabels = @[@"消费能力",@"好友邀请",@"活跃度",@"分享率",@"购物行为"];
    NSArray *subLabels = @[@"经常使用淘赚购物",
                           @"分享给好友，好友注册、消费都提升利率",
                           @"使用淘赚的频率，经常性签到",
                           @"经常分享淘赚、分享商品，与好友助力",
                           @"良好的购物行为，退货情况少"];
    
    
    for (int i=0; i<5; i++) {
        
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(270*i, 0, 270, 260-36)];
        bg.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:bg];
        
        //
        UIButton * img = [UIButton buttonWithType:UIButtonTypeCustom];
        img.frame = CGRectMake(0, 0, 270, 115);
        [img setImage:[UIImage imageNamed:imagenames[i]] forState:UIControlStateNormal];
        [bg addSubview:img];
        
        UILabel *mainL = [[UILabel alloc]initWithFrame:CGRectMake(0, img.bottomY+21, 270, 16)];
        mainL.text = mainLabels[i];
        mainL.textAlignment = NSTextAlignmentCenter;
        mainL.font = [UIFont systemFontOfSize:16];
        mainL.textColor = [UIColor blackColor];
        [bg addSubview:mainL];
        
        UILabel *subL = [[UILabel alloc]initWithFrame:CGRectMake(0, mainL.bottomY+20, 270, 13)];
        subL.text = subLabels[i];
        subL.textAlignment = NSTextAlignmentCenter;
        subL.font = [UIFont systemFontOfSize:13];
        subL.textColor = MAIN_COLOR_898989;
        [bg addSubview:subL];
        
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake((270-14*5)/2+14*i, scrollView.bottomY, 14, 36);
        [btn setImage:[UIImage imageNamed:@"rate未选中"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"rate选中"] forState:UIControlStateSelected];
        [viewSub addSubview:btn];
        btn.userInteractionEnabled = NO;
        [arr addObject:btn];
    }
    self.indexBtns = arr.copy;
    
    
    [scrollView setContentOffset:CGPointMake(270*(btn.tag), 0)];
    
    for (UIButton *indexbtn in self.indexBtns) {
        if (indexbtn.tag == btn.tag ) {
            indexbtn.selected = YES;
        }else{
            indexbtn.selected = NO;
        }
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x/270;
    
    for (UIButton *indexbtn in self.indexBtns) {
        if (indexbtn.tag == index ) {
            indexbtn.selected = YES;
        }else{
            indexbtn.selected = NO;
        }
    }
    
}


@end
