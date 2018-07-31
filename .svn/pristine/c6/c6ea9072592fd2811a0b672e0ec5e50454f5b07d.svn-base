//
//  RootViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 15/12/11.
//  Copyright (c) 2015年 zmxn. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//创建标题
-(void)createTitle:(NSString *)title{
    UILabel *label                = [[UILabel alloc]init];
    label.frame                   = CGRectMake(100, 0, self.view.frame.size.width-200, 64);
    label.text                    = title;
    label.textColor               = [UIColor blackColor];
    label.textAlignment           = NSTextAlignmentCenter;
    label.font                    = [UIFont systemFontOfSize:18];
    self.navigationItem.titleView = label;
}

-(void)createLeftButton:(NSString *)imageName andWith:(NSString *)tword{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onLeftButtonClick:)];
    if ([tword isEqualToString:@"left"]) {
        self.navigationItem.leftBarButtonItem = item;
        item.tag = -1;
    }else{
        self.navigationItem.rightBarButtonItem = item;
        item.tag = -2;
    }
}

-(void)onLeftButtonClick:(UIBarButtonItem *)item{
    //    子类重写
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//     [self.view  endEditing:YES];
    

    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
     [super viewWillDisappear:animated];
   

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
