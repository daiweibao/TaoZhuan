//
//  GetMoneyListCell.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/11.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "GetMoneyListCell.h"

@interface GetMoneyListCell()
@property (nonatomic,strong) UILabel *mainLabel;
@property (nonatomic,strong) UILabel *timelabel;
@property (nonatomic,strong) UILabel *numLabel;

@end

@implementation GetMoneyListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建UI
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    CGFloat numLabelW = [NSString sizeMyStrWith:@"+888.88" andFontSize:16 andMineWidth:222].width;
    
    //名字
    UILabel *mainLabel = [[UILabel alloc]init];
    self.mainLabel = mainLabel;
    mainLabel.text = @"收益明细";
    mainLabel.textColor = [UIColor blackColor];
    mainLabel.font = [UIFont systemFontOfSize:14];
    mainLabel.frame = CGRectMake(15, 15, SCREEN_WIDTH-30-numLabelW-10,  14);
    [self.contentView addSubview:mainLabel];
    
#pragma mark =====================时间============================
    //时间
    UILabel * timelabel = [[UILabel alloc]initWithFrame:CGRectMake(15, mainLabel.bottomY+8, SCREEN_WIDTH/2, 11)];
    self.timelabel = timelabel;
    timelabel.font = [UIFont systemFontOfSize:11];
    timelabel.textColor = MAIN_COLOR_898989;
    timelabel.text = @"";
    [self.contentView addSubview:timelabel];
    
    //数量
    UILabel *numLabel = [[UILabel alloc]init];
    self.numLabel = numLabel;
    numLabel.text = @"+0";
    numLabel.textAlignment = NSTextAlignmentRight;
    numLabel.textColor = [UIColor blackColor];
    numLabel.font = [UIFont boldSystemFontOfSize:16];
    numLabel.adjustsFontSizeToFitWidth = YES;
    numLabel.frame = CGRectMake(SCREEN_WIDTH-15-numLabelW, 0, numLabelW,  15+14+8+11+15);
    [self.contentView addSubview:numLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, numLabel.bottomY-0.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = MAIN_COLOR_Line_Xi;
    [self.contentView addSubview:line];
}

- (void)setModel:(TotalGetMoneyModel *)model{
    _model = model;
    self.mainLabel.text = [NSString stringWithFormat:@"%@",model.info];
    self.numLabel.text = [NSString stringWithFormat:@"%@",model.gain];
    
    if ([NSString isNULL:model.createDate]) {
        self.timelabel.text = @"未知";
    }else{
        self.timelabel.text = [NSString dateChangeStr:model.createDate andFormat:@"yyyy/MM/dd HH:mm"];
    }
    
}

@end
