//
//  NewUserAlterView.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/2/23.
//  Copyright © 2017年 zmxn. All rights reserved.
//

#import "NewUserAlterView.h"
#import "UserRedBagAlertView.h"

@interface NewUserAlterView()
//背景
@property(nonatomic,strong)UIImageView *coverImage;
@property(nonatomic,strong)UIImageView *coin;

@end

@implementation NewUserAlterView

// 在initWithFrame:方法中添加子控件
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createNewUserUI];
    }
    return self;
}

//创建UI
-(void)createNewUserUI{
    
    //蒙版
    _coverImage = [[UIImageView alloc]init];
    _coverImage.userInteractionEnabled = YES;
    _coverImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _coverImage.image = [UIImage imageWithColor:MAIN_COLOR_AlertBJ];
    [[UIApplication sharedApplication].keyWindow addSubview:_coverImage];
    WeakSelf(self);
    [_coverImage addTapActionTouch:^{
        
        if (SESSIONID.length == 0) {//非登录状态下 关闭弹窗  存入数据使得弹窗只弹出一次
            
            [[NSUserDefaults standardUserDefaults] setObject:@"NoLogin" forKey:@"NoLogin"];
           
            //弹窗登陆
            [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                
            }];
            
            [weakself.coverImage removeFromSuperview];
            
        }else{//登陆状态下关闭  接着判断红包逻辑
            [weakself.coverImage removeFromSuperview];
            [self getmyredbag];
        }

    }];
    
    //图片442*558
    UIImageView *heartImage = [[UIImageView alloc]init];
    heartImage.frame = CGRectMake((SCREEN_WIDTH-221)/2, 0, 221, 279);
    heartImage.image = [UIImage imageNamed:@"首次红包"];
    [_coverImage addSubview:heartImage];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 245, SCREEN_WIDTH, 30)];
    textLabel.font = [UIFont systemFontOfSize:12];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    if (SESSIONID.length == 0) {
        textLabel.text = @"领取后,请在钱包中查收";
    }else{
        textLabel.text = @"已到账,请在钱包中查收";
    }
    [_coverImage addSubview:textLabel];
    
    UIImageView *coin = [[UIImageView alloc]init];
    self.coin = coin;
    coin.frame = CGRectMake((SCREEN_WIDTH-35)/2, 192, 35, 35);
    coin.image = [UIImage imageNamed:@"首次金币"];
    [_coverImage addSubview:coin];
    
    
    //按钮272*88
    UIImageView *gotMoneyView=[UIImageView new];
    gotMoneyView.frame=CGRectMake((SCREEN_WIDTH-136)/2, heartImage.bottomY+70, 136, 44);
    gotMoneyView.image = [UIImage imageNamed:@"首次立即领取"];
    [_coverImage addSubview:gotMoneyView];
    gotMoneyView.userInteractionEnabled = YES;
    [gotMoneyView addTapActionTouch:^{
        
        if (SESSIONID.length == 0) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"NoLogin" forKey:@"NoLogin"];
            
            [_coverImage removeFromSuperview];
           
            //弹窗登陆
            [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                
            }];
            
            
        }else{
           
            self.coin.image = [UIImage gifImagePlay:@"timg3"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //移除弹框
                [weakself.coverImage removeFromSuperview];
                
                
                [self getmyredbag];
                
            });
        }
    
    }];

}


//判断是否领取过红包  当gain为-1证明领取过
- (void)getmyredbag{
    NSDictionary * dic=@{@"sessionId":SESSIONID};
    [GXJAFNetworking POST:getRedPacket parameters:dic success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] isEqual:@"00"]) {
            
            if ([responseObject[@"gain"] integerValue] == -1) {
                
            }else{//弹出领取红包界面
                dispatch_async(dispatch_get_main_queue(), ^{
                    UserRedBagAlertView *view = [UserRedBagAlertView new];
                    view.gain = [NSString isNULL:responseObject[@"gain"]] ? @"0.00" : responseObject[@"gain"];
                });
            }
            
        }else{
            
        }
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

@end
