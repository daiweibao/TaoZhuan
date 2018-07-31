//
//  SetUpTableViewCell.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/1/6.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetUpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myTitle;
@property (weak, nonatomic) IBOutlet UIButton *myEnt;
- (IBAction)myButtonEnt:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *mySwich;
- (IBAction)mySwich:(UISwitch *)sender;

@end
