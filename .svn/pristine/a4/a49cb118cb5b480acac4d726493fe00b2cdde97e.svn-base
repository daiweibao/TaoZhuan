//
//  JDAndTBGoodsCell.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/4.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "JDAndTBGoodsCell.h"


@interface JDAndTBGoodsCell()

@property (weak, nonatomic)  UILabel *titleLabel;//标题
@property (weak, nonatomic)  UIImageView *pictureView;//商品图片

@property (weak, nonatomic)  UILabel *yearMoneyLabel;//年收益

@property (weak, nonatomic)  UILabel *newpriceLabel;//价格
//商品的原来价格
@property (nonatomic,weak)UILabel *labelOldPrice;
//领劵减多少
@property (nonatomic,weak)UILabel *labelGetCounpon;



@end

@implementation JDAndTBGoodsCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
        //点击手势
        self.userInteractionEnabled = YES;
        WeakSelf(self);
        [self addTapActionTouch:^{
            //商品详情
            [weakself ActionSeeGoodsDetales];
        }];
    }
    return self;
}

//查看商品详情
-(void)ActionSeeGoodsDetales{
     //类型: 0 淘宝 1京东
    if ([self.model.goodsType isEqual:@"1"]) {
        //打开京东商品（封装）
        [OpenJDGoodesDetals  openJDMallDetaWithIdController:self.parentController JDSkuId:self.model.goodsId];
    }else{
      //打开淘宝商品（封装）
        [OpenTaobaoGoodes openTaoboMallDetaMyWebViewController:self.parentController TaoBaoItemId:self.model.goodsId TaoBaoUrl:self.model.goodsUrl AndGoodsType:self.model.goodsType AndGoodsPrice:self.model.goodsPrice AndGoodsImageUrl:self.model.goodsImage AndGoodsName:self.model.goodsName];
        
    }
}

- (void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 3;
    self.clipsToBounds = YES;
    
    //商品图片
    UIImageView *pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width)];
    self.pictureView = pictureView;
    pictureView.contentMode = UIViewContentModeScaleAspectFill;
    pictureView.clipsToBounds = YES;
    [self addSubview:pictureView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0*px, CGRectGetMaxY(pictureView.frame)+20.0*px, self.bounds.size.width-30.0*px, 1)];
    self.titleLabel = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor colorWithHexString:@"#313131"];
    [self addSubview:titleLabel];
    

    //新价格
    UILabel *newpriceLabel = [[UILabel alloc]init];
    self.newpriceLabel = newpriceLabel;
    newpriceLabel.frame = CGRectMake(15.0*px,self.bounds.size.height-15.0*px-17, self.bounds.size.width, 17);
    newpriceLabel.text = @"¥128.00";
    newpriceLabel.textAlignment = NSTextAlignmentLeft;
    newpriceLabel.font = [UIFont systemFontOfSize:16];
    newpriceLabel.textColor = MAIN_COLOR;
    [self addSubview:newpriceLabel];
    
    //年收益
    UILabel *yearMoneyLabel = [[UILabel alloc]init];
    self.yearMoneyLabel = yearMoneyLabel;
    yearMoneyLabel.frame = CGRectMake(0,self.bounds.size.height-15.0*px-12, self.bounds.size.width-20.0*px, 11);
    yearMoneyLabel.text = @"年收益:约¥0.00";
    yearMoneyLabel.textAlignment = NSTextAlignmentRight;
    yearMoneyLabel.font = [UIFont systemFontOfSize:10];
    yearMoneyLabel.textColor = [UIColor colorWithHexString:@"#898989"];
    [self addSubview:yearMoneyLabel];
    
    
    
    //计算两断汉字长度
    NSString * priceString2 =[NSString stringWithFormat:@"￥%.2f",[@"0" floatValue]];
    NSString * priceString3 =[NSString stringWithFormat:@"领券减%.2f",[@"0" floatValue]];
    //计算字体长度
    CGSize sizeOldePricrWidth = [NSString sizeMyStrWith:priceString2 andFontSize:10 andMineWidth:SCREEN_WIDTH/2];
    CGSize sizeCounponWidth = [NSString sizeMyStrWith:priceString3 andFontSize:10 andMineWidth:SCREEN_WIDTH/2];
    
    //领券减20
    UILabel * labelGetCounpon = [[UILabel alloc]init];
    self.labelGetCounpon = labelGetCounpon;
    labelGetCounpon.frame = CGRectMake(self.bounds.size.width-15.0*px-sizeCounponWidth.width, yearMoneyLabel.y-10.0*px-11, sizeCounponWidth.width, 11);
    labelGetCounpon.textColor = MAIN_COLOR_898989;
    labelGetCounpon.font = [UIFont systemFontOfSize:10];
    labelGetCounpon.text =priceString3;
    labelGetCounpon.adjustsFontSizeToFitWidth = YES;
    labelGetCounpon.textAlignment = NSTextAlignmentRight;
    [self addSubview:labelGetCounpon];
    
    //原来的的价钱
    UILabel * labelOldPrice = [[UILabel alloc]init];
    self.labelOldPrice = labelOldPrice;
    labelOldPrice.frame = CGRectMake(labelGetCounpon.x-5.0*px-sizeOldePricrWidth.width, yearMoneyLabel.y-10.0*px-11, sizeOldePricrWidth.width, 11);
    labelOldPrice.textColor = MAIN_COLOR_898989;
    labelOldPrice.font = [UIFont systemFontOfSize:10];
    //设置下划线
    NSDictionary *dic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *oldPriceAtt = [[NSMutableAttributedString alloc] initWithString:priceString2 attributes:dic];
    labelOldPrice.attributedText = oldPriceAtt;
    labelOldPrice.adjustsFontSizeToFitWidth = YES;
    [self addSubview:labelOldPrice];
    
    //发布界面商品选择红勾勾--发布界面专属
    UIButton * buttonChoose = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonChoose = buttonChoose;
    buttonChoose.frame = CGRectMake(self.pictureView.width-30, 0, 30, 30);
    [buttonChoose setImage:[UIImage imageNamed:@"选择商品未选中"] forState:UIControlStateNormal];
    [buttonChoose setImage:[UIImage imageNamed:@"选择商品选中"] forState:UIControlStateSelected];
     buttonChoose.selected = NO;
     buttonChoose.hidden = YES;//先影藏
    [buttonChoose addTarget:self action:@selector(ActionShoose:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonChoose];
}

//点击选中
-(void)ActionShoose:(UIButton*)button{
    //关键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //回调商品数据
    if (self.blackGetGoodsInfoSonCell) {
        self.blackGetGoodsInfoSonCell(self.model);
    }
    
}

-(void)setModel:(JDAndTBGoodsModel *)model{
    _model = model;
    
    //图片
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:model.goodsImage] placeholderImage:[UIImage imageNamed:@"启动图标最终版"]];
    //标题
    self.titleLabel.text = model.goodsName;
    self.titleLabel.frame = CGRectMake(15.0*px, CGRectGetMaxY(self.pictureView.frame)+20.0*px, self.bounds.size.width-30.0*px, 1);
    self.titleLabel.numberOfLines = 2;
    [self.titleLabel sizeToFit];
    
    //现价,封装数据
    self.newpriceLabel.text = [NSString stringWithFormat:@"￥%@",[NSString formatNumPointFloat:self.model.goodsPrice]];
    
    //年收益,判空
//    if ([NSString isNULL:self.model.commentCount]==YES) {
//        self.yearMoneyLabel.text = @"";
//    }else{
//        NSString * yearMoneyStr = [NSString stringWithFormat:@"年收益:约￥%.2f",[self.model.commentCount floatValue]];
//        self.yearMoneyLabel.text = yearMoneyStr;
//    }
    //计算年利率
    double moneyYears = [self.model.goodsPrice doubleValue] * [self.model.rate doubleValue];
    self.yearMoneyLabel.text = [NSString stringWithFormat:@"年收益:约￥%@",[NSString formatNumPointFloat:[NSString stringWithFormat:@"%f",moneyYears]]];
    
    //计算两断汉字长度，iOS小数点格式化：如果有两位小数不为0则保留两位小数，如果有一位小数不为0则保留一位小数，否则显示整数【封装】
    NSString * priceString2;//原价
    if ([NSString isNULL:self.model.goodsOldPrice]) {
        priceString2 = @"";
    }else{
       priceString2 =[NSString stringWithFormat:@"￥%@",[NSString formatNumPointFloat:self.model.goodsOldPrice]];
    }
    //优惠劵面额是一个字符串，带汉字
    NSString * priceString3;
    if ([NSString isNULL:self.model.goodsCounponMoney]) {
        priceString3 = @" ";
    }else{
        priceString3 = self.model.goodsCounponMoney;
    }
    
    //计算字体长度
    CGSize sizeOldePricrWidth = [NSString sizeMyStrWith:priceString2 andFontSize:10 andMineWidth:SCREEN_WIDTH/2];
    CGSize sizeCounponWidth = [NSString sizeMyStrWith:priceString3 andFontSize:10 andMineWidth:SCREEN_WIDTH/2];
    _labelGetCounpon.frame = CGRectMake(self.bounds.size.width-20.0*px-sizeCounponWidth.width, _yearMoneyLabel.y-10.0*px-11, sizeCounponWidth.width, 11);
    _labelGetCounpon.text =priceString3;
    _labelGetCounpon.textAlignment = NSTextAlignmentRight;
    
    _labelOldPrice.frame = CGRectMake(_labelGetCounpon.x-5.0*px-sizeOldePricrWidth.width, _yearMoneyLabel.y-10.0*px-11, sizeOldePricrWidth.width, 11);
    //设置下划线
    NSDictionary *dic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *oldPriceAtt = [[NSMutableAttributedString alloc] initWithString:priceString2 attributes:dic];
    _labelOldPrice.attributedText = oldPriceAtt;
    

#pragma mark ============== 发布界面添加商品才打开复选框=================
    if ([self.model.controllerType isEqual:@"发布添加商品"]) {
        //选中状态改变--发布界面添加商品专属
        self.buttonChoose.selected = self.model.isSelseGoods;
        self.buttonChoose.hidden = NO;//打开
    }
}


@end
