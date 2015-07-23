//
//  XXBUsersTool.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBUsersTool.h"
#import "XXBUsersParam.h"
#import "XXBUsersResult.h"
#import "XXBUser.h"
#import "XXBHttpTool.h"
#import "XXBAccountTools.h"
#import "XXBAccount.h"

@implementation XXBUsersTool

// block参数设计原理:需要把谁传出去,就填谁
/**
 *  获取用户信息
 *
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)userInfoDidSuccess:(void(^)(XXBUser *user))success failure:(void(^)(NSError *error))failure
{
    XXBUsersParam *param = [[XXBUsersParam alloc] init];
    param.uid = [XXBAccountTools account].uid;
    [XXBHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        /**
         *  如果成功的画吧用户的账号保存再沙盒里
         */
        XXBUser *user = [XXBUser objectWithKeyValues:responseObject];
        
        // 获取账号模型
        XXBAccount *account = [XXBAccountTools account];
        if (![user.name isEqualToString:account.name]) {
            // 保存
            account.name = user.name;
            [XXBAccountTools save:account];
        }
        success(user);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}


/**
 *  获取用户未读数
 *
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)getUnreadCountDidSuccess:(void(^)(XXBUsersResult *usersResult))success failure:(void(^)(NSError *error))failure
{
    XXBUsersParam *param = [[XXBUsersParam alloc] init];
    param.uid = [XXBAccountTools account].uid;
    [XXBHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {

        /**
         *  获取用户的未读数，直接返回
         */
        XXBUsersResult *userResult = [XXBUsersResult objectWithKeyValues:responseObject];
        success(userResult);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
