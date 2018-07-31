//
//  ChatQuestionView.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/9/14.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "ChatQuestionFootView.h"

@interface ChatQuestionFootView()
//大家都在问什么
@property(nonatomic,weak)UIView * viewStartSub;
@property(nonatomic,weak)UILabel * labelStart;
//问题父视图
@property(nonatomic,weak)UIView * questionSub;

//问题
@property(nonatomic,strong)NSArray * arrayQuestion;

@end

@implementation ChatQuestionFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //蒙版背景色
        self.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    return self;
}

//创建固定UI
-(void)createUI{
    //固定，一直显示的UI
    UIView * viewStartSub = [[UIView alloc]init];
    self.viewStartSub = viewStartSub;
    viewStartSub.frame = CGRectMake(30.0*px, 0, SCREEN_WIDTH-60.0*px, 33);
    viewStartSub.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewStartSub];
    
    UILabel *  labelStart = [[UILabel alloc]init];
    labelStart.frame = CGRectMake(30.0*px, 0,viewStartSub.width-44-30.0*px , 33);
    labelStart.text = @"大家都在问什么？";
    labelStart.font  =[UIFont systemFontOfSize:14];
    labelStart.textColor = MAIN_COLOR_313131;
    labelStart.userInteractionEnabled = YES;
    labelStart.textColor = MAIN_COLOR_313131;
    WeakSelf(self);
    [labelStart addTapActionTouch:^{
        [weakself ActionButtoUp];
    }];
    [viewStartSub addSubview:labelStart];
    
    //创建返回键
    UIButton * buttonUp = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonUp.frame = CGRectMake(viewStartSub.width-44, 0, 44, 33);
    [buttonUp setImage:[UIImage imageNamed:@"问题向上"] forState:UIControlStateNormal];
    [buttonUp addTarget:self action:@selector(ActionButtoUp) forControlEvents:UIControlEventTouchUpInside];
    [viewStartSub addSubview:buttonUp];

    //问题的父视图
    UIView * questionSub = [[UIView alloc]init];
    self.questionSub = questionSub;
    questionSub.hidden = YES;
    questionSub.frame = CGRectMake(30.0*px, 0, SCREEN_WIDTH-60.0*px, 0);
    questionSub.backgroundColor = [UIColor whiteColor];
    //添加到控制器上
    [self.parentController.view addSubview:questionSub];
    
}


//创建问题UI
-(void)createQuestionUI:(NSArray*)array{
    //移除所有子视图
    [_questionSub removeAllSubviews];
    //标题
    UILabel *  labelStart = [[UILabel alloc]init];
    labelStart.frame = CGRectMake(30.0*px, 0,_questionSub.width-44-30.0*px , 33);
    labelStart.text = @"大家都在问：";
    labelStart.font  =[UIFont systemFontOfSize:14];
    [_questionSub addSubview:labelStart];
    
    //创建返回键
    UIButton * buttonUp = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonUp.frame = CGRectMake(_questionSub.width-44, 0, 44, 33);
    [buttonUp setImage:[UIImage imageNamed:@"问题向下"] forState:UIControlStateNormal];
    [buttonUp addTarget:self action:@selector(ActionButtoDown) forControlEvents:UIControlEventTouchUpInside];
    [_questionSub addSubview:buttonUp];
    
    
    //循环创建问题
    CGFloat maxMyY =  labelStart.bottomY ;
    for (int i = 0; i < 6; i++) {
        //标题
        UILabel *  labelTitle = [[UILabel alloc]init];
        labelTitle.frame = CGRectMake(30.0*px, labelStart.bottomY + 33.0 * i,_questionSub.width-44-30.0*px , 33);
        labelTitle.text = array[i][@"question"];
        labelTitle.font  =[UIFont systemFontOfSize:13];
        labelTitle.textColor = MAIN_COLOR_313131;
        [_questionSub addSubview:labelTitle];
        
        //提问按钮
        UIButton * buttonSpace = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSpace.frame = CGRectMake(_questionSub.width-44,  labelStart.bottomY + 33.0 * i, 44, 33);
        [buttonSpace setTitle:@"提问" forState:UIControlStateNormal];
        [buttonSpace setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
         buttonSpace.titleLabel.font = [UIFont systemFontOfSize:13];
         buttonSpace.titleLabel.adjustsFontSizeToFitWidth = YES;
         buttonSpace.tag = 1000+i;
        [buttonSpace addTarget:self action:@selector(ActionButtoSender:) forControlEvents:UIControlEventTouchUpInside];
        [_questionSub addSubview:buttonSpace];
        
        //最大Y值
        maxMyY = labelTitle.bottomY+20.0*px;
        
    }
    
    //虚线
    UIImageView * imageLine = [[UIImageView alloc]init];
    imageLine.frame = CGRectMake(0, maxMyY, _questionSub.width, 2.0*px);
    imageLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_questionSub addSubview:imageLine];
    //标题
    UILabel *  labelNO = [[UILabel alloc]init];
    labelNO.frame = CGRectMake(30.0*px, imageLine.bottomY ,_questionSub.width-64-30.0*px , 33);
    labelNO.text = @"没有找到自己想问的？";
    labelNO.font  =[UIFont systemFontOfSize:14];
    labelNO.textColor = MAIN_COLOR_313131;
    [_questionSub addSubview:labelNO];
    
    //创建返回键
    UILabel * labelChange = [[UILabel alloc]init];
    labelChange.frame = CGRectMake(_questionSub.width-64-20.0*px, imageLine.bottomY, 64, 33);
    labelChange.text = @"换一换";
    labelChange.textColor = MAIN_COLOR;
    labelChange.font = [UIFont systemFontOfSize:14];
    labelChange.textAlignment = NSTextAlignmentRight;
    labelChange.userInteractionEnabled = YES;
    labelChange.adjustsFontSizeToFitWidth = YES;
    WeakSelf(self);
    [labelChange addTapActionTouch:^{
       //换一换，再次请求数据
        [SVProgressHUD showSVPLodingUseCanActionStart:@"问题切换中..."];
    }];
    [_questionSub addSubview:labelChange];
    
    //父视图坐标
     _questionSub.frame = CGRectMake(30.0*px, SCREEN_HEIGHT-50-labelNO.bottomY, SCREEN_WIDTH-60.0*px, labelNO.bottomY);
}


//点击展开
-(void)ActionButtoUp{
    //打开
    _questionSub.hidden = NO;
    //打开是关闭键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

//点击关闭问题
-(void)ActionButtoDown{
    //关闭
    _questionSub.hidden = YES;
}

//提问
-(void)ActionButtoSender:(UIButton*)button{
    //关闭问题
    [self ActionButtoDown];
    
    NSDictionary * dictInfo = self.arrayQuestion[button.tag-1000];
    
    if ([NSString isNULL:dictInfo[@"questionId"]]) {
        return;
    }
    if ([NSString isNULL:dictInfo[@"question"]]) {
        return;
    }
    //数据回调
    if (self.getQuestionInfoSender) {
        //问题、问题ID
        self.getQuestionInfoSender(dictInfo[@"question"], dictInfo[@"questionId"]);
    }
}

@end
