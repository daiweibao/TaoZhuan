//
//  MyRecordListCell.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/5/2.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import "MyRecordListCell.h"


@interface MyRecordListCell()
//标题14
@property(nonatomic,weak)UILabel * labelTitle;
//日期11
@property(nonatomic,weak)UILabel * labelDate;
//钱16
@property(nonatomic,weak)UILabel * labelMoney;
@end

@implementation MyRecordListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        //创建UI
        [self createUI];
        
    }
    return self;
}

- (CGFloat)getMaxY {
    
    [self layoutIfNeeded];
    
    return CGRectGetMaxY(self.labelDate.frame) + 10;
}


-(void)setModel:(MyRecordListModel *)model{
    _model = model;
    //标题
    if ([NSString isNULL:self.model.isSuccess]) {
        self.labelTitle.text = @"状态未知";
    }else{
        self.labelTitle.text = self.model.isSuccess;
    }
    //打开得到的钱
    if ([NSString isNULL:model.gainMoney] || self.model.gainMoney.integerValue==0) {
        self.labelMoney.text = @"";//不显示
    }else{
        
        self.labelMoney.text = [NSString stringWithFormat:@"￥%@",model.gainMoney];
    }
    
    //打卡时间
    if ([NSString isNULL:model.createDate]) {
        self.labelDate.text = @"打卡时间：未知";
    }else{
        self.labelDate.text = [NSString stringWithFormat:@"打卡时间：%@",[NSString dateChangeStr:model.createDate andFormat:@"yyyy/MM/dd HH:mm"]];
    }
}

-(void)createUI{
    //标题
    UILabel * labelTitle = [[UILabel alloc]init];
    self.labelTitle = labelTitle;
    labelTitle.text = @"消费金话费";
    labelTitle.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:labelTitle];
   
    
    //日期
    UILabel * labelDate = [[UILabel alloc]init];
    self.labelDate = labelDate;
    labelDate.text = @"2018/05/12";
    labelDate.textColor = MAIN_COLOR_898989;
    labelDate.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:labelDate];
   
    
    //钱
    UILabel * labelMoney = [[UILabel alloc]init];
    self.labelMoney = labelMoney;
    labelMoney.text = @"";
    labelMoney.textColor = [UIColor blackColor];
    labelMoney.font = [UIFont boldSystemFontOfSize:16];
    labelMoney.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:labelMoney];
   
    
    //布局
    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    [labelDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(labelTitle.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(12);
    }];
    [labelMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(0);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(100);
        make.bottom.mas_equalTo(self.contentView);
    }];
    
}

@end
