//
//  XXBDiscoverViewController.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-20.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBDiscoverViewController.h"
#import "XXBSearchBar.h"

@interface XXBDiscoverViewController ()<UITextFieldDelegate>

@end

@implementation XXBDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDiscoverViewController];
}
- (void)setupDiscoverViewController
{
    XXBSearchBar *searchBar = [[XXBSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 35)];
    self.navigationItem.titleView = searchBar;
    searchBar.delegate = self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.navigationController.view endEditing:YES];
    return YES;
}
@end
