//
//  SZCalendarPicker.m
//  SZCalendarPicker
//
//  Created by Stephen Zhuang on 14/12/1.
//  Copyright (c) 2014年 Stephen Zhuang. All rights reserved.
//

#import "SZCalendarPicker.h"
#import "SZCalendarCell.h"
#import "UIColor+ZXLazy.h"

NSString *const SZCalendarCellIdentifier = @"cell";

@interface SZCalendarPicker ()

@property (nonatomic , weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic , weak) IBOutlet UILabel *monthLabel;//上面的横幅标签

@end

@implementation SZCalendarPicker

+(instancetype)calendarPicker{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"SZCalendarPicker" owner:self options:nil] firstObject];
}


- (IBAction)closeButtonClick:(UIButton *)sender {
    //NSLog(@"关闭日历");
    if (self.closeBlock) {
        self.closeBlock();
    }
}

//注册cell
- (void)awakeFromNib
{
    [_collectionView registerClass:[SZCalendarCell class] forCellWithReuseIdentifier:SZCalendarCellIdentifier];
    self.collectionView.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:252.0/255.0 blue:248.0/255.0 alpha:1];
    self.monthLabel.backgroundColor = [UIColor colorWithRed:210.0/255.0 green:246.0/255.0 blue:241.0/255.0 alpha:1];

    //根据连续签到天数，提醒用户今天获得的美币
    if ([self.signContinue intValue] < 7) {
        self.monthLabel.text = [NSString stringWithFormat:@"签到成功,今日得到%@美币",@3];
    }
    
    if ([self.signContinue intValue] >= 7 && [self.signContinue intValue] < 15){
        self.monthLabel.text = [NSString stringWithFormat:@"签到成功,今日得到%@美币",@4];
    }
    if ([self.signContinue intValue] >= 15){
        self.monthLabel.text = [NSString stringWithFormat:@"签到成功,今日得到%@美币",@7];
    }
    
}


- (void)drawRect:(CGRect)rect {
    
    CGFloat itemWidth = 20;
    CGFloat itemHeight = 20;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = 16;
    layout.minimumInteritemSpacing = 16;
    [_collectionView setCollectionViewLayout:layout animated:YES];
}




#pragma -mark 数据源和代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        SZCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SZCalendarCellIdentifier forIndexPath:indexPath];
    
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];//返回本月天数
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];//本月1号是周几
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i < firstWeekday) {
            //本月第一天之前全为空白
            [cell.dateLabel setText:@""];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            //本月最后一天之后全为空白
            [cell.dateLabel setText:@""];
            
        }else{
            //本月要显示的天数
            day = i - firstWeekday + 1;
            
            //设置每个item显示的内容
            NSString *tempStr = [NSString stringWithFormat:@"%zd",day];
            [cell.dateLabel setText:tempStr];
            if ([tempStr length]<2) {
                tempStr = [NSString stringWithFormat:@"0%zd",day];
            }
            //[cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
            
            //this month
            
            if ([_today isEqualToDate:_date]) {
                
                if (day == [self day:_date]) {
                    //这里显示当天颜色
                    [cell.dateLabel setTextColor:[UIColor whiteColor]];
                    cell.layer.cornerRadius = 10;
                    cell.layer.masksToBounds = YES;
                    cell.backgroundColor = [UIColor colorWithHexString:@"#00ba3d"];
                } else if(day < [self day:_date]) {
                    //这里显示今天之前的颜色
                    [cell.dateLabel setTextColor:[UIColor blackColor]];
                    
                    //判断已经签到的显示灰色
                    for (NSString *date in self.signedDates) {
                        
                        NSString *dayStr = [date substringWithRange:NSMakeRange(8, 2)];
                        
//                        NSLog(@"%@",dayStr);
//                        
//                        NSLog(@"%@",tempStr);
//                        NSLog(@"====");
//                        
                        
                        if ([dayStr isEqualToString:tempStr]) {
                            cell.layer.cornerRadius = 10;
                            cell.layer.masksToBounds = YES;
                            cell.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
                        }
                        
//                        if ([yearStr isEqualToString:[NSString stringWithFormat:@"%zd",[self year:_date]]] && [monthStr isEqualToString:[NSString stringWithFormat:@"%02zd",[self month:_date]]]) {
//                            
//                            if ([dayStr isEqualToString:[NSString stringWithFormat:@"%zd",[self day:_date]]]) {
//                                
//                                cell.layer.cornerRadius = 10;
//                                cell.layer.masksToBounds = YES;
//                                cell.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
//                                
//                            }
//                            
//                        }
                        
                        
                    }

                    
//                    cell.layer.cornerRadius = 10;
//                    cell.layer.masksToBounds = YES;
//                    cell.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
                }else{
                    //这里显示今天之后的颜色
                    [cell.dateLabel setTextColor:[UIColor blackColor]];
//                    cell.layer.cornerRadius = 10;
//                    cell.layer.masksToBounds = YES;
                   // cell.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
                
                
                }
            } else if ([_today compare:_date] == NSOrderedAscending) {
                
                [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#cbcbcb"]];
                
            }
            
        }
    
    
    return cell;
}





/*
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeekday + 1;
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
    
    
}
*/














#pragma mark - 日期处理

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}


//- (void)setSignedDates:(NSArray *)signedDates{
//
////    NSLog(@"%@",signedDates);
////    
////    for (NSString *date in signedDates) {
////        
////        NSString *dayStr = [date substringWithRange:NSMakeRange(8, 2)];
////        NSString *monthStr = [date substringWithRange:NSMakeRange(5, 2)];
////        NSString *yearStr = [date substringWithRange:NSMakeRange(0, 4)];
////        NSLog(@"%@",yearStr);
////    }
//    
//    NSLog(@"%zd",self.collectionView.subviews.count);
//    
//}

@end
