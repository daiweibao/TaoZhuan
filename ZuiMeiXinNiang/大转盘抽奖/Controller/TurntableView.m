//
//  TurntableView.m
//  YDXTurntable
//
//  Created by LIN on 16/11/26.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "TurntableView.h"
#import "Masonry.h"
#define turnScale_W self.bounds.size.width/300
#define turnScale_H self.bounds.size.height/300

@implementation TurntableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self initUI];
    }
    return self;
}


-(void)setNumberArray:(NSArray *)numberArray{
    _numberArray = numberArray;
}
//图片
-(void)setImageArray:(NSArray *)imageArray{
    _imageArray  = imageArray;
    
     [self initUI];
}


-(void)initUI
{
    // 转盘
    self.rotateWheel = [[UIImageView alloc]initWithFrame:self.bounds];
    self.rotateWheel.backgroundColor = RGB_COLOR(255, 131, 150);//转盘颜色
    self.rotateWheel.layer.cornerRadius = self.bounds.size.width/2;
    self.rotateWheel.clipsToBounds = YES;
    self.rotateWheel.layer.borderWidth = 1;
    self.rotateWheel.layer.borderColor = [UIColor redColor].CGColor;
    self.rotateWheel.userInteractionEnabled = YES;
    //控件顺时针旋转多少度，只用改前面的度数就可以，（矫正下转盘不水平的问题）
    self.rotateWheel.transform = CGAffineTransformMakeRotation(-5 * M_PI / 180);
    [self addSubview:self.rotateWheel];
    
    //创建奖品
    for (int i = 0; i < self.imageArray.count; i ++) {
        //奖品名字
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,M_PI * CGRectGetHeight(self.bounds)/self.imageArray.count,CGRectGetHeight(self.bounds)/2)];
        label.layer.anchorPoint = CGPointMake(0.5, 1);
        label.center = CGPointMake(CGRectGetHeight(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        label.text = [NSString stringWithFormat:@"%@", _numberArray[i]];
        CGFloat angle = M_PI * 2 / self.imageArray.count * i;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.transform = CGAffineTransformMakeRotation(angle);
        [self.rotateWheel addSubview:label];
        //奖品图片
        UIButton * imageView = [UIButton buttonWithType:UIButtonTypeCustom];
        imageView.frame =CGRectMake(35*turnScale_W, 12, M_PI * CGRectGetHeight(self.bounds)/self.imageArray.count - 65*turnScale_W, 45*turnScale_H);
//        imageView.image = [UIImage imageNamed:imageArray[i]];
        [imageView setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
//        imageView.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.clipsToBounds = YES;
        [label addSubview:imageView];
        
      //分割线
        UIImageView * line = [[UIImageView alloc]init];
        line.frame = CGRectMake(CGRectGetMaxX(imageView.frame), 0, 1, CGRectGetHeight(self.bounds)/2);
        line.backgroundColor = MAIN_COLOR;
        //这里transform计算好了的，太难计算了
        line.transform =CGAffineTransformMakeRotation(M_PI/self.imageArray.count);
        [label addSubview:line];
        
    }
    
    
    //最后创建这两个按钮
    //抽奖图片
    UIImageView * imageChoujiangBj = [[UIImageView alloc]init];
    imageChoujiangBj.image = [UIImage imageNamed:@"抽奖指针"];
    imageChoujiangBj.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageChoujiangBj];
    [imageChoujiangBj mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-15);
        make.size.mas_equalTo(CGSizeMake(65, 100));
    }];
    
    
    //抽奖按钮
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playButton.layer.cornerRadius = 35;
    [self.playButton addTarget:self action:@selector(startAnimaition) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.playButton];
    [self.playButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    
}

//点击了button
-(void)startAnimaition{
    if (self.actionButtonChouJiang) {
        self.actionButtonChouJiang();
    }
}


@end
