//
//  HuaShenMoneyBarTopicCell.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/1/9.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "HuaShenMoneyBarTopicCell.h"
#import "ActivityGoodsListController.h"//活动商品详情
#import "TBAndJDGoodsClassListController.h"//三种商品分类列表
@interface HuaShenMoneyBarTopicCell()
@property (nonatomic,strong)NSArray *arrayActiveType;//推广活动类型

@end

@implementation HuaShenMoneyBarTopicCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];

    }
    return self;
}

//得到数据
-(void)getDateScrollerArray:(NSArray*)arrayScroller AndActiveArray:(NSArray*)activeArray andSelseTitle:(NSString*)selseTitle{
    self.arrayActiveType = activeArray;//得到数据
    //创建UI并赋值
    [self setupUI];
}

//创建其他固定UI
-(void)setupUI{
    //移除所有子视图
    [self.contentView removeAllSubviews];
    //创建大分割线
    UIImageView * imageLineBig = [[UIImageView alloc]init];
    imageLineBig.frame = CGRectMake(0,0, SCREEN_WIDTH, 20.0*px);
    imageLineBig.backgroundColor = MAIN_COLOR_Line_Cu;
    [self.contentView addSubview:imageLineBig];
    
    //创建9.9包邮
    //    NSArray * bigImageArray = @[@"9.9包邮",@"领券秒杀"];
    CGFloat buttonBigY = imageLineBig.bottomY;//底部
    CGFloat Activewidth = SCREEN_WIDTH/2-45.0*px;
    CGFloat ActiveHeight = 190.0*px;
    for (int j = 0; j <self.arrayActiveType.count ; j++) {
        //搜索框和汉字
        UIButton * buttonBig = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBig.frame =CGRectMake(30.0*px+(Activewidth+30.0*px)*(j%2),imageLineBig.bottomY+30.0*px+(ActiveHeight+30.0*px)*(j/2), Activewidth, ActiveHeight);
        buttonBig.layer.cornerRadius = 5;
        buttonBig.imageView.contentMode = UIViewContentModeScaleAspectFill;
        buttonBig.clipsToBounds = YES;
        if ([NSString isNULL:self.arrayActiveType[j][@"imgUrl"]]) {
            //判空
            [buttonBig setImage:[UIImage imageNamed:@"启动图标最终版"] forState:UIControlStateNormal];
        }else{
            [buttonBig sd_setImageWithURL:[NSURL URLWithString:self.arrayActiveType[j][@"imgUrl"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"启动图标最终版"]];
        }
        [buttonBig addTarget:self action:@selector(ActionButtonBig:) forControlEvents:UIControlEventTouchUpInside];
        buttonBig.tag = 1100+j;
        [self.contentView addSubview:buttonBig];
        //底部
        buttonBigY = buttonBig.bottomY;
    }
    
    if (self.arrayActiveType.count==0) {
        //减去距离,和大分割线
        buttonBigY =  buttonBigY -30.0*px- 20.0*px;
        imageLineBig.hidden = YES;
    }
    
    
    //创建热门推销
    UIView * hotView = [[UIView alloc]init];
    hotView.frame =CGRectMake(0, buttonBigY+ 30.0*px, SCREEN_WIDTH, 60.0*px);
    hotView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:hotView];
    UILabel * labelHot = [[UILabel alloc]init];
    labelHot.frame = CGRectMake(30.0*px, 20.0*px, SCREEN_WIDTH, 40.0*px);
    labelHot.text =@"热销推荐";
    labelHot.font = [UIFont systemFontOfSize:14];
    labelHot.textColor = MAIN_COLOR_313131;
    [hotView addSubview:labelHot];
}

//查看活动列表
-(void)ActionButtonBig:(UIButton*)button{
    //活动Id
    NSString * avtiveId = self.arrayActiveType[button.tag-1100][@"activityId"];
    NSString * navTitle = self.arrayActiveType[button.tag-1100][@"typeName"];
    //跳转到活动详情列表
    ActivityGoodsListController *vc = [[ActivityGoodsListController alloc]init];
    vc.avtiveId = avtiveId;
    vc.navTitle = navTitle;
    [self.parentController.navigationController pushViewController:vc animated:YES];
}

@end
