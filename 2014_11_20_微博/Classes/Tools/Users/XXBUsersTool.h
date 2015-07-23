//
//  XXBUsersTool.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XXBUser,XXBUsersResult;

@interface XXBUsersTool : NSObject

// block参数设计原理:需要把谁传出去,就填谁
/**
 *  获取用户信息
 *
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)userInfoDidSuccess:(void(^)(XXBUser *user))success failure:(void(^)(NSError *error))failure;


/**
 *  获取用户未读数
 *
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)getUnreadCountDidSuccess:(void(^)(XXBUsersResult *unreadResult))success failure:(void(^)(NSError *error))failure;

@end
