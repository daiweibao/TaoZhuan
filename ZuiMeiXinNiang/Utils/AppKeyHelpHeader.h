//
//  AppKeyHelpHeader.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/8/24.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#ifndef AppKeyHelpHeader_h
#define AppKeyHelpHeader_h


#pragma mark ============ AppKey=====================
//这里存放一些宏定义的字符串，如三方库的AppKey等

//友盟的AppKey-淘赚
#define UMappKey @"5b2e09bdb27b0a1ffd0000e5"

//友盟打开回到那个网站（默认值）
#define UMredirectURL @"http://www.xiumeiapp.com"

//2016年5月31号公司向微信注册的（新的）：wx27b2a84348b44c3a  => 嗅美
#define WXAppId [NSString stringWithFormat:@"wx27b2a84348b44c3a"]
#define WXappSecret [NSString stringWithFormat:@"7f7c4ae9835cf5cdba2e6671928106d5"]


//QQ的AppKey-嗅美
#define QQAppId @"1105311784"
#define QQAppSecret @"twWbYouCJWOpvVes"

//新浪的AppKey-嗅美
#define SinaAppId @"941019442"
#define SinaAppSecret @"250de6e48261150d6afc3ef1c0ed8188"

//融云的AppKey（线上）
#define RCIMappKey @"pkfcgjstfp6q8"
//融云客服Id（线上）
#define RCIMKefuID @"KEFU150406475516502"

//京东SDK-嗅美
#define JDAPPKey [NSString stringWithFormat:@"87ef8b3b840c48ce869f444b076136c8"]
#define JDAPPSecret [NSString stringWithFormat:@"6088869a1c73476c9ed702b69d6fcd18"]


//阿里百川电商SDK只需要去开放平台下载安全图片导入就可以，无需设置AppKey--（安全图片：yw_1222.jpg）
//URL Schemes 配置：tbopen24935738（后面数字是appkey）
//淘宝SDK妈妈Id  淘赚：mm_131616585_46322405_851422420
#define TB_mmId @"mm_131616585_46322405_851422420"


#pragma mark ============ 宏定义汉字之类的=====================
//账号下线提示
#define offlineNotification  @"你的账号在另一台手机登录,您被迫下线，如非本人操作，则密码可能已泄露，建议您修改密码。"


#endif /* AppKeyHelpHeader_h */
