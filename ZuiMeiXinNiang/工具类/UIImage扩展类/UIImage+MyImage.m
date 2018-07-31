//
//  UIImage+MyImage.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/8/15.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "UIImage+MyImage.h"
#import <CoreImage/CoreImage.h>
@implementation UIImage (MyImage)

/** 设置圆形图片(放到分类中使用) */
//这个方法就是设置圆角图片, 效率很高, 不会造成卡顿现象, 大家要把这个方法单独放到分类中使用
- (UIImage *)cutCircleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)cutCircleImage:(NSString *)image
{
    return [[self imageNamed:image] cutCircleImage];
}


/*
 用颜色创建一个虚线边框的图片
 
 @param size        需要虚线边框视图的大小
 @param color       边框颜色
 @param borderWidth 边框粗细
 
 @return 返回一张带边框的图片
 */
+ (UIImage *)imageWithSize:(CGSize)size borderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [[UIColor clearColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGFloat lengths[] = { 3, 1 };
    CGContextSetLineDash(context, 0, lengths, 1);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, size.width, 0.0);
    CGContextAddLineToPoint(context, size.width, size.height);
    CGContextAddLineToPoint(context, 0, size.height);
    CGContextAddLineToPoint(context, 0.0, 0.0);
    CGContextStrokePath(context);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/**
 截屏并保存到本地相册
 
 @param orgView 截取指定view上的图片
 @return 图片
 */
+(UIImage *)captureImageFromViewLow:(UIView *)orgView {
    
    //（1）截取指定View的图片
    UIGraphicsBeginImageContextWithOptions(orgView.bounds.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [orgView.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    //（2）保存到本地相册
    ALAssetsLibrary * library = [ALAssetsLibrary new];
    
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    
    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        if(!error){
            
            //顶部状态栏提醒
            [JDStatusBarNotification showJDStatusBarMy:@"截屏成功，已为你保存到相册"];
            
        }else{
            //顶部状态栏提醒
            [JDStatusBarNotification showJDStatusBarMy:@"抱歉，截屏失败"];
        }
        
    }];
    
    return image;
    
}

/**
 截屏不保、存不提示
 
 @param orgView 截取指定view上的图片
 @return 图片
 */
+(UIImage *)captureImageFromViewLowNoSaveAndInfo:(UIView *)orgView {
    
    //（1）截取指定View的图片
    UIGraphicsBeginImageContextWithOptions(orgView.bounds.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [orgView.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //必须
    UIGraphicsEndImageContext();
    
    return image;
    
}




/**
 截取滚动视图的长图片（如tableview等）

 @param scroller 滚动视图
 @return 截取的长图
 */
+ (UIImage *)captureImageLonge:(UIScrollView*)scroller{
    //（1）截取长图
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(scroller.contentSize, YES, 0.0);
    
    //保存collectionView当前的偏移量
    CGPoint savedContentOffset = scroller.contentOffset;
    CGRect saveFrame = scroller.frame;
    
    //将collectionView的偏移量设置为(0,0)
    scroller.contentOffset = CGPointZero;
    scroller.frame = CGRectMake(0, 0, scroller.contentSize.width, scroller.contentSize.height);
    
    //在当前上下文中渲染出collectionView
    [scroller.layer renderInContext: UIGraphicsGetCurrentContext()];
    //截取当前上下文生成Image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //恢复collectionView的偏移量
    scroller.contentOffset = savedContentOffset;
    scroller.frame = saveFrame;
    
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        
        //（2）保存到本地相册
        ALAssetsLibrary * library = [ALAssetsLibrary new];
        
        NSData * data = UIImageJPEGRepresentation(image, 1.0);
        
        [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
            if(!error){
                
                //顶部状态栏提醒
                [JDStatusBarNotification showJDStatusBarMy:@"截屏成功，已为你保存到相册"];
                
            }else{
                //顶部状态栏提醒
                [JDStatusBarNotification showJDStatusBarMy:@"抱歉，截屏失败"];
            }
            
        }];

        return image;
        
    }else {
        return nil;
    }
}


/**
 图片保存到本地

 @param image 图谱按
 */
+(void)saveImageLocal:(UIImage*)image{
    
    //（2）保存到本地相册
    ALAssetsLibrary * library = [ALAssetsLibrary new];
    
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    
    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        if(!error){
            
            //顶部状态栏提醒
            [JDStatusBarNotification showJDStatusBarMy:@"截屏成功，已为你保存到相册"];
            
        }else{
            //顶部状态栏提醒
            [JDStatusBarNotification showJDStatusBarMy:@"抱歉，截屏失败"];
        }
        
    }];

}


/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    //使用案列
    //    [self drawDashLine:labelLine lineLength:4 lineSpacing:1 lineColor:[UIColor yellowColor]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


/** 根据颜色生成纯色图片 */
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
/**
 根据颜色和坐标生成一张图片
 
 @param color 颜色
 @param size 尺寸
 @return 颜色图片
 */
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


/** 取图片某一像素的颜色 */
- (UIColor *)colorAtPixel:(CGPoint)point
{
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point))
    {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/** 获得灰度图 */
- (UIImage *)convertToGrayImage
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL)
    {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    
    return grayImage;
}

#pragma mark - 截取当前image对象rect区域内的图像
- (UIImage *)subImageWithRect:(CGRect)rect
{
    CGImageRef newImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    
    return newImage;
}

#pragma mark - 压缩图片至指定尺寸
- (UIImage *)rescaleImageToSize:(CGSize)size
{
    CGRect rect = (CGRect){CGPointZero, size};
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self drawInRect:rect];
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
}

#pragma mark - 压缩图片至指定像素
- (UIImage *)rescaleImageToPX:(CGFloat )toPX
{
    CGSize size = self.size;
    
    if(size.width <= toPX && size.height <= toPX)
    {
        return self;
    }
    
    CGFloat scale = size.width / size.height;
    
    if(size.width > size.height)
    {
        size.width = toPX;
        size.height = size.width / scale;
    }
    else
    {
        size.height = toPX;
        size.width = size.height * scale;
    }
    
    return [self rescaleImageToSize:size];
}

#pragma mark - 指定大小生成一个平铺的图片
- (UIImage *)getTiledImageWithSize:(CGSize)size
{
    UIView *tempView = [[UIView alloc] init];
    tempView.bounds = (CGRect){CGPointZero, size};
    tempView.backgroundColor = [UIColor colorWithPatternImage:self];
    
    UIGraphicsBeginImageContext(size);
    [tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return bgImage;
}

#pragma mark - UIView转化为UIImage
+ (UIImage *)imageFromView:(UIView *)view
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 将两个图片生成一张图片
+ (UIImage*)mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage
{
    CGImageRef firstImageRef = firstImage.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    CGImageRef secondImageRef = secondImage.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    UIGraphicsBeginImageContext(mergedSize);
    [firstImage drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [secondImage drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/**
 根据图片上的坐标截取图片上指定坐标的图片，如截取人脸之类的
 
 @param cutFrame 截取范围的坐标
 @param image 截取的图片
 */
+(UIImage*)cutImageSmallImageImage:(UIImage*)image Frame:(CGRect)cutFrame{
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, cutFrame);
    UIImage * resultImg = [UIImage imageWithCGImage:(__bridge CGImageRef)CFBridgingRelease(subImageRef)];
    //必须结束
    UIGraphicsEndImageContext();
    
    return resultImg;
    
}


/**
 绘制椭圆图形

 @param srcImg 图片
 @return 返回椭圆
 */
+(UIImage*)drawTheEllipse:(UIImage*)srcImg{
    //绘制椭圆
    CGFloat width = srcImg.size.width;
    CGFloat height = srcImg.size.height;
    //开始绘制图片
    UIGraphicsBeginImageContext(srcImg.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    ////绘制Clip区域
    CGContextAddEllipseInRect(gc, CGRectMake(width * 0.125, 0,width * 0.75, height)); //椭圆
    CGContextClosePath(gc);
    CGContextClip(gc);
    //坐标系转换
    //因为CGContextDrawImage会使用Quartz内的以左下角为(0,0)的坐标系
    CGContextTranslateCTM(gc, 0, height);
    CGContextScaleCTM(gc, 1, -1);
    CGContextDrawImage(gc, CGRectMake(0, 0, width, height), [srcImg CGImage]);
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImg;
}



#pragma marl ========= 按比例限制图片宽度不要超过最大宽度，同时高度按比例缩放 （（图片宽度填满））===================
+(CGFloat )getImageHeightWith:(NSString *)myImageWidth AndHeight:(NSString*)myImageHeight AndMaxWindth:(CGFloat)maxWidth{
    //判空，否者会崩溃
    if ([NSString isNULL:myImageWidth]) {
        myImageWidth = [NSString stringWithFormat:@"%f",maxWidth];
    }
    if ([NSString isNULL:myImageHeight]) {
        myImageHeight = [NSString stringWithFormat:@"%f",maxWidth];
    }
    
    //图片实际宽度
    CGFloat W = [myImageWidth floatValue];
    //图片实际高度
    CGFloat H = [myImageHeight floatValue];
    //图片要求宽度（铺满控件）
    CGFloat MaxW = maxWidth;
    
    if (W != MaxW) {
        CGFloat WC = 0.0;
        if (W > MaxW) {
            //比例
            WC = (W- MaxW)/W;
            //计算出最终高度（减去）
            H = H - H * WC;
            
        }else{
            //比例
            WC = (MaxW - W)/W;
            //计算出最终高度（加上）
            H = H + H * WC;
        }
        
        //最终宽度永远是屏幕那么宽
        W = MaxW;
        
    }
    
    return H;
}


/**
 tableviewCell上的封面图处理动态宽高，不会剪裁图片，类似微信朋友圈照片展示
 
 @param myImageWidth 图片原始宽度
 @param myImageHeight 图片原始高度
 @param maxWidth 图片限制的最大宽高（相等）
 @return 返回宽高
 */
+(NSArray* )getImageHeightMyCellWith:(NSString *)myImageWidth AndHeight:(NSString*)myImageHeight AndMaxWindth:(CGFloat)maxWidth{
    
//    //得到计算后的图片宽、高---（这个是用法）
//    NSArray * arrayWindhAndHeight = [UIImage getImageHeightMyCellWith:self.model.width AndHeight:self.model.height AndMaxWindth:SCREEN_WIDTH-60.0*px];
//    //图片宽度
//    CGFloat W = [arrayWindhAndHeight.firstObject floatValue];
//    //图片高度
//    CGFloat H = [arrayWindhAndHeight.lastObject floatValue];
//    //图片最大宽度
//    CGFloat MaxW = SCREEN_WIDTH-60.0*px;
//    //图片坐标
//    self.coverImage.frame = CGRectMake(30.0*px + (MaxW-W)/2.0, CGRectGetMaxY(self.headView.frame)+20.0*px,W,H);
//
    
    //判空，否者会崩溃
    if ([NSString isNULL:myImageWidth]) {
        myImageWidth = [NSString stringWithFormat:@"%f",maxWidth];
    }
    if ([NSString isNULL:myImageHeight]) {
        //宽高都为空时默认16比9
        myImageHeight = [NSString stringWithFormat:@"%f",maxWidth * (9.0/16)];
    }
    
    //图片实际宽度
    CGFloat W = [myImageWidth floatValue];
    //图片实际高度
    CGFloat H = [myImageHeight floatValue];
    //图片最大宽度
    CGFloat MaxW = maxWidth;
    
    if (W < MaxW && H < MaxW) {
        //图片宽和高都小于要求最大值，就不用做处理了
    }else{
        //（1）图片:宽 > 高
        CGFloat WC = 0.0;//缩放比例
        if (W > H) {//此时最大值一定超过限制的最大边框
            //比例
            WC = (W- MaxW)/W;
            //计算出最终高度（减去）
            H = H - H * WC;
            //最终宽度
            W = MaxW;
            
        }else{//此时最大值一定超过限制的最大边框
            //（2）图片:宽 < 高
            //比例
            WC = (H- MaxW)/H;
            //计算出最终宽度
            W = W - W * WC;
            //此时最大高度
            H = MaxW;
        }
    }
    //返回宽高
    return @[[NSString stringWithFormat:@"%f",W],[NSString stringWithFormat:@"%f",H]];
}





@end
