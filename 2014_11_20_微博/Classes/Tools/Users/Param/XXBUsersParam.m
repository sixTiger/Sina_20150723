//
//  XXBUsersParam.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBUsersParam.h"
#import "XXBAccountTools.h"
#import "XXBAccount.h"

@implementation XXBUsersParam

- (instancetype)init
{
    if (self = [super init]) {
        self.access_token = [XXBAccountTools account].access_token;
    }
    return self;
}

@end
