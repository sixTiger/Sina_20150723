//
//  XXBStatusResult.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//  存放返回的结果

#import "XXBStatusResult.h"
#import "MJExtension.h"
#import "XXBStatus.h"

@implementation XXBStatusResult

- (NSDictionary *)objectClassInArray
{
    /**
     *  把数组里边的字典模型转换成 XXBStatus 模型
     */
    return @{@"statuses":[XXBStatus class]};
}

@end
