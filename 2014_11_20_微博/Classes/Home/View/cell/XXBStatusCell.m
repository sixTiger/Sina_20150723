//
//  XXBStatusCell.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-27.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBStatusCell.h"
#import "XXBOriginalView.h"
#import "XXBRetweetView.h"
#import "XXBStatusToolBar.h"
#import "XXBStatusFrame.h"


@interface XXBStatusCell ()


@property (nonatomic, weak) XXBOriginalView *originalView;
@property (nonatomic, weak) XXBRetweetView *retweetView;
@property (nonatomic, weak) XXBStatusToolBar *statusToolBar;

@end

@implementation XXBStatusCell

/**
 *  快速创建cell
 *
 */
+ (instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *statusID = @"statusCell";
    XXBStatusCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:statusID];
    if (cell == nil) {
        
        cell = [[XXBStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:statusID];
        
    }
    return cell;
}

// 想要cell在一创建的时候做事情,一定要重写这个方法,而不是initWithFrame
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 添加所有子控件
        [self setupAllChildeView];
        
        // 清空cell的背景色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildeView
{
    // 原创微博
    XXBOriginalView *originalView = [[XXBOriginalView alloc] init];
    self.originalView = originalView;
    [self addSubview:originalView];
    
    // 转发微博
    XXBRetweetView *retweetView = [[XXBRetweetView alloc] init];
    self.retweetView = retweetView;
    [self addSubview:retweetView];
    
    // 工具条
    XXBStatusToolBar *statusToolBar = [[XXBStatusToolBar alloc] init];
    self.statusToolBar = statusToolBar;
    [self addSubview:statusToolBar];
}

- (void)setStatusFrame:(XXBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 设置所有子控件的frame
    // 设置原创微博frame
    self.originalView.frame = statusFrame.originalViewF;
    // 传递VM模型给originalView,sf包含了originalView内部所有子控件的frame和内容
    self.originalView.statusFrame = statusFrame;
#warning 还没有添加数据
    // 设置转发微博frame
    self.retweetView.frame = statusFrame.retweetViewF;
    
    // 设置转发微博所有子控件frame和内容
    self.retweetView.statusFrame = statusFrame;
    
    // 设置工具条
    self.statusToolBar.frame = statusFrame.toolBarF;
    
    
}

@end
