//
//  XXBFontSizeViewController.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-2.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBFontSizeViewController.h"

#import "XXBBadgeValue.h"
#import "XXBCheakItem.h"
#import "XXBSwitchItem.h"
#import "XXBArrowItem.h"
#import "XXBBadgeItem.h"
#import "XXBLabelItem.h"
#import "XXBGroupItem.h"
#import "XXBFontSizeTool.h"

#define XXBFontSizeNote @"fontSizeNote"

@interface XXBFontSizeViewController ()
@property (nonatomic, weak) XXBCheakItem *selCheakItem;

@end

@implementation XXBFontSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGroup0];
}

- (void)setupGroup0
{
    __weak typeof(self) weakSelf = self;
    // 大
    XXBCheakItem *big = [XXBCheakItem itemWithTitle:@"大"];
    
    big.option = ^(XXBCheakItem *item){
        [weakSelf selItem:item];
    };
    // 中
    XXBCheakItem *middle = [XXBCheakItem itemWithTitle:@"中"];
    middle.option = ^(XXBCheakItem *item){
        [weakSelf selItem:item];
    };
    // 小
    XXBCheakItem *small = [XXBCheakItem itemWithTitle:@"小"];
    small.option = ^(XXBCheakItem *item){
        [weakSelf selItem:item];
    };
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    group.items = @[big,middle,small];
    [self.groups addObject:group];
    
    // 默认选中item
    [self selItemWithTitle:[XXBFontSizeTool fontSize]];
    
    
}

// 根据字体选中item
- (void)selItemWithTitle:(NSString *)title
{
    for (XXBGroupItem *group in self.groups) {
        for (XXBCheakItem *item in group.items) {
            if ([item.title isEqualToString:title]) {
                [self selItem:item];
            }
        }
    }
}

- (void)selItem:(XXBCheakItem *)item
{
    self.selCheakItem.cheak = NO;
    item.cheak = YES;
    self.selCheakItem = item;
    
    [self.tableView reloadData];
    
    // 保存当前选中的字体
    [XXBFontSizeTool saveFontSize:item.title];
    
    // 发出通知,修改commomSetting的字体模型
    [[NSNotificationCenter defaultCenter] postNotificationName:XXBFontSizeNote object:nil];
    
}

@end
