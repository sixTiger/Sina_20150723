//
//  XXBPopView.h
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-22.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXBPopView : UIImageView

// 内容视图
@property (nonatomic, weak) UIView *contentView;
/**
 *  显示一个窗口
 */
- (void)showInRect:(CGRect)rect;

/**
 *  显示一个窗口  并在消失之前做一下事情
 */
- (void)showInRect:(CGRect)rect beforDismiss:(void(^)())beforDismiss;
/**
 *  让现实的窗口消失
 */
- (void)dismiss;
/**
 *  让现实的窗口同时做一件事情
 */
-  (void)dismisscompletion:(void(^)())completion;

@end
