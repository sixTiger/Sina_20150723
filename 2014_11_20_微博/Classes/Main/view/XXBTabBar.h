//
//  XXBTabBar.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-20.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXBTabBar;

@protocol XXBTabBarDeledgate <NSObject>

@optional

- (void)tabBar:(XXBTabBar *)tabBar from:(int)from to:(int)to;
- (void)tabBarAddButtonClick:(XXBTabBar *)tabBar;
@end

@interface XXBTabBar : UIView

@property (weak, nonatomic) id<XXBTabBarDeledgate> delegate;

- (void)addTabBarButton:(UITabBarItem *)item;

@end
