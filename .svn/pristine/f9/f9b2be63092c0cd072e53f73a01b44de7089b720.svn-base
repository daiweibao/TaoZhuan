//
//  NSMutableArray+ArraySorting.m
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/3/24.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import "NSMutableArray+ArraySorting.h"

@implementation NSMutableArray (ArraySorting)

//排序21-21-21方式
-(NSMutableArray*)createSorting1:(NSMutableArray*)arr1 addWithmArray2:(NSMutableArray*)arr2{
    //排序
    NSMutableArray * arrNew = [NSMutableArray array];
    if (arr1.count/2==arr2.count) {
        int j = 0;
        for (int i = 0;  i < arr1.count; i++) {
            [arrNew addObject:arr1[i]];
            if (i%2 !=0) {
                [arrNew addObject:arr2[j]];
                j++;
            }
        }
    }
    
    if (arr1.count/2 > arr2.count) {
        int j = 0;
        for (int i = 0;  i < arr1.count; i++) {
            [arrNew addObject:arr1[i]];
            if (i%2 !=0) {
                if (j==arr2.count) {
                    continue;
                }else{
                    [arrNew addObject:arr2[j]];
                    j++;
                    
                }
            }
        }
        
    }
    
    if (arr1.count/2 < arr2.count) {
        int j = 0;
        for (int i = 0;  i < MAXFLOAT; i++) {
            if (i != arr1.count&&i< arr1.count) {
                [arrNew addObject:arr1[i]];
            }
            if (i%2 !=0) {
                if (j==arr2.count) {
                    continue;
                }else{
                    [arrNew addObject:arr2[j]];
                    j++;
                }
            }
            if (j==arr2.count) {
                break;
            }
        }
        
    }
    return arrNew;
    
}


@end
