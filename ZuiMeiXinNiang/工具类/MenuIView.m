//
//  MenuIView.m
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/8/1.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "MenuIView.h"

@interface MenuIView()

@end

@implementation MenuIView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addLongPressGesture];
    }
    return self;
}

// 添加长按手势
- (void)addLongPressGesture {
    
    self.userInteractionEnabled = YES;
    //长按删除
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDoDelete:)];
//    longPressGr.minimumPressDuration = 0.8;
    [self addGestureRecognizer:longPressGr];
    

}

- (void)longPressToDoDelete:(UILongPressGestureRecognizer *)longRecognizer {
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        
        [self becomeFirstResponder];
        
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyItemClicked:)];
        UIMenuItem *resendItem = [[UIMenuItem alloc] initWithTitle:@"转发" action:@selector(resendItemClicked:)];
        
        UIMenuItem *resendItem1 = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(resendItemClicked:)];
        
        UIMenuItem *resendItem2 = [[UIMenuItem alloc] initWithTitle:@"收藏多条" action:@selector(resendItemClicked:)];
        
        UIMenuItem *resendItem3 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(resendItemClicked:)];
        
        UIMenuController *menu=[UIMenuController sharedMenuController];
        
        [menu setMenuItems:[NSArray arrayWithObjects:copyItem,resendItem,resendItem1,resendItem2,resendItem3,nil]];
        
        [menu setTargetRect:self.bounds inView:self];
        
        [menu setMenuVisible:YES animated:YES];
    }
}

- (void)resendItemClicked:(id)sender {
    NSLog(@"转发");
}

- (void)copyItemClicked:(UIMenuItem *)sender {
    NSLog(@"复制");
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"hongw";
}

//处理action事件
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if(action == @selector(copyItemClicked:)){
        return YES;
    } else if (action == @selector(resendItemClicked:)){
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}
//实现成为第一响应者方法
- (BOOL)canBecomeFirstResponder {
    return YES;
}


@end
