//
//  OrderCell.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 16/5/18.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "SubPeanutOrderListCell.h"
#import "SubPeanutOrderListController.h"

@interface SubPeanutOrderListCell()
@property (nonatomic,strong)UILabel *myLabel;
@property (nonatomic,strong)UILabel *contentLabel;//主标题
@property (nonatomic,strong)UIImageView *pictureView;//图片
@property (nonatomic,strong)UILabel *shareLabel;//分享购物得美币
@property (nonatomic,strong)UILabel *stateLabel;//状态
@property (nonatomic,strong) UILabel *priceLabel;//价格
@property (nonatomic,strong)UILabel *timeLabel;//下单时间

@end


@implementation SubPeanutOrderListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    //图片
    UIImageView *pictureView = [[UIImageView alloc]init];
    self.pictureView = pictureView;
//    pictureView.backgroundColor = MAIN_COLOR;
    pictureView.frame = CGRectMake(15, 15, 100, 100);
    pictureView.contentMode = UIViewContentModeScaleAspectFill;
    pictureView.clipsToBounds = YES;
    [self.contentView addSubview:pictureView];
    
    //状态
   CGFloat w = [NSString sizeMyStrWith:@"已存入" andFontSize:13 andMineWidth:111].width+6;
    UILabel *myLabel = [[UILabel alloc]init];
    self.myLabel = myLabel;
    myLabel.frame = CGRectMake(0, 0, w, 17);
    myLabel.font = [UIFont systemFontOfSize:13];
    myLabel.textAlignment = NSTextAlignmentCenter;
    [pictureView addSubview:myLabel];
    
    //标题
    UILabel *contentLabel = [[UILabel alloc]init];
    self.contentLabel = contentLabel;
    contentLabel.text = @"这里是商品";
    contentLabel.frame = CGRectMake(pictureView.rightX+10,5 , SCREEN_WIDTH-pictureView.rightX-25, 50);
    contentLabel.numberOfLines = 2;
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:contentLabel];

    //状态
    UILabel *stateLabel = [[UILabel alloc]init];
    self.stateLabel = stateLabel;
    stateLabel.frame = CGRectMake(0,contentLabel.bottomY+3, SCREEN_WIDTH-15, 12);
    stateLabel.text = @"已存入";
    stateLabel.textAlignment = NSTextAlignmentRight;
    stateLabel.font = [UIFont systemFontOfSize:12];
    stateLabel.textColor = MAIN_COLOR_BLACK;
    [self.contentView addSubview:stateLabel];

    //分享
    CGFloat shareLabelW = [NSString sizeMyStrWith:@"分享购物得美币啦 >" andFontSize:12 andMineWidth:SCREEN_WIDTH].width+5;
    UILabel *shareLabel = [[UILabel alloc]init];
//    shareLabel.backgroundColor = MAIN_COLOR;
    self.shareLabel = shareLabel;
    shareLabel.frame = CGRectMake(SCREEN_WIDTH-15-shareLabelW,stateLabel.bottomY, shareLabelW, 32);
//    shareLabel.text = @"分享购物得美币啦 >";
    shareLabel.textAlignment = NSTextAlignmentRight;
    shareLabel.font = [UIFont systemFontOfSize:12];
    shareLabel.textColor = MAIN_COLOR;
    [self.contentView addSubview:shareLabel];
    shareLabel.userInteractionEnabled = YES;
    [shareLabel addTapActionTouch:^{
       
        
    }];

    //价格
    UILabel *priceLabel = [[UILabel alloc]init];
     self.priceLabel = priceLabel;
    priceLabel.frame = CGRectMake(0,shareLabel.bottomY, SCREEN_WIDTH-15, 12);
    priceLabel.text = @"订单金额：¥128";
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont systemFontOfSize:12];
    priceLabel.textColor = MAIN_COLOR_BLACK;
    [self.contentView addSubview:priceLabel];
    
//    //下单时间
//    UILabel *timeLabel = [[UILabel alloc]init];
//    self.timeLabel = timeLabel;
//    timeLabel.frame = CGRectMake(pictureView.rightX+10,pictureView.bottomY-10, SCREEN_WIDTH, 10);
//    timeLabel.text = @"";
//    timeLabel.textAlignment = NSTextAlignmentLeft;
//    timeLabel.font = [UIFont systemFontOfSize:10];
//    timeLabel.textColor = MAIN_COLOR_898989;
//    [self.contentView addSubview:timeLabel];
    
    //分割线
    UIImageView *segmentationView = [[UIImageView alloc]init];
    segmentationView.frame = CGRectMake(0, 129.5, SCREEN_WIDTH, 0.5);
    segmentationView.backgroundColor = MAIN_COLOR_Line_Xi;
    [self addSubview:segmentationView];

}

- (void)setModel:(SubPeanutOrderListModel *)model{
    _model = model;
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"启动图标最终版"]];
    

    if ([model.order_state integerValue] == 1) {//已存入
        self.myLabel.hidden = NO;
        self.myLabel.text = @"已存入";
        self.myLabel.textColor = [UIColor whiteColor];
        self.myLabel.backgroundColor = MAIN_COLOR;
    }else if ([model.order_state integerValue] == 2) {//失效
        self.myLabel.hidden = NO;
        self.myLabel.text = @"无效";
        self.myLabel.textColor = MAIN_COLOR_898989;
        self.myLabel.backgroundColor = [UIColor colorWithHexString:@"#eaeaea"];
    }else if ([model.order_state integerValue] == 3) {//待存入
        self.myLabel.hidden = NO;
        self.myLabel.text = @"待存入";
        self.myLabel.textColor = [UIColor whiteColor];
        self.myLabel.backgroundColor = MAIN_COLOR;
    }else {
        self.myLabel.hidden = YES;
    }
    
    if ([model.type integerValue] == 2) {//京东
        self.contentLabel.attributedText = [NSString getLabelNOSpacingChangeColor:MAIN_COLOR andFont:[UIFont systemFontOfSize:13] andString1:@"" andChangeString:@"京东 " andGetstring3:model.product_name];
    }else{//淘宝 天猫
        self.contentLabel.attributedText = [NSString getLabelNOSpacingChangeColor:MAIN_COLOR andFont:[UIFont systemFontOfSize:13] andString1:@"" andChangeString:@"淘宝 " andGetstring3:model.product_name];
    }
    
    self.stateLabel.text = model.state;
    
    //标签
    if ([self.model.order_state integerValue] == 1) {//已存入状态
        self.shareLabel.hidden = NO;
        if ([NSString isNULL:model.topicId] || [model.topicId integerValue] == 0 ) {
            self.shareLabel.textColor = MAIN_COLOR;
            self.shareLabel.text = @"分享购物得美币啦 >";
        }else{
            self.shareLabel.textColor = MAIN_COLOR_BLACK;
            self.shareLabel.text = @"购物已分享";
        }
    }else{
        self.shareLabel.hidden = YES;
    }
    
    if ([self.model.order_state integerValue] == 1) {//已存入
        self.priceLabel.attributedText = [NSString getLabelNOSpacingChangeColor:MAIN_COLOR andFont:[UIFont systemFontOfSize:12] andString1:@"实际支付：" andChangeString:[NSString stringWithFormat:@"￥%.2f",[model.pay_price doubleValue]] andGetstring3:@""];
    }else{
        self.priceLabel.attributedText = [NSString getLabelNOSpacingChangeColor:MAIN_COLOR andFont:[UIFont systemFontOfSize:12] andString1:@"订单金额：" andChangeString:[NSString stringWithFormat:@"￥%.2f",[model.price doubleValue]] andGetstring3:@""];
    }
    
    if ([NSString isNULL:model.dealDate]) {
        self.timeLabel.text = @"";
    }else{
        self.timeLabel.text = [NSString stringWithFormat:@"下单时间：%@",[NSString dateChangeStr:model.dealDate andFormat:@"yyyy/MM/dd"]];
    }

}

@end


