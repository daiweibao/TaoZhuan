//
//  UIImageCollectionViewCell.m
//  ImageReview
//
//  Created by gyf on 16/5/3.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "UIImageCollectionViewCell.h"
#define MAXZOOMSCALE 3
#define MINZOOMSCALE 1
//#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface UIImageCollectionViewCell()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation UIImageCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.scrollView.minimumZoomScale = MINZOOMSCALE;
        self.scrollView.maximumZoomScale = MAXZOOMSCALE;
        self.scrollView.delegate = self;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self.scrollView addGestureRecognizer:tap];
        [self.contentView addSubview:self.scrollView];
        self.imageView = [[UIImageView alloc]initWithFrame:frame];
        self.imageView.userInteractionEnabled = YES;
        //双击手势
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleClickAction:)];
        doubleTap.numberOfTouchesRequired = 1;
        doubleTap.numberOfTapsRequired = 2;
        [self.imageView addGestureRecognizer:doubleTap];
        
        //单击手势关闭
        UITapGestureRecognizer * singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeViewActionpclose)];
        [self.scrollView addGestureRecognizer:singleTapGestureRecognizer];
           //优先触发单击手势
         [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTap];
        
        
        //长按手势
        UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo)];
        longPressGr.minimumPressDuration = 0.8;
        [self.scrollView addGestureRecognizer:longPressGr];
        
        [self.scrollView addSubview:self.imageView];
    }
    return self;
}

//点击关闭
-(void)closeViewActionpclose{
   
    if (self.offImage) {
        self.offImage();
    }
}

//长按保存照片
-(void)longPressToDo{
    
    if (self.LongImage) {
        self.LongImage();
    }
}


- (void)tapAction
{
    [self.delegate ImageCellDidClick];
}
- (void)doubleClickAction:(UIGestureRecognizer *)gesture
{
    CGFloat k = MAXZOOMSCALE;
    UIScrollView *scrollView = (UIScrollView *)gesture.view.superview;
    CGFloat width = gesture.view.frame.size.width;
    CGFloat height = gesture.view.frame.size.height;
    CGPoint point = [gesture locationInView:gesture.view];
    //获取双击坐标，分4种情况计算scrollview的contentoffset
    if (point.x<=width/2 && point.y<=height/2) {
        point = CGPointMake(point.x*k, point.y*k);
        point = CGPointMake(point.x-SCREEN_WIDTH/2>0?point.x-SCREEN_WIDTH/2:0,point.y-SCREEN_HEIGHT/2>0?point.y-SCREEN_HEIGHT/2:0);
    }else if (point.x<=width/2 && point.y>height/2)
    {
        point = CGPointMake(point.x*k, (height-point.y)*k);
        point = CGPointMake(point.x-SCREEN_WIDTH/2>0?point.x-SCREEN_WIDTH/2:0,point.y>SCREEN_HEIGHT/2?height*k-point.y-SCREEN_HEIGHT/2:height*k>SCREEN_HEIGHT?height*k-SCREEN_HEIGHT:0);
    }else if (point.x>width/2 && point.y<=height/2)
    {
        point = CGPointMake((width-point.x)*k, point.y*k);
        point = CGPointMake(point.x>SCREEN_WIDTH/2?width*k-point.x-SCREEN_WIDTH/2:width*k>SCREEN_WIDTH?width*k-SCREEN_WIDTH:0, point.y-SCREEN_HEIGHT/2>0?point.y-SCREEN_HEIGHT/2:0);
    }else
    {
        point = CGPointMake((width-point.x)*k, (height-point.y)*k);
        point = CGPointMake(point.x>SCREEN_WIDTH/2?width*k-point.x-SCREEN_WIDTH/2:width*k>SCREEN_WIDTH?width*k-SCREEN_WIDTH:0, point.y>SCREEN_HEIGHT/2?height*k-point.y-SCREEN_HEIGHT/2:height*k>SCREEN_HEIGHT?height*k-SCREEN_HEIGHT:0);
    }
    
    
    if (scrollView.zoomScale == 1) {
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.zoomScale = k;
            scrollView.contentOffset = point;
        } completion:^(BOOL finished) {
            
        }];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.zoomScale = 1;
        }];
    }
}
- (void)setImage:(UIImage *)imageName
{
    //重置zoomscale为1
    self.scrollView.zoomScale = 1;
    UIImage *image = imageName;
    self.imageView.image = image;
    CGFloat x = SCREEN_HEIGHT/SCREEN_WIDTH;
    CGFloat y = image.size.height/image.size.width;
    //x为屏幕尺寸，y为图片尺寸，通过两个尺寸的比较，重置imageview的frame
//     self.imageView.frame = CGRectMake(SCREEN_WIDTH/2-50,  SCREEN_HEIGHT/2-50,100 ,100);
    //动画
//    [UIView animateWithDuration:0.6 animations:^{
    if (y>x) {
        self.imageView.frame = CGRectMake(0, 0, SCREEN_HEIGHT/y, SCREEN_HEIGHT);
    }else
    {
        self.imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*y);
    }
        
        self.imageView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
//    }];
}
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    scrollView.subviews[0].center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                                scrollView.contentSize.height * 0.5 + offsetY);
}
@end
