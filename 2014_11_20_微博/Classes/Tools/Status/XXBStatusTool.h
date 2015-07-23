//
//  XXBStatusTool.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//  用于发送和返回微博的参数

#import <Foundation/Foundation.h>

@interface XXBStatusTool : NSObject
/**
 *  获取更多的微博数据
 *
 *  @param maxID   若指定此参数，则返回ID小于或等于max_id的微博
 *  @param success 成功时候的一个回调
 *  @param failure 失败时候的一个回调
 */
+ (void)getMoreStatusWithMaxID:(id)maxID success:(void (^)(NSArray *statuses))success failure:(void (^)( NSError *error))failure;



/**
 *  获取更新的微博数据
 *
 *  @param sinceID 若指定此参数，则返回ID比since_id大的微博
 *  @param success 成功时候的回调
 *  @param failure 失败时候的回调
 */
+ (void)getNewStatusWithSinceID:(id)sinceID success:(void (^)(NSArray *statuses))success failure:(void (^)( NSError *error))failure;

@end
