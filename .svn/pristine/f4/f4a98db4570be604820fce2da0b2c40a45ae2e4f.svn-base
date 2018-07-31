//
//  XMHeightScrollerView.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 2017/8/23.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "XMHeightScrollerView.h"

@interface XMHeightScrollerView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * Bigscroll;
@property(nonatomic,strong)NSMutableArray * dataSouce;

@property(nonatomic,strong)NSMutableArray * images;
@property(nonatomic,strong)NSMutableArray * imagesheights;

//下标父视图
@property(nonatomic,strong)UIButton * buttonIndexSub;
//下标数1
@property(nonatomic,strong)UILabel * labelIndex;
//下标数2
@property(nonatomic,strong)UILabel * labelIndexAll;

//记录当前下标
@property(nonatomic,assign)int indexdImage;


@end

@implementation XMHeightScrollerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //父亲控制器必须设置，否则有空白64
//        self.automaticallyAdjustsScrollViewInsets = NO;
        
        //初始化
        self.indexdImage = 0;
    }
    return self;
}

/**
 （1）传入包含图片名字和图片高度的数组（数组里包含字典，字典里包含图片url和图片高度）
 
 @param arrayImageAndHeight 数组
 @param name 图片url的键
 @param HeightName 图片高度url的键
 */
-(void)getScrollerArrayImage:(NSArray*)arrayImageAndHeight AndImagename:(NSString *)urlName AndImageWindthName:(NSString *)WindthName AndImageHeightName:(NSString *)HeightName{
    if (arrayImageAndHeight.count>0) {
        for (int i = 0; i< arrayImageAndHeight.count; i++) {
            //添加图片数组网址
            [self.dataSouce addObject:arrayImageAndHeight[i][urlName]];
            //添加图片高度
            if ([NSString isNULL:arrayImageAndHeight[i][urlName]]) {
                //高度不存在，高度默认为
                 [self.imagesheights addObject:@"300"];
            }else{
#pragma marl ========= 按比例限制图片宽度不要超过最大宽度，同时高度按比例缩放 （（图片宽度填满））（封装）===================
                CGFloat imageH = [UIImage getImageHeightWith:arrayImageAndHeight[i][WindthName] AndHeight:arrayImageAndHeight[i][HeightName] AndMaxWindth:SCREEN_WIDTH];//计算出来的图片高度（图片宽度填满）
                [self.imagesheights addObject:[NSString stringWithFormat:@"%f", imageH]];
            }
            
        }
        
        //创建UI
        [self createscroller];
    }else{
        //数据不存在回调高度为0
        if (self.getScrollerHeight) {
            self.getScrollerHeight(self.Bigscroll.height);
        }
    }
}

#pragma mark 创建
-(void)createscroller{
    //创建大滚动视图（用第一张图片的高度)
    self.Bigscroll = [[UIScrollView alloc]init];
    self.Bigscroll.frame = CGRectMake(0, 0, SCREEN_WIDTH,[self.imagesheights.firstObject floatValue]);
    self.Bigscroll.showsVerticalScrollIndicator = NO;
    self.Bigscroll.showsHorizontalScrollIndicator= NO;
    self.Bigscroll.bounces = NO;
    self.Bigscroll.pagingEnabled = YES;
    self.Bigscroll.delegate = self;
    self.Bigscroll.userInteractionEnabled = YES;
    self.Bigscroll.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:self.Bigscroll];
    self.Bigscroll.contentSize = CGSizeMake(SCREEN_WIDTH*self.dataSouce.count,[self.imagesheights.firstObject floatValue]);
    
    //长按手势
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(imglongTapClick)];
    [self.Bigscroll addGestureRecognizer:longTap];

    
    //回调第一张图片的高度，必须
    if (self.getScrollerHeight) {
        self.getScrollerHeight([self.imagesheights.firstObject floatValue]);
    }
    
    for (int i = 0; i< self.dataSouce.count; i++) {

        //图片，贴到滚动视图上
        UIImageView * imagevideo = [[UIImageView alloc]init];
        imagevideo.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, [self.imagesheights[i] floatValue]);
        [imagevideo sd_setImageWithURL:[NSURL URLWithString:self.dataSouce[i]] placeholderImage:[UIImage imageNamed:@"启动图标最终版"]];
        
//        [imagevideo sd_setImageWithURL:[NSURL URLWithString:self.dataSouce[i]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageCacheMemoryOnly];

        
        imagevideo.contentMode = UIViewContentModeScaleAspectFill;
        imagevideo.clipsToBounds = YES;
        imagevideo.userInteractionEnabled = YES;
        [self.Bigscroll addSubview:imagevideo];
        
        [self.images addObject:imagevideo];
    }
    
    if (self.dataSouce.count>1) {
        //下标父视图
        _buttonIndexSub = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonIndexSub.frame = CGRectMake(SCREEN_WIDTH-45, self.Bigscroll.bottomY-60, 30, 50);
        [_buttonIndexSub setImage:[UIImage imageNamed:@"页码分割线"] forState:UIControlStateNormal];
        [self addSubview:_buttonIndexSub];
        
        //下标1
        _labelIndex = [[UILabel alloc]init];
        _labelIndex.frame =  CGRectMake(0, 3, 15, 25);
        _labelIndex.text = @"1";
        _labelIndex.textColor = [UIColor whiteColor];
        _labelIndex.textAlignment = NSTextAlignmentCenter;
        _labelIndex.font = [UIFont systemFontOfSize:14];
        [_buttonIndexSub addSubview:_labelIndex];
        
        //下标2
        _labelIndexAll = [[UILabel alloc]init];
        _labelIndexAll.frame = CGRectMake(15, 22, 15, 25);
        _labelIndexAll.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.dataSouce.count];
        _labelIndexAll.textColor = [UIColor whiteColor];
        _labelIndexAll.textAlignment = NSTextAlignmentCenter;
        _labelIndexAll.font = [UIFont systemFontOfSize:14];
        [_buttonIndexSub addSubview:_labelIndexAll];

        
    }
}


//时时监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //获取偏移量
    CGFloat offX = scrollView.contentOffset.x;
    
    //拦截临界值
    if ( [@(offX/SCREEN_WIDTH) integerValue] - offX/SCREEN_WIDTH == 0 ) {
        return;
    }
    
    
    NSInteger index = offX/SCREEN_WIDTH;
    //高度差
    CGFloat cha = [self.imagesheights[index+1] floatValue] - [self.imagesheights[index] floatValue];
    
    //比例系数
    CGFloat n = (offX  / SCREEN_WIDTH );
    if (n > 1) {
        n = n - [@(n) intValue];
    }
    
    //要增加的高度
    CGFloat h = cha * n;
    UIImageView *lastimage = self.images[index];
    UIImageView *nowimage = self.images[index+1];
    lastimage.frame = CGRectMake(SCREEN_WIDTH*index, 0, SCREEN_WIDTH,[self.imagesheights[index] floatValue] + h);
    nowimage.frame = CGRectMake(SCREEN_WIDTH*(index+1), 0, SCREEN_WIDTH,[self.imagesheights[index] floatValue] + h);
    
    //滚动视图坐标
    self.Bigscroll.frame = CGRectMake(0, 0, SCREEN_WIDTH,[self.imagesheights[index] floatValue] + h);
    //滚动视图尺寸
    self.Bigscroll.contentSize = CGSizeMake(SCREEN_WIDTH*self.dataSouce.count, [self.imagesheights[index] floatValue] + h);
    //滚动视图页码坐标
      _buttonIndexSub.frame = CGRectMake(SCREEN_WIDTH-45, self.Bigscroll.bottomY-60, 30, 50);
    
    //时时回调滚动视图高度
    if (self.getScrollerHeight) {
        self.getScrollerHeight(self.Bigscroll.height);
    }
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //赋值，保存图片用（跟上面那个角标不一样）
    self.indexdImage = scrollView.contentOffset.x/SCREEN_WIDTH;
    //动态设置角标
    _labelIndex.text = [NSString stringWithFormat:@"%d",self.indexdImage+1];
}



#pragma mark ======长按保存图片 =====================
//长按动作
- (void)imglongTapClick{
    
    //保存图片
    [AlertViewTool AlertWXSheetToolWithTitle:nil otherItemArrays:@[@"保存图片"] ShowRedindex:-1 CancelTitle:@"取消" handler:^(NSInteger index) {
        if (index==0) {
            //保存
            dispatch_async(dispatch_get_main_queue(), ^{
                //保存图片到相册
                 UIImageView *ImageView = self.images[self.indexdImage];
                UIImageWriteToSavedPhotosAlbum(ImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
                
            });
        }
        
    }];
    
}

//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    if(!error){
        //延迟显示，否则会移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [MBProgressHUD showSuccess:@"保存成功"];
            
        });
        
    }else{
        //延迟显示，否则会移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:@"保存失败"];
        });
        
    }
    
}


-(NSMutableArray *)dataSouce{
    if (!_dataSouce) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

- (NSMutableArray *)imagesheights{
    
    if (_imagesheights == nil) {
        _imagesheights = [NSMutableArray array];
    }
    return _imagesheights;
}

- (NSMutableArray *)images{
    
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}


@end
