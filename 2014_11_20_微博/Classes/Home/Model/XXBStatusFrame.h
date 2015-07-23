//
//  XXBStatusFrame.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-27.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXBStatus.h"

@interface XXBStatusFrame : NSObject

@property (nonatomic, strong) XXBStatus *status;

// 计算所有cell子控件的frame
// 原创frame
@property (nonatomic, assign) CGRect originalViewF;
// 转发frame
@property (nonatomic, assign) CGRect retweetViewF;
// 工具条frame
@property (nonatomic, assign) CGRect toolBarF;

// cell的高度
@property (nonatomic, assign) CGFloat cellH;

/* 原创微博所有子控件*/
/**
 *  头像frame
 */
@property (nonatomic, assign) CGRect iconImageF;
/**
 *  昵称frame
 */
@property (nonatomic, assign) CGRect nameLabelF;
/**
 *  会员frame
 */
@property (nonatomic, assign) CGRect vipImageF;
/**
 *  时间frame
 */
@property (nonatomic, assign) CGRect timeLabelF;
/**
 *  来源frame
 */
@property (nonatomic, assign) CGRect soureceLabelF;
/**
 *  内容frame
 */
@property (nonatomic, assign) CGRect contentTextLabelF;
/**
 *  配图相册frame
 */
@property (nonatomic, assign) CGRect photosViewF;

/* 转发微博所有子控件*/
/**
 *  转发昵称frame
 */
@property (nonatomic, assign) CGRect retweetNameLabelF;

/**
 *  转发微博内容frame
 */
@property (nonatomic, assign) CGRect retWeetContentTextF;
/**
 *  转发配图相册frame
 */
@property (nonatomic, assign) CGRect retWeetphotosViewF;

@end
