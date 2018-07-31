//
//  TBAndJDGoodsClassListHeaderCell.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/9.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "TBAndJDGoodsClassListHeaderCell.h"
#import "PeanutSearchMainController.h"
@interface TBAndJDGoodsClassListHeaderCell()

@end

@implementation TBAndJDGoodsClassListHeaderCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self setupUI];
    }
    return self;
}

//得到类型
-(void)setGoodsTypeHeader:(NSString *)GoodsTypeHeader{
    _GoodsTypeHeader = GoodsTypeHeader;
    //创建UI并赋值
    [self setupUI];
}

//创建其他固定UI
-(void)setupUI{
    [self.contentView removeAllSubviews];
    //创建背景图片
    UIImageView * imageBg = [[UIImageView alloc]init];
    imageBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 411.0*px);
    if ([self.GoodsTypeHeader isEqual:@"0"]) {
        imageBg.image = [UIImage imageNamed:@"淘宝头部背景"];
    }else if ([self.GoodsTypeHeader isEqual:@"1"]){
         imageBg.image = [UIImage imageNamed:@"京东头部背景"];
    }else{
         imageBg.image = [UIImage imageNamed:@"天猫头部背景"];
    }
    [self.contentView addSubview:imageBg];
    
    //创建搜索框
    UIView * searchSub = [[UIView alloc]init];
    searchSub.frame = CGRectMake(60.0*px, imageBg.bottomY -40.0*px- 42, SCREEN_WIDTH-120.0*px, 42);
    searchSub.backgroundColor = [UIColor groupTableViewBackgroundColor];
    searchSub.layer.cornerRadius = 5;
    searchSub.clipsToBounds = YES;
    searchSub.userInteractionEnabled = YES;
    [searchSub addTapActionTouch:^{
        //搜搜
        PeanutSearchMainController *vc = [[PeanutSearchMainController alloc]init];
        if ([self.GoodsTypeHeader isEqual:@"0"]) {
            vc.searchType = @"淘宝";
        }else if ([self.GoodsTypeHeader isEqual:@"1"]){
            vc.searchType = @"京东";
        }else{
            vc.searchType = @"天猫";
        }
        [self.parentController.navigationController pushViewController:vc animated:YES];
    }];
    [self.contentView addSubview:searchSub];
    
    //搜索框和汉字
    UIButton * buttonType = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonType.userInteractionEnabled = NO;
    buttonType.frame = CGRectMake(20.0*px, 0, 250, 42);
    [buttonType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonType setTitleColor:[UIColor colorWithHexString:@"#c0c0c0"] forState:UIControlStateNormal];
    buttonType.titleLabel.font  =[UIFont systemFontOfSize:15];
    [buttonType setTitle:@"宝贝名称/关键词(如:连衣裙)" forState:UIControlStateNormal];
    [buttonType setImage:[UIImage imageNamed:@"搜索放大镜"] forState:UIControlStateNormal];
    buttonType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //这一行调整图片和文字的位置
    [buttonType setImagePositionWithType:SSImagePositionTypeLeft spacing:20.0*px];
    [searchSub addSubview:buttonType];
    
    //搜索按钮
    UIButton * buttonSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSearch.userInteractionEnabled = NO;
    buttonSearch.frame = CGRectMake(searchSub.width- 150.0*px, 0, 150.0*px, 42);
    [buttonSearch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonSearch.titleLabel.font  =[UIFont systemFontOfSize:16];
    [buttonSearch setTitle:@"搜索" forState:UIControlStateNormal];

    if ([self.GoodsTypeHeader isEqual:@"0"]) {
         [buttonSearch setBackgroundImage:[UIImage imageNamed:@"淘宝搜索背景"] forState:UIControlStateNormal];
    }else if ([self.GoodsTypeHeader isEqual:@"1"]){
        [buttonSearch setBackgroundImage:[UIImage imageNamed:@"京东搜索背景"] forState:UIControlStateNormal];
    }else{
        [buttonSearch setBackgroundImage:[UIImage imageNamed:@"天猫搜索背景"] forState:UIControlStateNormal];
    }
    [searchSub addSubview:buttonSearch];
    
}

@end
