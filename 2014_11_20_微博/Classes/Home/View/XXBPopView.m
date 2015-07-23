//
//  XXBPopView.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-22.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBPopView.h"

@interface XXBPopView ()

@property (copy, nonatomic) void(^beforDismiss)();
@end

@implementation XXBPopView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupPopView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame]) {
        [self setupPopView];
    }
    return self;
}

- (void)setupPopView
{
    self.userInteractionEnabled = YES;
    self.image = [UIImage resizedImageWithName:@"popover_background"];
    UIButton *coverButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    coverButton.frame = [UIScreen mainScreen].bounds;
    [XXBKeywindow addSubview:coverButton];
    [coverButton addTarget:self action:@selector(coverButtonClick :) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setContentViewFrame];
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
}
/**
 *  设置contentView的frame
 */
- (void)setContentViewFrame
{
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = self.width - x * 2;
    CGFloat h = self.height - y * 2;
    _contentView.frame = CGRectMake(x, y, w, h);
}
/**
 *  处理按钮的点击事件
 */
- (void)coverButtonClick:(UIButton *)coverButton
{
    [coverButton removeFromSuperview];
    [self dismisscompletion:self.beforDismiss];
}

/**
 *  显示一个窗口
 */
- (void)showInRect:(CGRect)rect
{
    [self showInRect:rect beforDismiss:nil];
}
/**
 *  显示一个窗口  并在消失之前做一下事情
 */
- (void)showInRect:(CGRect)rect beforDismiss:(void(^)())beforDismiss
{
    self.frame = rect;
    self.beforDismiss = beforDismiss;
    [XXBKeywindow addSubview:self];
}

/**
 *  让现实的窗口消失
 */
- (void)dismiss
{
    [self dismisscompletion:nil];
}
/**
 *  让现实的窗口同时做一件事情
 */
- (void)dismisscompletion:(void (^)())completion
{
    // self -> IWPopView
    for (UIView *popView in XXBKeywindow.subviews) {
        if ([popView isKindOfClass:self.class]) {
            [popView removeFromSuperview];
        }
    }
    if (completion)
    {
        completion();
    }
}

@end
