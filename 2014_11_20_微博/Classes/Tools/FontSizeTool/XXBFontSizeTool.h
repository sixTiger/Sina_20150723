//
//  XXBFontSizeTool.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-2.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXBFontSizeTool : NSObject


// 存储字体
+ (void)saveFontSize:(NSString *)fontSize;
// 获取字体
+ (NSString *)fontSize;


@end
