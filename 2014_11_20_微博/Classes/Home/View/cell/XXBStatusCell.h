//
//  XXBStatusCell.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-27.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXBStatusFrame;

@interface XXBStatusCell : UITableViewCell

/**
 *  VM(包含status数据,所有子控件frame)
 */
@property (nonatomic, strong) XXBStatusFrame *statusFrame;

/**
 *  快速创建cell
 *
 */
+ (instancetype)cellWithTable:(UITableView *)tableView;

@end
