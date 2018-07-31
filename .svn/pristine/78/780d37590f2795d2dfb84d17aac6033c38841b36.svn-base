//
//  ChatListCell.m
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/19.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "ChatListCell.h"
#import "GetChatTime.h"
@interface ChatListCell()
//头像
@property(nonatomic,weak)UIButton *headViewbtn;
//名字
@property(nonatomic,weak) UIButton * buttonName;
//时间
@property(nonatomic,weak)UILabel * labeldate;
//消息小红点
@property(nonatomic,weak)UILabel * numberlabel;
//聊天内容
@property(nonatomic,weak)UILabel * labelContent;
//消息状态
@property(nonatomic,weak)UIButton * buttonSenderStare;

@end

@implementation ChatListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        //创建自己ui
        [self createUI];
    }
    return self;
}
//融云数据消息
-(void)setModel:(ChatListModel *)model{
    _model = model;
}

//系统消息
-(void)setModelXT:(GXJMessageListModel *)modelXT{
    _modelXT = modelXT;
}

//在index里解析数据
-(void)setIntex:(NSInteger)intex{
    _intex = intex;

    //头像
    if ([NSString isNULL:self.model.portraitUri]==NO) {
        [self.headViewbtn sd_setImageWithURL:[NSURL URLWithString:self.model.portraitUri] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认头像"]];
    }else{
        [self.headViewbtn setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    }
    
    //名字
    if ([NSString isNULL:self.model.name]) {
        [self.buttonName setTitle:@"用户" forState:UIControlStateNormal];
        
    }else{
        [self.buttonName setTitle:self.model.name forState:UIControlStateNormal];
    }
    
    self.buttonName.frame = CGRectMake(self.headViewbtn.rightX+20.0*px, 13, self.labeldate.x-self.headViewbtn.rightX-40.0*px, 15);
    //设置button汉字或者图片左对齐：
    self.buttonName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //button显示图片和汉字
    [self.buttonName setImagePositionWithType:SSImagePositionTypeRight spacing:5];
    
    //聊天内容
    if ([NSString isNULL:self.model.lastContent]) {
        self.labelContent.text = @"暂无新消息";
    }else{
        
        self.labelContent.text = self.model.lastContent;
    }
    if (self.model.messageState==0) {
        //发送中
        self.buttonSenderStare.frame = CGRectMake(self.headViewbtn.rightX+20.0*px, self.buttonName.bottomY+9, 17, 14);
        self.buttonSenderStare.hidden = NO;
        self.buttonSenderStare.selected = YES;
        //内容
        self.labelContent.frame = CGRectMake(self.buttonSenderStare.rightX+10.0*px, self.buttonName.bottomY+9, SCREEN_WIDTH-(self.buttonSenderStare.rightX+10.0*px)-(30+30.0*px), 14);
        
    }else if (self.model.messageState==1){
        //失败
        //发送中
        self.buttonSenderStare.frame = CGRectMake(self.headViewbtn.rightX+20.0*px, self.buttonName.bottomY+9, 14, 14);
        self.buttonSenderStare.hidden = NO;
        self.buttonSenderStare.selected = NO;
        //内容
        self.labelContent.frame = CGRectMake(self.buttonSenderStare.rightX+10.0*px, self.buttonName.bottomY+9, SCREEN_WIDTH-(self.buttonSenderStare.rightX+10.0*px)-(30+30.0*px), 14);
    }else{
        //不显示
        self.buttonSenderStare.hidden = YES;
        self.labelContent.frame = CGRectMake(self.headViewbtn.rightX+20.0*px, self.buttonName.bottomY+9, SCREEN_WIDTH-(self.headViewbtn.rightX+20.0*px)-(30+30.0*px), 14);
    }
    
    
    //时间
    //聊天时间转换（封装）
    self.labeldate.text = [GetChatTime getMessageDateStringFromTimeInterval:self.model.lastSentTime andNeedTime:YES];
    //融云未读消息数量==开始
    self.numberlabel.text = [NSString stringWithFormat:@"%d",self.model.unreadMessageCount];
    self.numberlabel.layer.cornerRadius = 12.5;
    CGFloat sizeNumZanWidth = 0.0;
    //小于100圆角显示，大于100其他显示
    if (self.model.unreadMessageCount<100) {
        sizeNumZanWidth = 25;
    } else {
        sizeNumZanWidth = [NSString sizeMyStrWith:[NSString stringWithFormat:@"%d",self.model.unreadMessageCount] andFontSize:14 andMineWidth:100].width+10;
    }
    self.numberlabel.frame = CGRectMake(SCREEN_WIDTH-sizeNumZanWidth-20.0*px, self.labeldate.bottomY, sizeNumZanWidth, 25);
    if (self.model.unreadMessageCount>0) {
        self.numberlabel.hidden = NO;
    }else{
        self.numberlabel.hidden = YES;
    }
    //融云未读消息数量==结束
}


//创建UI
-(void)createUI{
    //头像
    UIButton *headViewbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headViewbtn = headViewbtn;
    headViewbtn.frame = CGRectMake(30.0*px, 8, 44, 44);
    headViewbtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    headViewbtn.layer.cornerRadius = 22;
    headViewbtn.layer.masksToBounds = YES;
    headViewbtn.userInteractionEnabled = NO;
    [self.contentView addSubview:headViewbtn];
    

    //日期
    UILabel*labeldate = [[UILabel alloc]init];
    self.labeldate = labeldate;
    labeldate.frame = CGRectMake(SCREEN_WIDTH-120-30.0*px, 0, 120, 30);
    labeldate.font = [UIFont systemFontOfSize:12];
    labeldate.textAlignment = NSTextAlignmentRight;
    labeldate.textColor = MAIN_COLOR_898989;
    [self.contentView addSubview:labeldate];
    
    //创建名字
    UIButton * buttonName = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonName = buttonName;
    buttonName.userInteractionEnabled = NO;
    buttonName.frame = CGRectMake(self.headViewbtn.rightX+20.0*px, 13, labeldate.x-headViewbtn.rightX-40.0*px, 15);
    buttonName.titleLabel.font = [UIFont systemFontOfSize:14.5];
    [buttonName setTitleColor:MAIN_COLOR_313131 forState:UIControlStateNormal];
    [self.contentView addSubview:buttonName];
    
    //消息小红点
    UILabel * numberlabel = [[UILabel alloc]init];
    self.numberlabel = numberlabel;
    numberlabel.backgroundColor = MAIN_COLOR;
    numberlabel.frame = CGRectMake(SCREEN_WIDTH-25-30.0*px, labeldate.bottomY, 25, 25);
    numberlabel.textColor = [UIColor whiteColor];
    numberlabel.font  =[UIFont systemFontOfSize:14];
    numberlabel.layer.cornerRadius = 12.5;
    numberlabel.textAlignment = NSTextAlignmentCenter;
    numberlabel.clipsToBounds = YES;
    [self.contentView addSubview:numberlabel];
    [self.contentView bringSubviewToFront:numberlabel];//添加到最上层
    
    
    //消息状态
    UIButton * buttonSenderStare  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonSenderStare = buttonSenderStare;
    [buttonSenderStare setImage:[UIImage imageNamed:@"发送失败"] forState:UIControlStateNormal];
    [buttonSenderStare setImage:[UIImage imageNamed:@"发送中"] forState:UIControlStateSelected];
    //影藏
    buttonSenderStare.hidden = YES;
    [self.contentView addSubview:buttonSenderStare];

    
    
    //聊天内容
    UILabel * labelContent = [[UILabel alloc]init];
    self.labelContent = labelContent;
    labelContent.font = [UIFont systemFontOfSize:13];
    labelContent.textColor = MAIN_COLOR_898989;
    [self.contentView addSubview:labelContent];
     [self.contentView sendSubviewToBack:labelContent];//添加到最下层
    

}

@end
