//
//  BigActionButton.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/8/30.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "BigActionButton.h"

@implementation BigActionButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(self.clickAreaRadious - bounds.size.width, 0);
    CGFloat heightDelta = MAX(self.clickAreaRadious - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
