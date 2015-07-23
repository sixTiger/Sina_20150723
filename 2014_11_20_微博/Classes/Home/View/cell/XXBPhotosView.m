//
//  XXBPhotosView.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-29.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotosView.h"
#import "XXBPhotoImageView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "XXBPhoto.h"

@implementation XXBPhotosView

static int photoCount = 9;
static int photoWidth = 70;
static int photoHeight = 70;
static int photoMargin = 20;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有的子控件,一开始就创建9个
        for (int i = 0; i < 9; i++) {
            XXBPhotoImageView *photoView = [[XXBPhotoImageView alloc] init];
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
            [self addSubview:photoView];
        }
        
    }
    return self;
}


- (void)tap:(UITapGestureRecognizer *)tap
{

    UIView *view = tap.view;
    // 弹出图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = view.tag;
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i < self.pic_urls .count; i++)
    {
#warning 修改过
        XXBPhoto *p = self.pic_urls[i];
#warning 优化了 有大图 可以播放GIF
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.srcImageView = (UIImageView *)view;
        NSString *string =[p.thumbnail_pic  absoluteString];
        NSString *urlString = [string stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        photo.url = [NSURL URLWithString:urlString];
#warning 只有设置了来源控制器才知道是在那个位置 最后才能回到相应地位置
        photo.srcImageView = self.subviews[i];
        [arrM addObject:photo];
    }
    
    browser.photos = arrM;
    
    [browser show];
}
// 一有新的cell出现的时候都会调用
// 注意:这里不能每次都创建新的,并且添加上去,因为这个方法会总是调用
- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i < pic_urls.count; i++) {
        XXBPhotoImageView *photoView = self.subviews[i];
        XXBPhoto *photo = pic_urls[i];
        photoView.photo = photo;
    }
    
}

// 计算所有子控件的尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int cols = _pic_urls.count == 4?2:3;
    
    int col = 0;
    int row = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    // 9 _pic_urls->6 0 1 2 3 4 5
    // 为什么不只设置需要显示图片的尺寸
    // cell 9张图片
    // 3 0 1 2 去设置位置 3 4 5 6 7 8
    for (int i = 0; i < photoCount; i++) {
        UIImageView *imageView = self.subviews[i];
        // 获取当前第几列
        col = i % cols;
        row = i / cols;
        x = col * (photoWidth + photoMargin);
        y = row * (photoHeight + photoMargin);
        imageView.frame = CGRectMake(x, y, photoWidth, photoHeight);
        if(_pic_urls.count == 1)
        {
            // 设置内容模式 缩放到能看到整张图片
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.clipsToBounds = NO;
        }
        else
        {
            // 设置内容模式 缩放到能看到有一边正好合适
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            // 超出边框的图片裁剪掉
            imageView.clipsToBounds = YES;
        }
        // 判断如果i>=_pic_urls.count,就隐藏imageView
        if (i >= _pic_urls.count) { // 3  0 1 2->no 4 yes
            imageView.hidden = YES;
        }else{
            imageView.hidden = NO;
        }
    }
}
@end
