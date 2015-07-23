//
//  UIView+Help.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-21.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//  方便进行个种鸽样的布局

#import <UIKit/UIKit.h>

@interface UIView (Help)

// @property如果写在分类里面就不会生成成员属性,只会生成get,set方法

// 快速设置控件的frame
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@end
