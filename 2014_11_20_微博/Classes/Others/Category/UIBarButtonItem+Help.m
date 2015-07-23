//
//  UIBarButtonItem+Help.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-21.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "UIBarButtonItem+Help.h"

@implementation UIBarButtonItem (Help)

/**
 *  快速创建一个包装Button的UIBarButtonitam
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage
{

    return  [self itemWithImage:image highImage:highImage target:nil action:nil];
}
/**
 *  快速创建一个包装Button的UIBarButtonitam 同时添加事件
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
