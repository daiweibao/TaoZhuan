//
//  ChatListCell.h
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/19.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatListModel.h"
#import "GXJMessageListModel.h"
@interface ChatListCell : UITableViewCell
@property(nonatomic,assign)NSInteger  intex;
@property(nonatomic,strong)ChatListModel * model;
@property(nonatomic,strong)GXJMessageListModel * modelXT;
@end
