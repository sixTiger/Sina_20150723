//
//  XXBTextView.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-29.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXBTextView : UITextView

@property(nonatomic,copy)   NSString *placeholder;

// 好处,不让内部的控件暴露,模仿
@property (nonatomic, assign) BOOL hidePlaceHolder;


@end
