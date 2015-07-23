//
//  XXBProfileViewController.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-20.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBProfileViewController.h"
#import "XXBSeetingVC.h"

#import "XXBBadgeValue.h"
#import "XXBCheakItem.h"
#import "XXBSwitchItem.h"
#import "XXBArrowItem.h"
#import "XXBBadgeItem.h"
#import "XXBLabelItem.h"
#import "XXBGroupItem.h"
#import "XXBProfileCell.h"

@interface XXBProfileViewController ()

@end

@implementation XXBProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupProfileViewController];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}
- (void)setupProfileViewController
{
    
    // 设置发送聊天按钮
    UIBarButtonItem *settting = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItem = settting;
    
}

- (void)setting
{
    XXBSeetingVC *settingVc = [[XXBSeetingVC alloc] init];
    
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - 设置数据源
// 返回每一行长什么样子
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    XXBProfileCell *cell = [XXBProfileCell cellWithTableView:tableView];
    
    // 2.给cell传递模型
    XXBGroupItem *group = self.groups[indexPath.section];
    XXBSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    
    return cell;
}
- (void)setupGroup1
{
    
    // 我的相册
    XXBArrowItem *friend = [XXBArrowItem itemWithTitle:@"我的相册" image:[UIImage imageNamed:@"album"]];
    friend.subTitle = @"(12)";
    // 我的收藏
    XXBArrowItem *collect = [XXBArrowItem itemWithTitle:@"我的收藏" image:[UIImage imageNamed:@"collect"]];
    collect.subTitle = @"(0)";
    // 赞
    XXBArrowItem *like = [XXBArrowItem itemWithTitle:@"赞" image:[UIImage imageNamed:@"like"]];
    like.subTitle = @"(1)";
    
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    
    group.items = @[friend,collect,like];
    
    [self.groups addObject:group];
}

- (void)setupGroup2
{
    
    // 微博支付
    XXBArrowItem *pay = [XXBArrowItem itemWithTitle:@"微博支付" image:[UIImage imageNamed:@"pay"]];
    // 个性化
    XXBArrowItem *vip = [XXBArrowItem itemWithTitle:@"个性化" image:[UIImage imageNamed:@"vip"]];
    vip.subTitle = @"微博来源,皮肤,封面图";
    
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    
    group.items = @[pay,vip];
    
    [self.groups addObject:group];
}
- (void)setupGroup3
{
    
    // 我的二维码
    XXBArrowItem *card = [XXBArrowItem itemWithTitle:@"我的二维码" image:[UIImage imageNamed:@"card"]];
    // 草稿箱
    XXBArrowItem *draft = [XXBArrowItem itemWithTitle:@"草稿箱" image:[UIImage imageNamed:@"draft"]];
    
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    
    group.items = @[card,draft];
    
    [self.groups addObject:group];
}
@end
