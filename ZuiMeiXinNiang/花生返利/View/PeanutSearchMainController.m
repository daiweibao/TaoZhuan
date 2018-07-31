//
//  PeanutSearchMainController.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/12/7.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "PeanutSearchMainController.h"

@interface PeanutSearchMainController ()<UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scroll;

@property (nonatomic,strong)NSMutableArray *historySearchTB;//历史搜索关键字淘宝
@property (nonatomic,strong)NSMutableArray *historySearchTM;//历史搜索关键字天猫
@property (nonatomic,strong)NSMutableArray *historySearchJD;//历史搜索关键字京东
@property (nonatomic,strong)NSMutableArray *hotSearch;//热门关键字

@property (nonatomic,strong)UITextField *searchTextField;
@property (nonatomic,strong) UIButton *typeButton;//搜索分类
@property (nonatomic,strong) UIView *typebg;//搜索分类bg

@end

@implementation PeanutSearchMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    [self loadData];

}

//加载推荐关键词
- (void)loadData{
    
    id tb = [[NSUserDefaults standardUserDefaults] objectForKey:@"historySearchtb"];
    id tm = [[NSUserDefaults standardUserDefaults] objectForKey:@"historySearchtm"];
    id jd = [[NSUserDefaults standardUserDefaults] objectForKey:@"historySearchjd"];
    
    for (id str in tb) {
        [self.historySearchTB addObject:str];
    }
    for (id str in tm) {
        [self.historySearchTM addObject:str];
    }
    for (id str in jd) {
        [self.historySearchJD addObject:str];
    }
    
    //加载热搜词
    [self loadHot];
    
    
}


//加载热搜词
- (void)loadHot{
    
    [GXJAFNetworking POST:HotSearchResult parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
            for (NSDictionary *dict in responseObject[@"search"]) {
                if (![NSString isNULL:dict[@"keyword"]]) {
                    [self.hotSearch addObject:dict[@"keyword"]];
                }
            }
            
            if (self.hotSearch.count == 0) {
                [self.hotSearch addObject:@"隔离霜"];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setupUI];
            });
            
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

//创建导航栏
- (void)setupNav{
    
    //底板
    UIView *navBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MC_NavHeight)];
    navBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navBg];
    
    //返回
    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, MC_StatusBarHeight, 44, 44);
    [back setImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(pressButtonLeft) forControlEvents:UIControlEventTouchUpInside];
    [navBg addSubview:back];
    
    //搜索
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(SCREEN_WIDTH-50, MC_StatusBarHeight, 50, 44);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [navBg addSubview:searchBtn];
    
    //搜索框背景
    UIView *searchBg = [[UIView alloc]initWithFrame:CGRectMake(50, MC_StatusBarHeight+7, SCREEN_WIDTH-100, 30)];
    searchBg.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    searchBg.layer.cornerRadius = 3;
    searchBg.clipsToBounds = YES;
    [navBg addSubview:searchBg];
    
    //搜索分类
    UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.typeButton = typeButton;
    if ([NSString isNULL:self.searchType]) {
        [typeButton setTitle:@"淘宝" forState:UIControlStateNormal];
    }else{
        [typeButton setTitle:self.searchType forState:UIControlStateNormal];
    }
    [typeButton setImage:[UIImage imageNamed:@"花生搜索下拉"] forState:UIControlStateNormal];
    typeButton.frame = CGRectMake(0, 0, 60, 30);
    [typeButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    typeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [typeButton addTarget:self action:@selector(typeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [typeButton setImagePositionWithType:SSImagePositionTypeRight spacing:5];
    [searchBg addSubview:typeButton];
    
    //搜索框
    UITextField *searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(typeButton.rightX,0, searchBg.width-typeButton.width-10, 30)];
    searchTextField.placeholder=@"宝贝名称/关键字";
    searchTextField.delegate = self;
    self.searchTextField = searchTextField;
    searchTextField.font = [UIFont systemFontOfSize:14];
    searchTextField.clearButtonMode = UITextFieldViewModeAlways;
    searchTextField.keyboardType = UIKeyboardTypeDefault;
    searchTextField.returnKeyType = UIReturnKeySearch;
    searchTextField.textAlignment=NSTextAlignmentLeft;
    searchTextField.textColor = [UIColor blackColor];
    [searchBg addSubview:searchTextField];
   
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, MC_NavHeight-0.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = MAIN_COLOR_Line_Xi;
    [self.view addSubview:line];
    
    //父视图
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight)];
    scroll.delegate = self;
    scroll.bounces = YES;
    self.scroll = scroll;
    scroll.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT+1);
    [self.view addSubview:scroll];

}

//刷新
- (void)refresh{
    
    [self.historySearchJD removeAllObjects];
    [self.historySearchTM removeAllObjects];
    [self.historySearchTB removeAllObjects];
    
    id tb = [[NSUserDefaults standardUserDefaults] objectForKey:@"historySearchtb"];
    id tm = [[NSUserDefaults standardUserDefaults] objectForKey:@"historySearchtm"];
    id jd = [[NSUserDefaults standardUserDefaults] objectForKey:@"historySearchjd"];
    
    for (id str in tb) {
        [self.historySearchTB addObject:str];
    }
    for (id str in tm) {
        [self.historySearchTM addObject:str];
    }
    for (id str in jd) {
        [self.historySearchJD addObject:str];
    }
    
    [self setupUI];
    
}

//创建界面
- (void)setupUI{
    
    [self.scroll removeAllSubviews];
    
    NSArray *historyArr;
    if ([self.typeButton.titleLabel.text isEqualToString:@"淘宝"]) {
        historyArr = self.historySearchTB;
    }else if ([self.typeButton.titleLabel.text isEqualToString:@"天猫"]) {
        historyArr = self.historySearchTM;
    }else{
        historyArr = self.historySearchJD;
    }
    
    NSArray *hotArr = self.hotSearch.copy;//热门关键字
    
    if (historyArr.count != 0) {
        
        UILabel *history = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 45)];
        history.text = @"历史搜索";
        history.font = [UIFont systemFontOfSize:15];
        [self.scroll addSubview:history];
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH-60, 8, 60, 30);
        [deleteBtn setImage:[UIImage imageNamed:@"地址管理删除"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.scroll addSubview:deleteBtn];
        
        //保存前一个button的宽以及前一个button距离屏幕边缘的距离
        CGFloat w = 15;
        //用来控制button距离父视图的高
        CGFloat h = history.bottomY;
        //button高度
        CGFloat heightbutton = 25;
        //button宽度，出去字体宽度的
        CGFloat buttonAddwidth = 20;
        
        UIButton* lastBtn;
    
        for (int i = 0; i < historyArr.count; i++) {
            
            UIButton* labelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            lastBtn = labelButton;
            [labelButton setTitleColor:MAIN_COLOR_898989 forState:UIControlStateNormal];
            [labelButton setTitle:historyArr[i] forState:UIControlStateNormal];
            labelButton.titleLabel.font = [UIFont systemFontOfSize:13];
            labelButton.layer.cornerRadius = 3;
            labelButton.clipsToBounds = YES;
            labelButton.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
            [labelButton addTarget:self action:@selector(historykeyClick:) forControlEvents:UIControlEventTouchUpInside];
            
            //根据计算文字的大小
            CGFloat length = [NSString sizeMyStrWith:historyArr[i] andFontSize:13 andMineWidth:SCREEN_WIDTH].width;
            //设置button的frame
            labelButton.frame = CGRectMake(w, h, length + buttonAddwidth , heightbutton);
            
            //当button的位置超出屏幕边缘时换行  只是button所在父视图的宽度
            if(labelButton.rightX > SCREEN_WIDTH-15){
               
                //换行时将w置为起始坐标
                w =  15;
                //距离父视图也变化
                h = h + labelButton.frame.size.height + 10;
                //重设button的frame
                labelButton.frame = CGRectMake(w, h, length + buttonAddwidth, heightbutton);
            }
            
            //多加的是两个标签之间的距离
            w = labelButton.frame.size.width + labelButton.frame.origin.x+15;
            
            [self.scroll addSubview:labelButton];
            
        }
        
        
        UILabel *hot = [[UILabel alloc]initWithFrame:CGRectMake(15, lastBtn.bottomY+5, SCREEN_WIDTH, 45)];
        hot.text = @"推荐";
        hot.font = [UIFont systemFontOfSize:15];
        [self.scroll addSubview:hot];
        
        //保存前一个button的宽以及前一个button距离屏幕边缘的距离
        CGFloat hotw = 15;
        h=hot.bottomY;
        for (int i = 0; i < hotArr.count; i++) {
            
            UIButton* labelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            lastBtn = labelButton;
            [labelButton setTitleColor:MAIN_COLOR_898989 forState:UIControlStateNormal];
            [labelButton setTitle:hotArr[i] forState:UIControlStateNormal];
            labelButton.titleLabel.font = [UIFont systemFontOfSize:13];
            labelButton.layer.cornerRadius = 3;
            labelButton.clipsToBounds = YES;
            labelButton.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
            [labelButton addTarget:self action:@selector(hotkeyClick:) forControlEvents:UIControlEventTouchUpInside];
            
            //根据计算文字的大小
            CGFloat length = [NSString sizeMyStrWith:hotArr[i] andFontSize:13 andMineWidth:SCREEN_WIDTH].width;
            //设置button的frame
            labelButton.frame = CGRectMake(hotw, h, length + buttonAddwidth , heightbutton);
            
            //当button的位置超出屏幕边缘时换行  只是button所在父视图的宽度
            if(labelButton.rightX > SCREEN_WIDTH-15){
                
                //换行时将w置为起始坐标
                hotw =  15;
                //距离父视图也变化
                h = h + labelButton.frame.size.height + 10;
                //重设button的frame
                labelButton.frame = CGRectMake(hotw, h, length + buttonAddwidth, heightbutton);
            }
            
            //多加的是两个标签之间的距离
            hotw = labelButton.frame.size.width + labelButton.frame.origin.x+15;
            
            [self.scroll addSubview:labelButton];
            
        }
        
        self.scroll.contentSize = CGSizeMake(SCREEN_WIDTH, lastBtn.bottomY+64);
        
    }else{
        
        UILabel *history = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 45)];
        history.text = @"推荐";
        history.font = [UIFont systemFontOfSize:15];
        [self.scroll addSubview:history];
        
        //保存前一个button的宽以及前一个button距离屏幕边缘的距离
        CGFloat w = 15;
        //用来控制button距离父视图的高
        CGFloat h = history.bottomY;
        //button高度
        CGFloat heightbutton = 25;
        //button宽度，出去字体宽度的
        CGFloat buttonAddwidth = 20;
        
        UIButton* lastBtn;
        
        for (int i = 0; i < hotArr.count; i++) {
            
            UIButton* labelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            lastBtn = labelButton;
            [labelButton setTitleColor:MAIN_COLOR_898989 forState:UIControlStateNormal];
            [labelButton setTitle:hotArr[i] forState:UIControlStateNormal];
            labelButton.titleLabel.font = [UIFont systemFontOfSize:13];
            labelButton.layer.cornerRadius = 3;
            labelButton.clipsToBounds = YES;
            labelButton.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
            [labelButton addTarget:self action:@selector(hotkeyClick:) forControlEvents:UIControlEventTouchUpInside];
            
            //根据计算文字的大小
            CGFloat length = [NSString sizeMyStrWith:hotArr[i] andFontSize:13 andMineWidth:SCREEN_WIDTH].width;
            //设置button的frame
            labelButton.frame = CGRectMake(w, h, length + buttonAddwidth , heightbutton);
            
            //当button的位置超出屏幕边缘时换行  只是button所在父视图的宽度
            if(labelButton.rightX > SCREEN_WIDTH-15){
                
                //换行时将w置为起始坐标
                w =  15;
                //距离父视图也变化
                h = h + labelButton.frame.size.height + 10;
                //重设button的frame
                labelButton.frame = CGRectMake(w, h, length + buttonAddwidth, heightbutton);
            }
            
            //多加的是两个标签之间的距离
            w = labelButton.frame.size.width + labelButton.frame.origin.x+15;
            
            [self.scroll addSubview:labelButton];
            
            self.scroll.contentSize = CGSizeMake(SCREEN_WIDTH, lastBtn.bottomY+64);
            
        }
    
    }
}

//搜索分类点击
- (void)typeButtonClick:(UIButton *)btn{
    
    if (self.typebg != nil) {
        self.typebg.alpha = 0;
        [self.typebg removeFromSuperview];
        self.typebg = nil;
        return;
    }
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(50, MC_NavHeight-6, 60, 44*3)];
    self.typebg = bg;
    bg.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    bg.layer.cornerRadius = 3;
    bg.clipsToBounds = YES;
    [self.view addSubview:bg];

    NSArray *titles = @[@"淘宝",@"天猫",@"京东"];
    for (int i=0; i<3; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 44*i, 60, 44)];
        label.text = titles[i];
        label.tag = i;
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        [bg addSubview:label];
        label.userInteractionEnabled = YES;
        WeakSelf(label);
        [label addTapActionTouch:^{
            [self.typeButton setTitle:titles[weaklabel.tag] forState:UIControlStateNormal];
            [self.typebg removeFromSuperview];
            self.typebg = nil;
            [self refresh];
        }];

        if ([self.typeButton.titleLabel.text isEqualToString:titles[i]]) {
             label.textColor = MAIN_COLOR;
        }else{
             label.textColor = [UIColor blackColor];
        }
    }

    for (int i=0; i<2; i++) {
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 44*(i+1), 60, 0.5)];
        line.backgroundColor = MAIN_COLOR_Line_Xi;
        [bg addSubview:line];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.text.length == 0){
        [textField resignFirstResponder];
        return YES;
    }
    
    //上传热搜词
    [self uploadSearchKey:textField.text];
    
    if ([self.typeButton.titleLabel.text isEqualToString:@"京东"]) {
        [OpenJDGoodesDetals JDSearchGoodsController:self AndWords:textField.text];
    }else if ([self.typeButton.titleLabel.text isEqualToString:@"天猫"]){
        //搜索爱淘宝商品
        [OpenTaobaoGoodes TBSearchGoodsController:self AndTBWords:textField.text];
    }else{
        //搜索爱淘宝商品
        [OpenTaobaoGoodes TBSearchGoodsController:self AndTBWords:textField.text];
    }
    
    
    [self test:textField];
    
    [textField resignFirstResponder];
    [self refresh];
    return YES;
    
}

//搜索按钮点击
- (void)searchClick{
    UITextField *textField = self.searchTextField;
    
    if (textField.text.length == 0){
        [textField resignFirstResponder];
        return;
    }
    
    //上传热搜词
    [self uploadSearchKey:textField.text];
    
    if ([self.typeButton.titleLabel.text isEqualToString:@"京东"]) {
          [OpenJDGoodesDetals JDSearchGoodsController:self AndWords:textField.text];
    }else if ([self.typeButton.titleLabel.text isEqualToString:@"天猫"]){
        //搜索爱淘宝商品
        [OpenTaobaoGoodes TBSearchGoodsController:self AndTBWords:textField.text];
    }else{
        //搜索爱淘宝商品
        [OpenTaobaoGoodes TBSearchGoodsController:self AndTBWords:textField.text];
    }
    

    [self test:textField];
    
    [textField resignFirstResponder];
    [self refresh];
    
}

//删除历史搜索记录
- (void)deleteBtnClick{
    
    [self.view endEditing:YES];
    
    [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:@"确定要清空历史搜索记录？" otherItemArrays:@[@"确定",@"取消"] Width:-1 Type:-1 handler:^(NSInteger index) {
        
        if (index == 0) {
            if ([self.typeButton.titleLabel.text isEqualToString:@"淘宝"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:@"historySearchtb"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }else if ([self.typeButton.titleLabel.text isEqualToString:@"天猫"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:@"historySearchtm"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }else{
                
                [[NSUserDefaults standardUserDefaults] setObject:@[] forKey:@"historySearchjd"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }
            [self refresh];
        }
        
    }];
    
}

//热门推荐按钮搜索
- (void)hotkeyClick:(UIButton *)btn{
    [self.view endEditing:YES];
    
    //上传热搜词
    [self uploadSearchKey:btn.titleLabel.text];
    
#warning 这里写网络请求
    if ([self.typeButton.titleLabel.text isEqualToString:@"京东"]) {
        [OpenJDGoodesDetals JDSearchGoodsController:self AndWords:btn.titleLabel.text];
    }else if ([self.typeButton.titleLabel.text isEqualToString:@"天猫"]){
        //搜索爱淘宝商品
        [OpenTaobaoGoodes TBSearchGoodsController:self AndTBWords:btn.titleLabel.text];
    }else{
        //搜索爱淘宝商品
        [OpenTaobaoGoodes TBSearchGoodsController:self AndTBWords:btn.titleLabel.text];
    }
    
    
    NSString *hotstr = btn.titleLabel.text;
    if ([self.typeButton.titleLabel.text isEqualToString:@"淘宝"]) {
        
        BOOL flag = NO;
        for (id str in self.historySearchTB) {
            if ([str isEqual:hotstr]) {//说明有重复
                flag = YES;
            }
        }
        if (flag == NO) {
            if (self.historySearchTB.count >=10) {
                [self.historySearchTB removeObjectAtIndex:0];
            }
            [self.historySearchTB addObject:hotstr];
        }
        [[NSUserDefaults standardUserDefaults] setObject:self.historySearchTB.copy forKey:@"historySearchtb"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else if ([self.typeButton.titleLabel.text isEqualToString:@"天猫"]) {
        
        BOOL flag = NO;
        for (id str in self.historySearchTM) {
            if ([str isEqual:hotstr]) {//说明有重复
                flag = YES;
            }
        }
        if (flag == NO) {
            if (self.historySearchTM.count >=10) {
                [self.historySearchTM removeObjectAtIndex:0];
            }
            [self.historySearchTM addObject:hotstr];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:self.historySearchTM.copy forKey:@"historySearchtm"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
        
        BOOL flag = NO;
        for (id str in self.historySearchJD) {
            if ([str isEqual:hotstr]) {//说明有重复
                flag = YES;
            }
        }
        if (flag == NO) {
            if (self.historySearchJD.count >=10) {
                [self.historySearchJD removeObjectAtIndex:0];
            }
            [self.historySearchJD addObject:hotstr];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:self.historySearchJD.copy forKey:@"historySearchjd"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    [self refresh];
    
}

//封装起来的搜索
- (void)test:(UITextField *)textField{
    
    if ([self.typeButton.titleLabel.text isEqualToString:@"淘宝"]) {
        
        BOOL flag = NO;
        
        for (id str in self.historySearchTB) {
            if ([str isEqual:textField.text]) {//说明有重复
                flag = YES;
            }
        }
        if (flag == NO) {
            if (self.historySearchTB.count >=10) {
                [self.historySearchTB removeObjectAtIndex:0];
            }
            [self.historySearchTB addObject:textField.text];
        }
        [[NSUserDefaults standardUserDefaults] setObject:self.historySearchTB.copy forKey:@"historySearchtb"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else if ([self.typeButton.titleLabel.text isEqualToString:@"天猫"]) {
        
        BOOL flag = NO;
        for (id str in self.historySearchTM) {
            if ([str isEqual:textField.text]) {//说明有重复
                flag = YES;
            }
        }
        if (flag == NO) {
            if (self.historySearchTM.count >=10) {
                [self.historySearchTM removeObjectAtIndex:0];
            }
            [self.historySearchTM addObject:textField.text];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:self.historySearchTM.copy forKey:@"historySearchtm"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
        
        BOOL flag = NO;
        for (id str in self.historySearchJD) {
            if ([str isEqual:textField.text]) {//说明有重复
                flag = YES;
            }
        }
        if (flag == NO) {
            if (self.historySearchJD.count >=10) {
                [self.historySearchJD removeObjectAtIndex:0];
            }
            [self.historySearchJD addObject:textField.text];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:self.historySearchJD.copy forKey:@"historySearchjd"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    
}

//历史关键字搜索
- (void)historykeyClick:(UIButton *)btn{
    
    //上传热搜词
    [self uploadSearchKey:btn.titleLabel.text];
    
    if ([self.typeButton.titleLabel.text isEqualToString:@"京东"]) {
        [OpenJDGoodesDetals JDSearchGoodsController:self AndWords:btn.titleLabel.text];
    }else if ([self.typeButton.titleLabel.text isEqualToString:@"天猫"]){
        //搜索爱淘宝商品
        [OpenTaobaoGoodes TBSearchGoodsController:self AndTBWords:btn.titleLabel.text];
    }else{
        //搜索爱淘宝商品
        [OpenTaobaoGoodes TBSearchGoodsController:self AndTBWords:btn.titleLabel.text];
    }
    
}

- (NSMutableArray *)historySearchTB{
    if (_historySearchTB == nil) {
        _historySearchTB = [NSMutableArray array];
    }
    return _historySearchTB;
}
- (NSMutableArray *)historySearchTM{
    if (_historySearchTM == nil) {
        _historySearchTM = [NSMutableArray array];
    }
    return _historySearchTM;
}
- (NSMutableArray *)historySearchJD{
    if (_historySearchJD == nil) {
        _historySearchJD = [NSMutableArray array];
    }
    return _historySearchJD;
}
- (NSMutableArray *)hotSearch{
    if (_hotSearch == nil) {
        _hotSearch = [NSMutableArray array];
    }
    return _hotSearch;
}

//上传搜索词
- (void)uploadSearchKey:(NSString *)str{
    if ([NSString isNULL:str]) {
        str = @"";
    }
    NSDictionary *dict = @{@"searchKey":str};
    [GXJAFNetworking POST:addSearchKey parameters:dict success:^(id  _Nullable responseObject) {
       
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;
#pragma mark ============添加京东订单，通知后台去同步订单账号================
    [OpenJDGoodesDetals addJDOrderLoadAFN];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end
