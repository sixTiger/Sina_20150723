//
//  XXBStatusTool.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBStatusTool.h"

#import "XXBAccountTools.h"
#import "XXBAccount.h"
#import "XXBStatusParam.h"
#import "XXBStatusResult.h"
#import "XXBHttpTool.h"
#import "XXBStatusCacheTool.h"

@implementation XXBStatusTool

/**
 *  获取更多的微博数据
 *
 *  @param maxID   若指定此参数，则返回ID小于或等于max_id的微博
 *  @param success 成功时候的一个回调
 *  @param failure 失败时候的一个回调
 */
+ (void)getMoreStatusWithMaxID:(id)maxID success:(void (^)(NSArray *statuses))success failure:(void (^)( NSError *error))failure
{
    XXBStatusParam *param = [[XXBStatusParam alloc] init];
    param.max_id = maxID;
    param.access_token = [XXBAccountTools account].access_token;
    
    // 1.先从缓存里面加载
    NSArray *statusArray = [XXBStatusCacheTool statuesWithParam:param];
    if (statusArray.count)
    { // 有缓存
        // 传递了block
        if (success)
        {
            //XXBStatusResult *result = [[XXBStatusResult alloc] init];
            // result.statuses = statusArray;
            success(statusArray);
        }
    }
    else
    {
        [XXBHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
            /**
             *  字典转模型
             */
            XXBStatusResult *result = [XXBStatusResult objectWithKeyValues:responseObject];
            // 缓存
            [XXBStatusCacheTool addStatuses:result.statuses];
            /**
             *  回传一个数组
             */
            success(result.statuses);
            
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
    
}



/**
 *  获取更新的微博数据
 *
 *  @param sinceID 若指定此参数，则返回ID比since_id大的微博
 *  @param success 成功时候的回调
 *  @param failure 失败时候的回调
 */
+ (void)getNewStatusWithSinceID:(id)sinceID success:(void (^)(NSArray *statuses))success failure:(void (^)( NSError *error))failure
{
    XXBStatusParam *param = [[XXBStatusParam alloc] init];
    // 判断sinceID有没有值
    if (sinceID) {
        // 拼接sinceId参数
        param.since_id = sinceID;
    }
    param.access_token = [XXBAccountTools account].access_token;
    // 1.先从缓存里面加载
    NSArray *statusArray = [XXBStatusCacheTool statuesWithParam:param];
    if (statusArray.count)
    { // 有缓存
        // 传递了block
        if (success)
        {
            //XXBStatusResult *result = [[XXBStatusResult alloc] init];
            // result.statuses = statusArray;
            success(statusArray);
        }
    }
    else
    {
        [XXBHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
            /**
             *  字典转模型
             */
            XXBStatusResult *result = [XXBStatusResult objectWithKeyValues:responseObject];
            /**
             *  回传一个数组
             */
            // 缓存
            [XXBStatusCacheTool addStatuses:result.statuses];
            success(result.statuses);
            
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

@end
