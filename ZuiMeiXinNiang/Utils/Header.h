//
//  Header.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 15/12/11.
//  Copyright (c) 2015年 北京嗅美科技有限公司. All rights reserved.
//

#ifndef ZuiMeiXinNiang_Header_h
#define ZuiMeiXinNiang_Header_h

#define DISPATH DISPATCH_QUEUE_PRIORITY_DEFAULT


//淘赚内网测试
#define OutInterent_IP @"http://192.168.1.23:8085/Buying"

//淘赚外网测试
//#define OutInterent_IP @"http://39.105.140.231:8080/Buying"




#pragma mark ================= 与H5有关的接口 开始(前面是正式环境、后面是测试环境) ======================

//大转盘接口html
#define turntableDraw  [OutInterent_IP isEqual:@"http://api2.kemeiapp.com"] ? @"http://www.xiumeiapp.com/turntableDraw/index_ios.html" : [NSString stringWithFormat:@"%@/outer/turntableDraw/index_ios.jsp",OutInterent_IP]
//嗅美用户协议
#define agreement [OutInterent_IP isEqual:@"http://api2.kemeiapp.com"] ? @"http://www.xiumeiapp.com/androidToH5/agreement/user.html" : [NSString stringWithFormat:@"%@/outer/agreement/user.jsp",OutInterent_IP]
//关于嗅美新接口,edition版本号
#define AboutXiumeiNew [OutInterent_IP isEqual:@"http://api2.kemeiapp.com"] ? @"http://www.xiumeiapp.com/androidToH5/appDetail_ios_2.html?edition=" : [NSString stringWithFormat:@"http://test.xiumeiapp.com/appDetail_ios_2.html?edition="]

//帮助4.1.0--（线上和测试同一个链接）
#define appHelp4_1 [OutInterent_IP isEqual:@"http://api2.kemeiapp.com"] ? [NSString stringWithFormat:@"http://www.xiumeiapp.com/androidToH5/appHelp_ios.html?edition=%@",GET_VERSION] : [NSString stringWithFormat:@"http://www.xiumeiapp.com/androidToH5/appHelp_ios.html?edition=%@",GET_VERSION]

//年化利率排行榜
#define weekList [OutInterent_IP isEqual:@"http://api2.kemeiapp.com"] ? @"http://www.xiumeiapp.com/androidToH5/weekList.html" : @"http://test.xiumeiapp.com/weekList.html"

//分享嗅美花生 需要登录
#define shareInvite_ios [OutInterent_IP isEqual:@"http://api2.kemeiapp.com"] ? [NSString stringWithFormat:@"http://www.xiumeiapp.com/androidToH5/shareInvite_ios.html?sessionId=%@",SESSIONID] : [NSString stringWithFormat:@"http://test.xiumeiapp.com/shareInvite_ios.html?sessionId=%@",SESSIONID]
//花生好友邀请 需要登录
#define peanutFriendInvit [OutInterent_IP isEqual:@"http://api2.kemeiapp.com"] ? [NSString stringWithFormat:@"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx1d6b633490637d5e&redirect_uri=http%%3a%%2f%%2fwww.xiumeiapp.com%%2fWeChat%%2finvite.html&response_type=code&scope=snsapi_userinfo&state=%@#wechat_redirect",USERID] : [NSString stringWithFormat:@"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx1d6b633490637d5e&redirect_uri=http://www.xiumeiapp.com/WeChat/invite.html&response_type=code&scope=snsapi_userinfo&state=%@#wechat_redirect",USERID]

//花生好友助力 需要登录
#define peanutFriendHelp [OutInterent_IP isEqual:@"http://api2.kemeiapp.com"] ? [NSString stringWithFormat:@"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx1d6b633490637d5e&redirect_uri=http%%3a%%2f%%2fwww.xiumeiapp.com%%2fWeChat%%2fhelp.html&response_type=code&scope=snsapi_userinfo&state=%@#wechat_redirect",USERID] : [NSString stringWithFormat:@"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx1d6b633490637d5e&redirect_uri=http://www.xiumeiapp.com/WeChat/help.html&response_type=code&scope=snsapi_userinfo&state=%@#wechat_redirect",USERID]

//花生攻略（线上和测试同一个链接）
#define peanutGuides [OutInterent_IP isEqual:@"http://api2.kemeiapp.com"] ? @"http://www.xiumeiapp.com/androidToH5/cost_ios.html" : @"http://www.xiumeiapp.com/androidToH5/cost_ios.html"

//红包分享出去的链接
#define invite_go [NSString stringWithFormat:@"http://www.xiumeiapp.com/WeChat/invite_go.html?userId=%@",USERID]
//精彩活动
#define activityList [NSString stringWithFormat:@"http://www.xiumeiapp.com/androidToH5/activityList.html?sessionId=%@",SESSIONID]

//用户注册后得到红包分享出去
#define ShareRedPacket [NSString stringWithFormat:@"http://www.xiumeiapp.com/WeChat/redPacket.html?userId=%@",USERID]

#pragma mark ================= 与H5有关的接口 结束 ======================


#pragma mark ====================登陆注册和用户相关接口 S======================
//发送验证码
#define SENDER_CODE [NSString stringWithFormat:@"%@/outer/v1/user/sendCodeNew.do",OutInterent_IP]
//手机验证码登陆
#define loginWithCode [NSString stringWithFormat:@"%@/outer/v1/frontUser/loginWithCode.do",OutInterent_IP]
//手机账号密码登陆
#define PHONE_LOGIN [NSString stringWithFormat:@"%@/outer/v1/user/login.do",OutInterent_IP]
//第三方登陆接口
#define addUser [NSString stringWithFormat:@"%@/outer/v1/frontUser/addUser.do",OutInterent_IP]
//验证手机号码是否已经被注册
#define verifyPhone [NSString stringWithFormat:@"%@/outer/v1/user/verifyPhone.do",OutInterent_IP]
//验证码是否正确--找回密码时用
#define valideCode [NSString stringWithFormat:@"%@/outer/v1/user/valideCode.do",OutInterent_IP]
//用户修改密码
#define Change_UsePassword [NSString stringWithFormat:@"%@/outer/v1/user/modifyPassword.do",OutInterent_IP]
//重置密码--找回密码
#define Change_Password [NSString stringWithFormat:@"%@/outer/v1/user/resetPassword.do",OutInterent_IP]
//修改绑定
#define Phone_Change_Binding [NSString stringWithFormat:@"%@/outer/v1/user/updateMobile.do",OutInterent_IP]
//绑定手机号
#define Phone_Binding [NSString stringWithFormat:@"%@/outer/v1/user/bindingMobile.do",OutInterent_IP]
//判断是否绑定手机qq、微信、微博
#define isBinding [NSString stringWithFormat:@"%@/outer/v1/user/isBinding.do",OutInterent_IP]
//开始绑定手机qq、微信、微博
#define myBinding [NSString stringWithFormat:@"%@/outer/v1/user/myBinding.do",OutInterent_IP]
//绑定支付宝
#define bindingAlipay [NSString stringWithFormat:@"%@/outer/v1/frontUser/bindingAlipay.do",OutInterent_IP]
//修改用户资料或者完善用户信息
#define editUser [NSString stringWithFormat:@"%@/outer/v1/user/editUser.do",OutInterent_IP]
//获取融云用户token
#define getUserToken [NSString stringWithFormat:@"%@/outer/rong/getUserToken.do",OutInterent_IP]
//根据sessionId获取用户信息
#define MINE_HOME_DATA [NSString stringWithFormat:@"%@/outer/v1/frontUser/getMyselfInfo.do",OutInterent_IP]
//上传头像
#define SENDER_PHONR [NSString stringWithFormat:@"%@/outer/v1/user/uploadImage.do",OutInterent_IP]

//9.1.2 获取聊天用户信息
#define getChatUserInfo [NSString stringWithFormat:@"%@/outer/v1/user/getChatUserInfo.do",OutInterent_IP]


#pragma mark ====================登陆注册和用户相关接口 E======================


#pragma mark ========= 花生返利模块 S==========

//花生界面轮播图
#define loadFocusIndex [NSString stringWithFormat:@"%@/outer/v1/front/navigation/loadFocusIndex.do",OutInterent_IP]
//23.2.8 获取推广活动类型
#define getActivityType [NSString stringWithFormat:@"%@/outer/v1/product/getActivityType.do",OutInterent_IP]
//23.2.9分页获取推广的商品
#define getActivityProduct [NSString stringWithFormat:@"%@/outer/v1/product/getActivityProduct.do",OutInterent_IP]
//35.1.6获取我的周累积收益记录
#define getWeekGain [NSString stringWithFormat:@"%@/outer/v1/cost/getWeekGain.do",OutInterent_IP]
//34.1.2添加淘宝订单
#define addTaobaoOrder [NSString stringWithFormat:@"%@/outer/v1/taobao/addTaobaoOrder.do",OutInterent_IP]

//35.1.2花生消费提现界面数据
#define preWithdraw [NSString stringWithFormat:@"%@/outer/v1/cost/preWithdraw.do",OutInterent_IP]
//33.1.1添加京东订单
#define addJDOrder [NSString stringWithFormat:@"%@/outer/v1/jd/addJDOrder.do",OutInterent_IP]
//33.1.3获取京东商品佣金
#define getProductCommision [NSString stringWithFormat:@"%@/outer/v1/jd/getProductCommision.do",OutInterent_IP]
//花生新用户领取200奖励金
#define getCostGold [NSString stringWithFormat:@"%@/outer/v1/cost/getCostGold.do",OutInterent_IP]
//花生用户领取红包
#define getRedPacket [NSString stringWithFormat:@"%@/outer/v1/cost/getRedPacket.do",OutInterent_IP]

//搜索页面-热门搜索
#define HotSearchResult [NSString stringWithFormat:@"%@/outer/v1/search/getHotSearch.do",OutInterent_IP]
//搜索词语上传
#define addSearchKey [NSString stringWithFormat:@"%@/outer/v1/search/addSearchKey.do",OutInterent_IP]

//手动找回淘宝订单
#define findTaobaoOrder [NSString stringWithFormat:@"%@/outer/v1/taobao/findTaobaoOrder.do",OutInterent_IP]

#pragma mark ========= 花生返利模块  E==========



#pragma mark  ===================我的S===================
//用户反馈
#define USE_advice [NSString stringWithFormat:@"%@/outer/v1/user/userTicking.do",OutInterent_IP]
//获取花生钱包信息
#define getMoneyPackage [NSString stringWithFormat:@"%@/outer/v1/cost/getMoneyPackage.do",OutInterent_IP]
//获取我的收益
#define getUserGain [NSString stringWithFormat:@"%@/outer/v1/cost/getUserGain.do",OutInterent_IP]
//获取我的消费记录
#define getUserCostRecord [NSString stringWithFormat:@"%@/outer/v1/cost/getUserCostRecord.do",OutInterent_IP]
//获取淘宝京东订单
#define getOrderList [NSString stringWithFormat:@"%@/outer/v1/taobao/getOrderList.do",OutInterent_IP]
//获取待存入订单（没有京东商品）
#define getAuditOrder [NSString stringWithFormat:@"%@/outer/v1/taobao/getAuditOrder.do",OutInterent_IP]
//花生钱包提现
#define withDrawCostGold [NSString stringWithFormat:@"%@/outer/v1/cost/withDrawCostGold.do",OutInterent_IP]
//花生提现记录
#define myWithdraw [NSString stringWithFormat:@"%@/outer/v1/withdraw/myWithdraw.do",OutInterent_IP]

#pragma mark  ===================我的E===================



#pragma mark  ===================APP相关 S===================
//获取启动后的广告
#define getstartPage [NSString stringWithFormat:@"%@/outer/v1/startPageFront/getstartPage.do",OutInterent_IP]
//获取版本号，并强制用户升级，为后期埋下伏笔（3.4.0版本启用--2017.9.17）
#define getNewIosVersions [NSString stringWithFormat:@"%@/outer/v1/versions/getNewIosVersions.do",OutInterent_IP]

//记录用户最后使用app的时间--只记录登陆用户的
#define recordUseDate [NSString stringWithFormat:@"%@/outer/v1/frontUser/recordUseDate.do",OutInterent_IP]

#pragma mark  ===================APP相关 E===================


#pragma mark ============== 打卡相关 S============================

//5.1 用户一天内首次打卡
#define playCard [NSString stringWithFormat:@"%@/outer/card/playCard.do",OutInterent_IP]
//5.2 用户第二天完成打卡， 用户第二天在7点到9点之间再次打卡，完成一次打卡分钱的过程
#define playCardTomorrow [NSString stringWithFormat:@"%@/outer/card/playCardTomorrow.do",OutInterent_IP]
//5.3 获取当日分钱最高的10个用户，用户第二天在7点到9点之间再次打卡，完成一次打卡分钱的过程 ???
#define gainMoreList [NSString stringWithFormat:@"%@/outer/card/gainMoreList.do",OutInterent_IP]
//5.4 获取我的打卡记录
#define getMyPlayCardRecord [NSString stringWithFormat:@"%@/outer/card/getMyPlayCardRecord.do",OutInterent_IP]
//获取我的历史累计--我的战绩界面
#define getMyPlayCardData [NSString stringWithFormat:@"%@/outer/card/getMyPlayCardData.do",OutInterent_IP]
//5.5 获取当日用户打卡记录--打卡池数据
#define getPlayCardUser [NSString stringWithFormat:@"%@/outer/card/getPlayCardUser.do",OutInterent_IP]
//5.6 获取打卡之星
#define getMostPlayCardInfo [NSString stringWithFormat:@"%@/outer/card/getMostPlayCardInfo.do",OutInterent_IP]


#pragma mark ============== 打卡相关 E============================
#endif





