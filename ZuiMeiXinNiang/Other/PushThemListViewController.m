//
//  ThemeViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2016/11/2.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "PushThemListViewController.h"


@interface PushThemListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,assign)NSInteger currentPage;

@property (nonatomic,strong) UIButton *navButton;//导航栏标题

@property (nonatomic,strong) NSMutableArray *dataSouse;

@end

@implementation PushThemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

@end
