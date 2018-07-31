//
//  ShareView.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/9/8.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "ShareView.h"
//友盟分享6.1适配https
#import <UMSocialCore/UMSocialCore.h>

@interface ShareView()


@end

@implementation ShareView

// 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 注意：该处不要给子控件设置frame与数据，可以在这里初始化子控件的属性
    }
    return self;
}


//公用分享UI
-(void)shareXiumeiPublicUI{
    
#pragma mark ----------------（1）公用分享控件 -S------------
    //蒙版
    UIImageView * bageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bageView.userInteractionEnabled = YES;
      if ([self.ReportType isEqualToString:@"直播间分享"]) {
    
      }else{
          
          bageView.backgroundColor = MAIN_COLOR_AlertBJ;
          
      }
    [self addSubview:bageView];
    
    //透明button为了点击关闭背景
    UIButton * buttonalph = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonalph.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-568.0*px-MC_TabbarSafeBottomMargin);
    [buttonalph addTarget:self action:@selector(cancelbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [bageView addSubview:buttonalph];
    
    //容器
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 568.0*px);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        contentView.frame = CGRectMake(0, SCREEN_HEIGHT-568.0*px-MC_TabbarSafeBottomMargin, SCREEN_WIDTH, 568.0*px);
        
    }];
    contentView.backgroundColor = [UIColor whiteColor];
    [bageView addSubview:contentView];
    
    //容器底部遮挡白色,不然很难看
    if (iPhoneX) {
        UIView * viewBjX = [[UIView alloc]init];
        viewBjX.frame = CGRectMake(0, contentView.bottomY, SCREEN_WIDTH, MC_TabbarSafeBottomMargin);
        viewBjX.backgroundColor = [UIColor whiteColor];
        [bageView addSubview:viewBjX];
    }
    
    //想要分享给谁
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 98.0*px);
    topLabel.text = @"想要分享给谁";
    topLabel.font = [UIFont systemFontOfSize:16];
    topLabel.textColor = [UIColor colorWithHexString:@"#313131"];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:topLabel];
    
    //线1
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(30.0*px, CGRectGetMaxY(topLabel.frame), SCREEN_WIDTH - 30.0*px*2, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:197.0/255 green:197.0/255 blue:197.0/255 alpha:1];
    [contentView addSubview:line];
    

    
    
    //分享按钮
    NSArray *names = @[@"朋友圈",@"微信好友",@"新浪微博",@"QQ空间",@"QQ好友",@"举报"];
    for(int i = 0; i<names.count; i++) {
        //图片
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(63.0*px + (i%4) *(99.0*px + 76.0*px), CGRectGetMaxY(line.frame)+ 34.0*px + (i/4)*(99.0*px + 78.0*px), 99.0*px, 99.0*px);
        btn.backgroundColor = [UIColor whiteColor];
        
        if (i==names.count-1) {
            //1举报  2删除
            if ([self.ReportType isEqualToString:@"1"]) {
                
                //是别人的话题（举报）
                [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@1-2-1",names[i]]] forState:UIControlStateNormal];
                
            }else if([self.ReportType isEqualToString:@"2"]){
                //是自己的话题(删除)
                [btn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
                
            }
            
        }else{
            
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@1-2-1",names[i]]] forState:UIControlStateNormal];
            
        }

        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        switch (i) {
            case 0:
                //微信朋友圈
                [btn addTarget:self action:@selector(friendShareClick) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                [btn addTarget:self action:@selector(weixinShareClick) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                [btn addTarget:self action:@selector(sinaShareClick) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 3:
                [btn addTarget:self action:@selector(QZoneShareClick) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 4:
                [btn addTarget:self action:@selector(QQShareClick) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 5:
                
                //1举报  2删除
                if ([self.ReportType isEqualToString:@"1"]) {
                    //其他人（举报）
                    [btn addTarget:self action:@selector(reportbuttonClick) forControlEvents:UIControlEventTouchUpInside];
                    
                 }else if([self.ReportType isEqualToString:@"2"]){
                    //是自己的话题（删除）
                    [btn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
                    
                }

                break;
                
            default:
                break;
        }
        [contentView addSubview:btn];
        
        //标题
        UILabel *nameLabel = [[UILabel alloc ] init];
        nameLabel.frame =  CGRectMake(CGRectGetMaxX(btn.frame)- 99.0*px*0.5-99.0*px, CGRectGetMaxY(btn.frame), 198.0*px, 64.0*px);
       
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.textColor = [UIColor colorWithHexString:@"#696969"];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.adjustsFontSizeToFitWidth = YES;
        if (i==5) {
            
            //1举报  2删除
            if ([self.ReportType isEqualToString:@"1"]) {
                //其他人（举报）
               nameLabel.text = @"举报";
                
            }else if([self.ReportType isEqualToString:@"2"]){
                //是自己的话题（删除）
                 nameLabel.text = @"删除";
                
            }else{
                
            //ReportType 类型不传1、2就隐藏
            btn.hidden = YES;
            nameLabel.hidden = YES;
                
            }
        }else{
            
             nameLabel.text = names[i];
        }
        [contentView addSubview:nameLabel];
        
    }
    
      //线2
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(30.0*px, contentView.bounds.size.height - 90.0*px, SCREEN_WIDTH - 30.0*px*2, 0.5)];
    line2.backgroundColor = [UIColor colorWithRed:197.0/255 green:197.0/255 blue:197.0/255 alpha:1];
    [contentView addSubview:line2];
    
    //取消
    UIButton *cancelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelbutton.frame = CGRectMake(0, CGRectGetMaxY(line2.frame), SCREEN_WIDTH, 90.0*px);
    cancelbutton.backgroundColor = [UIColor whiteColor];
    [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
    cancelbutton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelbutton setTitleColor:[UIColor colorWithHexString:@"#313131"] forState:UIControlStateNormal];
    [cancelbutton addTarget:self action:@selector(cancelbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:cancelbutton];
    
#pragma mark ----------------公用分享控件 -E-------------
   
}

//只分享到微信UI
-(void)shareXiumeiOnlyWeiXinUI{
    
#pragma mark ----------------（2）只分享到微信UI-S------------
    //蒙版
    UIImageView * bageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bageView.userInteractionEnabled = YES;
    bageView.backgroundColor = MAIN_COLOR_AlertBJ;
    [self addSubview:bageView];
    
    //透明button为了点击关闭背景
    UIButton * buttonalph = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonalph.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120-MC_TabbarSafeBottomMargin);
    [buttonalph addTarget:self action:@selector(cancelbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [bageView addSubview:buttonalph];
    
    //容器--放分享按钮
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 120);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        contentView.frame = CGRectMake(0, SCREEN_HEIGHT-120-MC_TabbarSafeBottomMargin, SCREEN_WIDTH, 120);
        
    }];
    contentView.backgroundColor = [UIColor whiteColor];
    [bageView addSubview:contentView];
    
    //容器底部遮挡白色,不然很难看
    if (iPhoneX) {
        UIView * viewBjX = [[UIView alloc]init];
        viewBjX.frame = CGRectMake(0, SCREEN_HEIGHT-MC_TabbarSafeBottomMargin, SCREEN_WIDTH, MC_TabbarSafeBottomMargin);
        viewBjX.backgroundColor = [UIColor whiteColor];
        [bageView addSubview:viewBjX];
    }
    
    //分享按钮
    NSArray *arrayTitle = @[@"微信好友",@"朋友圈"];
    NSArray *arrayImages = @[@"只分享到微信好友",@"只分享到微信朋友圈"];
    CGFloat buttonWindth = 200.0*px;
     CGFloat buttonSpace = 120.0*px;
    CGFloat buttonMinX = SCREEN_WIDTH/2-60.0*px- buttonWindth;
    for(int i = 0; i < arrayTitle.count; i++) {
        //图片
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(buttonMinX + (buttonWindth + buttonSpace) * i, 0, buttonWindth, 120);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setImage:[UIImage imageNamed:arrayImages[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font  =[UIFont systemFontOfSize:13];
        [btn setTitle:arrayTitle[i] forState:UIControlStateNormal];
        //这一行调整图片和文字的位置
        [btn setImagePositionWithType:SSImagePositionTypeTop spacing:30.0*px];
        
        switch (i) {
            case 0:
                //微信好友
                [btn addTarget:self action:@selector(weixinShareClick) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                //微信朋友圈
                [btn addTarget:self action:@selector(friendShareClick) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                break;
        }
        [contentView addSubview:btn];

    }
    
    //线2
    UILabel *lineSmall = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-0.5, 30, 1, 50)];
    lineSmall.backgroundColor = MAIN_COLOR_Line_Xi;
    [contentView addSubview:lineSmall];
    
#pragma mark ----------------只分享到微信UI -E-------------
    
}

//嗅美花生好友邀请-分享,shareImage只能传入图片
-(void)shareXiumeiHuashengUI{
    
#pragma mark ----------------（3）嗅美花生好友邀请-分享UI-S------------
    //蒙版
    UIImageView * bageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bageView.userInteractionEnabled = YES;
    bageView.backgroundColor = MAIN_COLOR_AlertBJ;
    [self addSubview:bageView];
    
    //透明button为了点击关闭背景
    UIButton * buttonalph = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonalph.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-120-MC_TabbarSafeBottomMargin);
    [buttonalph addTarget:self action:@selector(cancelbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [bageView addSubview:buttonalph];
    
    //容器--放分享按钮
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 120);
    contentView.backgroundColor = [UIColor whiteColor];
    [bageView addSubview:contentView];
    
    //容器底部遮挡白色,不然很难看
    if (iPhoneX) {
        UIView * viewBjX = [[UIView alloc]init];
        viewBjX.frame = CGRectMake(0, SCREEN_HEIGHT-MC_TabbarSafeBottomMargin, SCREEN_WIDTH, MC_TabbarSafeBottomMargin);
        viewBjX.backgroundColor = [UIColor whiteColor];
        [bageView addSubview:viewBjX];
    }
    
    //分享按钮
    NSArray *arrayTitle = @[@"微信好友",@"朋友圈"];
    NSArray *arrayImages = @[@"只分享到微信好友",@"只分享到微信朋友圈"];
    CGFloat buttonWindth = 200.0*px;
    CGFloat buttonSpace = 120.0*px;
    CGFloat buttonMinX = SCREEN_WIDTH/2-60.0*px- buttonWindth;
    for(int i = 0; i < arrayTitle.count; i++) {
        //图片
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(buttonMinX + (buttonWindth + buttonSpace) * i, 0, buttonWindth, 120);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setImage:[UIImage imageNamed:arrayImages[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font  =[UIFont systemFontOfSize:13];
        [btn setTitle:arrayTitle[i] forState:UIControlStateNormal];
        //这一行调整图片和文字的位置
        [btn setImagePositionWithType:SSImagePositionTypeTop spacing:30.0*px];
        
        switch (i) {
            case 0:
                //微信好友
                [btn addTarget:self action:@selector(weixinShareClick) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                //微信朋友圈
                [btn addTarget:self action:@selector(friendShareClick) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                break;
        }
        [contentView addSubview:btn];
        
    }
    
    //线2
    UILabel *lineSmall = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-0.5, 30, 1, 50)];
    lineSmall.backgroundColor = MAIN_COLOR_Line_Xi;
    [contentView addSubview:lineSmall];
    
    //花生邀请分享图
    UIImageView * buttonImage = [[UIImageView alloc]init];
    buttonImage.image = self.shareImage;
    buttonImage.userInteractionEnabled = YES;
    [bageView addSubview:buttonImage];
    
    //动画
    CGFloat windthImage = 514.0*px;
    CGFloat heightImage = windthImage * 16.0 / 9.0;
    CGFloat ImageMinX = (SCREEN_WIDTH - windthImage) / 2.0;
    CGFloat ImageMinY = (SCREEN_HEIGHT-120-MC_TabbarSafeBottomMargin-MC_NavHeight-heightImage)/2.0;
    [UIView animateWithDuration:0.3 animations:^{
         contentView.frame = CGRectMake(0, SCREEN_HEIGHT-120-MC_TabbarSafeBottomMargin, SCREEN_WIDTH, 120);
    }completion:^(BOOL finished) {
        //起始坐标,16:9
         buttonImage.frame = CGRectMake(ImageMinX, -heightImage, windthImage, heightImage);
        [UIView animateWithDuration:0.3 animations:^{
            //动画后坐标
            buttonImage.frame = CGRectMake(ImageMinX, MC_NavHeight+ImageMinY, windthImage, heightImage);
        }];
    }];
    
#pragma mark ----------------（3）嗅美花生好友邀请-分享UI-E-------------
    
}




//小类型
-(void)setReportType:(NSString *)ReportType{
    _ReportType = ReportType;
  
}
//分享类型
-(void)setShareType:(NSString *)shareType{
    _shareType = shareType;
    //只分享到微信，要影藏其他分享按钮
    if ([self.ReportType isEqual:@"只分享到微信"]) {
        //只分享到微信
        [self shareXiumeiOnlyWeiXinUI];
        
    }else if ([self.ReportType isEqual:@"嗅美花生好友邀请"]){
     //嗅美花生好友邀请
        [self shareXiumeiHuashengUI];
        
    }else{
        //公用分享
        //应为要创建举报跟删除按钮，所以要在得到是否创建的数据后在创建UI
        [self shareXiumeiPublicUI];
        
    }
    
}
#pragma mark 各种分享点击事件
#pragma mark =============分享到哪里去================
//友盟分享6.1适配https==分享网页 text（分享的文字） descr(描述) thumImage（分享的图片，可以是网址，也可以是image） webpageUrl（分享的网页链接） shareType（分享的类型）
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType WithTitle:(NSString *)text WithContent:(NSString *)descr ThumImage:(id)thumImage WebpageUrl:(NSString*)webpageUrl shareType:(NSString *)shareType{
    //（1）防止出现null
    if ([NSString isNULL:webpageUrl]==YES) {
        webpageUrl = @"";
    }
    if ([NSString isNULL:text]==YES) {
        text = @"";
    }
    if ([NSString isNULL:descr]==YES) {
        descr = @"";
    }
    //(2)判断图片链接是否包含https
    if ([thumImage isKindOfClass:[NSString class]]) {
//       //是否是以http开头,就要转化成图片类型
        if ([thumImage hasPrefix:@"https"]==YES) {
            //           是以https开头什么也不干
           
        }else{
            
            UIImageView * imageView = [UIImageView new];
            [imageView sd_setImageWithURL:[NSURL URLWithString:thumImage] placeholderImage:[UIImage imageNamed:@"嗅美logo"]];
            //赋值
            thumImage = imageView.image;
            
        }
        
    }
    
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //新浪微博分享特殊
    if (platformType==UMSocialPlatformType_Sina) {
       
        if ([shareType isEqual:@"只分享文字"]) {
            //分享到新浪微博拼接上嗅美小尾巴
            text = [NSString stringWithFormat:@"%@%@ #嗅美#（来自@嗅美）",text,descr];
            //设置文本
            messageObject.text = text;
            
        }else if ([shareType isEqual:@"只分享图片"]) {
            //设置只分享图片的描述
            if ([NSString isNULL:text]==YES) {
                //无分享标题
                messageObject.text = @"我在嗅美分享了一张图片 #嗅美#（来自@嗅美）";
                
            }else{
                //有分享标题
                messageObject.text = [NSString stringWithFormat:@"%@ #嗅美#（来自@嗅美）",text];
                
            }
            
            //创建图片内容对象
            UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
            
            //如果有缩略图，则设置缩略图本地
            shareObject.thumbImage = thumImage;
            //分享的图片
            [shareObject setShareImage:thumImage];
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            
            
        }else{
            
            if (!thumImage) {
                //网页分享缩略图不能为空
                [DWBToast showCenterWithText:@"缩略图为空，无法分享"];
                return;
            }
            
            //设置文本
            //分享到新浪微博拼接上嗅美小尾巴
            webpageUrl = [NSString stringWithFormat:@"~>>%@  #嗅美#（来自@嗅美）",webpageUrl];
            messageObject.text =[NSString stringWithFormat:@"%@%@%@",text,descr,webpageUrl];
            //创建图片内容对象
            UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
            //如果有缩略图，则设置缩略图
            shareObject.thumbImage = thumImage;
            //分享的图片
            shareObject.shareImage = thumImage;
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            
        }
        
    }else{
        
        if ([shareType isEqual:@"只分享文字"]) {
            //设置文本
            messageObject.text = text;
            
        }else if ([shareType isEqual:@"只分享图片"]) {
            //创建图片内容对象
            UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
            //如果有缩略图，则设置缩略图本地
            shareObject.thumbImage = thumImage;
            
            [shareObject setShareImage:thumImage];
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            
            
        }else{
            
            if (!thumImage) {
                //网页分享缩略图不能为空
                [DWBToast showCenterWithText:@"缩略图为空，无法分享"];
                return;
            }
            //创建网页内容对象
            //判空
            NSString * descrNew;
            if ([NSString isNULL:descr]==YES) {
                
                descrNew = @"穿衣打扮 一步到位";
                
            }else{
                
                descrNew = descr;
                
            }
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:text descr:descrNew thumImage:thumImage];
            
            if ([NSString isNULL:webpageUrl]==YES) {
                [DWBToast showCenterWithText:@"失败，分享连接不存在"];
                 NSLog(@"分享连接：%@",webpageUrl);
            }else if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:webpageUrl]]){
                //不是https开头的
                 [DWBToast showCenterWithText:@"分享连接是无效网址"];
                NSLog(@"分享连接：%@",webpageUrl);
            }
            //设置网页地址(不设置，直接分享失败)
            shareObject.webpageUrl = webpageUrl;
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            
        }
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
         NSString *  strCode;
        
        if (error) {
          
            strCode = @"01";
            
            
            //顶部状态栏提醒--JDStatusBarStyleDark 样式
            NSString * messageInfo = nil;
            
            if (error.code==2014) {
                
                messageInfo = @"分享失败，图片链接必须为https";
                
            }else if (error.code==2008){
                
                if (platformType==UMSocialPlatformType_WechatSession||platformType==UMSocialPlatformType_WechatTimeLine) {
                    
                    messageInfo = @"分享失败，你没有安微信";
                    
                }else if (platformType==UMSocialPlatformType_QQ||platformType==UMSocialPlatformType_Qzone){
                    
                    messageInfo = @"分享失败，你没有安QQ";
                    
                }else{
                    messageInfo = @"分享失败";
                    
                }
                
            }else if (error.code==2009){
                
               messageInfo = @"分享失败，用户取消操作";
                
            }else{
                
                messageInfo = @"分享失败";
            }

            //顶部状态栏提醒
            [JDStatusBarNotification showJDStatusBarMy:messageInfo];
            
            
        }else{
            //顶部状态栏提醒
            [JDStatusBarNotification showJDStatusBarMy:@"分享成功"];
            
            strCode = @"00";
            
            //分享成功获得美币
            [self getCoin];
        }
        
        //分享结果回调
        if (self.shareResponse) {
            self.shareResponse(strCode);
        }
        
    }];
    
    //移除分享控件
    [self cancelbuttonClick];
}




//分享到微信朋友圈
- (void)friendShareClick{
    
    //分享的图片
    NSString *  shareType = nil;
    
    if ([self.shareType isEqualToString:@"只分享文字"]) {
        
        shareType = @"只分享文字";
        
    }else if ([self.shareType isEqualToString:@"只分享图片"]) {
        
      shareType = @"只分享图片";

    }else{
        
      shareType = nil;
    }
   //起调分享
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine WithTitle:self.shareTitle WithContent:self.descr ThumImage:self.shareImage WebpageUrl:self.shareUrl shareType:shareType];
}


//分享到微信好友
- (void)weixinShareClick{
    //分享的图片
    NSString *  shareType = nil;
    
    if ([self.shareType isEqualToString:@"只分享文字"]) {
        
        shareType = @"只分享文字";
        
    }else if ([self.shareType isEqualToString:@"只分享图片"]) {
        
        shareType = @"只分享图片";
        
    }else{
        
        shareType = nil;
    }
    //起调分享
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession WithTitle:self.shareTitle WithContent:self.descr ThumImage:self.shareImage WebpageUrl:self.shareUrl shareType:shareType];
}



//分享到新浪微博
- (void)sinaShareClick{
    //分享的图片
    NSString *  shareType = nil;
    
    if ([self.shareType isEqualToString:@"只分享文字"]) {
        
        shareType = @"只分享文字";
        
    }else if ([self.shareType isEqualToString:@"只分享图片"]) {
        
        shareType = @"只分享图片";
        
    }else{
        
        shareType = nil;
    }
    //起调分享
    [self shareWebPageToPlatformType:UMSocialPlatformType_Sina WithTitle:self.shareTitle WithContent:self.descr ThumImage:self.shareImage WebpageUrl:self.shareUrl shareType:shareType];
}



//分享到qq空间
- (void)QZoneShareClick{
    
    //分享的图片
    NSString *  shareType = nil;
    
    if ([self.shareType isEqualToString:@"只分享文字"]) {
        
        shareType = @"只分享文字";
        
    }else if ([self.shareType isEqualToString:@"只分享图片"]) {
        
        shareType = @"只分享图片";
        
    }else{
        
        shareType = nil;
    }
    //起调分享
    [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone WithTitle:self.shareTitle WithContent:self.descr ThumImage:self.shareImage WebpageUrl:self.shareUrl shareType:shareType];
}

//分享到QQ好友
- (void)QQShareClick{
    
    //分享的图片
    NSString *  shareType = nil;
    
    if ([self.shareType isEqualToString:@"只分享文字"]) {
        
        shareType = @"只分享文字";
        
    }else if ([self.shareType isEqualToString:@"只分享图片"]) {
        
        shareType = @"只分享图片";
        
    }else{
        
        shareType = nil;
    }
    //起调分享
    [self shareWebPageToPlatformType:UMSocialPlatformType_QQ WithTitle:self.shareTitle WithContent:self.descr ThumImage:self.shareImage WebpageUrl:self.shareUrl shareType:shareType];
}


//举报
-(void)reportbuttonClick{
    
    //举报点击回调
    if (self.shareResponse) {
        self.shareResponse(@"举报");
    }

    //移除分享控件
    [self cancelbuttonClick];
}

//删除
-(void)deleteClick{
    //删除点击回调
    if (self.shareResponse) {
        self.shareResponse(@"删除");
    }

    //移除分享控件
    [self cancelbuttonClick];
}

//移除分享控件
- (void)cancelbuttonClick{
    
    [self removeFromSuperview];
   
}


#pragma mark ================= 控件2 =================

- (void)getCoin{

    
}

@end
