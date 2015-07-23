//
//  XXBPhotoImageView.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-29.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoImageView.h"
#import "XXBPhoto.h"
#import "UIImageView+WebCache.h"

@interface XXBPhotoImageView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation XXBPhotoImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        // 添加所有的子控件
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        _gifView = gifView;
        [self addSubview:gifView];
    }
    return self;
}


- (void)setPhoto:(XXBPhoto *)photo
{
    _photo = photo;
    // 加载图片
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 判断后缀
    if ([photo.thumbnail_pic.absoluteString hasSuffix:@".gif"])
    {
        _gifView.hidden = NO;
    }
    else
    {
        _gifView.hidden = YES;
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _gifView.x = self.width - _gifView.width;
    _gifView.y = self.height - _gifView.height;
    
}

@end
