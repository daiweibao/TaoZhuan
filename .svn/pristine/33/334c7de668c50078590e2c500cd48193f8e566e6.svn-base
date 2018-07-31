//
//  JDAndTBAboutGoodsView.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/5.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "JDAndTBAboutGoodsCell.h"

@interface JDAndTBAboutGoodsCell()
//封面
@property (nonatomic,weak)UIImageView *headView;
//商品名字
@property (nonatomic,weak)UILabel *nameLame;
//商品返利
@property (nonatomic,weak)UILabel * goodsGetMoneyLabel;
//商品的价格
@property (nonatomic,weak)UILabel *labelPrice;
//商品的原来价格
@property (nonatomic,weak)UILabel *labelOldPrice;

//领劵减多少
@property (nonatomic,weak)UILabel *labelGetCounpon;

//立即购买
@property (nonatomic,weak)UIButton * buttonBuy;

@end

@implementation JDAndTBAboutGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建UI
        [self setupUI];
        //点击手势
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ActionSeeGoodsDetales)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

//查看商品详情
-(void)ActionSeeGoodsDetales{
    //类型: 0 淘宝 1京东 2是天猫
    if ([self.model.goodsType isEqual:@"1"]) {
        //打开京东商品（封装）
        [OpenJDGoodesDetals  openJDMallDetaWithIdController:self.parentController JDSkuId:self.model.goodsId];
    }else{
        //打开淘宝商品（封装）
        [OpenTaobaoGoodes openTaoboMallDetaMyWebViewController:self.parentController TaoBaoItemId:self.model.goodsId TaoBaoUrl:self.model.goodsUrl AndGoodsType:self.model.goodsType AndGoodsPrice:self.model.goodsPrice AndGoodsImageUrl:self.model.goodsImage AndGoodsName:self.model.goodsName];
        
    }
}


- (void)setModel:(JDAndTBGoodsModel *)model{
    
    _model = model;
    
    //封面
     [_headView sd_setImageWithURL:[NSURL URLWithString:self.model.goodsImage] placeholderImage:[UIImage imageNamed:@"启动图标最终版"]];
    //标题
    _nameLame.frame =CGRectMake(_headView.rightX+20.0*px,20.0*px, SCREEN_WIDTH-_headView.rightX-50.0*px, 1);
    _nameLame.text = self.model.goodsName;
    _nameLame.numberOfLines = 2;
    [_nameLame sizeToFit];
    
    //返利
    _goodsGetMoneyLabel.frame = CGRectMake(_headView.rightX+20.0*px, _nameLame.bottomY+15.0*px, SCREEN_WIDTH-_headView.rightX-50.0*px, 14);

    //计算年利率
    double moneyYears = [self.model.goodsPrice doubleValue] * [self.model.rate doubleValue];
    _goodsGetMoneyLabel.text = [NSString stringWithFormat:@"年收益:约￥%@",[NSString formatNumPointFloat:[NSString stringWithFormat:@"%f",moneyYears]]];
    
    //价格
    //计算两断汉字长度
    NSString * priceString1 = [NSString stringWithFormat:@"￥%@",[NSString formatNumPointFloat:self.model.goodsPrice]];
    //原价判空
    NSString * priceString2;
    if ([NSString isNULL:self.model.goodsOldPrice]) {
        priceString2 = @"";
    }else{
        priceString2 = [NSString stringWithFormat:@"￥%@",[NSString formatNumPointFloat:self.model.goodsOldPrice]];
    }
    
    //优惠劵面额
    NSString * priceString3;
    if ([NSString isNULL:self.model.goodsCounponMoney]) {
        priceString3 = @" ";
    }else{
        priceString3 = self.model.goodsCounponMoney;
    }
    
    //计算字体长度
    CGSize sizePricrWidth = [NSString sizeMyStrWith:priceString1 andFontSize:13 andMineWidth:SCREEN_WIDTH/2];
    CGSize sizeOldePricrWidth = [NSString sizeMyStrWith:priceString2 andFontSize:13 andMineWidth:SCREEN_WIDTH/2];
    CGSize sizeCounponWidth = [NSString sizeMyStrWith:priceString3 andFontSize:13 andMineWidth:SCREEN_WIDTH/2];
    
     _labelPrice.frame = CGRectMake(_headView.rightX+20.0*px, _headView.bottomY-14, sizePricrWidth.width, 14);
      _labelOldPrice.frame = CGRectMake(_labelPrice.rightX+20.0*px, _headView.bottomY-14, sizeOldePricrWidth.width, 14);
     _labelGetCounpon.frame = CGRectMake(_labelOldPrice.rightX+20.0*px, _headView.bottomY-14, sizeCounponWidth.width, 14);
    _labelPrice.text =priceString1;
    //设置下划线
    NSDictionary *dic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *oldPriceAtt = [[NSMutableAttributedString alloc] initWithString:priceString2 attributes:dic];
    _labelOldPrice.attributedText = oldPriceAtt;
    _labelGetCounpon.text =priceString3;
    
}

- (void)setupUI{
    //商品封面
    UIImageView *headView = [UIImageView new];
    self.headView = headView;
    headView.image = [UIImage imageNamed:@"启动图标最终版"];
    headView.frame = CGRectMake(30.0*px, 20.0*px, 80, 80);
    headView.contentMode = UIViewContentModeScaleAspectFill;
    headView.clipsToBounds = YES;
    [self addSubview:headView];

    //标题
    UILabel *nameLame = [[UILabel alloc]init];
    self.nameLame = nameLame;
    nameLame.frame =CGRectMake(headView.rightX+20.0*px,20.0*px, SCREEN_WIDTH-headView.rightX-50.0*px, 1);
    nameLame.font = [UIFont systemFontOfSize:13];
    nameLame.textColor = [UIColor colorWithHexString:@"#000000"];
    nameLame.text = self.model.wareName;
    nameLame.numberOfLines = 2;
    [nameLame sizeToFit];
    [self addSubview:nameLame];
    
    //返利
    UILabel * goodsGetMoneyLabel = [[UILabel alloc]init];
    self.goodsGetMoneyLabel = goodsGetMoneyLabel;
    goodsGetMoneyLabel.frame = CGRectMake(headView.rightX+20.0*px, nameLame.bottomY+15.0*px, SCREEN_WIDTH-headView.rightX-50.0*px, 14);
    goodsGetMoneyLabel.font = [UIFont systemFontOfSize:13];
    goodsGetMoneyLabel.textColor = MAIN_COLOR_898989;
    goodsGetMoneyLabel.text = @"年收益：约0.00元";
    [self addSubview:goodsGetMoneyLabel];
    
    //计算两断汉字长度
    NSString * priceString1 =[NSString stringWithFormat:@"¥%.2f",[@"0" floatValue]];
    NSString * priceString2 =[NSString stringWithFormat:@"¥%.2f",[@"0" floatValue]];
    NSString * priceString3 =[NSString stringWithFormat:@"领券减%.2f",[@"0" floatValue]];
    //计算字体长度
    CGSize sizePricrWidth = [NSString sizeMyStrWith:priceString1 andFontSize:13 andMineWidth:SCREEN_WIDTH/2];
    CGSize sizeOldePricrWidth = [NSString sizeMyStrWith:priceString2 andFontSize:13 andMineWidth:SCREEN_WIDTH/2];
    CGSize sizeCounponWidth = [NSString sizeMyStrWith:priceString3 andFontSize:13 andMineWidth:SCREEN_WIDTH/2];
    
    //现在的价钱
    UILabel *labelPrice = [[UILabel alloc]init];
    self.labelPrice = labelPrice;
    labelPrice.frame = CGRectMake(headView.rightX+20.0*px, headView.bottomY-14, sizePricrWidth.width, 14);
    labelPrice.textColor = MAIN_COLOR;
    labelPrice.font = [UIFont systemFontOfSize:13];
    labelPrice.text =priceString1;
    labelPrice.adjustsFontSizeToFitWidth = YES;
    [self addSubview:labelPrice];
    
    //原来的的价钱
    UILabel * labelOldPrice = [[UILabel alloc]init];
    self.labelOldPrice = labelOldPrice;
    labelOldPrice.frame = CGRectMake(labelPrice.rightX+20.0*px, headView.bottomY-14, sizeOldePricrWidth.width, 14);
    labelOldPrice.textColor = MAIN_COLOR_898989;
    labelOldPrice.font = [UIFont systemFontOfSize:13];
    //设置下划线
    NSDictionary *dic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *oldPriceAtt = [[NSMutableAttributedString alloc] initWithString:priceString2 attributes:dic];
    labelOldPrice.attributedText = oldPriceAtt;
    labelOldPrice.adjustsFontSizeToFitWidth = YES;
    [self addSubview:labelOldPrice];
    
  //领券减20
    UILabel * labelGetCounpon = [[UILabel alloc]init];
    self.labelGetCounpon = labelGetCounpon;
    labelGetCounpon.frame = CGRectMake(labelOldPrice.rightX+20.0*px, headView.bottomY-14, sizeCounponWidth.width, 14);
    labelGetCounpon.textColor = MAIN_COLOR_ababab;
    labelGetCounpon.font = [UIFont systemFontOfSize:13];
    labelGetCounpon.text =priceString3;
    labelGetCounpon.adjustsFontSizeToFitWidth = YES;
    [self addSubview:labelGetCounpon];
    
    //立即购买按钮
    UIButton * buttonBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonBuy = buttonBuy;
    buttonBuy.userInteractionEnabled = NO;
    buttonBuy.frame = CGRectMake(SCREEN_WIDTH-152.0*px, CGRectGetMaxY(headView.frame)-45.0*px, 130.0*px, 50.0*px);
    //1内部商品，
    [buttonBuy setImage:[UIImage imageNamed:@"立即购买"] forState:UIControlStateNormal];
    buttonBuy.hidden = NO;
    buttonBuy.userInteractionEnabled = NO;
    [self addSubview:buttonBuy];
    
    //线
    UIImageView * imageafter = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame)+20.0*px, SCREEN_WIDTH, 2.0*px)];
    imageafter.backgroundColor = MAIN_COLOR_Line_Xi;
    [self addSubview:imageafter];
    
}

@end
