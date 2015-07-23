//
//  XXBStatusFrame.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-27.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBStatusFrame.h"
#import "XXBUser.h"
#import "NSString+Help.h"

#define XXBIconW 35
#define XXBVipW  14
#define XXBScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation XXBStatusFrame


// 只要传递微博模型就算出所有子控件的尺寸
- (void)setStatus:(XXBStatus *)status
{
    _status = status;
    
    //计算原创微博frame
    [self setupOriginalFrame];
    
    //计算工具条的frame
    CGFloat toolY = CGRectGetMaxY(_originalViewF);
    //计算转发微博
    if (_status.retweeted_status) { // 判断有木有转发微博
        // 1. _retweetViewF -> _retWeetTextViewF
        // 转发微博
        [self setupRetweetFrame];
        // 先要算出转发微博的frame,才赋值
        toolY = CGRectGetMaxY(_retweetViewF);
    }
    
    _toolBarF = CGRectMake(0, toolY, XXBScreenWidth, 35);
    
    // cell高度
    _cellH = CGRectGetMaxY(_toolBarF);
    
    
}
// 原创微博frame
- (void)setupOriginalFrame
{
    // 头像
    CGFloat iconX = XXBCellMargin;
    CGFloat iconY = XXBCellMargin;
    CGFloat iconW = XXBIconW;
    CGFloat iconH = XXBIconW;
    self.iconImageF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.iconImageF) + XXBCellMargin;
    CGFloat nameY = iconY;
    CGSize nameSize = [self.status.user.name sizeWithStingFount:XXBNameFont];
    // 强转结构体,因为不知道这样的是哪个结构体
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    // 会员图标
    if (self.status.user.vip) { // 会员
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + XXBCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipW = XXBVipW;
        CGFloat vipH = XXBVipW;
        self.vipImageF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    
    // 内容
    CGFloat contentTextX = XXBCellMargin;
    CGFloat contentTextY = CGRectGetMaxY(self.iconImageF) + XXBCellMargin;
    // Size:限制尺寸,限制文字最高多少最宽多少
    CGSize contentTextSize = [self.status.text sizeWithStingFount:XXBContentFont withMaxSize:CGSizeMake(XXBScreenWidth - 2 * XXBCellMargin, MAXFLOAT)];

    self.contentTextLabelF = (CGRect){{contentTextX,contentTextY},contentTextSize};
   
    
    CGFloat originH = CGRectGetMaxY(self.contentTextLabelF) + XXBCellMargin;
    //配图
    if (_status.pic_urls.count) { // 有配图
        // 配图的frame
        CGFloat photoX = contentTextX;
        CGFloat photoY = CGRectGetMaxY(self.contentTextLabelF) + XXBCellMargin;
        CGSize photoSize = [self photosSizeWithCount:_status.pic_urls.count ];
        _photosViewF = (CGRect){{photoX,photoY},photoSize};
        // 最大的配图加上一段间距
        originH =  CGRectGetMaxY(_photosViewF) + XXBCellMargin;
    }

    
    // 整个原创微博的frame
    CGFloat originY = XXBCellMargin;
    self.originalViewF = CGRectMake(0, originY, XXBScreenWidth, originH);
}

// 转发微博
- (void)setupRetweetFrame
{
    // 昵称
    CGFloat nameX = XXBCellMargin;
    CGFloat nameY = XXBCellMargin;
    NSString *name =[NSString stringWithFormat:@"@%@",self.status.retweeted_status.user.name];
    CGSize nameSize = [name sizeWithStingFount:XXBNameFont];
    // 强转结构体,因为不知道这样的是哪个结构体
    self.retweetNameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    // 内容
    CGFloat textX = XXBCellMargin;
    CGFloat textY = CGRectGetMaxY(self.retweetNameLabelF) + XXBCellMargin;
    // 计算文字的大小
    CGSize retweetContentSize = [self.status.retweeted_status.text sizeWithStingFount:XXBContentFont withMaxSize:CGSizeMake(XXBScreenWidth - 2 * XXBCellMargin, MAXFLOAT)];

    self.retWeetContentTextF = (CGRect){{textX,textY},retweetContentSize};
    
    
    CGFloat retweetH = CGRectGetMaxY(self.retWeetContentTextF) + XXBCellMargin;
    //配图
    if (_status.retweeted_status.pic_urls.count) { // 有配图
        // 配图的frame
        CGFloat photoX = textX;
        CGFloat photoY = CGRectGetMaxY(self.retWeetContentTextF) + XXBCellMargin;
        CGSize photoSize = [self photosSizeWithCount:_status.retweeted_status.pic_urls.count ];
        _retWeetphotosViewF = (CGRect){{photoX,photoY},photoSize};
        // 最大的配图加上一段间距
        retweetH =  CGRectGetMaxY(_retWeetphotosViewF);
    }

    // 整个转发微博的frame
    
    CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
    self.retweetViewF = CGRectMake(0, retweetY, XXBScreenWidth, retweetH);
    
}

// 计算相册的尺寸
- (CGSize)photosSizeWithCount:(NSUInteger)count
{
    // 9 cols=3 rows = 3
    // 5 cols=3 rows =2
    // 4 cols=2 rows 2
    
    // 获取总列数
    NSInteger cols = count == 4?2:3;
    // 获取总行数
    NSInteger rows = (count - 1) / cols + 1;
    
    CGFloat photosW = cols * 70 + (cols - 1) * 20;
    CGFloat photosH = rows * 70 + (rows - 1) * 20;
    
    return CGSizeMake(photosW, photosH);
}


@end
