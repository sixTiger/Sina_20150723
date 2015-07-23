//
//  XXBCommonSetting.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-2.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBCommonSetting.h"

#import "XXBBadgeValue.h"
#import "XXBCheakItem.h"
#import "XXBSwitchItem.h"
#import "XXBArrowItem.h"
#import "XXBBadgeItem.h"
#import "XXBLabelItem.h"
#import "XXBGroupItem.h"
#import "XXBFontSizeTool.h"
#import "XXBFontSizeViewController.h"


#define XXBFontSizeNote @"fontSizeNote"

@interface XXBCommonSetting ()

@property (nonatomic, weak) XXBSettingItem *fontSize;

@end

@implementation XXBCommonSetting
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    [self setupGroup4];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontSizeChange) name:XXBFontSizeNote object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// 只要点击字体界面的cell就会调用
- (void)fontSizeChange
{
    // 修改模型
    _fontSize.subTitle = [XXBFontSizeTool fontSize];
    // 刷新界面
    [self.tableView reloadData];
}

- (void)setUpGroup0
{
    // 阅读模式
    XXBSettingItem *read = [XXBSettingItem itemWithTitle:@"阅读模式"];
    read.subTitle = @"有图模式";
    
    
    // 字体大小
    XXBSettingItem *fontSize = [XXBSettingItem itemWithTitle:@"字体大小"];
    _fontSize = fontSize;
    NSString *fontSizeStr = [XXBFontSizeTool fontSize];
    if (fontSizeStr)
    {
        fontSize.subTitle = fontSizeStr;
    }
    else
    {
        // 设置字体
        fontSize.subTitle = @"小";
        // 存储字体
        [XXBFontSizeTool saveFontSize:@"小"];
        
    }
#warning 注意控制器没有跳转
    fontSize.destVcClass = [XXBFontSizeViewController class];
    // 显示备注
    XXBSwitchItem *remark = [XXBSwitchItem itemWithTitle:@"显示备注"];
    
    
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    group.items = @[read,fontSize,remark];
    [self.groups addObject:group];
}
- (void)setupGroup1
{
    // 图片质量
    XXBArrowItem *quality = [XXBArrowItem itemWithTitle:@"图片质量" ];
    
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    group.items = @[quality];
    [self.groups addObject:group];
}
- (void)setupGroup2{
    // 声音
    XXBSwitchItem *sound = [XXBSwitchItem itemWithTitle:@"声音" ];
    
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    group.items = @[sound];
    [self.groups addObject:group];
}
- (void)setupGroup3
{
    // 多语言环境
    XXBSettingItem *language = [XXBSettingItem itemWithTitle:@"多语言环境"];
    language.subTitle = @"跟随系统";
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    group.items = @[language];
    [self.groups addObject:group];
}



- (void)setupGroup4
{
    // 清空图片缓存
    XXBArrowItem *clearImage = [XXBArrowItem itemWithTitle:@"清空图片缓存"];
    
    XXBGroupItem *group = [[XXBGroupItem alloc] init];
    group.items = @[clearImage];
    [self.groups addObject:group];
}


@end
