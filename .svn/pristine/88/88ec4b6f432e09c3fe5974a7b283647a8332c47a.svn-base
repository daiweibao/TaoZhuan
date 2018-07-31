//
//  zySheetPickerView.m
//  ZYSheetPicker
//
//  Created by Corki on 16/6/20.
//  Copyright © 2016年 Corki. All rights reserved.
//

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width

#import "zySheetPickerView.h"
@interface zySheetPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak,nonatomic)UIView *bgView;    //屏幕下方看不到的view
@property (weak,nonatomic)UILabel *titleLabel; //中间显示的标题lab
@property (weak, nonatomic) UIPickerView *pickerView;
@property (weak,nonatomic)UIButton *cancelButton;
@property (weak,nonatomic)UIButton *doneButton;
@property (strong,nonatomic)NSArray *dataArray;   // 用来记录传递过来的数组数据
@property (strong,nonatomic)NSString *headTitle;  //传递过来的标题头字符串
@property (strong,nonatomic)NSString *backString; //回调的字符串

@end
@implementation zySheetPickerView

+(instancetype)ZYSheetStringPickerWithTitle:(NSArray *)title andHeadTitle:(NSString *)headTitle Andcall:(zySheetPickerViewBlock)callBack
{
    zySheetPickerView *pickerView = [[zySheetPickerView alloc]initWithFrame:[UIScreen mainScreen].bounds  andTitle:title andHeadTitle:headTitle];
    pickerView.callBack = callBack;
    return pickerView;
}

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSArray*)title andHeadTitle:(NSString *)headTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = title;
        _headTitle = headTitle;
        _backString = self.dataArray[0];
        [self setupUI];
    }
    return self;
}

- (void)tap
{
    [self dismissPicker];
}
-(void)setupUI
{
    //首先创建一个位于屏幕下方看不到的view
    UIView* bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
    bgView.alpha = 0.0f;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [bgView addGestureRecognizer:g];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    self.bgView = bgView;
    
    
    
    //上方工具条背景
    UILabel *toolbarBG = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
    toolbarBG.backgroundColor = MAIN_COLOR;
    [self addSubview:toolbarBG];
    
    //  标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 150, 20)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setText:_headTitle];
    [titleLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    //取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 58, 48);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"取消" attributes:
                                      @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                         NSFontAttributeName :           [UIFont systemFontOfSize:14],
                                         NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone) }];
    [cancelButton setAttributedTitle:attrString forState:UIControlStateNormal];
    cancelButton.adjustsImageWhenHighlighted = NO;
    cancelButton.backgroundColor = [UIColor clearColor];
    [cancelButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
    self.cancelButton = cancelButton;
    
    //完成按钮
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(SCREEN_WIDTH-58, 0, 58, 48);
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"完成" attributes:
                                       @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                          NSFontAttributeName :           [UIFont systemFontOfSize:14],
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone) }];
    [doneButton setAttributedTitle:attrString2 forState:UIControlStateNormal];
    doneButton.adjustsImageWhenHighlighted = NO;
    doneButton.backgroundColor = [UIColor clearColor];
    [doneButton addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:doneButton];
    self.doneButton = doneButton;
    
    
    
    //选择器
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,48, SCREEN_SIZE.width, 160)];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView setDelegate:self];
    [pickerView setDataSource:self];
    [self addSubview:pickerView];
    self.pickerView = pickerView;
    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //self
    self.backgroundColor = [UIColor whiteColor];
    
    [self setFrame:CGRectMake(0, SCREEN_SIZE.height-(48+160), SCREEN_SIZE.width , 48+160)];
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    [self setFrame: CGRectMake(0, SCREEN_SIZE.height,SCREEN_SIZE.width , 48+160)];
}



- (void)clicked:(UIButton *)sender
{
    if ([sender isEqual:self.cancelButton]) {
        [self dismissPicker];
    }else{
        if (self.callBack) {
            self.callBack(self,_backString);
        }
    }
}


#pragma mark - 该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

#pragma mark - 该方法的返回值决定该控件指定列包含多少个列表项
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

#pragma mark - 该方法返回的NSString将作为UIPickerView中指定列和列表项的标题文本
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return self.dataArray[row];
//}

#pragma mark - 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //这个属性可以控制 标题栏。
//    self.titleLabel.text =self.dataArray[row];
    _backString = self.dataArray[row];
}

- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
//    //设置分割线的颜色
//    for(UIView *singleLine in pickerView.subviews)
//    {
//        if (singleLine.frame.size.height < 1)
//        {
//            singleLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        }
//    }
    
    
    UILabel* l = [[UILabel alloc] init];
    l.textColor = self.textColor;
    l.textAlignment = NSTextAlignmentCenter;
    l.font = self.textFont;
    l.text = self.dataArray[row];
    
    //分割线4
    UILabel * line4 = [[UILabel alloc]initWithFrame:CGRectMake(25,49, SCREEN_WIDTH-50, 1)];
    line4.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [l addSubview:line4];
    
    return l;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

- (UIColor *)textColor
{
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}

- (void)show
{
    [UIView animateWithDuration:0.8f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
        self.bgView.alpha = 1.0;
        
        self.frame = CGRectMake(0, SCREEN_SIZE.height-250, SCREEN_SIZE.width, 250);
    } completion:NULL];
}

- (void)dismissPicker
{
    [UIView animateWithDuration:0.8f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        self.bgView.alpha = 0.0;
        self.frame = CGRectMake(0, SCREEN_SIZE.height,SCREEN_SIZE.width , 250);
        
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}



@end
