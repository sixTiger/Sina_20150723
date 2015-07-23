//
//  XXBSearchBar.m
//  2014_10_15_sina
//
//  Created by Mac10.9 on 14-10-15.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBSearchBar.h"

@interface XXBSearchBar ()<UITextFieldDelegate>

@end

@implementation XXBSearchBar
+ (instancetype)searchBar
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    //整个框居中
    //ios6及一下有效
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    // 背景
    self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
    // 左边的放大镜图标
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    iconView.contentMode = UIViewContentModeCenter;
    self.leftView = iconView;
    //让图片变大点就可以有间隙了
    iconView.frame = CGRectMake(0, 0, 30, 30);
    self.leftViewMode = UITextFieldViewModeAlways;
    // 字体
    self.font = [UIFont systemFontOfSize:13];
    // 右边的清除按钮
    self.clearButtonMode = UITextFieldViewModeAlways;
    // 设置提醒文字
    self.placeholder = @"搜索";
    
    // 设置键盘右下角按钮的样式
    self.returnKeyType = UIReturnKeySearch;
    self.enablesReturnKeyAutomatically = YES;
}
/**
 *  重写系统的Placeholder方法 可以设置称自己想要的样式
 */
- (void)setPlaceholder:(NSString *)Placeholder
{
    [super setPlaceholder:Placeholder];
    // 设置提醒文字
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:5];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:Placeholder attributes:attrs];
}
@end
