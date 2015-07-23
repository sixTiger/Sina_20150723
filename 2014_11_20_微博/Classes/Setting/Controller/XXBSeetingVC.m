//
//  XXBSeetingVC.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-2.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBSeetingVC.h"
#import "XXBBadgeValue.h"
#import "XXBCheakItem.h"
#import "XXBSwitchItem.h"
#import "XXBArrowItem.h"
#import "XXBBadgeItem.h"
#import "XXBLabelItem.h"
#import "XXBGroupItem.h"
#import "XXBCommonSetting.h"

@implementation XXBSeetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加group0
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加group3
    [self setUpGroup3];
    
}

- (void)setUpGroup0
{
    
    // 账号管理
    XXBBadgeItem *account = [XXBBadgeItem itemWithTitle:@"账号管理"];
    account.badgeValue = @"10";
    
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    
    group.items = @[account];
    
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    // 提醒和通知
    XXBArrowItem *notice = [XXBArrowItem itemWithTitle:@"我的相册" ];
    // 通用设置
    XXBArrowItem *setting = [XXBArrowItem itemWithTitle:@"通用设置" ];
    // 设置跳转控制器的类名
#pragma mark 控制器跳转
    setting.destVcClass = [XXBCommonSetting class];
    
    // 隐私与安全
    XXBArrowItem *secure = [XXBArrowItem itemWithTitle:@"隐私与安全" ];
    
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    group.items = @[notice,setting,secure];
    [self.groups addObject:group];
}
- (void)setUpGroup2{
    // 意见反馈
    XXBArrowItem *suggest = [XXBArrowItem itemWithTitle:@"意见反馈" ];
    // 关于微博
    XXBArrowItem *about = [XXBArrowItem itemWithTitle:@"关于微博"];
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    group.items = @[suggest,about];
    [self.groups addObject:group];
}

- (void)setUpGroup3
{
    XXBLabelItem *logout = [[XXBLabelItem alloc] init];
    logout.text = @"退出当前账号";
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    group.items = @[logout];
    [self.groups addObject:group];
}
@end
