//
//  NSString+Help.m
//  2014_09_21_qq
//
//  Created by Mac10.9.4 on 14-9-21.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "NSString+Help.h"

@implementation NSString (Help)

- (CGSize)sizeWithStingFount:(UIFont *)fount
{
    return [self sizeWithStingFount:fount withMaxSize:CGSizeMake(MAXFLOAT, 0)];
}

/**
 *  计算一个字符串的大小
 */
- (CGSize)sizeWithStingFount:(UIFont *)fount withMaxSize:(CGSize)maxSize;
{
    NSDictionary *attrs = @{NSFontAttributeName : fount};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
