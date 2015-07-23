//
//  XXBTabBar.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-20.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBTabBar.h"
#import "XXBTabBarButton.h"

@interface XXBTabBar ()

@property (nonatomic, weak) UIButton *addButton;
@property (strong, nonatomic) NSMutableArray *tabBarButtonArray;
@property (weak, nonatomic) XXBTabBarButton *selectBtn;

@end

@implementation XXBTabBar

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置所有tabBarButton的frame
    [self setUpAllTabBarButtonFrame];
    
    // 设置加号按钮的frame
    [self setUpAddButtonFrame];
}
- (void)setUpAllTabBarButtonFrame
{
    int count = (int)self.tabBarButtonArray.count + 1;
    CGFloat w = self.bounds.size.width / count;
    CGFloat h = self.bounds.size.height;
    CGFloat x = 0;
    CGFloat y = 0;
    int i = 0;
    for (UIView *tabBarButton in self.tabBarButtonArray) {
        
        if (i == 2) {
            i = 3;
        }
        x = i * w;
        tabBarButton.frame = CGRectMake(x, y, w, h);
        i++;
        
    }
}
/**
 *  设置所有的按钮的frame
 */
- (void)setUpAddButtonFrame
{
    CGFloat x = self.bounds.size.width * 0.5;
    CGFloat y = self.bounds.size.height * 0.5;
    self.addButton.center = CGPointMake(x, y);
}

/**
 *  添加一个按钮
 */
- (void)addTabBarButton:(UITabBarItem *)item
{
    XXBTabBarButton *tabBarButton = [[XXBTabBarButton alloc] init];
    tabBarButton.item = item;
    tabBarButton.tag = self.tabBarButtonArray.count;
    [tabBarButton setTitle:item.title forState:UIControlStateNormal];
    [tabBarButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [tabBarButton setImage:item.image forState:UIControlStateNormal];
    [tabBarButton setImage:item.selectedImage forState:UIControlStateSelected];
    [self addSubview:tabBarButton];
    [self.tabBarButtonArray addObject:tabBarButton];
    [tabBarButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (self.tabBarButtonArray.count == 1) {
        tabBarButton.selected = YES;
        self.selectBtn = tabBarButton;
    }
   
}
/**
 *  按钮点击事件
 */
- (void)btnClick:(XXBTabBarButton *)clickedBtn
{
    if ([self.delegate respondsToSelector:@selector(tabBar:from:to:)]) {
        [self.delegate tabBar:self from:(int)self.selectBtn.tag to:(int)clickedBtn.tag];
    }
    self.selectBtn.selected = NO;
    clickedBtn.selected = YES;
    self.selectBtn = clickedBtn;
}
#pragma mark - 懒加载

- (NSMutableArray *)tabBarButtonArray
{
    if(_tabBarButtonArray == nil)
    {
        _tabBarButtonArray = [NSMutableArray array];
    }
    return _tabBarButtonArray;
}
- (UIButton *)addButton
{
    if (_addButton == nil) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        /**
         *  自动计算按钮的大小 默认的情况下跟背景图片的大侠一样
         */
        [addButton sizeToFit];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        self.addButton = addButton;
    }
    return _addButton;
}
/**
 *  处理加号点击
 */
- (void)addButtonClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarAddButtonClick:)]) {
        [self.delegate tabBarAddButtonClick:self];
    }
}
@end
