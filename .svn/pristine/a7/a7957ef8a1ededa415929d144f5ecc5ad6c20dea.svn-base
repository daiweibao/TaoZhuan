//
//  SetUpTableViewCell.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/1/6.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "SetUpTableViewCell.h"

@implementation SetUpTableViewCell

- (void)awakeFromNib {
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(30.0*px, self.bounds.size.height, SCREEN_WIDTH-30.0*px, 1)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:line];

    //设置颜色
    self.myTitle.textColor = [UIColor colorWithHexString:@"#696969"];
    
    if (ios8orLater) {
        //如果UIUserNotificationTypeNone表示没开取推送（从系统获取）
        if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]==UIUserNotificationTypeNone) {
            [self.mySwich setOn:NO];
        }else{
            [self.mySwich setOn:YES];
        }
        
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//进入
- (IBAction)myButtonEnt:(id)sender {
}

//开关
- (IBAction)mySwich:(UISwitch*)sender {
    
    //跳转到系统设置-通知界面
//    prefs:root=NOTIFICATIONS_ID&path=com.xiumei.zmxn（iOS10之前）
//    UIApplicationOpenSettingsURLString（iOS10只能跳转到自己的应用设置）
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if (ios10_0orLater) {
        [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:^(BOOL success) {
        
        }];
        
    }else{
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID&path=com.xiumei.zmxn"]];
        
    }
    
//    //跳转系统对应APP设置界面
//    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//    if (ios10_0orLater) {
//        
//        [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:nil];
//        
//    }else{
//        
//        if ([[UIApplication sharedApplication] canOpenURL:url])
//        {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//        
//    }
    

    
}

@end
