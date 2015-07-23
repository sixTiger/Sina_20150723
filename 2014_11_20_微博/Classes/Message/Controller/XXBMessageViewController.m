//
//  XXBMessageViewController.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-20.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBMessageViewController.h"

@interface XXBMessageViewController ()

@end

@implementation XXBMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMessageViewController];
}

/**
 *  初始化XXBMessageViewController
 */
- (void)setupMessageViewController
{
    // 设置发送聊天按钮
    UIBarButtonItem *chat = [[UIBarButtonItem alloc] initWithTitle:@"发起聊天" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.rightBarButtonItem = chat;
}
@end
