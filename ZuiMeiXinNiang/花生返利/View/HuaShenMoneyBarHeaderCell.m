//
//  HuaShenMoneyBarHeaderCell.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/7.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "HuaShenMoneyBarHeaderCell.h"
#import "SDCycleScrollView.h"
#import "TBAndJDGoodsWebController.h"
#import "PeanutSearchMainController.h"
@interface HuaShenMoneyBarHeaderCell()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView2;//轮播图控件
@property (nonatomic,strong)NSArray *headimages;//轮播图数据
@property (nonatomic,strong)NSString * selseTitle;//选中的标题,是选中了京东还是淘宝天猫

@end

@implementation HuaShenMoneyBarHeaderCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
       [self setupUI];
        
// 高度       ImageHeight + 30.0*px + 42 +30.0*px + 70 + 30.0*px + 20.0*px + 30.0*px+ 190.0 * px + 30.0*px + 60.0*px 
    }
    return self;
}

//得到数据
-(void)getDateScrollerArray:(NSArray*)arrayScroller AndActiveArray:(NSArray*)activeArray andSelseTitle:(NSString*)selseTitle{
    self.headimages = arrayScroller;//得到数据
    self.selseTitle = selseTitle;//选中的标题,是选中了京东还是淘宝天猫
    //创建UI并赋值
    [self setupUI];
}

//创建其他固定UI
-(void)setupUI{
    //移除所有子视图
    [self.contentView removeAllSubviews];
    
    //轮播图高度
    CGFloat scrollerHeight;
    if (self.headimages.count>0) {
        scrollerHeight = ImageHeight;
    }else{
//        scrollerHeight = 0.0;
         scrollerHeight = ImageHeight;
    }
    //轮播图
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, scrollerHeight) delegate:self placeholderImage:[UIImage imageNamed:@"启动图标最终版"]];
    self.cycleScrollView2 = cycleScrollView2;
    //分页控件大大小
    cycleScrollView2.pageControlDotSize = CGSizeMake(10.5, 4.5);
    cycleScrollView2.currentPageDotImage=[UIImage imageNamed:@"首页小红点"];
    cycleScrollView2.pageDotImage=[UIImage imageNamed:@"首页小白点"];
    //位置
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    [self.contentView addSubview:cycleScrollView2];
    //网址数组
    NSMutableArray * arrayScroll = [NSMutableArray array];
    for (NSDictionary * dict in self.headimages) {
        [arrayScroll addObject:dict[@"picUrl"]];
    }
    self.cycleScrollView2.imageURLStringsGroup = arrayScroll;
    
    //创建搜索框
    UIView * searchSub = [[UIView alloc]init];
    searchSub.frame = CGRectMake(30.0*px, _cycleScrollView2.bottomY+30.0*px, SCREEN_WIDTH-60.0*px, 42);
    searchSub.backgroundColor = [UIColor groupTableViewBackgroundColor];
    searchSub.layer.cornerRadius = 5;
    searchSub.clipsToBounds = YES;
    searchSub.userInteractionEnabled = YES;
    [searchSub addTapActionTouch:^{
//        搜搜
        PeanutSearchMainController *vc = [[PeanutSearchMainController alloc]init];
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
    [buttonType setTitle:@"宝贝名称/关键词" forState:UIControlStateNormal];
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
    [buttonSearch setBackgroundImage:[UIImage imageNamed:@"搜索渐变"] forState:UIControlStateNormal];
    [searchSub addSubview:buttonSearch];
    
    //创建淘宝天猫三个按钮
     NSArray * arrayTitle = @[@"淘宝",@"天猫",@"京东"];
      NSArray * arrayImage = @[@"淘宝",@"天猫",@"京东"];
    
    CGFloat ButtonSpace = 100.0*px;//间距离
    CGFloat ButtonMinX  = (SCREEN_WIDTH-45*3-ButtonSpace*2)/2.0;//起始坐标
    CGFloat buttonTBY = searchSub.bottomY;//底部
    for (int i = 0; i < arrayTitle.count ; i++) {
        //
        UIButton * buttonTB = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonTB.frame = CGRectMake(ButtonMinX+(45+ButtonSpace)*i,searchSub.bottomY+30.0*px, 45, 70);
        [buttonTB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [buttonTB setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
        buttonTB.titleLabel.font  =[UIFont systemFontOfSize:15];
        [buttonTB setTitle:arrayTitle[i] forState:UIControlStateNormal];
         [buttonTB setTitle:arrayTitle[i] forState:UIControlStateSelected];
        [buttonTB setImage:[UIImage imageNamed:arrayImage[i]] forState:UIControlStateNormal];
         [buttonTB setImage:[UIImage imageNamed:arrayImage[i]] forState:UIControlStateSelected];
        //这一行调整图片和文字的位置
        [buttonTB setImagePositionWithType:SSImagePositionTypeTop spacing:20.0*px];
        [buttonTB addTarget:self action:@selector(ActionButtonTB:) forControlEvents:UIControlEventTouchUpInside];
        buttonTB.tag = 1000+i;
        [self.contentView addSubview:buttonTB];
        
        //控制选中状态,其他都变成非选中状态
        if ([self.selseTitle isEqual:buttonTB.titleLabel.text]) {
            buttonTB.selected = YES;
        }else{
             buttonTB.selected = NO;
        }
        
        //底部
        buttonTBY = buttonTB.bottomY;
    }
    
    //创建展开的父视图
    UIView * viewShowTbSub = [[UIView alloc]init];
    viewShowTbSub.frame = CGRectMake(0, buttonTBY, SCREEN_WIDTH, 320.0*px);
    [self.contentView addSubview:viewShowTbSub];
    //小箭头
    UIButton * buttonSanUp = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSanUp.frame = CGRectMake(ButtonMinX+45.0 / 2.0 - 15.0*px, 0, 30.0*px, 13.0*px);
    [buttonSanUp setImage:[UIImage imageNamed:@"花生淘宝箭头"] forState:UIControlStateNormal];
    buttonSanUp.userInteractionEnabled = NO;
    [viewShowTbSub addSubview:buttonSanUp];
    //背景
    UIImageView * imageView_TB_BK = [[UIImageView alloc]init];
    imageView_TB_BK.frame = CGRectMake(0, buttonSanUp.bottomY, SCREEN_WIDTH, viewShowTbSub.height-buttonSanUp.bottomY);
    imageView_TB_BK.image = [UIImage imageNamed:@"花生淘宝背景"];
    imageView_TB_BK.contentMode = UIViewContentModeScaleAspectFill;
    imageView_TB_BK.clipsToBounds = YES;
    [viewShowTbSub addSubview:imageView_TB_BK];
    
    //创建淘宝天猫京东的展开层级 箭头：15.0 突变上下30.0 图标上下距离20.0
    NSArray * array_TB;
    NSArray * arrayTitle_TB;

    //类型区分，选中了哪一个记录
    if ([self.selseTitle isEqual:@"淘宝"]) {
        //小箭头坐标
       buttonSanUp.frame = CGRectMake(ButtonMinX+45.0 / 2.0 - 15.0*px, 0, 30.0*px, 13.0*px);
       array_TB = @[@"淘宝首页",@"聚划算",@"淘抢购",@"淘券",@"浏览足迹-淘宝",@"淘宝订单",@"我的收藏-淘宝",@"我的淘宝"];
       arrayTitle_TB = @[@"淘宝",@"聚划算",@"淘抢购",@"淘券",@"浏览足迹",@"淘宝订单",@"我的收藏",@"我的淘宝"];
    }else if ([self.selseTitle isEqual:@"天猫"]){
           //小箭头坐标
       buttonSanUp.frame = CGRectMake(ButtonMinX+45.0 / 2.0 - 15.0*px + (45 + ButtonSpace), 0, 30.0*px, 13.0*px);
        array_TB = @[@"天猫首页",@"天猫国际",@"天猫女装",@"天猫美妆",@"浏览足迹-天猫",@"天猫订单",@"我的收藏-天猫",@"我的天猫"];
        arrayTitle_TB = @[@"天猫",@"天猫国际",@"天猫女装",@"天猫美妆",@"浏览足迹",@"天猫订单",@"我的收藏",@"我的天猫"];
    }else if ([self.selseTitle isEqual:@"京东"]){
           //小箭头坐标
       buttonSanUp.frame = CGRectMake(ButtonMinX+45.0 / 2.0 - 15.0*px + (45 + ButtonSpace)*2, 0, 30.0*px, 13.0*px);
        array_TB = @[@"京东首页",@"京东超市",@"京东秒杀",@"京东优惠券",@"浏览足迹-京东",@"京东订单",@"京东关注",@"我的京东"];
        arrayTitle_TB = @[@"京东",@"京东超市",@"京东秒杀",@"京东优惠券",@"浏览足迹",@"京东订单",@"京东关注",@"我的京东"];
    }else{
        //都没选中
         viewShowTbSub.frame = CGRectMake(0, buttonTBY+30.0*px, SCREEN_WIDTH, 0);
         viewShowTbSub.hidden = YES;
    }
    
//    花生淘宝背景
     CGFloat buttonTb_BJ = buttonTBY;
    CGFloat buttonTb_windth = 140.0*px;
    CGFloat buttonTb_height = 120.0*px;
    CGFloat buttonTb_Space = (SCREEN_WIDTH-100.0*px-buttonTb_windth * 4.0) / 3.0;
    for (int n = 0; n < array_TB.count ; n++) {
        //
        UIButton * button_Tb = [UIButton buttonWithType:UIButtonTypeCustom];
        button_Tb.frame =CGRectMake(50.0*px+(buttonTb_windth+ buttonTb_Space)*(n%4),43.0 * px+(buttonTb_height+20.0*px)*(n/4), buttonTb_windth, buttonTb_height);
        [button_Tb setImage:[UIImage imageNamed:array_TB[n]] forState:UIControlStateNormal];
        [button_Tb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button_Tb.titleLabel.font  =[UIFont systemFontOfSize:13];
        [button_Tb setTitle:arrayTitle_TB[n] forState:UIControlStateNormal];
        button_Tb.titleLabel.adjustsFontSizeToFitWidth = YES;
        //这一行调整图片和文字的位置
        [button_Tb setImagePositionWithType:SSImagePositionTypeTop spacing:20.0*px];
        [button_Tb addTarget:self action:@selector(ActionButton_Tb:) forControlEvents:UIControlEventTouchUpInside];
        button_Tb.tag = 1500+n;
        [viewShowTbSub addSubview:button_Tb];
        //底部
        buttonTb_BJ = button_Tb.bottomY;
    }
}
//点击三个按钮
-(void)ActionButtonTB:(UIButton*)button{
    button.selected = !button.selected;
    if (button.tag==1000) {
        //淘宝
        if (self.actionTBJDTMTitle) {
            if (button.selected == YES) {
                self.actionTBJDTMTitle(@"淘宝");
            }else{
                 self.actionTBJDTMTitle(nil);
            }
        }
    }else if (button.tag==1001){
        //天猫
        if (button.selected == YES) {
            self.actionTBJDTMTitle(@"天猫");
        }else{
            self.actionTBJDTMTitle(nil);
        }
    }
    else{
        //京东--直接打开京东SDK首页-12月28日修改
        if (button.selected == YES) {
            self.actionTBJDTMTitle(@"京东");
        }else{
            self.actionTBJDTMTitle(nil);
        }
    }
}

//点开分类
-(void)ActionButton_Tb:(UIButton*)button{
    TBAndJDGoodsWebController * JdAndTBVC = [[TBAndJDGoodsWebController alloc]init];
    JdAndTBVC.hidesBottomBarWhenPushed = YES;
    if ([self.selseTitle isEqual:@"淘宝"]) {
        if ([OpenTaobaoGoodes isTaoBaoLoginTb]==YES) {
            [self openTbDetails:button];
            
        }else{
            [OpenTaobaoGoodes openTBLoginController:self.parentController LoginSuccess:^{
                [self openTbDetails:button];
            }];
        }
    }else if ([self.selseTitle isEqual:@"天猫"]){
        if ([OpenTaobaoGoodes isTaoBaoLoginTb]==YES) {
            [self openTMDetails:button];
        }else{
            [OpenTaobaoGoodes openTBLoginController:self.parentController LoginSuccess:^{
                 [self openTMDetails:button];
            }];
        }
    }else if ([self.selseTitle isEqual:@"京东"]){
        if ([OpenJDGoodesDetals isKeplerLoginJD]==YES) {
            //京东详情
            [self openJDDetails:button];
        }else{
            //登陆京东--用SDK授权
            [OpenJDGoodesDetals openJDLoginController:self.parentController LoginSuccess:^{
                //京东详情
                [self openJDDetails:button];
        }];
     }
   }
}

//打开淘宝8个按钮的详情
-(void)openTbDetails:(UIButton*)button{
    TBAndJDGoodsWebController * JdAndTBVC = [[TBAndJDGoodsWebController alloc]init];
    JdAndTBVC.hidesBottomBarWhenPushed = YES;
    JdAndTBVC.type = @"淘宝";//类型不传是淘宝
    //淘宝商品只能拦截商品列表然后进入SDK，否则没有佣金
    if (button.tag==1500) {
        JdAndTBVC.urlTbOrJd = @"https://ai.m.taobao.com";//爱淘宝--主页
    }else if (button.tag==1501){
        JdAndTBVC.urlTbOrJd = @"https://jhs.m.taobao.com/m/index.htm";//爱淘宝--聚划算
    }else if (button.tag==1502){
        JdAndTBVC.urlTbOrJd = @"https://h5.m.taobao.com/purchase/index.html";//爱淘宝--淘抢购
    }else if (button.tag==1503){
        JdAndTBVC.urlTbOrJd = @"http://temai.m.taobao.com/index.html";//爱淘宝--淘劵
    }else if (button.tag==1504){
        JdAndTBVC.urlTbOrJd = @"https://h5.m.taobao.com/footprint/homev2.html";//爱淘宝--浏览足迹
    }else if (button.tag==1505){
        JdAndTBVC.urlTbOrJd = @"https://h5.m.taobao.com/mlapp/olist.html";//爱淘宝--我的订单
    }else if (button.tag==1506){
        JdAndTBVC.urlTbOrJd = @"https://h5.m.taobao.com/fav/index.htm?";//爱淘宝--我的收藏
    }else if (button.tag==1507){
        JdAndTBVC.urlTbOrJd = @"https://ai.m.taobao.com/myTaobao.html";//爱淘宝--我的淘宝
    }
    [self.parentController.navigationController pushViewController:JdAndTBVC animated:YES];
    
}
//打开天猫8个按钮的详情
-(void)openTMDetails:(UIButton*)button{
    TBAndJDGoodsWebController * JdAndTBVC = [[TBAndJDGoodsWebController alloc]init];
    JdAndTBVC.hidesBottomBarWhenPushed = YES;
    JdAndTBVC.type = @"淘宝";//类型不传是淘宝
    //淘宝商品只能拦截商品列表然后进入SDK，否则没有佣金
    if (button.tag==1500) {
        JdAndTBVC.urlTbOrJd = @"https://pages.tmall.com/wow/rais/act/tmall-choice";//爱淘宝--天猫主页
    }else if (button.tag==1501){
        JdAndTBVC.urlTbOrJd = @"https://pages.tmall.com/wow/import/17151/tmallglobal";//爱淘宝--天猫国际
    }else if (button.tag==1502){
        JdAndTBVC.urlTbOrJd = @"https://www.tmall.com/wh/tmall/fushi/act/nvzhuang";//爱淘宝--天猫女装
    }else if (button.tag==1503){
        JdAndTBVC.urlTbOrJd = @"https://meizhuang.tmall.com";//爱淘宝--天猫美妆
    }else if (button.tag==1504){
        JdAndTBVC.urlTbOrJd = @"https://h5.m.taobao.com/footprint/homev2.html";//爱淘宝--浏览足迹
    }else if (button.tag==1505){
        JdAndTBVC.urlTbOrJd = @"https://h5.m.taobao.com/mlapp/olist.html";//爱淘宝--我的订单
    }else if (button.tag==1506){
        JdAndTBVC.urlTbOrJd = @"https://h5.m.taobao.com/fav/index.htm?";//爱淘宝--我的收藏
    }else if (button.tag==1507){
        JdAndTBVC.urlTbOrJd = @"https://ai.m.taobao.com/myTaobao.html";//爱淘宝--我的淘宝
    }
    [self.parentController.navigationController pushViewController:JdAndTBVC animated:YES];
}

//打开京东8个按钮的详情
-(void)openJDDetails:(UIButton*)button{
    TBAndJDGoodsWebController * JdAndTBVC = [[TBAndJDGoodsWebController alloc]init];
    JdAndTBVC.hidesBottomBarWhenPushed = YES;
    JdAndTBVC.type = @"京东";//类型不传是淘宝
    if (button.tag==1500) {
        JdAndTBVC.urlTbOrJd = @"https://m.jd.com/?ad_od=3";//京东--首页
    }else if (button.tag==1501){
        JdAndTBVC.urlTbOrJd = @"https://pro.m.jd.com/mall/active/2hqsQcyM5bEUVSStkN3BwrBHqVLd/index.html";//京东--秒杀
    }else if (button.tag==1502){
        JdAndTBVC.urlTbOrJd = @"https://ms.m.jd.com/seckill/seckillList";//京东--京东秒杀
    }else if (button.tag==1503){
        JdAndTBVC.urlTbOrJd = @"https://coupon.m.jd.com/center/getCouponCenter.action";//京东--优惠劵
    }else if (button.tag==1504){
        JdAndTBVC.urlTbOrJd = @"https://home.m.jd.com/myJd/history/wareHistory.action";//京东--浏览足迹
    }else if (button.tag==1505){
        JdAndTBVC.urlTbOrJd = @"https://wqs.jd.com/order/orderlist_merge.shtml";//京东--订单列表
    }else if (button.tag==1506){
        JdAndTBVC.urlTbOrJd = @"https://home.m.jd.com/myJd/myFocus/newFocusWare.actionv2";//京东--关注
    }else if (button.tag==1507){
        JdAndTBVC.urlTbOrJd = @"https://home.m.jd.com/myJd/newhome.action";//京东--我的京东
    }
    [self.parentController.navigationController pushViewController:JdAndTBVC animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSString * module = [NSString stringWithFormat:@"%@",self.headimages[index][@"functionCode"]];
    NSString * paramId = [NSString stringWithFormat:@"%@",self.headimages[index][@"paramId"]];
    NSString * strtitle = self.headimages[index][@"title"];
    NSString * strlink = self.headimages[index][@"link"];
    //图片链接
    NSString * imageUrl = self.headimages[index][@"picUrl"];
    
    NSDictionary * dic=@{@"module":module,@"paramId":paramId,@"link":strlink,@"title":strtitle,@"picUrl":imageUrl};
    
    //轮播图点击事件【封装】
    [ADScrollerActionPush AdscrollClickController:self.parentController AndDict:dic];
}



@end
