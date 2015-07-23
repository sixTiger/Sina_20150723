//
//  XXBGroupItem.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-2.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXBGroupItem : NSObject

/**
 *  一组有多少行cell(IWSettingItem)
 */
@property (nonatomic, strong) NSArray *items;

/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *headedTitle;

/**
 *  尾部标题
 */
@property (nonatomic, copy) NSString *footerTitle;

@end
