//
//  NSObject+XMwebView.m
//  ZuiMeiXinNiang
//
//  Created by 爱淘包 on 2016/12/19.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "NSObject+XMwebView.h"

@implementation NSObject (XMwebView)


+ (void)load{
    //  "v@:"
    Class class = NSClassFromString(@"WebActionDisablingCALayerDelegate");
    class_addMethod(class, @selector(setBeingRemoved), setBeingRemoved, "v@:");
    class_addMethod(class, @selector(willBeRemoved), willBeRemoved, "v@:");
    
    class_addMethod(class, @selector(removeFromSuperview), willBeRemoved, "v@:");
}

id setBeingRemoved(id self, SEL selector, ...)
{
    return nil;
}

id willBeRemoved(id self, SEL selector, ...)
{
    return nil;
}

@end
