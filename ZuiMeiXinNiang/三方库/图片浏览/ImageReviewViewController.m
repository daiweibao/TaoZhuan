//
//  ImageReviewViewController.m
//  ImageReview
//
//  Created by gyf on 16/5/3.
//  Copyright © 2016年 owen. All rights reserved.
//

#import "ImageReviewViewController.h"
#import "UIImageCollectionViewCell.h"
//#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface ImageReviewViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ImageCellClickDelegate>
{
    UIButton *_closeBtn;
}
@property (nonatomic, strong) UICollectionView *collectionContentView;
//页码
@property(nonatomic,strong)UILabel * pageLabel;
@end
@implementation ImageReviewViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:(UIStatusBarAnimationFade)];
//    self.imageArray = @[@"启动图标最终版",@"嗅美logo"];
    //创建控件
    [self buildCollectionView];
//    _closeBtn = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
//    _closeBtn.frame = CGRectMake(0, 0, 44, 44);
//    [_closeBtn setTitle:@"关闭" forState:(UIControlStateNormal)];
//    [_closeBtn addTarget:self action:@selector(closeViewAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:_closeBtn];
    
   
    
}
- (void)closeViewAction
{
    [self dismissViewControllerAnimated:NO completion:^{
        //[[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:(UIStatusBarAnimationFade)];
    }];
}
- (void)buildCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionContentView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    self.collectionContentView.delegate = self;
    self.collectionContentView.dataSource = self;
    self.collectionContentView.showsHorizontalScrollIndicator = NO;
    self.collectionContentView.showsVerticalScrollIndicator = NO;
    [self.collectionContentView registerClass:[UIImageCollectionViewCell class] forCellWithReuseIdentifier:@"imagecell"];
    self.collectionContentView.pagingEnabled = YES;
    [self.view addSubview:self.collectionContentView];
    
#pragma mark ============ 图片页码左右滚动 ============
    //页码
    self.pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT - 40, 100, 30)];
    self.pageLabel.userInteractionEnabled = NO;
    //防止有些地方没写的,页码错乱
    if (self.indextSelImage) {
        //存在
        self.pageLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)self.indextSelImage,(unsigned long)self.imageArray.count];
        
        //滚到指定位置
        [self.collectionContentView setContentOffset:CGPointMake(SCREEN_WIDTH*(self.indextSelImage-1),0) animated:NO];
        
    }else{
        //不存在
          self.pageLabel.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)self.imageArray.count];
        
    }
    self.pageLabel.textAlignment  =NSTextAlignmentCenter;
    self.pageLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.pageLabel];
    
}

//滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int n = scrollView.contentOffset.x/SCREEN_WIDTH;
    //必须加1
    self.pageLabel.text = [NSString stringWithFormat:@"%d/%lu",n+1,(unsigned long)self.imageArray.count];
}



- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"imagecell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setImage:self.imageArray[indexPath.row]];
    
    //单击关闭图片
    __weak typeof (self) wearkSelf = self;
    [cell setOffImage:^{
        [wearkSelf dismissViewControllerAnimated:NO completion:^{
            [[UIApplication sharedApplication]setStatusBarHidden:NO withAnimation:(UIStatusBarAnimationFade)];
           //回调（暂时没用）
            if (wearkSelf.imageSamll) {
                wearkSelf.imageSamll();
            }
            
        }];

    }];
    
    
    [cell setLongImage:^{
        [AlertViewTool AlertWXSheetToolWithTitle:@"提示" otherItemArrays:@[@"保存图片到相册"] ShowRedindex:-1 CancelTitle:@"取消" handler:^(NSInteger index) {
            if (index==0) {
                
                //保存图片到相册
                UIImageWriteToSavedPhotosAlbum(wearkSelf.imageArray[indexPath.row], wearkSelf, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
            
            }
        }];


    }];
    
    return cell;
}

//保存照片到本地相册
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
         [MBProgressHUD showSuccess:@"保存成功"];
    }else
    {
       [MBProgressHUD showSuccess:@"保存失败"];
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}
- (void)ImageCellDidClick
{
    _closeBtn.hidden = !_closeBtn.hidden;
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //影藏电池
     [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}



- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    //打开电池
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
}




@end
