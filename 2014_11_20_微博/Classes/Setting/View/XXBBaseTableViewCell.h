//
//  XXBBaseTableViewCell.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-2.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXBSettingItem;

@interface XXBBaseTableViewCell : UITableViewCell


@property (nonatomic, strong) XXBSettingItem *item;

/**
 *  快速返回一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
