//
//  XXBHttpTool.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXBHttpTool : NSObject

/**
 *  封装的post请求
 */
+ (void)POST:(NSString *)URLString  parameters:(id)parameters  success:(void (^)(id responseObject))success  failure:(void (^)( NSError *error))failure;
/**
 *  封装的get请求
 */
+ (void)GET:(NSString *)URLString    parameters:(id)parameters   success:(void (^)( id responseObject))success   failure:(void (^)( NSError *error))failure;

@end
