//
//  TBSeaechAlertView.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/25.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "TBSeaechAlertView.h"
#import "TBAndJDGoodsWebController.h"
@interface TBSeaechAlertView()
@property (nonatomic, weak) UIButton *contentView;
@property(nonatomic,weak)UIButton * buttonIcon;
@property(nonatomic,strong)NSString * searchString;//搜索内容
@end

@implementation TBSeaechAlertView

/**
 淘宝口令搜索弹窗
 */
+ (void)AlertTBSeaechAlertWitView{
    
    NSString * contentString;//内容
    
//  获取设备的剪贴板很简单，一行代码搞定​,然后判断是否包含口令
    NSString *shareStr = [UIPasteboard generalPasteboard].string;
    if ([shareStr containsString:@"【"]&&[shareStr containsString:@"】"]) {
        //取出一个字符串括号【】之间的内容
        NSString *string = shareStr;
        NSRange startRange = [string rangeOfString:@"【"];
        NSRange endRange = [string rangeOfString:@"】"];
        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
        NSString *result1 = [string substringWithRange:range];
        contentString = result1;
        
        
        //内容二次判断是否右括号，取出（）之间的内容--淘宝商品就是这样的
        if ([result1 containsString:@"（"]&&[result1 containsString:@"）"]) {
            //取出括号（）之间的内容
            NSRange startRange2 = [result1 rangeOfString:@"（"];
            NSRange endRange2 = [result1 rangeOfString:@"）"];
            NSRange range2 = NSMakeRange(startRange2.location + startRange2.length, endRange2.location - startRange2.location - startRange2.length);
            NSString *result2 = [result1 substringWithRange:range2];
             contentString = result2;
        }
        
        NSLog(@"取出的内容%@",contentString);
    }else if ([shareStr containsString:@"item.m.jd.com/product"]&&[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:shareStr]]){
        //京东商品，判断网址能打开，并且是京东商品
        contentString = shareStr;
        
    }else{
        //不创建
        return;
    }
    
    //判空
    if ([NSString isNULL:contentString]) {
        return;
    }
    //字数大于等于5个才展示
    if (contentString.length<5) {
        return;
    }
    
    //清除粘贴板，防止多次弹出
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"";
    
    //延迟1秒创建
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //不在keyWindow上
        UIView * viewWX = (UIView*)[[UIApplication sharedApplication].keyWindow viewWithTag:19920227];
        //控件不存在才创建，防止重复创建
        if (viewWX==nil) {
            TBSeaechAlertView * alertView = [[TBSeaechAlertView alloc]init];
            alertView.tag = 19920227;
            //搜索内容
            alertView.searchString = contentString;
            //添加 ==不在keyWindow上
            [[UIApplication sharedApplication].keyWindow addSubview:alertView];
            //创建UI
            [alertView setUpContentView:contentString];
        }
        
    });
}


//init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        //设置蒙版层背景色
        self.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:0.7];
        //开启用户交互
        self.userInteractionEnabled = YES;
        //添加点击手势（拦截点击事件）
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionView)];
        [self addGestureRecognizer:tap];
        
        //关键盘
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        
    }
    return self;
}

//点击移除view(动画少点，否则会造成两个弹窗弹不出来)默认0.2
-(void)ActionBackRemoView{
    //移除动画
    [self dismissAlertAnimation];
    [self removeFromSuperview];
}

//创建UI
- (void)setUpContentView:(NSString *)contentStr{
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        UIButton *contentView = [[UIButton alloc]init];
        self.contentView = contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius =5;
        //拦截点击事件
        contentView.userInteractionEnabled = YES;
        //添加点击手势拦截
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionView)];
        [contentView addGestureRecognizer:tap];
        //添加控件
        [self addSubview:contentView];
        
        //创建UI
        [self createUITwo:contentStr];
    });
}



#pragma mark ========== UI ===============
-(void)createUITwo:(NSString *)contentStr{
    //弹框宽度
    CGFloat widthAlter = 316.0*2.0*px;
    
    //设置View坐标
    _contentView.width = widthAlter;
    _contentView.height = 190;
    _contentView.center = self.center;
    
    //创建logo
    UIButton * buttonIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonIcon = buttonIcon;
    buttonIcon.frame = CGRectMake(_contentView.width/2-35, -30, 70, 70);
    if ([self.searchString containsString:@"item.m.jd.com/product"]){
        [buttonIcon setImage:[UIImage imageNamed:@"京东口令logo"] forState:UIControlStateNormal];
        
    }else{
        
        [buttonIcon setImage:[UIImage imageNamed:@"淘宝口令logo"] forState:UIControlStateNormal];
    }
    [_contentView addSubview:buttonIcon];
    
    //添加固定标题
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"淘赚检测到你复制的关键词";
    titleLabel.frame = CGRectMake(15, 55, _contentView.width-30, 15);
    titleLabel.font  = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHexString:@"#313131"];
    [_contentView addSubview:titleLabel];
    
    //2个按钮 316*80
    //按钮1
    CGFloat buttonWidth = widthAlter / 2.0;
    UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonOne.frame = CGRectMake(0, _contentView.height-80.0*px, buttonWidth, 80.0*px);
    [buttonOne setBackgroundImage:[UIImage imageNamed:@"淘宝取消"] forState:UIControlStateNormal];
     buttonOne.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;//底部对齐
    [buttonOne addTarget:self action:@selector(btnActionOne) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:buttonOne];
    
    
    //按钮2
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTwo.frame = CGRectMake(CGRectGetMaxX(buttonOne.frame), _contentView.height-80.0*px, buttonWidth, 80.0*px);
    if ([self.searchString containsString:@"item.m.jd.com/product"]){
         [buttonTwo setBackgroundImage:[UIImage imageNamed:@"京东口令查看详情"] forState:UIControlStateNormal];
        
    }else{
        
        [buttonTwo setBackgroundImage:[UIImage imageNamed:@"立即搜索"] forState:UIControlStateNormal];
        
    }
    buttonTwo.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;//底部对齐
    [buttonTwo addTarget:self action:@selector(btnActionTwo) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:buttonTwo];
    
    //复制的内容
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.text =[NSString stringWithFormat:@"%@",contentStr];
    messageLabel.frame =CGRectMake(15,titleLabel.bottomY+10,_contentView.width-30,40);
    messageLabel.font  = [UIFont systemFontOfSize:14];
    messageLabel.textColor = [UIColor colorWithHexString:@"#313131"];
    messageLabel.numberOfLines = 2;
    [_contentView addSubview:messageLabel];
    
    //展示动画
    [self showAlertAnimation];
    
}


//按钮1点击事件
-(void)btnActionOne{
    //移除弹框
    [self ActionBackRemoView];
    
}

//按钮2点击事件--立即搜索
-(void)btnActionTwo{
    
    if ([self.searchString containsString:@"item.m.jd.com/product"]){
        
         UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
        //先登录了才能购买
        if ([NSString isNULL:SESSIONID]) {
          
            //弹窗登陆
            [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                
            }];
        }else{
            //打开京东商品
            TBAndJDGoodsWebController * JdAndTBVC = [[TBAndJDGoodsWebController alloc]init];
             JdAndTBVC.urlTbOrJd = self.searchString;//口令打开刚才肤质的京东商品
             JdAndTBVC.type = @"京东";//类型不传是淘宝
            JdAndTBVC.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:JdAndTBVC animated:YES];
        }
        
    }else{
        //搜索爱淘宝商品
        [OpenTaobaoGoodes TBSearchGoodsController:[UIApplication sharedApplication].keyWindow.rootViewController AndTBWords:self.searchString];
        
        //淘宝搜索上传热搜词
        [self uploadSearchKey:self.searchString];
    }
    
    //移除弹框
    [self ActionBackRemoView];
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


//淘宝口令搜索上传搜索词
- (void)uploadSearchKey:(NSString *)str{
    if ([NSString isNULL:str]) {
        str = @"糖宝";
    }
    NSDictionary *dict = @{@"searchKey":str};
    [GXJAFNetworking POST:addSearchKey parameters:dict success:^(id  _Nullable responseObject) {
    } failure:^(NSError * _Nullable error) {
    }];
}




@end
