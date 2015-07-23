//
//  XXBBaseTableViewCell.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-2.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBBaseTableViewCell.h"
#import "XXBBadgeValue.h"
#import "XXBCheakItem.h"
#import "XXBSwitchItem.h"
#import "XXBArrowItem.h"
#import "XXBBadgeItem.h"
#import "XXBLabelItem.h"



@interface XXBBaseTableViewCell ()

// 箭头
@property (nonatomic, strong) UIImageView *arrowView;
// cheak
@property (nonatomic, strong) UIImageView *cheakView;
// switch
@property (nonatomic, strong) UISwitch *switchView;
// badge
@property (nonatomic, strong) XXBBadgeValue *badgeView;

// label
@property (nonatomic, strong) UILabel *labelView;

@end

@implementation XXBBaseTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"baseTableViewCell";
    XXBBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItem:(XXBSettingItem *)item
{
    _item = item;
    
    // 设置内容
    [self setUpData];
    
    // 设置右边视图
    [self setUpRightView];
    
    if ([item isKindOfClass:[XXBLabelItem class]])
    {
        XXBLabelItem *labelItem = (XXBLabelItem *)_item;
        self.labelView.text = labelItem.text;
        // 设置label
        [self addSubview:self.labelView];
    }
    else
    {// 不是就需要干掉
        [_labelView removeFromSuperview];
    }
}
// 设置内容
- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    self.imageView.image = _item.image;
}

// 设置右边视图
- (void)setUpRightView
{
#warning 设置cell高亮的颜色
    // 设置cell选中高亮
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    if ([_item isKindOfClass:[XXBArrowItem class]])
    { // 箭头
        self.accessoryView = self.arrowView;
        return;
    }
    if ([_item isKindOfClass:[XXBBadgeItem class]])
    {
        // badgeView
        XXBBadgeItem *badgeItem = (XXBBadgeItem *)_item;
        self.badgeView.badgeValue = badgeItem.badgeValue;
        self.accessoryView = self.badgeView;
        return;
    }
    if ([_item isKindOfClass:[XXBSwitchItem class]])
    { // switchView
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        return;
    }
    if ([_item isKindOfClass:[XXBCheakItem class]])
    { // cheakView
        XXBCheakItem *cheakItem = (XXBCheakItem *)_item;
        if (cheakItem.cheak)
        {
            self.accessoryView = self.cheakView;
        }
        else
        {
            self.accessoryView = nil;
        }
        return;
    }
    self.accessoryView = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.labelView.frame = self.bounds;
    
}

#pragma mark - 懒加载

- (UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
        
    }
    return _labelView;
}
- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
        
        _arrowView = arrowView;
        
    }
    return _arrowView;
}

- (UIImageView *)cheakView
{
    if (_cheakView == nil) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
        
        _cheakView = arrowView;
        
    }
    return _cheakView;
}
- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (XXBBadgeValue *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [XXBBadgeValue buttonWithType:UIButtonTypeCustom];
    }
    return _badgeView;
}

@end
