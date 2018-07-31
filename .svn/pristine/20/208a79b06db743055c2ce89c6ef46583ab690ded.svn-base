//
//  SafeTableViewCell.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/5/3.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "SafeTableViewCell.h"

@implementation SafeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    //标题
    self.labelTiitle = [[UILabel alloc]initWithFrame:CGRectMake(30.0*px, 0, SCREEN_WIDTH/2, 90.0*px)];
    self.labelTiitle.textColor = [UIColor colorWithHexString:@"#696969"];
    self.labelTiitle.font = [UIFont systemFontOfSize:28.0*px];
    [self.contentView addSubview:self.labelTiitle];
    //进入
    self.buttonEn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonEn.frame = CGRectMake(SCREEN_WIDTH-64.0*px, 28.0*px, 34.0*px, 34.0*px);
    [self.buttonEn setImage:[UIImage imageNamed:@"进入"] forState:UIControlStateNormal];
    self.buttonEn.userInteractionEnabled = YES;
    [self.contentView addSubview:self.buttonEn];
    
    //是否绑定的提示
    //标题
    self.labelright = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-30.0*px, 28.0*px, SCREEN_WIDTH/2, 34.0*px)];
    self.labelright.textColor = [UIColor colorWithHexString:@"#696969"];
    self.labelright.textAlignment = NSTextAlignmentRight;
    self.labelright.font = [UIFont systemFontOfSize:28.0*px];
    [self.contentView addSubview:self.labelright];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
