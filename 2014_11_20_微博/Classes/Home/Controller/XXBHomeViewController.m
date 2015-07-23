//
//  XXBHomeViewController.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-20.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBHomeViewController.h"
#import "XXBMainTitleButton.h"
#import "XXBPopView.h"
#import "XXBPopTable.h"
#import "XXBAccountTools.h"
#import "XXBAccount.h"
#import "XXBStatus.h"
#import "XXBUser.h"
#import "XXBPhoto.h"
#import "UIImageView+WebCache.h"
#import "XXBUsersTool.h"
#import "XXBUser.h"
#import "XXBStatusCell.h"
#import "XXBStatusFrame.h"
#import "XXBStatusTool.h"

#import "XXBTestViewController1.h"




@interface XXBHomeViewController ()

@property (weak, nonatomic) XXBMainTitleButton *titleButton;

@property (strong, nonatomic) XXBPopTable *popTable;
@property (assign, nonatomic) BOOL hearerRefresh;

/**
 *  微博frame模型
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation XXBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupHomeViewController];
    // 添加上下拉刷新控件
    [self setupRefresh];
    [self.tableView headerBeginRefreshing];
    
}

#pragma mark - 对控制器进行初始化
/**
 *  对主界面进行相关的设置
 */
- (void)setupHomeViewController
{
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = XXBColor(201, 201, 201);
    /**
     *  初始化导航栏的按钮
     */
    [self setupNavBar];
}
- (void)setupNavBar
{
    
    // 创建左边item
    UIBarButtonItem *left = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch)];
    self.navigationItem.leftBarButtonItem = left;
    
    // 创建右边item
    UIBarButtonItem *right = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:nil action:nil];
    self.navigationItem.rightBarButtonItem = right;
    /**
     *  设置导航栏的标题
     */
    [XXBUsersTool userInfoDidSuccess:^(XXBUser *user) {
        
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
    } failure:^(NSError *error) {
        XXBLog(@"%@",error);
    }];
     NSString *name = [XXBAccountTools account].name;
   
    [self.titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
}

/**
 *  设置上拉下拉刷新
 */
- (void)setupRefresh
{
    // 添加下拉刷新控件
    // 当你下拉的时候就会调用Target对象action方法
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatuses)];
    // 添加上拉刷新控件
    // 当你上拉的时候就会调用Target对象action方法
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatuses)];
}
#pragma mark 懒加载

- (XXBMainTitleButton *)titleButton
{
    if (_titleButton == nil) {
        
        XXBMainTitleButton *titleButton = [[XXBMainTitleButton alloc] init];
        self.navigationItem.titleView = titleButton;
        self.titleButton = titleButton;
        [titleButton setImage: [UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _titleButton;
}
- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
#pragma mark - 刷新刷新事件处理

/**
 *  加载新微博 下拉刷新
 */
- (void)loadNewStatuses
{
    [[NSNotificationCenter defaultCenter] postNotificationName:XXBBeginNewNote object:nil];
    if (self.hearerRefresh)
        return;
    self.hearerRefresh = YES;
    id sinceID = nil;
    // 判断数组有没有微博值
    if (self.statusFrames.count)
    {
        XXBStatusFrame *statusFrame = [self.statusFrames firstObject];
        XXBStatus *status = statusFrame.status;
       sinceID =  status.idstr;
    }
    [XXBStatusTool getNewStatusWithSinceID:sinceID success:^(NSArray *statuses) {
        [self.tableView headerEndRefreshing];
        self.hearerRefresh = NO;
        
        NSRange range = NSMakeRange(0, statuses.count);
        // location : 插入哪个角标
        // len :插入个数:最新微博数组的个数
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        // 用成员变量保存数据
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (XXBStatus *tempStatus in statuses) {
            XXBStatusFrame *statusFrame = [[XXBStatusFrame alloc] init];
            statusFrame.status = tempStatus;
            [statusFrameArray addObject:statusFrame];
        }
        [self.statusFrames insertObjects:statusFrameArray atIndexes:indexSet];
        
        // 获取到新数据的时候,刷新表格
        [self.tableView reloadData];
        [self showNewStatusesCount:(int)statuses.count];
        
    } failure:^(NSError *error) {
        self.hearerRefresh = NO;
        XXBLog(@"%@",error);
    }];
}
/**
 *  加载旧微博 上拉加载更多
 */
- (void)loadMoreStatuses
{
    [[NSNotificationCenter defaultCenter] postNotificationName:XXBBeginMoreNote object:nil];
    id maxID = nil;
    // 判断数组有没有微博值
    if (self.statusFrames.count)
    {
        XXBStatusFrame *statusFrame = [self.statusFrames lastObject];
        XXBStatus *status = statusFrame.status;
        maxID = @([status.idstr longLongValue] - 1);
    }
    [XXBStatusTool getMoreStatusWithMaxID:maxID success:^(NSArray *statuses) {
        //停止刷新
        [self.tableView footerEndRefreshing];
        // 用成员变量保存数据
        for (XXBStatus *tempStatus in statuses) {
            XXBStatusFrame *statusFrame = [[XXBStatusFrame alloc] init];
            statusFrame.status = tempStatus;
            [self.statusFrames addObject:statusFrame];
        }
        
        // 获取到新数据的时候,刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
         XXBLog(@"%@",error);
    }];

}
/**
 *  标题按钮点击事件
 */
- (void)titleButtonClick:(XXBMainTitleButton *)titleButton
{
    titleButton.selected = !titleButton.selected;
    if (titleButton.selected) {
        XXBPopView *popView =[[XXBPopView alloc] init];
        self.popTable = [[XXBPopTable alloc] init];
        popView.contentView = self.popTable.view;

        [popView  showInRect:CGRectMake((self.view.width - 200) * 0.5, 55, 200, 200) beforDismiss:^{
            titleButton.selected = !titleButton.selected;
        }];
    }
}
- (void)friendsearch
{
    XXBLog(@"%s",__func__);
}

#pragma mark - 表格的相关处理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XXBTestViewController1 *test = [[XXBTestViewController1 alloc] init];
#warning 跳转的时候隐藏tabBar
     test.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    XXBStatusCell *cell = [XXBStatusCell cellWithTable:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XXBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellH;
}
// 提示最新微博数
- (void)showNewStatusesCount:(int)count
{
    
    if (count == 0) return;
    //    self.view = self.tableView
    
    CGFloat labelH = 35;
    CGFloat labelY = 64-labelH;
    CGFloat labelW = self.view.width;
    CGFloat labelX = 0;
    
    // 弹出最新微博数控件
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    
    // 设置微博数
    statusLabel.text = [NSString stringWithFormat:@"%d 条新微博数",count];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = [UIColor whiteColor];
    statusLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    
    // 把statusLabel插入到导航条下面
    [self.navigationController.view insertSubview:statusLabel belowSubview:self.navigationController.navigationBar];
    
    // 做动画
    CGFloat durtion = 0.25;
    [UIView animateWithDuration:durtion animations:^{
        // 往下移动
        statusLabel.transform = CGAffineTransformMakeTranslation(0, labelH);
    } completion:^(BOOL finished) {
        
        // 延迟1秒,在做动画,往上移动
        [UIView animateWithDuration:durtion delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            
            // 把形变清空
            statusLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 移除导航控制器
            [statusLabel removeFromSuperview];
            
        }];
        
    }];
}

//刷新首页
- (void)refresh
{
    [self.tableView headerBeginRefreshing];
}
@end
