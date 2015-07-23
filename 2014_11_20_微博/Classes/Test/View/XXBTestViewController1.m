//
//  XXBTestViewController1.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-23.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBTestViewController1.h"
#import "XXBTestViewController2.h"

@interface XXBTestViewController1 ()
- (IBAction)jumpClick;
@end

@implementation XXBTestViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)jumpClick
{
    
    XXBTestViewController2 *testViewController2 = [[XXBTestViewController2 alloc] init];
    
    [self.navigationController pushViewController:testViewController2 animated:YES];
}
@end
