//
//  GradientLabel.h
//  iphoneLive
//
//  Created by 郭常青 on 2016/12/2.
//  Copyright © 2016年 cat. All rights reserved.
//

#import <UIKit/UIKit.h>
//渐变色
@interface GradientLabel : UIView

@property (nonatomic, strong) NSArray * colors;//颜色数组

@property (nonatomic, strong) UIFont *font;//字体

@property (nonatomic, copy) NSString *text;//文字

@property (nonatomic, assign) NSTextAlignment textAlignment;//对齐方式

@property (nonatomic, assign) CGPoint startPoint;//起始点（0.0~1.0）

@property (nonatomic, assign) CGPoint endPoint;//结束点（0.0~1.0）

- (void) setGradientLabel;

@end
/*
GradientLabel *label = [[GradientLabel alloc] initWithFrame:CGRectMake(0, 100, 300,20)];
[self.view addSubview:label];

id yellow = (id)([UIColor yellowColor].CGColor);
id red = (id)([UIColor redColor].CGColor);

label.colors = @[yellow,red];
label.font = [UIFont systemFontOfSize:18];
label.text = @"测试渐变色文字测试渐变色文字";
label.textAlignment = NSTextAlignmentLeft;
label.startPoint = CGPointMake(0, 0);
label.endPoint = CGPointMake(0,1);
[label setGradientLabel];
*/
