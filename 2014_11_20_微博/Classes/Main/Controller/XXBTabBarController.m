//
//  XXBTabBarController.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-20.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBTabBarController.h"
#import "XXBNavigationController.h"
#import "XXBDiscoverViewController.h"
#import "XXBHomeViewController.h"
#import "XXBProfileViewController.h"
#import "XXBMessageViewController.h"
#import "XXBTabBar.h"
#import "XXBUsersTool.h"
#import "XXBUsersResult.h"
#import "XXBComposeViewController.h"

@interface XXBTabBarController ()<XXBTabBarDeledgate>

@property (weak, nonatomic) XXBTabBar *customTabBar;

@property (weak, nonatomic) XXBHomeViewController *home;
@property (weak, nonatomic) XXBProfileViewController *profile;
@property (weak, nonatomic) XXBMessageViewController *message;
@property (weak, nonatomic) XXBDiscoverViewController *discover;

@property (strong, nonatomic) NSTimer *timer;

// 当前的未读数
@property (nonatomic, assign) int curUnreadStatusCount;
// 总共的未读数
@property (nonatomic, assign) int lastTotalUnreadStatusCount;
@end

@implementation XXBTabBarController

// 第一次使用这个类或者他的子类的时候调用
+ (void)initialize
{
    /**
     *  UITabBarItem 的属性
     */
    // 它只是所有item的标志
    UITabBarItem *item = [UITabBarItem appearance];
    /**
     *  设置item的颜色之类的属性
     */
    NSMutableDictionary *textAtt = [NSMutableDictionary dictionary];
    textAtt[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:textAtt forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTabBarController];
    [self getUnreadCount];
    [self setupNotification];
    /**
     * 把定时器加到主运行循环中
     */
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)dealloc
{
    /**
     *  移除定时器
     */
    [self.timer invalidate];
    self.timer = nil;
    /**
     *  把自己从通知中心中移除
     */
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 通知处理
/**
 *  监听通知
 */
- (void)setupNotification
{
    // 接收上啦刷新通知
    /**
     *  self谁监听通知
     *  selector 监听到通知的时候,调用这个方法
     *  name:通知的名称
     *  object:谁发出,一般传nil,意味着不管谁发出的都监听
     */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginMore) name:XXBBeginMoreNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginNew) name:XXBBeginNewNote object:nil];;
}
- (void)beginMore
{
    // 记录上一次总共未读数
    _lastTotalUnreadStatusCount = _lastTotalUnreadStatusCount + _curUnreadStatusCount;
    
}
- (void)beginNew
{
    _lastTotalUnreadStatusCount = 0;
}
/**
 *初始化控制器
 */
- (void)setTabBarController
{
    XXBTabBar *tabBar = [[XXBTabBar alloc] initWithFrame:self.tabBar.bounds];
    self.customTabBar = tabBar;
    tabBar.delegate = self;
    tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    [self.tabBar addSubview:tabBar];
    [self setupAllChildController];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /**
     *  移除系统自带的UITabBar 的iteam
     */
    for (UIView *view in self.tabBar.subviews ) {
        
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}
/**
 *  加载未读的消息
 */
- (void)getUnreadCount
{
    [XXBUsersTool getUnreadCountDidSuccess:^(XXBUsersResult *unreadResult) {
        
        // 当前每次的未读数
        _curUnreadStatusCount = unreadResult.status;
        // 设置首页的微博未读数
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",self.lastTotalUnreadStatusCount + _curUnreadStatusCount];
        // 设置消息的未读数
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadResult.messageCount];
        // 设置我的未读数
        self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadResult.follower];
        
        // 设置桌面提醒数字
        [UIApplication sharedApplication].applicationIconBadgeNumber = unreadResult.totalCount;
        
        
    } failure:^(NSError *error) {
        
        XXBLog(@"%@",error);
    }];
}
- (void)setupAllChildController
{
    /**
     首页
     */
    XXBHomeViewController * home = [[XXBHomeViewController alloc] init];
    [self setupChildController:home WithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_home"] selectImage:[UIImage imageNamed:@"tabbar_home_selected"]];
    self.home = home;
    /**
     消息
     */
    XXBMessageViewController * message = [[XXBMessageViewController alloc] init];
    [self setupChildController:message WithTitle:@"消息" image:[UIImage imageNamed:@"tabbar_message_center"] selectImage:[UIImage imageNamed:@"tabbar_message_center_selected"]];
    self.message = message;
    /**
     广场
     */
    XXBDiscoverViewController * discover = [[XXBDiscoverViewController alloc] init];
    [self setupChildController:discover WithTitle:@"广场" image:[UIImage imageNamed:@"tabbar_discover"] selectImage:[UIImage imageNamed:@"tabbar_discover_selected"]];
    self.discover = discover;
    /**
     首我
     */
    
    XXBProfileViewController * profile = [[XXBProfileViewController alloc] init];
    [self setupChildController:profile WithTitle:@"我" image:[UIImage imageNamed:@"tabbar_profile"] selectImage:[UIImage imageNamed:@"tabbar_profile_selected"]];
    self.profile = profile;
    
}
- (void)setupChildController:(UIViewController *)childController WithTitle:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage
{
    /**
     包装一下
     */
    XXBNavigationController *nav = [[XXBNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
    
    childController.title = title;
    [childController.tabBarItem setImage:image];
    /**
     *  图片已经渲染不需要处理了
     */
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childController.tabBarItem setSelectedImage:selectImage];
    [self.customTabBar addTabBarButton:childController.tabBarItem];
}
#pragma mark - 实现代理方法

- (void)tabBar:(XXBTabBar *)tabBar from:(int)from to:(int)to
{
    if (from == to) {
        if ( !from) {
            [self.home refresh];
        }
    }
    self.selectedIndex = to;
}
/**
 *  处理加号点击事件
 */
- (void)tabBarAddButtonClick:(XXBTabBar *)tabBar
{
    // modal发送微博控制器,包装成导航控制器
    XXBComposeViewController *composeVc = [[XXBComposeViewController alloc] init];
    XXBNavigationController *nav = [[XXBNavigationController alloc] initWithRootViewController:composeVc];
    
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 懒加载
- (NSTimer *)timer
{
    if (_timer == nil) {        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
        self.timer = timer;
    }
    return _timer;
}
@end
