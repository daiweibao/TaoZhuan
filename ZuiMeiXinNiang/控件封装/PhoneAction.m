//
//  PhoneAction.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2016/11/7.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "PhoneAction.h"


@interface PhoneAction()

@end

@implementation PhoneAction

- (instancetype)initWithuserId:(NSString *)userId{
    if (self = [super init]) {
       
    }
    return self;
    
}

//传入控制器和人的Id
+(void)ActionPhoneControll:(UIViewController * )controll UseId:(id)userId{
    //头像点击暂时不跳转

}

//主题点击跳转
+(void)ActionTheme:(UIViewController * )controll themeId:(id)themeId themeType:(id)themeType{

    
    
}


/**
 点击查看大图，单张图片

 @param controll 控制器
 @param imageSee 图片
 */
+(void)SeeBigImage:(UIViewController * )controll Image:(UIImage*)imageSee{
    //push控制器
    ImageReviewViewController * imageVC = [[ImageReviewViewController alloc]init];
    UIImage * image = imageSee;
    //把图片对象传下去（否则必死），而不是图片名字
    imageVC.imageArray = @[image];
    //    判空,有值才传下去
    if (imageVC.imageArray.count>0) {
        
        [controll.navigationController presentViewController:imageVC animated:NO completion:nil];
        
    }else{
        
        return;
    }
}


@end
