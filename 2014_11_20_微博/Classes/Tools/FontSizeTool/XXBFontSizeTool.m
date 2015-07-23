//
//  XXBFontSizeTool.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-2.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBFontSizeTool.h"
#define IWUserDefaults [NSUserDefaults standardUserDefaults]
#define IWFontSizeKey @"fontSizeKey"

@implementation XXBFontSizeTool


+ (void)saveFontSize:(NSString *)fontSize
{
    [IWUserDefaults setObject:fontSize forKey:IWFontSizeKey];
    [IWUserDefaults synchronize];
}

+ (NSString *)fontSize
{
    return [IWUserDefaults objectForKey:IWFontSizeKey];
}

@end
