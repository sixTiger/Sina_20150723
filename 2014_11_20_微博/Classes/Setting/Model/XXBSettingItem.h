//
//  XXBSettingItem.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-2.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XXBCheakItem;

@interface XXBSettingItem : NSObject

/**
 *  描述imageView
 */
@property (nonatomic, strong) UIImage *image;
/**
 *  描述textLabel
 */
@property (nonatomic, copy) NSString *title;
/**
 *  描述detailLabel
 */
@property (nonatomic, copy) NSString *subTitle;

/**
 *  保存每一行需要做的事情
 */
@property (nonatomic, copy) void(^option)(XXBCheakItem *item);

/**
 *  目标控制器的类名
 */
@property (nonatomic, assign) Class destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image;


@end
