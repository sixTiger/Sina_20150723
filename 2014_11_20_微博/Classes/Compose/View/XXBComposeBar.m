//
//  XXBComposeBar.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-1.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBComposeBar.h"

@implementation XXBComposeBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setupAllChildView];
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
    }
    return self;
}
// 计算所有子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    for (int i = 0; i < count; i++)
    {
        UIButton *btn = self.subviews[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
}
/**
 *  添加所有的子控件
 */
- (void)setupAllChildView
{
    // 添加5个按钮,每个按钮的图标
    // 相册
    [self setupOneChildViewWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highImg:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"]];
    // 提及
    [self setupOneChildViewWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highImg:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"]];
    // 趋势
    [self setupOneChildViewWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highImg:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"]];
    // 表情
    [self setupOneChildViewWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highImg:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]];
    // 键盘
    [self setupOneChildViewWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] highImg:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"]];
}
/**
 *  添加一个按钮
 */
- (void)setupOneChildViewWithImage:(UIImage *)image highImg:(UIImage *)highImg
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImg forState:UIControlStateHighlighted];
    button.tag = self.subviews.count;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
}
/**
 *  处理按钮点击事件
 */
- (void)btnClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(composeBar:didClickBtn:)])
    {
        [self.delegate composeBar:self didClickBtn:button.tag];
    }
}
@end
