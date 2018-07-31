//
//  ADScrollerActionPush.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/12/12.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "ADScrollerActionPush.h"
#import "JZAlbumViewController.h"//查看大图
//滚动视图及导航图跳转的界面
//连接
#import "WebViewController.h"

@implementation ADScrollerActionPush



/**
 广告轮播图点击事件封装

 @param controller 控制器
 @param dictScroll 数据数组
 */
+(void)AdscrollClickController:(UIViewController *)controller AndDict:(NSDictionary *)dictScroll{
    
    NSString * strID = dictScroll[@"paramId"];
    NSString * strmodule = dictScroll[@"module"];
    
    NSString * imageUrl = dictScroll[@"picUrl"];
    
    
    
    
    
    //先判断，如果Id和外链都为空，点击就直接查看大图。26是试用专区，要过滤掉
    if ([NSString isNULL:dictScroll[@"link"]]&&[NSString isNULL:strID]&&![strmodule isEqual:@"26"]) {
       //查看大图
        //控制器跳转
        JZAlbumViewController *jzAlbumVC = [[JZAlbumViewController alloc]init];
        //当前点击图片的索引
        jzAlbumVC.currentIndex = 0;
        jzAlbumVC.imgArr = [NSMutableArray arrayWithArray:@[imageUrl]];
       [controller.navigationController presentViewController:jzAlbumVC animated:NO completion:nil];
        return;//结束掉
    }else if ([strmodule isEqual:@"0"]) {
        //连接
        //        NSString * strLink = dictScroll[@"link"];
        //        WebViewController * webView = [[WebViewController alloc]init];
        //        webView.strTitle = dictScroll[@"title"];
        //        webView.sttWebID = strLink;
        //        webView.hidesBottomBarWhenPushed = YES;
        //        [controller.navigationController pushViewController:webView animated:YES];
        //        NSLog(@"连接：%@",dictScroll[@"link"]);
        //在浏览器中打开外连接
        [NSString openOutUrl:dictScroll[@"link"]];
        
    }
   
}


//查看商品详情
-(void)ActionSeeGoodsDetales{
//    //类型: 0 淘宝 1京东
//    if ([self.model.goodsType isEqual:@"1"]) {
//        //打开京东商品（封装）
//        [OpenJDGoodesDetals  openJDMallDetaWithIdController:self.parentController JDSkuId:self.model.goodsId];
//    }else{
//        //打开淘宝商品（封装）
//        [OpenTaobaoGoodes openTaoboMallDetaMyWebViewController:self.parentController TaoBaoItemId:self.model.goodsId TaoBaoUrl:self.model.goodsUrl AndGoodsType:self.model.goodsType AndGoodsPrice:self.model.goodsPrice AndGoodsImageUrl:self.model.goodsImage AndGoodsName:self.model.goodsName];
//        
//    }
}



@end
