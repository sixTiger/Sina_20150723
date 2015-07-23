//
//  XXBAccountTools.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-24.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XXBAccount;

@interface XXBAccountTools : NSObject


+ (void)save:(XXBAccount *)account;
+ (XXBAccount *)account;
+ (void)getAccessTokenWithCode:(id)code success:(void (^)())success failure:(void (^)( NSError *error))failure;
@end
