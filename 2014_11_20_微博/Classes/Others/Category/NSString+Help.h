//
//  NSString+Help.h
//  2014_09_21_qq
//
//  Created by Mac10.9.4 on 14-9-21.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Help)

/**
 *  计算一行字符串的大小
 */
- (CGSize)sizeWithStingFount:(UIFont *)fount;

/**
 *  计算字符串的大小可以换行
 */
- (CGSize)sizeWithStingFount:(UIFont *)fount withMaxSize:(CGSize)maxSize;

@end
