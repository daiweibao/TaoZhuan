//
//  WebViewController.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/1/11.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
//标题
@property(nonatomic,strong)NSString * strTitle;
//连接
@property(nonatomic,strong)NSString * sttWebID;
//时间
@property(nonatomic,copy)void(^timeStare)(void);
@end
