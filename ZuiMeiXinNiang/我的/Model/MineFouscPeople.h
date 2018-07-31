//
//  MineFouscPeople.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/1/10.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "JSONModel.h"

@interface MineFouscPeople : JSONModel
//用户关注的人
@property(nonatomic,strong)NSNumber <Optional>* followerId;
@property(nonatomic,strong)NSString <Optional>* imageUrl;
@property(nonatomic,strong)NSString<Optional> * nickName;
@property(nonatomic,strong)NSNumber<Optional> * topicNum;//发帖数

@property(nonatomic,strong)NSNumber<Optional> * type;// 1表示 用户     2表示设计师    3 红人用户


@property (nonatomic,copy)NSString<Optional> *age;//年龄
@property (nonatomic,copy)NSString<Optional> *constellation;//星座
@property (nonatomic,copy)NSString<Optional> *sex;//性别 0未知 1男  2 女

//测试用
@property (nonatomic,strong)NSString<Optional> *info;//html



//达人用到的key
@property (nonatomic,copy)NSString<Optional> *headImg;//头像
@property (nonatomic,copy)NSString<Optional> *intro;//介绍
@property (nonatomic,copy)NSString<Optional> *isFollower;//是否关注  0未关注   1关注
@property (nonatomic,copy)NSString<Optional> *name;//名字
@property (nonatomic,copy)NSString<Optional> *redPersonId;//id



@property (nonatomic,copy)NSString<Optional> *fansNum;//粉丝数


@end
