//
//  PeanutOrderDetailController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/12.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "PeanutOrderDetailController.h"
#import "PeanutServiceListController.h"//花生客服
#import "OpenJDGoodesDetals.h"
#import "OpenTaobaoGoodes.h"

@interface PeanutOrderDetailController ()
@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation PeanutOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backButton.hidden = NO;
    self.titleLabel.text = @"订单详情";
    
    [self setupUI];
    
}

- (void)setupUI{
    
//    NSLog(@"%@",self.model);
    
    //创建滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.userInteractionEnabled = YES;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    //订单状态
    NSInteger order_state = [self.model.order_state integerValue];//1已存入  2失效  3待存入（自己定义的）
    
    
    if (order_state == 1) {//已存入状态
        
        CGFloat imageX = 35.0;//第一个图标X
        CGFloat imageY = 15.0;//第一个图标Y
        CGFloat imageW = 51.0;//图标宽度
        CGFloat lineW = (SCREEN_WIDTH-imageX*2-imageW*3)/2;//中间连线长度
        NSArray *imageNames = @[@"花生详情下单付款",@"花生详情待存入",@"花生详情已存入"];
        NSArray *titles = @[@"下单付款",@"待存入",@"已存入"];
        for (int i=0; i<3; i++) {
            UIImageView *logo = [[UIImageView alloc]init];
            logo.frame = CGRectMake(imageX+(imageW+lineW)*i, imageY, imageW, imageW);
            logo.image = [UIImage imageNamed:imageNames[i]];
            [scrollView addSubview:logo];
        }
        for (int i=0; i<2; i++) {
            UIImageView *line = [[UIImageView alloc]init];
            if (i==0) {
                line.frame = CGRectMake(imageX+imageW, imageY+25, lineW, 1.5);
            }else{
                line.frame = CGRectMake(imageX+imageW+lineW+imageW, imageY+25, lineW, 1.5);
            }
            line.backgroundColor = MAIN_COLOR;
            [scrollView addSubview:line];
        }
        for (int i=0; i<3; i++) {
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(imageX+(imageW+lineW)*i-10, imageY+imageW+10, imageW+20, 14);
            label.text = titles[i];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            [scrollView addSubview:label];
        }
        
    }else if (order_state == 2) {//失效3步
        CGFloat imageX = 35.0;//第一个图标X
        CGFloat imageY = 15.0;//第一个图标Y
        CGFloat imageW = 51.0;//图标宽度
        CGFloat lineW = (SCREEN_WIDTH-imageX*2-imageW*3)/2;//中间连线长度
        NSArray *imageNames = @[@"花生详情下单付款",@"花生详情待存入",@"花生详情已失效"];
        NSArray *titles = @[@"下单付款",@"待存入",@"已失效"];
        for (int i=0; i<3; i++) {
            UIImageView *logo = [[UIImageView alloc]init];
            logo.frame = CGRectMake(imageX+(imageW+lineW)*i, imageY, imageW, imageW);
            logo.image = [UIImage imageNamed:imageNames[i]];
            [scrollView addSubview:logo];
        }
        for (int i=0; i<2; i++) {
            UIImageView *line = [[UIImageView alloc]init];
            if (i==0) {
                line.frame = CGRectMake(imageX+imageW, imageY+25, lineW, 1.5);
            }else if (i==1){
                line.frame = CGRectMake(imageX+imageW+lineW+imageW, imageY+25, lineW, 1.5);
            }else{
                line.frame = CGRectMake(imageX+imageW+lineW+imageW+lineW+imageW, imageY+25, lineW, 1.5);
            }
            line.backgroundColor = MAIN_COLOR;
            [scrollView addSubview:line];
        }
        for (int i=0; i<3; i++) {
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(imageX+(imageW+lineW)*i-10, imageY+imageW+10, imageW+20, 14);
            label.text = titles[i];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            [scrollView addSubview:label];
        }
    }else{//待存入
        CGFloat imageX = 35.0;//第一个图标X
        CGFloat imageY = 15.0;//第一个图标Y
        CGFloat imageW = 51.0;//图标宽度
        CGFloat lineW = (SCREEN_WIDTH-imageX*2-imageW*3)/2;//中间连线长度
        NSArray *imageNames = @[@"花生详情下单付款",@"花生详情待存入",@"订单详情已存入灰"];
        NSArray *titles = @[@"下单付款",@"待存入",@"已存入"];
        for (int i=0; i<3; i++) {
            UIImageView *logo = [[UIImageView alloc]init];
            logo.frame = CGRectMake(imageX+(imageW+lineW)*i, imageY, imageW, imageW);
            logo.image = [UIImage imageNamed:imageNames[i]];
            [scrollView addSubview:logo];
        }
        for (int i=0; i<2; i++) {
            UIImageView *line = [[UIImageView alloc]init];
            if (i==0) {
                line.frame = CGRectMake(imageX+imageW, imageY+25, lineW, 1.5);
            }else{
                line.frame = CGRectMake(imageX+imageW+lineW+imageW, imageY+25, lineW, 1.5);
            }
            line.backgroundColor = MAIN_COLOR;
            [scrollView addSubview:line];
        }
        for (int i=0; i<3; i++) {
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(imageX+(imageW+lineW)*i-10, imageY+imageW+10, imageW+20, 14);
            label.text = titles[i];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blackColor];
            [scrollView addSubview:label];
            if (i==2) {//最后一个变灰
                 label.textColor = [UIColor grayColor];
            }
            
        }
    }
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 15+51+10+14+15, SCREEN_WIDTH, 10)];
    line1.backgroundColor = MAIN_COLOR_Line_Cu;
    [scrollView addSubview:line1];
    
    //待存入
    UILabel *waitDepositLabel = [[UILabel alloc]init];
    waitDepositLabel.frame = CGRectMake(15, line1.bottomY, SCREEN_WIDTH, 44);
    if (order_state == 1) {
         waitDepositLabel.text = @"已存入";
    }else if (order_state == 2) {
         waitDepositLabel.text = @"已失效";
    }else{
         waitDepositLabel.text = @"待存入";
    }
    waitDepositLabel.font = [UIFont systemFontOfSize:15];
    waitDepositLabel.textAlignment = NSTextAlignmentLeft;
    waitDepositLabel.textColor = [UIColor blackColor];
    [scrollView addSubview:waitDepositLabel];
    
    //钱数
    UILabel *waitMoneyLabel = [[UILabel alloc]init];
    waitMoneyLabel.frame = CGRectMake(0, line1.bottomY, SCREEN_WIDTH-15, 44);
//    1已存入  2失效  3待存入（自己定义的）
    if (order_state == 1) {
        waitMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[self.model.pay_price doubleValue]];
    }else if (order_state == 2) {
        waitMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[self.model.price doubleValue]];
    }else{
        waitMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f",[self.model.price doubleValue]];
    }
    
    waitMoneyLabel.font = [UIFont boldSystemFontOfSize:14];
    waitMoneyLabel.textAlignment = NSTextAlignmentRight;
    waitMoneyLabel.textColor = MAIN_COLOR;
    [scrollView addSubview:waitMoneyLabel];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, waitMoneyLabel.bottomY, SCREEN_WIDTH, 10)];
    line2.backgroundColor = MAIN_COLOR_Line_Cu;
    [scrollView addSubview:line2];
    
    //订单详情
    UILabel *orderDetailLabel = [[UILabel alloc]init];
    orderDetailLabel.frame = CGRectMake(15, line2.bottomY, SCREEN_WIDTH, 38);
    orderDetailLabel.text = @"订单详情";
    orderDetailLabel.font = [UIFont systemFontOfSize:15];
    orderDetailLabel.textAlignment = NSTextAlignmentLeft;
    orderDetailLabel.textColor = [UIColor blackColor];
    [scrollView addSubview:orderDetailLabel];
    
    //图片
    UIImageView *pictureView = [[UIImageView alloc]init];
    [pictureView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] placeholderImage:[UIImage imageNamed:@"启动图标最终版"]];
    pictureView.frame = CGRectMake(15, orderDetailLabel.bottomY, 65, 65);
    pictureView.contentMode = UIViewContentModeScaleAspectFill;
    pictureView.clipsToBounds = YES;
    [scrollView addSubview:pictureView];
    pictureView.userInteractionEnabled = YES;
    [pictureView addTapActionTouch:^{
        [self ActionSeeGoodsDetales];
    }];
    
    //标题
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.frame = CGRectMake(pictureView.rightX+10,orderDetailLabel.bottomY, SCREEN_WIDTH-pictureView.rightX-10-44, 1);
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.textColor = [UIColor blackColor];
    [scrollView addSubview:contentLabel];
    if ([self.model.type integerValue] == 2) {//京东
        contentLabel.attributedText = [NSString getLabelNOSpacingChangeColor:MAIN_COLOR andFont:[UIFont systemFontOfSize:13] andString1:@"" andChangeString:@"京东 " andGetstring3:self.model.product_name];
    }else{//淘宝 天猫
        contentLabel.attributedText = [NSString getLabelNOSpacingChangeColor:MAIN_COLOR andFont:[UIFont systemFontOfSize:13] andString1:@"" andChangeString:@"淘宝 " andGetstring3:self.model.product_name];
    }
    contentLabel.numberOfLines = 4;
    [contentLabel sizeToFit];
    contentLabel.userInteractionEnabled = YES;
    [contentLabel addTapActionTouch:^{
        [self ActionSeeGoodsDetales];
    }];
    
    //进入
    UIButton * Enter = [UIButton buttonWithType:UIButtonTypeCustom];
    Enter.frame = CGRectMake(SCREEN_WIDTH-44, orderDetailLabel.bottomY, 44, 65);
    [Enter setImage:[UIImage imageNamed:@"进入"] forState:UIControlStateNormal];
    [Enter addTarget:self action:@selector(ActionSeeGoodsDetales) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:Enter];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, pictureView.bottomY+15, SCREEN_WIDTH, 0.5)];
    line3.backgroundColor = MAIN_COLOR_Line_Xi;
    [scrollView addSubview:line3];
    
    NSMutableArray *temparr = [NSMutableArray array];
    if ([self.model.type integerValue] == 2) {//京东
        [temparr addObject:@"京东商城"];
    }else{
        [temparr addObject:@"淘宝商城"];
    }
    if ([NSString isNULL:self.model.order_number]) {//京东
        [temparr addObject:@"未知"];
    }else{
        [temparr addObject:self.model.order_number];
    }
    
    if ([NSString isNULL:self.model.dealDate]) {
        [temparr addObject:@"未知"];
    }else{
        [temparr addObject:[NSString dateChangeStr:self.model.dealDate andFormat:@"yyyy/MM/dd HH:mm"]];
    }
    
    if ([NSString isNULL:self.model.price]) {//京东
        [temparr addObject:@"未知"];
    }else{
        if (order_state == 1) {//已存入
             [temparr addObject:[NSString stringWithFormat:@"￥%.2f",[self.model.pay_price doubleValue]]];
        }else{
             [temparr addObject:[NSString stringWithFormat:@"￥%.2f",[self.model.price doubleValue]]];
        }
    }
    
    NSArray *tempArr1 = @[@"商城名称",@"订单号",@"提交时间",@"订单金额"];
    if (order_state == 1) {//已存入
        tempArr1 = @[@"商城名称",@"订单号",@"提交时间",@"实际支付"];
    }
    NSArray *tempArr2 = temparr.copy;
    
    UIView *line4;
    for (int i=0; i<4; i++) {
        
        UILabel *mainLabel = [[UILabel alloc]init];
        mainLabel.frame = CGRectMake(15, line3.bottomY+44*i, SCREEN_WIDTH, 44);
        mainLabel.text = tempArr1[i];
        mainLabel.font = [UIFont systemFontOfSize:15];
        mainLabel.textAlignment = NSTextAlignmentLeft;
        mainLabel.textColor = [UIColor blackColor];
        [scrollView addSubview:mainLabel];
        
        CopyLabel *subLabel = [[CopyLabel alloc]init];
        subLabel.frame = CGRectMake(0, line3.bottomY+44*i, SCREEN_WIDTH-15, 44);
        subLabel.text = tempArr2[i];
        subLabel.font = [UIFont systemFontOfSize:14];
        subLabel.textAlignment = NSTextAlignmentRight;
        subLabel.textColor = MAIN_COLOR_898989;
        [scrollView addSubview:subLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, mainLabel.bottomY-0.5, SCREEN_WIDTH-15, 0.5)];
        line4 = line;
        line.backgroundColor = MAIN_COLOR_Line_Xi;
        [scrollView addSubview:line];
    }
    
    //进程
    UILabel *progressLabel = [[UILabel alloc]init];
    progressLabel.frame = CGRectMake(15, line4.bottomY, SCREEN_WIDTH, 44);
    progressLabel.text = self.model.state;
    progressLabel.font = [UIFont systemFontOfSize:15];
    progressLabel.textAlignment = NSTextAlignmentLeft;
    progressLabel.textColor = MAIN_COLOR;
    [scrollView addSubview:progressLabel];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, progressLabel.bottomY, SCREEN_WIDTH, 10)];
    line5.backgroundColor = MAIN_COLOR_Line_Cu;
    [scrollView addSubview:line5];
    
    //客服图片
    UIImageView *ServiceView = [[UIImageView alloc]init];
    ServiceView.image = [UIImage imageNamed:@"客服漫画"];
    ServiceView.frame = CGRectMake(43, line5.bottomY+4, 95, 80);
    [scrollView addSubview:ServiceView];
    
    UILabel *ServiceLabel = [[UILabel alloc]init];
    ServiceLabel.frame = CGRectMake(0, line5.bottomY+18, SCREEN_WIDTH-30, 15);
    ServiceLabel.text = @"有疑问？客服来解决";
    ServiceLabel.font = [UIFont systemFontOfSize:15];
    ServiceLabel.textAlignment = NSTextAlignmentRight;
    ServiceLabel.textColor = [UIColor blackColor];
    [scrollView addSubview:ServiceLabel];

    UILabel *chatServiceLabel = [[UILabel alloc]init];
    chatServiceLabel.frame = CGRectMake(SCREEN_WIDTH-30-75, ServiceLabel.bottomY+10, 75, 30);
    chatServiceLabel.text = @"联系客服";
    chatServiceLabel.backgroundColor = MAIN_COLOR;
    chatServiceLabel.font = [UIFont systemFontOfSize:15];
    chatServiceLabel.textAlignment = NSTextAlignmentCenter;
    chatServiceLabel.textColor = [UIColor whiteColor];
    chatServiceLabel.layer.cornerRadius = 3;
    chatServiceLabel.clipsToBounds = YES;
    [scrollView addSubview:chatServiceLabel];
    chatServiceLabel.userInteractionEnabled = YES;
    [chatServiceLabel addTapActionTouch:^{
        PeanutServiceListController *vc = [[PeanutServiceListController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ServiceView.bottomY+5);
}

//查看商品详情
-(void)ActionSeeGoodsDetales{
    
    if ([NSString isNULL:self.model.skuId]) {
        [DWBToast showCenterWithText:@"该商品暂时还没有详情~"];
        return;
    }
    
    //类型: 0 淘宝 1京东
    if ([self.model.type integerValue] == 2) {
        //打开京东商品（封装）
        [OpenJDGoodesDetals  openJDMallDetaWithIdController:self JDSkuId:self.model.skuId];
    }else{
        //打开淘宝商品（封装）
        [OpenTaobaoGoodes openTaoboMallDetaMyWebViewController:self TaoBaoItemId:self.model.skuId TaoBaoUrl:self.model.taoBaoUrl AndGoodsType:@"0" AndGoodsPrice:self.model.price AndGoodsImageUrl:self.model.imageUrl AndGoodsName:self.model.product_name];
        
    }
#pragma mark ============添加京东订单，通知后台去同步订单账号================
    [OpenJDGoodesDetals addJDOrderLoadAFN];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end
