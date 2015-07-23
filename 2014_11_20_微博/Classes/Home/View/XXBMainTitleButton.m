//
//  XXBMainTitleButton.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-21.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBMainTitleButton.h"

@interface XXBMainTitleButton ()

@property (nonatomic, strong) UIImage *curImage;
@end

@implementation XXBMainTitleButton


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupMainTitleButton];
    }
    return self;
}

/**
 *  初始化只用设置一次的属性
 */
- (void)setupMainTitleButton
{
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //高亮取消
    self.adjustsImageWhenHighlighted = NO;
    //图片居中
    self.imageView.contentMode = UIViewContentModeCenter;
    // 拉伸背景图片
    UIImage *image = [UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"];
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
/**
 * 重亲计算图片的位置
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect imageFrame = [super imageRectForContentRect:contentRect];
    CGFloat imageX = contentRect.size.width - imageFrame.size.width;
    CGFloat imageY = imageFrame.origin.y;
    CGFloat imageW = imageFrame.size.width;
    CGFloat imageH = imageFrame.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
/**
 *  重现计算文字的位置
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect titleFrame = [super titleRectForContentRect:contentRect];
    return CGRectMake(contentRect.origin.x, titleFrame.origin.y, titleFrame.size.width, titleFrame.size.height);
}
@end
