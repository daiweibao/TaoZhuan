//
//  MyRecordListCell.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2018/5/2.
//  Copyright © 2018年 北京嗅美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRecordListModel.h"
@interface MyRecordListCell : UITableViewCell
@property(nonatomic,strong)MyRecordListModel * model;
- (CGFloat)getMaxY;
@end
