//
//  UIView+ActionTap.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/9/2.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "UIView+ActionTap.h"

@implementation UIView (ActionTap)
static char touchKey;
-(void)actionTap{
    void (^block)(void) = objc_getAssociatedObject(self, &touchKey);
    if (block) block();
}
-(void)addTapActionTouch:(TouchBlock)block{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &touchKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
