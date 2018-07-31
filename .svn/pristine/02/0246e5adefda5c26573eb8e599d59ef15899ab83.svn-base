//
//  AdviceViewController.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/2/25.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "AdviceViewController.h"

@interface AdviceViewController ()<UITextViewDelegate>
/**
 *  内容框
 */
@property (nonatomic,strong) ZBHTextView * textContent;
@property (nonatomic,strong) ZBHTextView * phonetextContent;

@property (nonatomic,weak)UIImageView *headView;
@property (nonatomic,weak)UILabel *notice;
@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backButton.hidden = NO;
    self.titleLabel.text = @"意见反馈";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton * buttonright = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonright.titleLabel.font = [UIFont systemFontOfSize:15];
    buttonright.frame = CGRectMake(0, 0, 44, 44);
    [buttonright setTitle:@"提交" forState:UIControlStateNormal];
    [buttonright setTitleColor:[UIColor colorWithHexString:@"#898989"] forState:UIControlStateNormal];
    UIBarButtonItem * rightitem  = [[UIBarButtonItem alloc]initWithCustomView:buttonright];
    self.navigationItem.rightBarButtonItem = rightitem;
    [buttonright addTarget:self action:@selector(pressButtonRight:) forControlEvents:UIControlEventTouchUpInside];
    
    [self createUI];
   
}

-(void)createUI{
    
    //头像
    UIImageView *headView = [[UIImageView alloc]init];
    self.headView = headView;
    headView.frame = CGRectMake(15, MC_NavHeight+22, 46, 46);
    headView.image = [UIImage imageNamed:@"jixiangwu"];
    headView.layer.cornerRadius = 23;
    headView.clipsToBounds = YES;
    [self.view addSubview:headView];
    
    //告示
    UILabel *notice = [[UILabel alloc]init];
    self.notice = notice;
    notice.numberOfLines= 0;
    notice.frame = CGRectMake(CGRectGetMaxX(headView.frame)+10, MC_NavHeight+19, SCREEN_WIDTH-71-20, 20);
    notice.font = [UIFont systemFontOfSize:14];
    notice.textColor = [UIColor colorWithHexString:@"#696969"];
    notice.text = @"你好，我们是淘赚产品团队，你有任何想法及建议都可以反馈给我们，我们会在第一时间去改进！淘赚会因你们变得更好！";
    [notice sizeToFit];
    [self.view addSubview:notice];
      
    //内容
    _textContent = [[ZBHTextView alloc]initWithFrame:CGRectMake(30.0*px, CGRectGetMaxY(notice.frame)+56.0 * px, SCREEN_WIDTH-60.0*px, 280.0*px)];
    _textContent.backgroundColor = [UIColor whiteColor];
    _textContent.textColor = [UIColor blackColor];
    _textContent.font = [UIFont systemFontOfSize:13];
    _textContent.placeholder = @"欢迎你提出宝贵的意见或建议...";
    _textContent.placeholderColor = [UIColor colorWithHexString:@"#aaaaaa"];
    _textContent.delegate=self;
    _textContent.layer.cornerRadius = 6;
    _textContent.clipsToBounds= YES;
    _textContent.tag = 1;
    [self.view addSubview:_textContent];
    
    //手机号
    _phonetextContent = [[ZBHTextView alloc]initWithFrame:CGRectMake(30.0*px, CGRectGetMaxY(_textContent.frame)+20.0 * px, SCREEN_WIDTH-60.0*px, 32)];
    _phonetextContent.backgroundColor = [UIColor whiteColor];
    _phonetextContent.textColor = [UIColor blackColor];
    _phonetextContent.font = [UIFont systemFontOfSize:13];
    _phonetextContent.placeholder = @"请留下你的手机号或者qq,方便我们联系你哦";
    _phonetextContent.placeholderColor = [UIColor colorWithHexString:@"#aaaaaa"];
    _phonetextContent.delegate=self;
    _phonetextContent.layer.cornerRadius = 6;
    _phonetextContent.clipsToBounds= YES;
    _phonetextContent.tag = 2;
    [self.view addSubview:_phonetextContent];
  
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

//提交按钮
-(void)pressButtonRight:(UIButton*)button{
    [self.view endEditing:YES];
    //去除首尾空格
    self.textContent.text = [NSString removeStringTwoSpace:self.textContent.text];
    
    if (self.textContent.text.length>500) {
        
        if (ios8orLater) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"淘赚提示你"  message:@"意见内容不能超过500字" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
             return;
        }else{
            
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"淘赚提示你" message:@"意见内容不能超过500字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
            return;
            
        }

    }
    
    if (self.textContent.text.length==0) {
        
        if (ios8orLater) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"淘赚提示你"  message:@"意见内容不能为空" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
             return;
        }else{
            
            UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"淘赚提示你" message:@"意见内容不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [aler show];
            return;

        }

    }

    if (self.phonetextContent.text.length > 0) {
        
        if ([self.phonetextContent.text doubleValue] == 0) {
            if (ios8orLater){
            self.phonetextContent.text =@"";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"淘赚提示你"  message:@"你输入的手机号或qq号有误" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
                return;
            }else{
                 self.phonetextContent.text =@"";
                UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"淘赚提示你" message:@"手机号或qq号有误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [aler show];
                return;
                
            }
        }
        
    }

    button.userInteractionEnabled = NO;
    NSDictionary * dic = @{@"sessionId":SESSIONID,
                           @"content":self.textContent.text,
                           @"contactInformation":self.phonetextContent.text
                           };
    [GXJAFNetworking POST:USE_advice parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
            if (ios8orLater) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"淘赚提示你"  message:@"意见提交成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    button.userInteractionEnabled = YES;
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }];
                
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                
                UIAlertView * aler = [[UIAlertView alloc]initWithTitle:@"淘赚提示你" message:@"意见提交成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [aler show];
                button.userInteractionEnabled = YES;
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
}

//将要出现
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (SCREEN_WIDTH == 320 ) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.view.frame = CGRectMake(0, -30, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (SCREEN_WIDTH == 320 ) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            
        }];
        
    }
}

- (BOOL)isQQ:(NSString *)str{

    if ([str doubleValue] == 0) {
        return NO;
    }else{
    
        if (str.length > 4) {
            return YES;
        }
    
        return NO;
    
    }

}



@end
