//
//  UIImageCollectionViewCell.h
//  ImageReview
//
//  Created by gyf on 16/5/3.
//  Copyright © 2016年 owen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImageCellClickDelegate<NSObject>
- (void)ImageCellDidClick;
@end
@interface UIImageCollectionViewCell : UICollectionViewCell
@property(nonatomic , assign) NSObject<ImageCellClickDelegate> *delegate;
- (void)setImage:(UIImage *)imageName;

//单击手势关闭
@property(nonatomic,copy)void(^offImage)(void);
//保存照片
@property(nonatomic,copy)void(^LongImage)(void);

@end
