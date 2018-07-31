//
//  MineCurrencyTableViewCell.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 15/12/28.
//  Copyright (c) 2015年 zmxn. All rights reserved.
//

#import "MineCurrencyTableViewCell.h"

@interface MineCurrencyTableViewCell()

@property (nonatomic,strong)UIImageView *headView;

@property (nonatomic,strong)UILabel *labelTitle;//标题

@property (nonatomic,strong)UILabel *timeTitle;//标题

@property (nonatomic,strong)UILabel *countTitle;

@end

@implementation MineCurrencyTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

-(void)createUI{
//    收入3_4支出3_4
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 36, 36)];
    self.headView = headView;
    [self.contentView addSubview:headView];
    
    //标题
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headView.frame)+15, 13, SCREEN_WIDTH/2, 14)];
    self.labelTitle = labelTitle;
    labelTitle.text = @"签到";
    labelTitle.textColor = [UIColor blackColor];
    labelTitle.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:labelTitle];
    
    //标题
    UILabel *timeTitle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headView.frame)+15, CGRectGetMaxY(labelTitle.frame)+7, SCREEN_WIDTH/2, 10)];
    self.timeTitle = timeTitle;
    timeTitle.textColor = [UIColor colorWithHexString:@"#898989"];
    timeTitle.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:timeTitle];
    
    //数量
    UILabel *countTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-15, 60)];
    self.countTitle = countTitle;
    countTitle.textColor = [UIColor blackColor];
    countTitle.font = [UIFont boldSystemFontOfSize:14];
    countTitle.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:countTitle];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:line];
    
}


-(void)setModel:(MineCurrencyCellModel *)model{
    _model = model;
    
    self.labelTitle.text = model.type;
    
    self.timeTitle.text = [NSString dateChangeStr:model.createDate andFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    CGFloat money = [model.point doubleValue];
    if (money<0) {
        self.headView.image = [UIImage imageNamed:@"支出3_4"];
        self.countTitle.text =  [NSString stringWithFormat:@"%.1f",money];
    }else{
        self.headView.image = [UIImage imageNamed:@"收入3_4"];
        self.countTitle.text =  [NSString stringWithFormat:@"+%.1f",money];
    }
    
}




@end
