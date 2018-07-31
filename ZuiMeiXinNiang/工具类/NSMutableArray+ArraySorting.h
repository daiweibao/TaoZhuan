//
//  NSMutableArray+ArraySorting.h
//  ZuiMeiXinNiang
//
//  Created by 爱恨的潮汐 on 16/3/24.
//  Copyright © 2016年 zmxn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (ArraySorting)
/**
 *  两个数组排序
 *
 *  @param arr1 数组1
 *  @param arr2 数组2
 *
 *  @return 返回排好的数组
 */
-(NSMutableArray*)createSorting1:(NSMutableArray*)arr1 addWithmArray2:(NSMutableArray*)arr2;
@end
