//
//  AdddateViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/5/11.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "AdddateViewController.h"
#import "CityChoose.h"

@interface AdddateViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)UIImageView * headView;//头像

@property (nonatomic,strong) UITextField * nickName;//完善昵称
@property (nonatomic,strong)  UILabel *sexLabel;//性别

@property (nonatomic,strong)UIScrollView *scroll;

@property (nonatomic,strong)NSDictionary *userInfo;

@end

@implementation AdddateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"编辑个人资料";
    self.backButton.hidden = NO;
    
    [self dataRrlode];
    
}

//我的资料
-(void)dataRrlode{
    
    NSDictionary * dic = @{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:MINE_HOME_DATA parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
            NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
            if (![ISBangDingTalentPeople isEqual:@"1"]) {
                //把用户名存进去
                [defuaults setObject:responseObject[@"userInfo"][@"nickName"] forKey:@"userName"];
            
            }
            
            self.userInfo = responseObject[@"userInfo"];//image,nickName,sex,birthday,addr,stature,tiTai,faceType,bodyType
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setupUI];
            });
            
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

//完成
- (void)nextClick{
    
    [self.view endEditing:YES];
    
    if (self.headView.image == nil) {
        [DWBToast showCenterWithText:@"请选择头像"];
        return ;
    }
    
    if (self.nickName.text.length == 0) {
        [DWBToast showCenterWithText:@"请输入昵称"];
        return ;
    }
    
    NSRange _range = [self.nickName.text rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        [DWBToast showCenterWithText:@"昵称不能存在空格"];
        return;
    }
    
    //判断昵称合法
    if (self.nickName.text.length == 0 || self.nickName.text.length>12) {
        [DWBToast showCenterWithText:@"昵称不合格（要求1-12个字）"];
        return;
    }
    
    UIImage *head = self.headView.image;
    NSString *nickname = self.nickName.text;
    NSString *sex;
    if (self.sexLabel.text.length == 1 ) {
        sex = self.sexLabel.text;
        if ([self.sexLabel.text isEqual:@"男"] == 1) {
            sex = @"1";
        }else{
            sex = @"2";
        }
    }else{
        sex = @"2";
    }
    
    
     [MBProgressHUD showHUDLodingStart:@"正在保存" toView:self.view];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval=100;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    //先上传头像
    NSData * imageData=UIImageJPEGRepresentation(head, 0.5);
    NSDictionary * dict=@{@"sessionId":SESSIONID,@"image":imageData};
    [manager POST:SENDER_PHONR parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"snn.png" mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //头像上传成功后再传资料
        if ([responseObject[@"code"] isEqual:@"00"]) {
            //修改资料把用户头像连接，和用户名字存进去(聊天用，必须)
            //用户资料缓存-修改资料
            [NSString userInfoCacheMyuserId:nil AndUserName:nickname AndUserImage:responseObject[@"image"] AndUserType:nil];
            
            NSDictionary * dic = @{@"sessionId":SESSIONID,
                                   @"nickName":nickname,//必填
                                   @"sex":sex,//必填
                                   };
            
            [GXJAFNetworking POST:editUser parameters:dic success:^(id  _Nullable responseObject) {
                  [MBProgressHUD hideHUDForView:self.view];
                if ([responseObject[@"code"] isEqual:@"00"]) {
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"  message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //发通知去上一页刷新个人资料
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshHeadNotification" object:nil];
                        
                        //发通知刷新我的界面
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"mineLoginSussce" object:nil];
                    
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                    }];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }else{
                    //影藏他
                    [MBProgressHUD hideHUDForView:self.view];
                    [DWBToast showCenterWithText:@"修改资料失败"];
                }
                
            } failure:^(NSError * _Nullable error) {
                //影藏他
                [MBProgressHUD hideHUDForView:self.view];
            }];
            
        }else{
            
            [MBProgressHUD showHUDLodingEnd:@"修改资料失败" toView:self.view];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD showHUDLodingEnd:@"修改资料失败" toView:self.view];
        //没网等各种错误提示(把句号替换成空白)
        [MBProgressHUD showNoNetwork:[error.localizedDescription stringByReplacingOccurrencesOfString:@"。" withString:@""]];
    }];
    
}

- (void)setupUI{
    
    //完成
    CGFloat w = [NSString sizeMyStrWith:@"完成" andFontSize:13 andMineWidth:111].width;
    UIButton *next = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, w, 44)];
    [next setTitle:@"完成" forState:UIControlStateNormal];
    [next setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    next.titleLabel.font = [UIFont systemFontOfSize:13];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:next];
    self.navigationItem.rightBarButtonItem = item;
    [next addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    
    //父视图
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, MC_NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-MC_NavHeight)];
    scroll.delegate = self;
    scroll.bounces = YES;
    self.scroll = scroll;
    scroll.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT-MC_NavHeight);
    [self.view addSubview:scroll];
    
    //头像
    UIImageView *headView = [UIImageView new];
    self.headView = headView;
    headView.frame = CGRectMake((SCREEN_WIDTH - 60)*0.5, 25, 60, 60);
    if (![NSString isNULL:self.userInfo[@"image"]]) {
        [headView sd_setImageWithURL:[NSURL URLWithString:self.userInfo[@"image"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    }else{
        headView.image = [UIImage imageNamed:@"默认头像"];
    }
    headView.layer.cornerRadius = 30;
    headView.contentMode = UIViewContentModeScaleAspectFill;
    headView.clipsToBounds = YES;
    [self.scroll addSubview:headView];
    headView.userInteractionEnabled = YES;
    [headView addTapActionTouch:^{
        [self.view endEditing:YES];
        [AlertViewTool AlertWXSheetToolWithTitle:@"" otherItemArrays:@[@"相机",@"相册"] ShowRedindex:-1 CancelTitle:@"取消" handler:^(NSInteger index) {
            if (index==0) {
                
                //调取相机拍摄
                UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.delegate = self;
                picker.allowsEditing = YES;
                [self presentViewController:picker animated:YES completion:nil];
                
            }else if (index==1){
                
                //调取相册
                UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                picker.delegate = self;
                picker.allowsEditing = YES;
                [self presentViewController:picker animated:YES completion:nil];
                
            }
        }];
    }];
    
    //上传头像
    UILabel *headlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame)+5, SCREEN_WIDTH, 13)];
    headlabel.text = @"更换头像";
    headlabel.font = [UIFont systemFontOfSize:13];
    headlabel.textAlignment = NSTextAlignmentCenter;
    headlabel.textColor = MAIN_COLOR;
    [self.scroll addSubview:headlabel];
    
    //描述
    UILabel *headlabel2 =[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headlabel.frame)+10, SCREEN_WIDTH, 0.01)];
    headlabel2.text = @"";
    headlabel2.font = [UIFont systemFontOfSize:10];
    headlabel2.textAlignment = NSTextAlignmentCenter;
    headlabel2.textColor = [UIColor colorWithHexString:@"#c0c0c0"];
    [self.scroll addSubview:headlabel2];
    
#pragma mark----------------------------------------------
    CGFloat labelW = [NSString sizeMyStrWith:@"昵称" andFontSize:13 andMineWidth:111].width;
    CGFloat inputX = 15+labelW+40;//输入框x
    CGFloat inputW = SCREEN_WIDTH - (15+labelW+40) - 44;//输入框宽度
    
    //starlabel
    UILabel *starlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headlabel2.frame)+35, 15, 40)];
    starlabel.text = @"*";
    starlabel.font = [UIFont systemFontOfSize:13];
    starlabel.textAlignment = NSTextAlignmentCenter;
    starlabel.textColor = MAIN_COLOR;
    [self.scroll addSubview:starlabel];
    
    //昵称标题
    UILabel *nicklabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(headlabel2.frame)+35, labelW, 40)];
    nicklabel.text = @"昵称";
    nicklabel.font = [UIFont systemFontOfSize:13];
    nicklabel.textAlignment = NSTextAlignmentLeft;
    nicklabel.textColor = [UIColor blackColor];
    [self.scroll addSubview:nicklabel];
    
    //昵称
    UITextField *nickName = [[UITextField alloc]initWithFrame:CGRectMake(inputX,CGRectGetMaxY(headlabel2.frame)+35, SCREEN_WIDTH - inputX - 15, 40)];
    nickName.placeholder=@"请输入1-10字昵称";
    self.nickName = nickName;
    nickName.font = [UIFont systemFontOfSize:13];
    nickName.clearButtonMode = UITextFieldViewModeAlways;
    nickName.keyboardType = UIKeyboardTypeDefault;
    nickName.textAlignment=NSTextAlignmentLeft;
    nickName.textColor = [UIColor blackColor];
    [self.scroll addSubview:nickName];
    if (![NSString isNULL:self.userInfo[@"nickName"]]) {
        nickName.text = self.userInfo[@"nickName"];
    }
    
    //分割线2
    UILabel * line2 = [[UILabel alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(nickName.frame), SCREEN_WIDTH-15, 1)];
    line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.scroll addSubview:line2];
    
    //性别标题
    UILabel *sex = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(line2.frame), inputW, 40)];
    sex.text = @"性别";
    sex.font = [UIFont systemFontOfSize:13];
    sex.textAlignment = NSTextAlignmentLeft;
    sex.textColor = [UIColor blackColor];
    [self.scroll addSubview:sex];
    
    //性别
    UILabel *sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(line2.frame), SCREEN_WIDTH, 40)];
    self.sexLabel = sexLabel;
    sexLabel.text = @"请选择";
    sexLabel.font = [UIFont systemFontOfSize:13];
    sexLabel.textAlignment = NSTextAlignmentLeft;
    sexLabel.textColor = [UIColor colorWithHexString:@"#c0c0c0"];
    [self.scroll addSubview:sexLabel];
    if (![NSString isNULL:self.userInfo[@"sex"]]) {
        sexLabel.textColor = [UIColor blackColor];
        if ([self.userInfo[@"sex"] integerValue] == 1) {
            sexLabel.text = @"男";
        }else{
            sexLabel.text = @"女";
        }
        
    }
    
    //进入
    UIButton * sexbuttonEnter = [UIButton buttonWithType:UIButtonTypeCustom];
    sexbuttonEnter.tag = 7000;
    sexbuttonEnter.frame = CGRectMake(SCREEN_WIDTH-44, CGRectGetMaxY(line2.frame), 44, 40);
    [sexbuttonEnter setImage:[UIImage imageNamed:@"进入"] forState:UIControlStateNormal];
    [sexbuttonEnter setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [sexbuttonEnter addTarget:self action:@selector(buttonEnterClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scroll addSubview:sexbuttonEnter];
    
    
    //分割线2
    UILabel * line3 = [[UILabel alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(sexLabel.frame), SCREEN_WIDTH-15, 1)];
    line3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.scroll addSubview:line3];

}

//进入按钮
- (void)buttonEnterClick:(UIButton *)button{
    [self.view endEditing:YES];
    
    if (button.tag == 7000) {
        //性别
        NSArray * str  = @[@"女",@"男"];
        zySheetPickerView *pickerView = [zySheetPickerView ZYSheetStringPickerWithTitle:str andHeadTitle:@"" Andcall:^(zySheetPickerView *pickerView, NSString *choiceString) {
            self.sexLabel.textColor = [UIColor blackColor];
            self.sexLabel.text = choiceString;
            [pickerView dismissPicker];
        }];
        pickerView.textFont = [UIFont boldSystemFontOfSize:17];
        [pickerView show];
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

//相册和拍照结束  选择照片后的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //头像要编辑后的图片，不要原始图片
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    //返回之前页面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //给头像图片
    self.headView.image = image;
    
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
