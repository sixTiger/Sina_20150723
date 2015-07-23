//
//  XXBStatusParam.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-26.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBStatusParam.h"

@implementation XXBStatusParam

//默认返回20条
- (NSNumber *)count
{
    return _count ? _count : @20;
}

@end
