//
//  GXJAFNetworking.m
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/6/19.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "GXJAFNetworking.h"
//单例
static AFHTTPSessionManager *manager;

@implementation GXJAFNetworking

//用单例防止重复创建造成内存泄露
+ (AFHTTPSessionManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化请求管理类
        manager = [AFHTTPSessionManager manager];
        // 支持内容格式
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
//         manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
    });
    return manager;
}


/**
 AFNetworking二次封装-POST
 
 @param URLString 请求接口
 @param parameters 接口参数-字典
 @param results 请求成功结果
 @param MyError 失败结果
 */
+(void)POST:(NSString *_Nullable)URLString parameters:(id _Nullable )parameters success:(void (^_Nullable)(id _Nullable responseObject))results failure:(void (^_Nullable)(NSError * _Nullable error))MyError{
    
//    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
    //调用自己的单例，防止内存泄露
    AFHTTPSessionManager * manager =  [GXJAFNetworking sharedManager];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"code"] isEqual:@"97"]){
            //影藏加载(必须，因为在封装中处理了，后面后不再处理了)
            [SVProgressHUD dismiss];
            
            //给他赋值为空，以清除sessionId
            NSUserDefaults * defuaults = [NSUserDefaults standardUserDefaults];
            [defuaults setObject:@"" forKey:@"sessionId"];
            //保证数据存储成功
            [defuaults synchronize];
            
            //回调请求结果
            if (results) {
                results(responseObject);
            }
            
            if ([NSString isNULL:SESSIONID]) {
                //用户没有登录时的sessionId为空也会返回97，此时不提示，也不要做弹窗提示
            }else{
                //sessionId过期
                [AlertGXJView AlertGXJAlertWithController:[UIApplication sharedApplication].keyWindow.rootViewController Title:@"提示" Message:offlineNotification otherItemArrays:@[@"去登陆"] Width:-1 Type:-1 handler:^(NSInteger index) {
                    
                    //弹窗登陆
                    [AlertCXLoginView showAletCXInfoisBlackHome:nil LoginSuccess:^{
                        
                    }];
                    
                }];
                
            }
            
        } else if ([responseObject[@"code"] isEqual:@"98"]){
            //影藏加载(必须，因为在封装中处理了，后面后不再处理了)
            [SVProgressHUD dismiss];
            //参数为空
            [DWBToast showCenterWithText:@"有参数为空（错误码98）"];
            //回调请求结果
            if (results) {
                results(responseObject);
            }
        }else if ([responseObject[@"code"] isEqual:@"99"]){
            //影藏加载(必须，因为在封装中处理了，后面后不再处理了)
            [SVProgressHUD dismiss];
            //空指针
            [DWBToast showCenterWithText:@"未知异常（错误码99）"];
            //回调请求结果
            if (results) {
                results(responseObject);
            }
            
             NSLog(@"99接口：%@",URLString);
        }  else if ([NSString isNULL:responseObject[@"code"]]){
            //影藏加载(必须，因为在封装中处理了，后面后不再处理了)
            [SVProgressHUD dismiss];
            //空指针
            [DWBToast showCenterWithText:@"服务器空指针"];
            NSLog(@"空指针数据：%@,空指针接口:%@",responseObject,URLString);
            
            //回调请求结果
            if (results) {
                results(responseObject);
            }
            
        } else if ([responseObject[@"code"] isEqual:@"90"]){
            //影藏加载(必须，因为在封装中处理了，后面后不再处理了)（共享街项目）
            [SVProgressHUD dismiss];
             //去申诉界面
            [AlertGXJView AlertGXJAlertWithController:[UIApplication sharedApplication].keyWindow.rootViewController Title:@"提示" Message:responseObject[@"errorMsg"] otherItemArrays:@[@"去申诉",@"取消"] Width:-1 Type:-1 handler:^(NSInteger index) {
                if (index==0) {
                    //跳转登陆界面(然后回首页)
                    UINavigationController * nav = [(UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController selectedViewController];
                    UIViewController * myXinYuVC = [[NSClassFromString(@"MyXinYuController") alloc] init];
                    [nav pushViewController:myXinYuVC animated:YES];
                    
                }
                
            }];

        
        } else{
            //影藏加载(必须，因为在封装中处理了，后面后不再处理了)
            [SVProgressHUD dismiss];
            
            //回调请求结果
            if (results) {
                results(responseObject);
            }
        }
        
        /*
         //其他错误提示
         [AlertGXJView AlertGXJAlertWithController:self Title:nil Message:responseObject[@"errorMsg"] otherItemArrays:@[@"知道啦"] Width:-1 Type:-1 handler:^(NSInteger index) {}];
         
         */

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //影藏加载(必须，应为项目中好多地方用了系统加载中)
        [SVProgressHUD dismiss];
        
        //加载失败，只要有加载中控件存在，加载失败就能添加上去
        [LoadingView loadingfailure];

           NSLog(@"404接口：%@",URLString);
        
        //没网等各种错误提示(把句号替换成空白)
        [MBProgressHUD showNoNetwork:[error.localizedDescription stringByReplacingOccurrencesOfString:@"。" withString:@""]];
        //数据请求失败
        NSLog(@"数据请求失败：%@",error.localizedDescription);
        if (MyError) {
            MyError(error);
        }
    }];

    
}

@end
