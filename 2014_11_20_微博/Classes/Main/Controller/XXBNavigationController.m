//
//  XXBNavigationController.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-20.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBNavigationController.h"
#import "XXBTabBar.h"

@interface XXBNavigationController ()

@property (nonatomic, strong) id popDelegate;

@end

@implementation XXBNavigationController

// 第一次使用本类或者子类的时候调用
+ (void)initialize
{
    // 获取所有的UIBarButtonItem
    UIBarButtonItem *barItem =  [UIBarButtonItem appearance];
    
    // 创建文本的属性字典
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    // 给模型设置富文本属性(可以设置字符串的一些颜色,字体大小)
    [barItem setTitleTextAttributes:textDict forState:UIControlStateNormal];
    
}

/**
 *  自定义的NavigationController 实现手滑返回
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 只要覆盖了导航条系统自带的左边按钮,这个代理就会做些事情
    // 实现滑动返回功 同时记录一下这个代理,然后
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.interactivePopGestureRecognizer.delegate = nil;
}
// 将要显示viewController这个控制器的时候调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
#warning 如果直接清除代理的画会在首页的时候崩溃
    // 只要覆盖了导航条系统自带的左边按钮,这个代理就会做些事情
    // 实现滑动返回功能
    // 直接删除,系统的某些相当于不会调用
    if (viewController == self.viewControllers[0])
    { // 是根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }
    else
    {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count)
    {
        
        // push的时候隐藏底部条
        viewController.hidesBottomBarWhenPushed = YES;
        //如果不是跟控制器才设置上边的按钮
        // 设置左边的按钮
        UIBarButtonItem *popPre = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popPre)];
        
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = popPre;
        // 设置右边的按钮
        UIBarButtonItem *popRoot = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popRoot)];
        
        // 设置导航条的按钮
        viewController.navigationItem.rightBarButtonItem = popRoot;
    }
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    NSArray *array = [super popToRootViewControllerAnimated:animated];
    
    for (UIView *childView in self.tabBarController.tabBar.subviews) {
        if (![childView isKindOfClass:[XXBTabBar class]]) { // 不是自己的tabBar
            [childView removeFromSuperview];
        }
    }
    return array;
}

- (void)popPre
{
    // 回到上一个控制器
    [self popViewControllerAnimated:YES];
}
- (void)popRoot
{
    // 回到根控制器控制器
    [self popToRootViewControllerAnimated:YES];
}
@end
