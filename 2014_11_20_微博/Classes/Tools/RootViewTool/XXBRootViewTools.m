//
//  XXBRootViewChoose.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-24.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBRootViewTools.h"
#import "XXBNewFeatureViewController.h"
#import "XXBTabBarController.h"
#import "XXBOAuthController.h"
#import "XXBAccount.h"
#import "XXBAccountTools.h"

@implementation XXBRootViewTools

/**
 *  选中窗口的根控制器
 */
+ (void)chooseRootViewController:(UIWindow *)window
{
    // 2.获取accessToken
    XXBAccount *account = [XXBAccountTools account];
    if (account.access_token)
    { // 有
        // 判断有没有新特性,从而选择窗口的根控制器
        NSString *key = @"CFBundleVersion";
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults]valueForKey:key];
        NSString *newVersion = [NSBundle mainBundle].infoDictionary[key];
        if ([lastVersion isEqualToString:newVersion])
        {
            /**
             一样直接跳过去
             */
            XXBTabBarController *tabbarcontroller = [[XXBTabBarController alloc] init];
            window.rootViewController = tabbarcontroller;
        }
        else
        {
            /**
             不一样显示新版本特性同时把版本号存期来
             */
            [[NSUserDefaults standardUserDefaults]setObject:newVersion forKey:key];
            /**
             *  Xcode6可以忽略这一句
             */
            [[NSUserDefaults standardUserDefaults] synchronize];
            XXBNewFeatureViewController *newFeatureViewController = [[XXBNewFeatureViewController alloc] init];
            window.rootViewController = newFeatureViewController;
        }
    }
    else
    {
        //没有的时候去获取授权
        
        window.rootViewController = [[XXBOAuthController alloc] init];
    }
    
}
@end
