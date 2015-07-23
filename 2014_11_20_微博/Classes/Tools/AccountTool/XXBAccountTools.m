//
//  XXBAccountTools.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-24.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBAccountTools.h"
#import "XXBAccount.h"
#import "XXBHttpTool.h"
#import "XXBAccountParam.h"
#import "2014_11_20_微博config.h"



#define XXBAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation XXBAccountTools


+ (void)save:(XXBAccount *)account
{
    // 存储账号
    [NSKeyedArchiver archiveRootObject:account toFile:XXBAccountFile];
}
+ (XXBAccount *)account
{
    
    XXBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:XXBAccountFile];
    // 账号过期 过期时间 11:25  > 11:24 没有过期
    // 小于当前时间 过期
    // NSOrderedAscending = -1L, 升序 1~10
    // NSOrderedDescending 降序 10 ~1
    
    if ([account.expires_date compare:[NSDate date]] == NSOrderedAscending) { // 过期
        
        account = nil;
    }
    return account;
}

+ (void)getAccessTokenWithCode:(id)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 请求参数:key value:
    XXBAccountParam *param = [[XXBAccountParam alloc] init];
    param.client_id = XXBAppkey;
    param.client_secret = XXBAppSecret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = XXBRedirectUrl;
    [XXBHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        // 字典转模型
        XXBAccount *account = [XXBAccount objectWithKeyValues:responseObject];
        // 保存模型
        [self save:account];
        success();
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}
@end
