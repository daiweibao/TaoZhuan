//
//  GuiGeView.h
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2017/8/31.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuiGeView : UIView

@property (nonatomic,copy)void(^callback)(NSString *rule,NSInteger count);



@end
