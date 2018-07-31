//
//  ChuanYiJieHuoCell.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/9/14.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "ChuanYiJieHuoCell.h"


@interface ChuanYiJieHuoCell()
@property (nonatomic,strong)UIView *bg;
@property (nonatomic,strong)UIImageView * imagebg;//蓝色橙色背景
@property (nonatomic,strong)UIImageView * headView;//头像
@property (nonatomic,strong)UILabel * labeltitle;//名字
@property (nonatomic,strong)UILabel * signtitle;//标签
@property (nonatomic,strong)UILabel * counttitle;//次数

@property (nonatomic,strong)UIButton *xunwen;//询问按钮

//标签图标
@property (nonatomic,strong)UIImageView *signView;

//logo
@property (nonatomic,strong)UILabel *logotitle;
@end


@implementation ChuanYiJieHuoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)setIndex:(NSInteger)index{
    _index = index;
    if (index==0) {
         _headView.image = [UIImage imageNamed:@"客服一"];
         _labeltitle.text = @"人工客服一";
    }else{
         _headView.image = [UIImage imageNamed:@"客服二"];
         _labeltitle.text = @"人工客服二";
    }
    
}

-(void)createUI{
    
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 105)];
    self.bg = bg;
    bg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bg];
    
    //bg
    UIImageView * imagebg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 105)];
    self.imagebg = imagebg;
    imagebg.backgroundColor = MAIN_COLOR_qqGreen;
    [bg addSubview:imagebg];

    //询问按钮
    UIButton *xunwen = [UIButton buttonWithType:UIButtonTypeCustom];
    self.xunwen = xunwen;
    xunwen.frame = CGRectMake(SCREEN_WIDTH-30-15-65, 0, 65, 105);
    [xunwen setImage:[UIImage imageNamed:@"询问按钮"] forState:UIControlStateNormal];
    [imagebg addSubview:xunwen];
    xunwen.userInteractionEnabled = NO;
    
    //头像
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 55, 55)];
    self.headView = headView;
    headView.contentMode = UIViewContentModeScaleAspectFill;
    headView.layer.cornerRadius = 27.5;
    headView.clipsToBounds = YES;
    [bg addSubview:headView];
    
    //标题
    UILabel *labeltitle = [[UILabel alloc]init];
//    labeltitle.backgroundColor = MAIN_COLOR;
    self.labeltitle = labeltitle;
    labeltitle.frame = CGRectMake(headView.rightX+15, 25, SCREEN_WIDTH-30-(15+55+15+120), 55);
    labeltitle.font = [UIFont boldSystemFontOfSize:14];
    labeltitle.textColor = [UIColor whiteColor];
    labeltitle.text = @"淘赚";
    [bg addSubview:labeltitle];
    
}

@end
