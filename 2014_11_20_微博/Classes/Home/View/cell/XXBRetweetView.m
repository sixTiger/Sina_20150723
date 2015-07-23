//
//  XXBRetweetView.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-27.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBRetweetView.h"
#import "XXBStatusFrame.h"
#import "XXBStatus.h"
#import "XXBUser.h"
#import "XXBPhotosView.h"


@interface XXBRetweetView ()

// 昵称
@property (nonatomic, weak) UILabel *retweetNameLabel;

// 内容
@property (nonatomic, weak) UILabel *retweetContentTextLabel;

// 转发的配图相册
@property (nonatomic, weak) XXBPhotosView *photosView;
@end

@implementation XXBRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupRetweetView];
    }
    return self;
}
/**
 *  初始化RetweetView窗口 同时设置 一次性的属性
 */
- (void)setupRetweetView
{
    self.userInteractionEnabled = YES;
    self.image = [UIImage resizedImageWithName:@"timeline_retweet_background"];
    
    // 昵称
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    // 52 83 86
    retweetNameLabel.textColor = XXBColor(52, 83, 86);
    retweetNameLabel.font = XXBNameFont;
    self.retweetNameLabel = retweetNameLabel;
    [self addSubview:retweetNameLabel];
    
    // 内容
    UILabel *retweetContentTextLabel = [[UILabel alloc] init];
    retweetContentTextLabel.font = XXBContentFont;
    retweetContentTextLabel.numberOfLines = 0;
    self.retweetContentTextLabel =retweetContentTextLabel;
    [self addSubview:retweetContentTextLabel];
    
    // 配图的相册
    XXBPhotosView *photosView = [[XXBPhotosView alloc] init];
    _photosView = photosView;
    [self addSubview:photosView];
}

- (void)setStatusFrame:(XXBStatusFrame *)statusFrame
{
    XXBStatus *status = statusFrame.status.retweeted_status;
    
    // 设置所有子控件的内容和frame
    
    // 设置转发微博的昵称
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",status.user.name];
    // 设置转发微博昵称frame
    self.retweetNameLabel.frame = statusFrame.retweetNameLabelF;
    
    // 设置转发微博的内容
    self.retweetContentTextLabel.text = status.text;
    self.retweetContentTextLabel.frame = statusFrame.retWeetContentTextF;
    
    // 设置转发微博配图尺寸
    _photosView.frame = statusFrame.retWeetphotosViewF;
    _photosView.pic_urls = status.pic_urls;
}
@end
