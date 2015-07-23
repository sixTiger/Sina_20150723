//
//  XXBHttpTool.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBHttpTool.h"
#import "AFNetworking.h"

@implementation XXBHttpTool
/**
 *  封装的post请求
 */
+ (void)POST:(NSString *)URLString  parameters:(id)parameters  success:(void (^)(id responseObject))success  failure:(void (^)( NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
/**
 *  封装的get请求
 */
+ (void)GET:(NSString *)URLString    parameters:(id)parameters   success:(void (^)( id responseObject))success   failure:(void (^)( NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        /**
         *  成功处理
         */
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        /**
         *  失败处理
         */
        failure(error);
    }];

    
}

@end
