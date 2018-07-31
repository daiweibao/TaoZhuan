//
//  MineDataViewController.m
//  ZuiMeiXinNiang
//
//  Created by zmxn on 15/12/27.
//  Copyright (c) 2015年 zmxn. All rights reserved.
//

#import "MineDataViewController.h"
#import "MineDataTableViewCell.h"
#import "MineDataCodeTableViewCell.h"
#import "NameChangeViewController.h"
#import "ChangeAddressViewController.h"
#import "ChangePasswordViewController.h"
#import "SetUpViewController.h"

#import "UMSocial.h"


@interface MineDataViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>{
    
    UIView * viewPhoneNumber;
    //地址
    UITextField *  AreaLabel;
  
}
@property (nonatomic,strong)AddressView * addressView;
@property (nonatomic,strong)UIToolbar * toolBar;

@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,strong)UITableView * tableView;

//日期选择器父视图
@property(nonatomic,strong)UIView * viewSubDate;
//日期
@property(nonatomic,strong)NSString * stringDate;
//性别
@property(nonatomic,strong)NSString * stringSex;
/**
 *  头像
 */
@property(nonatomic,strong)UIImageView * imagePhone;
//昵称
@property(nonatomic,strong)NSString * changeName;

//地区
@property(nonatomic,strong) NSString * stringAdders;

//星座
@property(nonatomic,strong)NSString * stringXingzuo;

//我的女资料数组
@property(nonatomic,strong)NSMutableArray * arrTitle;
//选择地址的父视图
@property(nonatomic,strong)UIView * Subadderss;
//透明挡板
@property(nonatomic,strong)UIButton * buttonalph;

//昵称输入框
@property(nonatomic,strong)UITextField * textName;
//省跟城市
@property(nonatomic,strong)NSMutableArray *arrayProvinces;
@property(nonatomic,strong)NSMutableArray *arrayCity;

//存放选择后得到的日期
@property(nonatomic,strong)NSString * pickDate;


@end

@implementation MineDataViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    
    [self dataRrlode];
 
//    //修改昵称
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeName:) name:@"changeName" object:nil];
    //修改头像
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changePhone:) name:@"minedateEditImage" object:nil];

//    监听键盘限制字数输入
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(infoAction:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

//时时监听键盘限制标签字数为5
- (void)infoAction:(NSNotification*)notf{
    
    self.changeName = self.textName.text;
   
}






-(NSMutableArray *)arrTitle{
    if (!_arrTitle) {
        _arrTitle=[NSMutableArray array];
    }
    return _arrTitle;
}
////修改昵称
//-(void)changeName:(NSNotification*)notif{
//    self.changeName = notif.object[@"name"];
//    //刷新指定表格
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
//    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//}



-(void)createUI{
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onLeftButtonClick)];
//    self.navigationItem.leftBarButtonItem = item;
////    UIBarButtonItem * itemRight = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"设置"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onRightbuttonClick)];
////    self.navigationItem.rightBarButtonItem  = itemRight;
//    
//    //设置中间标题
//    UILabel *label                = [[UILabel alloc]init];
//    label.frame                   = CGRectMake(100, 0, self.view.frame.size.width-200, 64);
//    label.text                    = @"我的资料";
//    label.textColor               = [UIColor blackColor];
//    label.textAlignment           = NSTextAlignmentCenter;
//    label.font                    = [UIFont systemFontOfSize:20];
//    self.navigationItem.titleView = label;
    
    
    UIView * TopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    TopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:TopView];
    //美聊
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100,20, 200, 44)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"我的资料";
    [TopView addSubview:titleLabel];
    
    //相机按钮
    UIButton * buttonsearch = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonsearch.frame = CGRectMake(0, 20, 44, 44);
    [buttonsearch setImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [buttonsearch addTarget:self action:@selector(onLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:buttonsearch];
    
    
    UIButton * buttonoK = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonoK.frame = CGRectMake(SCREEN_WIDTH-49, 19, 44, 44);
    [buttonoK setTitle:@"保存" forState:UIControlStateNormal];
    [buttonoK setTitleColor:MAIN_COLOR_TWO forState:UIControlStateNormal];
    buttonoK.titleLabel.font = [UIFont systemFontOfSize:16];
    [buttonoK addTarget:self action:@selector(onRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:buttonoK];

    //创建一条线
    UIImageView * imagelineTope = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
    imagelineTope.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [TopView addSubview:imagelineTope];


}

//返回
-(void)onLeftButtonClick:(UIButton*)button{
    if (self.refshDate.length>0) {
        //注册界面下来的
        [[NSNotificationCenter defaultCenter]postNotificationName:@"RegistrationLoginMine" object:nil];
        //跳回首页
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];

        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark ============== 保存按钮点击事件====================
-(void)onRightButtonClick:(UIButton*)button{
   

    if (self.changeName.length==0) {
        
        if (ios8orLater) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"  message:@"昵称不能为空" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else{
            
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"昵称不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
            
        }
        
        
        return;
    }
    if (self.changeName.length>10) {
        
        if (ios8orLater) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"  message:@"昵称长度不能超过10个字" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else{
            
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"昵称长度不能超过10个字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
            
        }
        
        
        return;
    }
    

    
    
    //判断生日
    
    if ([self.stringDate isEqual:@"未知"]) {
    //用户没有选择生日，会崩溃
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"  message:@"请选择生日" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;

    }
    
    
    
    MBProgressHUD  * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
    [hud setLabelText:@"正在保存..."];
    button.userInteractionEnabled = NO;
    //先上传头像
    UIImage * image=self.imagePhone.image;//从控件上获取
    NSData * imageData=UIImageJPEGRepresentation(image, 0.5);
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval=100;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSDictionary * dict=@{@"sessionId":SESSIONID,@"image":imageData};
    [manager POST:SENDER_PHONR parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"snn.png" mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         button.userInteractionEnabled = YES;
        //头像连接
        NSString * inageurePhone;
        //提示用户账号被挤掉，重新登录
        if ([responseObject[@"code"] isEqual:@"97"]){
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下线通知" message:@"你的账号在另一台手机登录,您被迫下线，如非本人操作，则密码可能已泄露，建议您修改密码。" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okActionLogin = [UIAlertAction actionWithTitle:@"重新登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //给他赋值为空，以清除sessionId
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"sessionId"];
                //跳到登陆界面
                LoginViewController * loginVc = [[LoginViewController alloc]init];
                loginVc.hidesBottomBarWhenPushed = YES;
                //传标识下去，登陆后回到首页
                loginVc.blackHome = @"downLine";
                [self.navigationController pushViewController:loginVc animated:YES];
            }];
            [alertController addAction:okActionLogin];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }

        //头像上传成功后再传资料
        if ([responseObject[@"code"] isEqual:@"00"]) {
          //头像连接
            inageurePhone = responseObject[@"image"];
            
            NSDictionary * dic = @{@"sessionId":SESSIONID,@"nickName":self.changeName,@"birthday":self.stringDate,@"sex":self.stringSex,@"addr":self.stringAdders};
            [manager POST: Change_Usedata parameters:dic constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject[@"code"] isEqual:@"00"]) {
                    
                    
                    //把自己账户信息存进去(昵称，ID，头像)
                    NSDictionary * dictuse = @{@"userName":self.changeName,@"userId":USERINFO[@"userId"],@"image":inageurePhone};
                    [[NSUserDefaults standardUserDefaults] setObject:dictuse forKey:@"userInfo"];
                    //保证数据存储成功
                    [[NSUserDefaults standardUserDefaults] synchronize];

                    
                    
                    //影藏他
                    [hud hide:YES afterDelay:0.1];
                    
                    //提示用户账号被挤掉，重新登录
                    if ([responseObject[@"code"] isEqual:@"97"]){
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下线通知" message:@"你的账号在另一台手机登录,您被迫下线，如非本人操作，则密码可能已泄露，建议您修改密码。" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okActionLogin = [UIAlertAction actionWithTitle:@"重新登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            //给他赋值为空，以清除sessionId
                            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"sessionId"];
                            //跳到登陆界面
                            LoginViewController * loginVc = [[LoginViewController alloc]init];
                            loginVc.hidesBottomBarWhenPushed = YES;
                            //传标识下去，登陆后回到首页
                            loginVc.blackHome = @"downLine";
                            [self.navigationController pushViewController:loginVc animated:YES];
                        }];
                        [alertController addAction:okActionLogin];
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    }

                    
                    if (ios8orLater) {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"  message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            //发通知去上一页刷新个人资料
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshHeadNotification" object:nil];
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                        [alertController addAction:okAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                        
                    }else{
                        
                        
                        UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        aler.delegate = self;
                        [aler show];
                        
                        
                    }
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 button.userInteractionEnabled = YES;
                //没网等各种错误提示(把句号替换成空白)
                [MBProgressHUD showNoNetwork:[error.localizedDescription stringByReplacingOccurrencesOfString:@"。" withString:@""]];
            }];

        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         button.userInteractionEnabled = YES;
        //没网等各种错误提示(把句号替换成空白)
        [MBProgressHUD showNoNetwork:[error.localizedDescription stringByReplacingOccurrencesOfString:@"。" withString:@""]];
    }];
}

//确定键点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //发通知去上一页刷新个人资料
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshHeadNotification" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


//我的资料
-(void)dataRrlode{
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
    NSDictionary * dic = @{@"sessionId":SESSIONID};
    [manager POST: MINE_HOME_DATA parameters:dic constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

       
       dispatch_async(dispatch_get_main_queue(), ^{
           
           //提示用户账号被挤掉，重新登录
           if ([responseObject[@"code"] isEqual:@"97"]){
               
               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"下线通知" message:@"你的账号在另一台手机登录,您被迫下线，如非本人操作，则密码可能已泄露，建议您修改密码。" preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction *okActionLogin = [UIAlertAction actionWithTitle:@"重新登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   //给他赋值为空，以清除sessionId
                   [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"sessionId"];
                   //跳到登陆界面
                   LoginViewController * loginVc = [[LoginViewController alloc]init];
                   loginVc.hidesBottomBarWhenPushed = YES;
                   //传标识下去，登陆后回到首页
                   loginVc.blackHome = @"downLine";
                   [self.navigationController pushViewController:loginVc animated:YES];
               }];
               [alertController addAction:okActionLogin];
               [self presentViewController:alertController animated:YES completion:nil];
               
           }

           if ([responseObject[@"code"] isEqual:@"00"]) {
               
               NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
               //把用户名存进去
               [defuaults setObject:responseObject[@"userInfo"][@"nickName"] forKey:@"userName"];
               
               if (_currentPage==0) {
                   [self.arrTitle removeAllObjects];
               }
               [self.arrTitle addObject:responseObject[@"userInfo"]];
               //初始化修改后的昵称
               self.changeName =  [self.arrTitle firstObject][@"nickName"];
               //初始化生日
               if ( [[self.arrTitle firstObject][@"birthday"] isEqual:[NSNull null]]) {
                   self.stringDate = @"未知";
               }else{
                   
                   self.stringDate = [[[self.arrTitle firstObject][@"birthday"] componentsSeparatedByString:@"T"] firstObject];
               }
               
               //初始化星座
               self.stringXingzuo = [self.arrTitle firstObject][@"constellation"];
               
               //初始化地区
               if ([[self.arrTitle firstObject][@"addr"] isEqual:[NSNull null]]) {
                   self.stringAdders = @"用户未填写";
               }else{
                   self.stringAdders = [self.arrTitle firstObject][@"addr"];
               }
               
               
               
               [self.tableView reloadData];
               [self.tableView.mj_header endRefreshing];
               
           }
           
       });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        //没网等各种错误提示(把句号替换成空白)
        [MBProgressHUD showNoNetwork:[error.localizedDescription stringByReplacingOccurrencesOfString:@"。" withString:@""]];
    }];
}


#pragma mark Create  TableView

//tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //tableview拖动时收起键盘
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

        //去掉cell之间的分割线
//        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //分割线的颜色
        [_tableView setSeparatorColor:[UIColor groupTableViewBackgroundColor]];
        
        [self.view addSubview:_tableView];
        //创建日期选择器
        [self createDatePicker];

    }
    
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 122.0*HeightProportion;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 20.0*HeightProportion;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString * string=@"MineData";
        MineDataTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:string];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"MineDataTableViewCell" owner:self options:nil]lastObject];
            
        }
    //移除进入按钮
    [cell.buttonEnt removeFromSuperview];
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.myData.text = @"头像";
            cell.myTitle.text = @"";
            self.imagePhone = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-161.0*WidthProportion,11.0*HeightProportion , 100.0*WidthProportion, 100.0*WidthProportion)];
            
            NSURL * navurl = [NSURL URLWithString:[self.arrTitle firstObject][@"image"]];
            [self.imagePhone sd_setImageWithURL:navurl placeholderImage:[UIImage imageNamed:@"启动图标最终版"]];
            self.imagePhone.layer.cornerRadius = 50.0*WidthProportion;
            self.imagePhone.clipsToBounds = YES;
            [cell addSubview:self.imagePhone];
        }
        if (indexPath.row==1) {
            cell.myData.text = @"昵称";
             cell.myTitle.text = @"";
#pragma ==============昵称输入框UITextField===========
            self.textName=[[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2-22, 122.0*HeightProportion)];
            //右对齐
            self.textName.textAlignment = UITextLayoutDirectionRight;
            self.textName.placeholder = @"请在此输入昵称";
            self.textName.delegate = self;
            self.textName.text = self.changeName;
            self.textName.textColor = [UIColor grayColor];
            [cell addSubview:self.textName];
        }
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            cell.myData.text = @"性别";
            //设值默认
            self.stringSex = [self.arrTitle firstObject][@"sex"];
            //创建性别选择开关
            UIButton * buttonSex = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonSex.frame = CGRectMake(SCREEN_WIDTH-158.0*WidthProportion,11.0*HeightProportion , 115.0*WidthProportion, 100.0*WidthProportion);
            [buttonSex setImage:[UIImage imageNamed:@"nan"] forState:UIControlStateNormal];
             [buttonSex setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateSelected];
            [buttonSex addTarget:self action:@selector(pressSex:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:buttonSex];
            
            //未知性别情况下，默认男的
            if ([[self.arrTitle firstObject][@"sex"] isEqual:@"0"]) {
                cell.myTitle.text = @"";
                
            }
            if ([[self.arrTitle firstObject][@"sex"] isEqual:@"1"]) {
                cell.myTitle.text = @"";
                
            }

            if ([[self.arrTitle firstObject][@"sex"] isEqual:@"2"]) {
                buttonSex.selected = YES;
                cell.myTitle.text = @"";
                
            }

        }
        if (indexPath.row==1) {
            cell.myData.text = @"生日";
            cell.myTitle.text = self.stringDate;
        }
        if (indexPath.row==2) {
            cell.myData.text = @"星座";
            cell.myTitle.text = self.stringXingzuo;
        }
        if (indexPath.row==3) {
            cell.myData.text = @"地区";
            
#pragma ==============初始化地址选择器，控件必须是UITextField===========
            AreaLabel=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-42, 44)];
            //光标颜色
            AreaLabel.tintColor = [UIColor clearColor];
            //右对齐
            AreaLabel.textAlignment = UITextLayoutDirectionRight;
            [cell addSubview:AreaLabel];
            self.addressView = [[AddressView alloc] init];
            AreaLabel.inputView = self.addressView;
            
            AreaLabel.inputAccessoryView = self.toolBar;
            AreaLabel.delegate = self;
            //地区
             cell.myTitle.text = self.stringAdders;
            
        }

        

    }
        return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.textName resignFirstResponder];
     [AreaLabel resignFirstResponder];
    if (indexPath.section==0) {
    //头像
      if (indexPath.row==0) {
          //起吊图图SDK相机及照片
          EditAdvancedComponentSample * editaVC = [EditAdvancedComponentSample sample];
           editaVC.TypeMineDate = @"minedate";
          [editaVC showSampleWithController:self];
      }
    //昵称
    if (indexPath.row==1) {
//        NameChangeViewController * nameChangeVC = [[NameChangeViewController alloc]init];
//        nameChangeVC.name = [self.arrTitle firstObject][@"nickName"];
//        [self.navigationController pushViewController:nameChangeVC animated:YES];
     }
        
 }
    if (indexPath.section==1) {
        //性别
        if (indexPath.row==0) {
            
           
        }
        //生日
        if (indexPath.row==1) {
            [UIView animateWithDuration:0.5 animations:^{
                //必须设空
                  self.stringDate =@"";
                self.viewSubDate.frame = CGRectMake(0, SCREEN_HEIGHT-220, SCREEN_WIDTH, 220);
                
            }];
            
        }
        //星座
        if (indexPath.row==2) {
            
          //星座不可以修改
            
        }
        //地区
        if (indexPath.row==3) {
           //地区不用写
        }
   
        
    }
   
  
}

//监听开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.viewSubDate.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 220);
    return YES;
}


//性别选择
-(void)pressSex:(UIButton*)button{
    button.selected = !button.selected;
    if (button.selected==YES) {
        //女的
       self.stringSex = @"2";
        
    }else{
        //男的
       self.stringSex = @"1";
    }
}

//接收修改后的头像
-(void)changePhone:(NSNotification*)notf{
   
     self.imagePhone.image  = notf.object[@"img"];
  
}


//收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (id text in self.view.subviews) {
        if ([text isKindOfClass:[UITextField class]]) {
            //强转
            UITextField * textField = text;
            [textField resignFirstResponder];
        }
    }
}




#pragma mark ===================地址填写================

- (UIToolbar *)toolBar{
    if (_toolBar == nil) {
        self.toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _toolBar.barTintColor=[UIColor groupTableViewBackgroundColor];
        UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
        _toolBar.items = @[item1, item2];
    }
    return _toolBar;
}

//修改地址点击确认后
- (void)click{
   
    if (AreaLabel.isFirstResponder) {
        [AreaLabel resignFirstResponder];
         if (self.addressView.province==nil||self.addressView.city==nil||self.addressView.area==nil) {
           self.stringAdders = @"北京-通州";
         }else{
             if (self.addressView.area.length>0) {
                 self.stringAdders = [NSString stringWithFormat:@"%@-%@-%@",self.addressView.province,self.addressView.city,self.addressView.area];
             }else{
                 
                 self.stringAdders = [NSString stringWithFormat:@"%@-%@",self.addressView.province,self.addressView.city];
             }
         }
        
        //刷新指定表格
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:3 inSection:1];
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
     }
}


//创建日期选择器
-(void)createDatePicker{
    //父视图
    self.viewSubDate = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 220)];
    self.viewSubDate.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.viewSubDate];
    //确定键
    UIButton * buttonOk = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonOk.frame = CGRectMake(SCREEN_WIDTH-60, 0, 40, 20);
    [buttonOk setTitle:@"确定" forState:UIControlStateNormal];
    [buttonOk setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonOk addTarget:self action:@selector(pressOk) forControlEvents:UIControlEventTouchUpInside];
    [self.viewSubDate addSubview:buttonOk];
    //日期选择器
    UIDatePicker *datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0, 20,SCREEN_WIDTH,200)];
     datePicker.datePickerMode = UIDatePickerModeDate;//模式
    datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //转换成中文格式
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datePicker.locale = locale;
//监听
    [datePicker addTarget:self action:@selector(pressDate:) forControlEvents:UIControlEventValueChanged];
    [self.viewSubDate addSubview:datePicker];
    
}

-(void)pressDate:(UIDatePicker*)picker{
    //日期提取(时时监听)
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * picDate = [formatter stringFromDate:picker.date];
    //的到日期
    self.pickDate =picDate;
    
}

//日期的确定键点击事件
-(void)pressOk{
    
    self.stringDate = self.pickDate;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.viewSubDate.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 220);
        
    }];
    
    //因为不滚动的时候选择不到日期，所以在这里做个判断
    if (self.stringDate.length>0) {
        
    }else{
        if (self.pickDate.length>0) {
            
             self.stringDate =self.pickDate;
            
        }else{
            
            //系统时间的字符串
            NSDate *currentDate = [NSDate date];//获取当前时间，日期
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSString *dateString = [dateFormatter stringFromDate:currentDate];
            self.stringDate =dateString;
            
        }
        
    }
    
    //刷新生日
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:1];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    //星座也改变
//    切割日期
    NSArray * arrayDate = [self.stringDate componentsSeparatedByString:@"-"];
    //计算星座
    self.stringXingzuo = [NSString stringWithFormat:@"%@座",[NSString getAstroWithMonth:[arrayDate[1] intValue] day:[[arrayDate lastObject] intValue]]];
    //拼接星座
    
    //刷新星座
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:2 inSection:1];
    [_tableView reloadRowsAtIndexPaths:@[indexPath1] withRowAnimation:UITableViewRowAnimationNone];


}


-(NSMutableArray *)arrayProvinces{
    if (!_arrayProvinces) {
        _arrayProvinces = [NSMutableArray array];
    }
    return _arrayProvinces;
}

-(NSMutableArray *)arrayCity{
    if (!_arrayCity) {
        _arrayCity = [NSMutableArray array];
    }
    return _arrayCity;
}


-(void)dealloc{
    //销毁照片通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"minedateEditImage" object:nil];

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.view  endEditing:YES];
    
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@", self.class]];//("PageOne"为页面名称，可自定义)
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.tabBarController.tabBar.hidden = YES;

    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@", self.class]];
       
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
