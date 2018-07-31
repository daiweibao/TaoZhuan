//
//  AlertGXJView.m
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/6/26.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "AlertGXJView.h"

@interface AlertGXJView()
@property (nonatomic, weak) UIView *contentView;
//弹框宽度
@property (nonatomic, assign) CGFloat widthAlter;
//类型
@property (nonatomic, assign) NSInteger type;

//标题和副标题
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *subTitleText;
@property (nonatomic,strong)NSArray * array;
@property (nonatomic,strong)UIViewController * controller;


@end

@implementation AlertGXJView

/**
 自己封装的共享街aleat type暂时还没用到
 
 @param controller 弹窗所在控制器
 @param title 标题
 @param message 内容
 @param array 按钮
 @param width 宽度
 @param type 类型，1代表允许重复弹窗 ,2代表允许移除老的弹窗，展示新的弹窗（推送用）
 @param block 回调
 */
+ (void)AlertGXJAlertWithController:(UIViewController*)controller Title:(NSString*)title Message:(NSString *)message otherItemArrays:(NSArray *)array Width:(CGFloat)width Type:(NSInteger)type handler:(ActionBlockAtIndex)block{

//   //判断弹窗是否在哪屏幕中，如果不在屏幕中就不要弹窗了--用系统弹窗时不用判断，否则必死
//    if ([UIView isViewAddWindowUp:controller.view]==NO) {
//        //控制器不在屏幕中，不要弹窗了
//        NSLog(@"收到控制器不在屏幕中的弹窗屏幕");
//        return;
//    }
    
    if (array.count>2) {
        NSLog(@"按钮个数必最多只能是2个");
        return;
    }
    
    //不在keyWindow上
    UIView * viewWX = (UIView*)[[UIApplication sharedApplication].keyWindow viewWithTag:1314506];

    if (type==1) {
        //推送可以重复弹窗,设置成nil
        viewWX =nil;
    }

    if (type==2 && viewWX != nil) {
        //移除上次创建的弹框，显示最新弹框
        //移除弹框
        [viewWX removeFromSuperview];
         viewWX =nil;
    }

    //控件不存在才创建，防止重复创建
    if (viewWX==nil) {
        AlertGXJView * alertView = [[AlertGXJView alloc]init];
        alertView.tag = 1314506;
        //添加 ==不在keyWindow上
        [[UIApplication sharedApplication].keyWindow addSubview:alertView];

        //    block
        alertView.actionBlockAtIndex = block;

        //弹框宽度
        if (width==-1 || width==0 || width>290) {
            //默认值
            width = 290;
        }
        alertView.widthAlter = width;

        alertView.type = type;

        //判空拦截
        if ([title isEqual:@""]||[NSString isNULL:title]) {
            title = nil;
        }
        if ([message isEqual:@""]||[NSString isNULL:message]) {
            message = nil;
        }

        if ([NSString isNULL:title]&&[NSString isNULL:message]) {

             title = @"抱歉，出错了~😂";
        }
       //赋值
        alertView.titleText = title;
        alertView.subTitleText = message;
        alertView.array = array;
        alertView.controller = controller;
        //    创建UI
//        [alertView setUpContentViewAray:array];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //创建系统aleart
            [alertView createAlertUI];
            
        });
        
    }
    
}


//init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//        //设置蒙版层背景色
//        self.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.7];
//        //开启用户交互
//        self.userInteractionEnabled = YES;
//        //添加点击手势（拦截点击事件）
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionView)];
//        [self addGestureRecognizer:tap];
        
        //关键盘
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        
    }
    return self;
}


#pragma mark ============== 先注释掉上面的自己创建的alert,最多只能2个按钮====================
-(void)createAlertUI{
    //换成系统的
    [AlertViewTool AlertAlertWithTitle:self.titleText Message:self.subTitleText otherItemArrays:self.array viewController:self.controller handler:^(NSInteger index) {
        if (index==0) {
            //回调按钮点击标记
            //回调按钮点击标记
            if (self.actionBlockAtIndex) {
                self.actionBlockAtIndex(0);
            }
            //移除控制器
            [self removeFromSuperview];
        }else if (index==1){
            //回调按钮点击标记
            if (self.actionBlockAtIndex) {
                self.actionBlockAtIndex(1);
            }
            //移除控制器
            [self removeFromSuperview];
        }
        
    }];
}


/*
//点击移除view(动画少点，否则会造成两个弹窗弹不出来)默认0.2
-(void)ActionBackRemoView{
    //移除动画
    [self dismissAlertAnimation];
    //控件动画影藏
//    [UIView animateWithDuration:0.01 animations:^{
        self.alpha = 0;
//    }];
//    [UIView animateWithDuration:0.01 animations:^{
        _contentView.alpha = 0;
//    } completion:^(BOOL finished) {
        [self removeFromSuperview];
//    }];
}

//创建UI
- (void)setUpContentViewAray:(NSArray*)array{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIView *contentView = [[UIView alloc]init];
        self.contentView = contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.masksToBounds = YES;
        contentView.layer.cornerRadius =5;
        //拦截点击事件
        contentView.clipsToBounds = YES;
        contentView.userInteractionEnabled = YES;
        //添加点击手势拦截
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionView)];
        [contentView addGestureRecognizer:tap];
        //添加控件
        [self addSubview:contentView];
        
        //创建UI
        [self createUITwo:array];
    });
}



#pragma mark ========== UI ===============
-(void)createUITwo:(NSArray*)array{
    if (array.count>2) {
        NSLog(@"按钮个数必最多只能是2个");
        return;
    }
    //添加标题
    CGSize sizetitle = [self.titleText boundingRectWithSize:CGSizeMake(self.widthAlter-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} context:nil].size;
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.titleText;
    titleLabel.frame = CGRectMake(15, 30, self.widthAlter-30, sizetitle.height);
    if (array.count==1) {
        
         titleLabel.font  = [UIFont boldSystemFontOfSize:17];
    }else{
        
        titleLabel.font  = [UIFont boldSystemFontOfSize:18];
        
    }
    titleLabel.textColor = [UIColor colorWithHexString:@"#313131"];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:titleLabel];
    
    //副标题
    CGSize sizeSubtitle = [self.subTitleText boundingRectWithSize:CGSizeMake(self.widthAlter-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    UILabel *messageLabel = [UILabel new];
    messageLabel.text = self.subTitleText;
    //如果大标题和小标题中的任何一个不存在就走这里
    if (self.subTitleText.length==0||self.titleText.length==0) {
        
        messageLabel.frame = CGRectMake(15, CGRectGetMaxY(titleLabel.frame), self.widthAlter-30, sizeSubtitle.height);
        
    }else{
        
        messageLabel.frame = CGRectMake(15, CGRectGetMaxY(titleLabel.frame)+20, self.widthAlter-30, sizeSubtitle.height);
        
    }
    
    messageLabel.font  = [UIFont systemFontOfSize:14];
    messageLabel.textColor = [UIColor colorWithHexString:@"#313131"];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:messageLabel];
    
    
     //只有一个按钮
     if (array.count==1) {
         //按钮
         UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
         buttonOne.frame = CGRectMake((self.widthAlter-120)/2, CGRectGetMaxY(messageLabel.frame)+25, 120, 35);
         [buttonOne setTitle:[array firstObject] forState:UIControlStateNormal];
         [buttonOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         buttonOne.titleLabel.font = [UIFont systemFontOfSize:17];
         buttonOne.backgroundColor = MAIN_COLOR;
         buttonOne.layer.cornerRadius = 5;
         buttonOne.layer.borderWidth = 1;
         buttonOne.layer.borderColor = MAIN_COLOR.CGColor;
         [buttonOne addTarget:self action:@selector(btnActionOne) forControlEvents:UIControlEventTouchUpInside];
         [_contentView addSubview:buttonOne];
         
         //设置View坐标
         _contentView.width = self.widthAlter;
         _contentView.height = CGRectGetMaxY(buttonOne.frame)+15;
         _contentView.center = self.center;

         
     }else{
         //2个按钮
         //按钮1
         CGFloat buttonWidth = (self.widthAlter - 46)/2;
         UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
         buttonOne.frame = CGRectMake(19, CGRectGetMaxY(messageLabel.frame)+25, buttonWidth, 35);
         [buttonOne setTitle:[array firstObject] forState:UIControlStateNormal];
         [buttonOne setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
         buttonOne.titleLabel.font = [UIFont systemFontOfSize:17];
         buttonOne.layer.cornerRadius = 5;
         buttonOne.layer.borderWidth = 1;
         buttonOne.layer.borderColor = MAIN_COLOR.CGColor;
         [buttonOne addTarget:self action:@selector(btnActionOne) forControlEvents:UIControlEventTouchUpInside];
         [_contentView addSubview:buttonOne];
         
         
         //按钮2
         UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
         buttonTwo.frame = CGRectMake(CGRectGetMaxX(buttonOne.frame)+8, CGRectGetMaxY(messageLabel.frame)+25, buttonWidth, 35);
         [buttonTwo setTitle:[array lastObject] forState:UIControlStateNormal];
         [buttonTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         buttonTwo.titleLabel.font = [UIFont systemFontOfSize:17];
         buttonTwo.backgroundColor = MAIN_COLOR;
         buttonTwo.layer.cornerRadius = 5;
         buttonTwo.layer.borderWidth = 1;
         buttonTwo.layer.borderColor = MAIN_COLOR.CGColor;
         [buttonTwo addTarget:self action:@selector(btnActionTwo) forControlEvents:UIControlEventTouchUpInside];
         [_contentView addSubview:buttonTwo];
         
         
         //设置View坐标
         _contentView.width = self.widthAlter;
         _contentView.height = CGRectGetMaxY(buttonTwo.frame)+15;
         _contentView.center = self.center;
         
     }
    
    //展示动画
    [self showAlertAnimation];
    
}


//按钮1点击事件
-(void)btnActionOne{
    //移除弹框
    [self ActionBackRemoView];
    //回调按钮点击标记
    if (self.actionBlockAtIndex) {
        self.actionBlockAtIndex(0);
    }
    
}

//按钮2点击事件
-(void)btnActionTwo{
    //移除弹框
    [self ActionBackRemoView];
    //回调按钮点击标记
    if (self.actionBlockAtIndex) {
        self.actionBlockAtIndex(1);
    }
}

-(void)ActionView{
    //什么也不干，拦截点击事件
}

//展示动画
- (void)showAlertAnimation {
    //弹出动画，不带弹簧
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .3;
    
    [_contentView.layer addAnimation:animation forKey:@"showAlert"];
    
}
//移除动画
- (void)dismissAlertAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)]];
    animation.keyTimes = @[ @0, @0.5, @1 ];
    animation.fillMode = kCAFillModeRemoved;
    animation.duration = 0.01;
    
    [_contentView.layer addAnimation:animation forKey:@"dismissAlert"];
}

*/

@end
