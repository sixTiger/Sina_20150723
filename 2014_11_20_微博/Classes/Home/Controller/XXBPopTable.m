//
//  XXBPopTable.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-23.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBPopTable.h"

@interface XXBPopTable ()

@end

@implementation XXBPopTable

- (void)viewDidLoad
{
    [super viewDidLoad];
    //去除cell下边的线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"popTablecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"我就是出来试一下%d",(int)indexPath.row];
    return cell;
}

@end
