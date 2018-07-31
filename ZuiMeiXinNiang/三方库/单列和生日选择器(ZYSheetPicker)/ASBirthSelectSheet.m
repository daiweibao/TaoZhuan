//
//  ASBirthSelectSheet.m
//  ASBirthSheet
//
//  Created by Ashen on 15/12/8.
//  Copyright © 2015年 Ashen. All rights reserved.
//

#import "ASBirthSelectSheet.h"
#import <UIKit/UIKit.h>

static CGFloat MainScreenHeight = 0;
static CGFloat MainScreenWidth = 0;


@interface ASBirthSelectSheet()

@property (weak,nonatomic)UIView *bgView;    //屏幕下方看不到的view

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIButton *btnCancel;

@end
@implementation ASBirthSelectSheet

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        MainScreenHeight = [UIScreen mainScreen].bounds.size.height;
        MainScreenWidth = [UIScreen mainScreen].bounds.size.width;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEmpty:)];
        [self addGestureRecognizer:tap];
       
    }
    return self;
}

//类型
-(void)setTypeString:(NSString *)typeString{
    _typeString = typeString;
    
    [self makeUI];
}

- (void)makeUI {
    
    //首先创建一个位于屏幕下方看不到的view
    UIView* bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
    bgView.alpha = 1;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [bgView addGestureRecognizer:g];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    self.bgView = bgView;
    
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, MainScreenHeight, MainScreenWidth, 48+218)];
    _containerView.backgroundColor = [UIColor whiteColor];
    
    //上方工具条背景
    UILabel *toolbarBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
    toolbarBG.backgroundColor = MAIN_COLOR;
    [_containerView addSubview:toolbarBG];
    
    _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCancel.frame = CGRectMake(0, 0, 58, 48);
    [_btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_btnCancel];
    
    _btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDone.frame = CGRectMake(MainScreenWidth-58, 0, 58, 48);
    [_btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnDone setTitle:@"完成" forState:UIControlStateNormal];
    [_btnDone addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_btnDone];
    
    
#pragma mark 创建UIDatePicker
    
    _datePicker =  [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 48, MainScreenWidth, 218)];
    [_datePicker setDate:[NSDate date] animated:YES];
    
    
    if ([self.typeString isEqual:@"1"]) {
        //生日选择
        [_datePicker setDatePickerMode:UIDatePickerModeDate];
        [_datePicker setMaximumDate:[NSDate date]];
        
    }else if([self.typeString isEqual:@"2"]){
        //带日期时间的选择
         [_datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:time + (9000*24*3600)];
        [_datePicker setMaximumDate:nowDate];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        [_datePicker setMinimumDate:[dateFormatter dateFromString:@"1900/01/01日"]];
    }
    
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [_containerView addSubview:_datePicker];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_containerView];
    
    
    [UIView animateWithDuration:0.8f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.bgView.alpha = 1.0;
        
        _containerView.frame = CGRectMake(0, MainScreenHeight - (48+218), MainScreenWidth, 48+218);
        
    } completion:NULL];
}

#pragma mark - private method
- (void)clickEmpty:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
}
#pragma mark - Action
- (void)doneAction:(UIButton *)btn {
    if (self.GetSelectDate) {

        if ([self.typeString isEqual:@"1"]) {
            //生日
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy/MM/dd"];
            NSString *newTimeStr=[dateFormatter stringFromDate:_datePicker.date];
            _GetSelectDate(newTimeStr);
            
        }else{
            //日期选择
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            NSString *newTimeStr=[dateFormatter stringFromDate:_datePicker.date];
            _GetSelectDate(newTimeStr);
        
        }
    
        [self tap];
    }
}

- (void)cancelAction:(UIButton *)btn {
    [self tap];
}

- (void)dateChange:(id)datePicker {
    
}

#pragma mark - setter、getter
- (void)setSelectDate:(NSString *)selectDate {
    
    if ([self.typeString integerValue] == 1) {
        //生日
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        [_datePicker setDate:[dateFormatter dateFromString:selectDate] animated:YES];
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        [_datePicker setDate:[dateFormatter dateFromString:selectDate] animated:YES];
    
    }

}


- (void)tap{
    [UIView animateWithDuration:0.8f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        self.bgView.alpha = 0.0;
        _containerView.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, 48+218);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.bgView removeFromSuperview];
        [_containerView removeFromSuperview];
    }];
}


@end
