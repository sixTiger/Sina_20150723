//
//  XXBComposeBar.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-12-1.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXBComposeBar;

typedef enum : NSUInteger {
    /**
     *  相册
     */
    XXBComposeBarButtonStylePicture,
    /**
     *  体积
     */
    XXBComposeBarButtonStyleMention,
    /**
     *  趋势
     */
    XXBComposeBarButtonStyleTrend,
    /**
     *表情
     */
    XXBComposeBarButtonStyleEmoticon,
    /**
     *  键盘
     */
    XXBComposeBarButtonStyleKeyboard,
} XXBComposeBarButtonStyle;

@protocol XXBComposeBarDelegate <NSObject>

@optional
- (void)composeBar:(XXBComposeBar *)bar didClickBtn:(XXBComposeBarButtonStyle)style;

@end

@interface XXBComposeBar : UIView

@property (nonatomic, weak) id<XXBComposeBarDelegate> delegate;

@end
