//
//  UIImage+PlayGif.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/3/17.
//  Copyright © 2017年 zmxn. All rights reserved.
//
// 播放本地gif图片（复制SDWebImage的方法，更新SDWebImage也不影响）
#import <UIKit/UIKit.h>

@interface UIImage (PlayGif)

//+ (UIImage *)sd_animatedGIFNamed:(NSString *)name;
//
//+ (UIImage *)sd_animatedGIFWithData:(NSData *)data;
//
//- (UIImage *)sd_animatedImageByScalingAndCroppingToSize:(CGSize)size;



/**
 播放本地gif图片（复制SDWebImage的方法，更新SDWebImage也不影响）
 
 @param imageName gif图片名字
 @return 返回图片
 */
+(UIImage *)gifImagePlay:(NSString * )imageName;

@end
