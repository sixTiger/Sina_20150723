//
//  XXBOriginalView.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-27.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBOriginalView.h"
#import "XXBStatusFrame.h"
#import "XXBStatus.h"
#import "XXBUser.h"
#import "UIImageView+WebCache.h"
#import "NSString+Help.h"
#import "XXBPhotosView.h"


@interface XXBOriginalView ()


// 头像
@property (nonatomic, weak) UIImageView *iconImage;

// 昵称
@property (nonatomic, weak) UILabel *nameLabel;
// 会员图标
@property (nonatomic, weak) UIImageView *vipImage;
// 时间
@property (nonatomic, weak) UILabel *timeLabel ;
// 来源
@property (nonatomic, weak) UILabel *sourceLabel;
// 内容
@property (nonatomic, weak) UILabel *contentTextLabel;
/**
 配图
 */
// 配图的相册
@property (nonatomic, weak) XXBPhotosView *photosView;

@end

@implementation XXBOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupOriginalView];
    }
    return self;
}
/**
 *  初始化OriginalView的所有的子控件 和 一次性的设置
 */
- (void)setupOriginalView
{
    self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
    self.userInteractionEnabled = YES;
    
    // 头像
    UIImageView *iconImage = [[UIImageView alloc] init];
    self.iconImage = iconImage;
    [self addSubview:iconImage];
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = XXBNameFont;
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    
    // 会员图片
    UIImageView *vipImage = [[UIImageView alloc] init];
    self.vipImage = vipImage;
    [self addSubview:vipImage];
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor orangeColor];
    timeLabel.font = XXBTimeFont;
    self.timeLabel = timeLabel;
    [self addSubview:timeLabel];
    
    // 来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = XXbSourceFont;
    sourceLabel.textColor = [UIColor lightGrayColor];
    self.sourceLabel = sourceLabel;
    [self addSubview:sourceLabel];
    
    // 内容
    UILabel *contentTextLabel = [[UILabel alloc] init];
    contentTextLabel.numberOfLines = 0;
    contentTextLabel.font = XXBContentFont;
    self.contentTextLabel = contentTextLabel;
    [self addSubview:contentTextLabel];
    // 配图的相册
    XXBPhotosView *photosView = [[XXBPhotosView alloc] init];
    _photosView = photosView;
    [self addSubview:photosView];
}
/**
 *  重写setStatusFrame 同时进行数据的设置
 */
- (void)setStatusFrame:(XXBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    XXBStatus *status = statusFrame.status;
    
    // 头像frame
    self.iconImage.frame = statusFrame.iconImageF;
    
    // 设置头像的内容 同时提供一张占位图片
    [self.iconImage sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    
    // 昵称
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = status.user.name;
    
    // 会员图标
    if (status.user.vip)
    { // 会员
        // frame
        self.vipImage.frame = statusFrame.vipImageF;
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
        // 设置会员的内容
        self.vipImage.image = [UIImage imageNamed:imageName];
        self.vipImage.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
    }
    else
    {
        self.nameLabel.textColor = [UIColor blackColor];
        // 有可能下一次不是会员
        self.vipImage.hidden = YES;
    }
    
    // 时间
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF);
    // 根据文字内容算出尺寸,font:根据这样的字体算
    CGSize timeSize = [status.created_at sizeWithStingFount:XXBTimeFont];
    // 设置创建时间的frame
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + XXBCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithStingFount:XXbSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 时间
    // 设置时间
    self.timeLabel.text = status.created_at;
    //    _timeView.frame = sf.timeViewF;
    
    // 来源
    self.sourceLabel.text = status.source;
    
    // 内容
    self.contentTextLabel.text = status.text;
    self.contentTextLabel.frame = statusFrame.contentTextLabelF;
    
    // 配图
    // 配图尺寸
    _photosView.frame = statusFrame.photosViewF;
    
    // 配图内容
    _photosView.pic_urls = status.pic_urls;
    
}

@end
