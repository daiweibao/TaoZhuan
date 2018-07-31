//
//  UserRedBagAlertView.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2018/1/11.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "UserRedBagAlertView.h"

@interface UserRedBagAlertView()
//背景
@property(nonatomic,strong)UIImageView *coverImage;
@property(nonatomic,strong)UIImageView *heartImage;
@property(nonatomic,strong)UILabel *textLabel;
//头像
@property(nonatomic,strong)UIImageView *headView;
@property(nonatomic,strong)UIView *bgview;

@end

@implementation UserRedBagAlertView

// 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createNewUserUI];
    }
    return self;
}

//创建UI
-(void)createNewUserUI{
    
    //蒙版
    _coverImage = [[UIImageView alloc]init];
    _coverImage.userInteractionEnabled = YES;
    _coverImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _coverImage.image = [UIImage imageWithColor:MAIN_COLOR_AlertBJ];
    [[UIApplication sharedApplication].keyWindow addSubview:_coverImage];
    
    //图片442*558
    UIImageView *heartImage = [[UIImageView alloc]init];
    self.heartImage = heartImage;
    heartImage.frame = CGRectMake((SCREEN_WIDTH-222)/2, (SCREEN_HEIGHT-288)/2, 222, 288);
    heartImage.image = [UIImage imageNamed:@"抽红包4_1"];
    [_coverImage addSubview:heartImage];
    heartImage.userInteractionEnabled = YES;
    [heartImage addTapActionTouch:^{
        //抽红包
        [self getRedClick];
    }];
    
}

//点击了抽红包
- (void)getRedClick{
    
    [self.heartImage removeFromSuperview];
    
    //图片442*558
    UIImageView *heartImage = [[UIImageView alloc]init];
    heartImage.frame = CGRectMake((SCREEN_WIDTH-250)/2, (SCREEN_HEIGHT-366)/2, 250, 316);
    heartImage.image = [UIImage imageNamed:@"红包抽中4_1"];
    [_coverImage addSubview:heartImage];
    
    //关闭
    UIButton *closeBtn = [[UIButton alloc]init];
    closeBtn.frame = CGRectMake(heartImage.rightX-40, heartImage.y-10, 44, 44);
    [closeBtn setImage:[UIImage imageNamed:@"红包关闭4_1"] forState:UIControlStateNormal];
    [_coverImage addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //分享
    UIButton *shareBtn = [[UIButton alloc]init];
    shareBtn.frame = CGRectMake(0, heartImage.bottomY+14, SCREEN_WIDTH, 36);
    [shareBtn setImage:[UIImage imageNamed:@"红包分享按钮4_1"] forState:UIControlStateNormal];
    [_coverImage addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];

//    370/170
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 185, 250, 85)];
    textLabel.font = [UIFont boldSystemFontOfSize:30];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [heartImage addSubview:textLabel];
    textLabel.text = [NSString stringWithFormat:@"%@元",self.gain];
    
}

//关闭
- (void)closeBtnClick{
    [_coverImage removeFromSuperview];
}

//分享
- (void)shareBtnClick{

    [self  closeBtnClick];
    
    //分享
    UIImage * image = [UIImage imageNamed:@"花生分享红包图"];
    [ShareView share:self.parentController ShareTitle:@"来淘赚领红包喽" WithContent: [NSString stringWithFormat:@"我是%@，我在淘赚领取了%@元现金红包，你也来试试吧~",USER_name,self.gain] ShareUrl:ShareRedPacket shareImage:image ReporStrType:@"只分享到微信" shareType:nil completion:^(NSString *code) {
        
    }];
    
    
#pragma mark =============下面试当时生成红包二维码的代码，暂时注释掉==================
//    //背景
//    UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(0,0, 750, 1334)];
//    self.bgview = bgview;
//    
//    
//    UIImageView *bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 750, 1334)];
//    bgimg.image = [UIImage imageNamed:@"分享扫码领红包背景图"];
//    [bgview addSubview:bgimg];
//    
//    //头像
//    UIImageView *headView = [[UIImageView alloc]init];
//    self.headView = headView;
//    headView.frame = CGRectMake((750-110)*0.5, 250, 110, 110);
//    headView.layer.cornerRadius = 55;
//    headView.contentMode = UIViewContentModeScaleAspectFill;
//    headView.clipsToBounds = YES;
//    [bgview addSubview:headView];
//   
//    //用户
//    UILabel * namelabel = [[UILabel alloc]init];
//    namelabel.frame = CGRectMake(0, headView.bottomY+20, 750, 32);
//    namelabel.textColor = [UIColor whiteColor];
//    namelabel.font  =[UIFont systemFontOfSize:30];
//    namelabel.textAlignment = NSTextAlignmentCenter;
//    namelabel.adjustsFontSizeToFitWidth = YES;
//    namelabel.text = [NSString stringWithFormat:@"我是%@",USER_name];
//    [bgview addSubview:namelabel];
//    
//    //用户
//    UILabel * sublabel = [[UILabel alloc]init];
//    sublabel.frame = CGRectMake(0, namelabel.bottomY+26, 750, 32);
//    sublabel.textColor = [UIColor whiteColor];
//    sublabel.font  =[UIFont systemFontOfSize:30];
//    sublabel.textAlignment = NSTextAlignmentCenter;
//    sublabel.adjustsFontSizeToFitWidth = YES;
//    sublabel.text = @"我在嗅美给你发现金红包";
//    [bgview addSubview:sublabel];
//    
//    UIImageView *dd = [[UIImageView alloc]initWithFrame:CGRectMake((750-200)*0.5, 780, 200, 200)];
//    [bgview addSubview:dd];
//    
//    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(200*0.8*0.5, 200*0.8*0.5, 200*0.2, 200*0.2)];
//    logo.image = [UIImage imageNamed:appLogoName];
//    logo.layer.cornerRadius = 1;
//    logo.clipsToBounds = YES;
//    [dd addSubview:logo];
//    
//    
//    // 1. 创建一个二维码滤镜实例(CIFilter)
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    // 滤镜恢复默认设置
//    [filter setDefaults];
//    // 2. 给滤镜添加数据
//    NSString *string = invite_go;
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    // 使用KVC的方式给filter赋值
//    [filter setValue:data forKeyPath:@"inputMessage"];
//    // 3. 生成二维码
//    CIImage *image = [filter outputImage];
//    // 4. 显示二维码
//    dd.image = [UIImage imageWithCIImage:image];
//    
//    [headView sd_setImageWithURL:[NSURL URLWithString:USER_PhoneImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        //截屏分享
//        UIImage * imageShare = [UIImage captureImageFromViewLowNoSaveAndInfo:self.bgview];
//        [ShareView share:[UIApplication sharedApplication].keyWindow.rootViewController ShareTitle:nil WithContent:nil ShareUrl:nil shareImage:imageShare ReporStrType:@"嗅美花生好友邀请" shareType:@"只分享图片" completion:^(NSString *code) {
//            
//        }];
//        
//    }];

}



@end
