//
//  XXBTabBarButton.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-20.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBTabBarButton.h"
#import "XXBBadgeValue.h"
#define ImageRadio 0.7

#define margin 5

@interface XXBTabBarButton ()
@property (weak, nonatomic) XXBBadgeValue *badgeButton;

@end

@implementation XXBTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupTabBarButton];
    }
    return self;
}

- (void)dealloc
{
#warning 一定要取消监听
    /**
     *  取消监听
     */
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}
/**
 *  初始化按钮
 */
- (void)setupTabBarButton
{
    
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
}
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    /**
     * 添加观察者
     */
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];

    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    /**
     *  处理通知
     */
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    [self setTitle:_item.title forState:UIControlStateNormal];
    // 设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
}

/**
 *  设置button的布局
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    /**
     *  图片的位置
     */
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageH = self.bounds.size.height * ImageRadio;
    CGFloat imageW = self.bounds.size.width;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    /**
     *  文字的位置
     */
    CGFloat titleY = imageH;
    CGFloat titleX = 0;
    CGFloat titleW = imageW;
    CGFloat titleH = self.bounds.size.height - imageH;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    /**
     *  提示数字的位置
     */
    self.badgeButton.frame = CGRectMake(self.frame.size.width - self.badgeButton.frame.size.width - margin, 0, self.badgeButton.frame.size.width, self.badgeButton.frame.size.height);
    
}

- (XXBBadgeValue *)badgeButton
{
    if (_badgeButton == nil) {
        XXBBadgeValue *badgeButton = [[XXBBadgeValue alloc] init];
        [self addSubview:badgeButton];
        _badgeButton = badgeButton;
    }
    return  _badgeButton;
}
- (void)setHighlighted:(BOOL)highlighted{}

@end
