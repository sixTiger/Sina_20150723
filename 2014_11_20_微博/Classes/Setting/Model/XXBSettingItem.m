//
//  XXBSettingItem.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-2.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBSettingItem.h"

@implementation XXBSettingItem

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image
{
    XXBSettingItem *item = [[self alloc] init];
    item.title = title;
    item.subTitle = subTitle;
    item.image = image;
    return item;
}
+ (instancetype)itemWithTitle:(NSString *)title
{
    return  [self itemWithTitle:title subTitle:nil image:nil];
}

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image
{
    return [self itemWithTitle:title subTitle:nil image:image];
}

@end
