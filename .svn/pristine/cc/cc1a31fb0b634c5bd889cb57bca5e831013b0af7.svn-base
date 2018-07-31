//
//  SetUpViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/1/6.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "SetUpViewController.h"
#import "SetUpTableViewCell.h"
#import "AdviceViewController.h"
#import "AboutMyViewController.h"

#import "HelpViewController.h"

//在app内部打开appstore指定应用的界面
#import <StoreKit/StoreKit.h>

//iOS10.3系统评价应用
#import <StoreKit/StoreKit.h>


@interface SetUpViewController ()<UITableViewDelegate,UITableViewDataSource,SKStoreProductViewControllerDelegate>
@property(nonatomic,strong)UITableView * tableView;
//缓存大小
@property(nonatomic,strong)NSString * strfieldSize;
//缓存
@property(nonatomic,strong) UILabel * labelfieldnumber;

@property (nonatomic,weak)UIView *bageView;
@property (nonatomic,weak)UIView *contentView;
@end

@implementation SetUpViewController

#pragma =============在app内部打开appstore S =============
//在app内部打开appstore指定应用的界面
- (void)openAppWithIdentifier:(NSString*)appId{
    
    SKStoreProductViewController * storeProductVC =     [[SKStoreProductViewController alloc] init];
    //设置代理 SKStoreProductViewControllerDelegate
    storeProductVC.delegate=self;
    
    NSDictionary * dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result,NSError*error) {
        
        if(result) {
            
            [self presentViewController:storeProductVC animated:YES completion:nil];
            
        }
        
    }];
    
}

#pragma mark -协议方法
//在app内部打开appstore指定应用的界面代理方法
- (void)productViewControllerDidFinish:(SKStoreProductViewController*)viewController{
//    NSLog(@"关闭界面");
    //关闭界面，必须
    [viewController dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma =============在app内部打开appstore E =============
- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"设置";
    
    
    [self tableView];
   
    //接收通知刷新开关
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshSwith) name:@"APPWillEnterForeground" object:nil];
    
}




//刷新开关状态（刷新指定cell--开关在哪个）
-(void)refreshSwith{
    
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView reloadData];
   
}


//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 1;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20.0*px;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 20.0*px)];
    viewHeader.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return viewHeader;
}
//脚
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        //return 190.0 * px;
        return 80;
    }
    return 0.01;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * viewFoot = [[UIView alloc]init];
    if (section==2) {
        viewFoot.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        //进入嗅美
        UIButton * loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.backgroundColor = MAIN_COLOR;
        loginBtn.frame=CGRectMake((SCREEN_WIDTH-472.0*px)/2, 20, 472.0*px, 40);
         [loginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [loginBtn addTarget:self action:@selector(outLogin) forControlEvents:UIControlEventTouchUpInside];
        loginBtn.layer.cornerRadius = 20;
        loginBtn.clipsToBounds = YES;
        [viewFoot addSubview:loginBtn];

    }
    
    return viewFoot;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * string=@"str";
    SetUpTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SetUpTableViewCell" owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            [cell.myEnt removeFromSuperview];
            cell.myTitle.text = @"消息推送";
        }
    }
    if (indexPath.section==1) {
     [cell.mySwich removeFromSuperview];
     
        if (indexPath.row==0) {
            [cell.mySwich removeFromSuperview];
            [cell.myEnt removeFromSuperview];
            cell.myTitle.text = @"清除缓存";
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                //沙盒目录下library文件夹下的cache文件夹就是缓存文件夹
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                NSFileManager * fileManager = [NSFileManager defaultManager];
                
                float folderSize = 0.0;
                if ([fileManager fileExistsAtPath:path]){
                    //如果存在
                    //计算文件的大小
                    NSArray * fileArray = [fileManager subpathsAtPath:path];
                    for (NSString * fileName in fileArray){
                        //获取每个文件的路径
                        NSString * filePath = [path stringByAppendingPathComponent:fileName];
                        //计算每个子文件的大
                        long fileSize = [fileManager attributesOfItemAtPath:filePath error:nil].fileSize;//字节数
                        folderSize = folderSize + fileSize / 1024.0 / 1024.0;
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _labelfieldnumber = [[UILabel alloc]init];
                        _labelfieldnumber.frame = CGRectMake(SCREEN_WIDTH-110, 0, 100, 44);
                        _labelfieldnumber.text = [NSString stringWithFormat:@"%.2fM",folderSize];
                        _labelfieldnumber.font = [UIFont systemFontOfSize:16];
                        _labelfieldnumber.textColor = [UIColor colorWithHexString:@"#898989"];
                        _labelfieldnumber.textAlignment = NSTextAlignmentRight;
                        [cell addSubview:_labelfieldnumber];
                    });
                    
                    
                    
                }
            });
        }
    }
    
     if (indexPath.section==2) {
         [cell.mySwich removeFromSuperview];
         
         
         
         if (indexPath.row==0) {
             cell.myTitle.text = @"分享应用";
         }
         if (indexPath.row==1) {
             cell.myTitle.text = @"评价我们";
         }
         
     }
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        //清除缓存
        if (indexPath.row==0) {
            [self GetfolderSize];
        }
       
    }
    
    if (indexPath.section==2) {
        
        //分享应用
        if (indexPath.row==0) {
            //分享
            UIImage * image = [UIImage imageNamed:appLogoName];
            [ShareView share:self ShareTitle:@"淘赚 超in美妆护肤穿衣搭配助手-看美容美妆心得分享，享正品折扣免费试用" WithContent:[NSString stringWithFormat:@"版本：%@",GET_VERSION] ShareUrl:@"http://www.xiumeiapp.com/androidToH5/shareApp.html" shareImage:image ReporStrType:nil shareType:@"只分享到微信" completion:^(NSString *code) {
                
            }];

        }
        
        //评价我们
        if (indexPath.row==1) {

            //由于此API只支持iOS10.3+，因此应该先做版本判断，iOS10.3以下还是跳转到Appstore中进行评分，即将上面代码改为：
            if (ios10_3orLater) {
                //app内部弹出评论框，只能评论星星
//                if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){
//                    [SKStoreReviewController requestReview];
//                }
                //外部直接打开appstore评论界面iOS10.3以上
                NSString *strAppStore = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", AppstoreId];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strAppStore]];
         
            }else{
                //只需要修改后面的App-Id即可
                //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppstoreUrl]];
                
                //在app内部打开appstore调用
//                [self openAppWithIdentifier:AppstoreId];//AppID可以在iTunesconnect中APP信息里查看。
                
                 //外部直接打开appstore评论界面iOS10.3以下
                NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", AppstoreId];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                
               
            }
        }
        
    }
    
}

//退出登录按钮点击
-(void)outLogin{
    
    //退出登录
    [self pressOut];
    
}

//退出登录
-(void)pressOut{
    //退出
    if (SESSIONID.length>0) {
       
        [AlertGXJView AlertGXJAlertWithController:self Title:@"确定退出登录？" Message:nil otherItemArrays:@[@"确定",@"取消"] Width:-1 Type:-1 handler:^(NSInteger index) {
            if (index==0) {
                //用户退出登录-封装
                [OutLoginHelp userOutLogin];
                [self dismissViewControllerAnimated:NO completion:nil];
                self.tabBarController.selectedIndex = 0;//回首页
                [self.navigationController popToRootViewControllerAnimated:NO];
            }
        }];
        
    }
    
    
    
}

#pragma mark 清除缓存
-(void)deleteField{
    //沙盒目录下library文件夹下的cache文件夹就是缓存文件夹
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //彻底删除文件
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]){
        NSArray * fileArray = [fileManager subpathsAtPath:path];
        for (NSString * fileName in fileArray){
            //获取每个子文件的路径
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            //移除指定路径下的文件
            [fileManager removeItemAtPath:filePath error:nil];
        }
        
        //清除首页等自己做的缓存
          [XHNetworkCache clearCache];
        

        //刷新指定表格
        _labelfieldnumber.text = [NSString stringWithFormat:@"0.00M"];
        [self.tableView reloadData];
    }
    

}

#pragma mark - 计算缓存大小
-(void)GetfolderSize{
    //沙盒目录下library文件夹下的cache文件夹就是缓存文件夹
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]){
        //如果存在
        //计算文件的大小
        NSArray * fileArray = [fileManager subpathsAtPath:path];
        for (NSString * fileName in fileArray){
            //获取每个文件的路径
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            //计算每个子文件的大
            long fileSize = [fileManager attributesOfItemAtPath:filePath error:nil].fileSize;//字节数
            
            folderSize = folderSize + fileSize / 1024.0 / 1024.0;
        }
        if (folderSize > 0.01){
            [AlertGXJView AlertGXJAlertWithController:self Title:@"提示" Message:[NSString stringWithFormat:@"缓存大小:%.2fM,是否清除？",folderSize] otherItemArrays:@[@"确定",@"取消"] Width:-1 Type:-1 handler:^(NSInteger index) {
                if (index==0) {
                   [self deleteField];
                }
            }];
            
        }else{
            [AlertGXJView AlertGXJAlertWithController:self Title:@"提示" Message:@"缓存已全部清理" otherItemArrays:@[@"确定"] Width:-1 Type:-1 handler:^(NSInteger index) {
            }];
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
    //清除上传的视频缓存（指定文件夹路径清理缓存）
    [NSString videoRemoField];
    
  
}





-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
