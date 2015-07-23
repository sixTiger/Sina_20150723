//
//  XXBStatusCacheTool.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-4.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XXBStatus ,XXBStatusParam;

@interface XXBStatusCacheTool : NSObject

/**
 *  缓存一条微博
 *
 *  @param status 需要缓存的微博数据
 */
+ (void)addStatus:(XXBStatus *)status;

/**
 *  缓存N条微博
 *
 *  @param statusArray 需要缓存的微博数据
 */
+ (void)addStatuses:(NSArray *)statusArray;

/**
 *  根据请求参数获得微博数据
 *
 *  @param param 请求参数
 *
 *  @return 模型数组
 */
+ (NSArray *)statuesWithParam:(XXBStatusParam *)param;

@end
